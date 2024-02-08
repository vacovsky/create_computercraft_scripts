
remoteNetworks = require("remote_networks")
rednet.open("left");

local DIMENSION = "world"
local warehouseProtocol = "mcwarehouselookup"
local REFRESH_TIME = 15
local stressStr = "Create_Stressometer_0"
local speedStr = "Create_Speedometer_0"
local monitorStr = "monitor_4"
local boilerStr = "fluidTank_2"
local netherProtocol = "nethermine"
local stress = peripheral.wrap(stressStr)

local displayState = {}

for network, props in pairs(remoteNetworks) do
    if props.connectionString ~= nil then
        remoteNetworks[network].connection = peripheral.wrap(props.connectionString)
    end
end

local monitor = peripheral.wrap(monitorStr)

function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
    monitor.write(input, line)
end


-- function RightJustify(input, line)
--     monitor.setCursorPos(monitor.getSize() - string.len(input), line)
-- end

function RenderDisplay()
    local line = 1
    local xcur = 2
    monitor.setTextScale(1)
    monitor.clear()
    monitor.setCursorPos(xcur, line)
    monitor.setTextColor(8)
    monitor.write("STRESS")
    local worldPower = "WORLD " .. string.format("%.2f",((((GetSystemStressLevel()) * 100 ) * 10) / 10))  .. "% used"
    RightJustify(worldPower, line)
    line = line + 1

    local netherPower = "NETHER " .. QueryExtradimensionalNetworkStress()  .. "% used"
    RightJustify(netherPower, line)

    line = line + 1
    monitor.setCursorPos(xcur, line)
    monitor.write("=====================================")
    line = line + 1

    for network, props in pairs(displayState) do
        print("netowrk", network)
        line = line + 1
        monitor.setCursorPos(xcur, line)
        monitor.write(props.name)
        if props.change < 0 then monitor.setTextColor(colors.red) elseif props.change > 0 then monitor.setTextColor(colors.green) end
        local lineText = props.stock .. " (" .. props.change ..")   " .. StringState(props.state)
        RightJustify(lineText, line)
        monitor.setTextColor(8)
    end
end

function StringState(state)
    if state then return "RUN" else return "OFF" end
end

function GetSystemStressLevel() -- 0 thru 1
    return stress.getStress() / stress.getStressCapacity()
end

function CheckStatusOfConnectedSubnet(subnet, props)

    local whStock = QueryWarehouseForAssociatedItems(props.relevantItems)
    local change = 0
    if displayState[subnet] ~= nil and displayState[subnet].stock ~= nil then
      change = -(displayState[subnet].stock - whStock)
    end

    if whStock > props.maximumStock then
        props.connection.setTargetSpeed(0)
        props.currentSpeed = 0
    else
        props.connection.setTargetSpeed(props.maxSpeed)
        props.currentSpeed = props.maxSpeed
    end

    displayState[subnet] = {
        name = props.name,
        speed = props.currentSpeed,
        state = props.currentSpeed > 0,
        refinedName = props.refinedResourceName,
        change = change,
        stock = whStock
    }
    print(props.name, whStock, "/", props.maximumStock, "(" .. change .. ")")
end


function QueryExtradimensionalSubnetStatus()
    rednet.broadcast("status", netherProtocol);
    senderId, message, protocol = rednet.receive(netherProtocol, 1)
    return message
end

function QueryExtradimensionalNetworkStress()
    local edns = 0
    rednet.broadcast("stress", netherProtocol);
    senderId, message, protocol = rednet.receive(netherProtocol, 1)
    if message ~= nil then
        edns = edns + message
    end
    return edns
end

function QueryWarehouseForAssociatedItems(items)
    local totalItems = 0
    for i, item in pairs(items) do
        rednet.broadcast(item, warehouseProtocol);
        senderId, message, protocol = rednet.receive(warehouseProtocol, 1)
        if message ~= nil then
            totalItems = totalItems + message.count
        end
    end
    return totalItems
end

function CheckStatusOfRemoteSubnet(subnet, props)
    return 0
end

function Main()
    for subnet, props in pairs(remoteNetworks) do
        if props.dimension == DIMENSION then
            CheckStatusOfConnectedSubnet(subnet, props)
        else
            local status = 0
            CheckStatusOfRemoteSubnet(subnet, props)
        end
    end

    local exss = QueryExtradimensionalSubnetStatus()
    if exss ~= nil then
        for subnet, props in pairs(exss) do
            displayState[subnet] = props
        end
    end
    RenderDisplay()
end

local counter = 0
while true do
    counter = counter + 1
    term.clear()                            -- Paint the entire display with the current background colour.
    term.setCursorPos(1,1)
    print("Pass", counter, "refresh interval", REFRESH_TIME .. "s")
    print()
    Main()
    sleep(REFRESH_TIME)
end