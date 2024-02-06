
remoteNetworks = require("remote_networks")
rednet.open("left");

local warehouseProtocol = "mcwarehouselookup"
local REFRESH_TIME = 15
local stressStr = "Create_Stressometer_0"
local speedStr = "Create_Speedometer_0"
local monitorStr = "monitor_4"
local boilerStr = "fluidTank_2"
local stress = peripheral.wrap(stressStr)

local displayState = {
    
}


for network, props in pairs(remoteNetworks) do
    remoteNetworks[network].connection = peripheral.wrap(props.connectionString)
end

local monitor = peripheral.wrap(monitorStr)

function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
    monitor.write(input)
end


function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
end

function RenderDisplay()
    local line = 1
    local xcur = 2
    monitor.setTextScale(1)
    monitor.clear()
    monitor.setCursorPos(xcur, line)
    monitor.setTextColor(8)
    monitor.write("REMOTE POWER")
    line = line + 1
    monitor.setCursorPos(xcur, line)
    monitor.write("=====================================")
    line = line + 1

    for network, props in pairs(displayState) do
        line = line + 1
        monitor.setCursorPos(xcur, line)
        monitor.write(props.name)
        if props.change < 0 then monitor.setTextColor(colors.red) elseif props.change > 0 then monitor.setTextColor(colors.green) end
        local lineText = props.stock .. "(" .. props.change ..")   " .. StringState(props.state)
        RightJustify(lineText, line)
        monitor.write(lineText, line)
        monitor.setTextColor(8)
    end

end

function StringState(state)
    if state then return "ON" else return "OFF" end
end

function GetSystemStressLevel() -- 0 thru 1
    return stress.getStress() / stress.getStressCapacity()
end

function CheckStatusOfConnectedSubnet(subnet, props)
    local whStock = QueryWarehouseForAssociatedItems(props.relevantItems)

    
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
        change = 0,
    }
    if displayState[subnet].stock ~= nil then
        displayState[subnet].change = displayState[subnet].stock - whStock
        print(props.name, whStock, "/", props.maximumStock, "(" .. displayState[subnet].stock .. ")") 
    end
    displayState[subnet].stock = whStock
end


function QueryWarehouseForAssociatedItems(items)
    local totalItems = 0
    for i, item in pairs(items) do
        rednet.broadcast(item, warehouseProtocol);
        senderId, message, protocol = rednet.receive(warehouseProtocol, 5)
        totalItems = totalItems + message.count
    end
    return totalItems
end


function Main()
    GetSystemStressLevel()
    for subnet, props in pairs(remoteNetworks) do
        CheckStatusOfConnectedSubnet(subnet, props)
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