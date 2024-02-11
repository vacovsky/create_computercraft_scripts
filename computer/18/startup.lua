
remoteNetworks = require("remote_networks")
rednet.open("left");

shell.openTab("status_api")
print("Starting Monitor")

local DIMENSION = "nether"
local warehouseProtocol = "mcwarehouselookup"
local REFRESH_TIME = 15
local monitorStr = "monitor_6"
local stressStr = "Create_Stressometer_1"
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


function RenderDisplay()
    local line = 1
    local xcur = 2
    monitor.setTextScale(1)
    monitor.clear()
    monitor.setCursorPos(xcur, line)
    monitor.setTextColor(8)
    monitor.write("STRESS ENERGY CONTROL")
    local curPower = string.format("%.2f",(((  (stress.getStress() / stress.getStressCapacity()) * 100 ) * 10) / 10))  .. "% used"
    RightJustify(curPower, line)

    line = line + 1
    monitor.setCursorPos(xcur, line)
    monitor.write("=====================================")
    line = line + 1

    for network, props in pairs(displayState) do
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
        props.connection.setTargetSpeed(props.minSpeed)
        props.currentSpeed = props.minSpeed
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


function QueryWarehouseForAssociatedItems(items)
    local totalItems = 0
    for i, item in pairs(items) do
        rednet.broadcast(item, warehouseProtocol);
        senderId, message, protocol = rednet.receive(warehouseProtocol, 5)
        if message.count ~= nil then
            totalItems = totalItems + message.count
        end
    end
    return totalItems
end


function WriteTableToFile(table, fileName)
    WriteToFile(textutils.serialize(table), fileName)
end


function WriteToFile(input, fileName)
    local file = io.open(fileName, "w")
    io.output(file)
    io.write(input)
    io.close(file)
end


function Main()
    GetSystemStressLevel()
    for subnet, props in pairs(remoteNetworks) do
        if props.dimension == DIMENSION then
            CheckStatusOfConnectedSubnet(subnet, props)
        end
    end
    WriteTableToFile(displayState, "state")
    RenderDisplay()
end


local counter = 0
while true do
    counter = counter + 1
    term.clear()
    term.setCursorPos(1,1)
    print("Pass", counter, "refresh interval", REFRESH_TIME .. "s")
    print()
    pcall(Main)
    sleep(REFRESH_TIME)
end