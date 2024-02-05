rednet.open("left");

local warehouseProtocol = "mcwarehouselookup"
local REFRESH_TIME = 15
local stressStr = "Create_Stressometer_0"
local speedStr = "Create_Speedometer_0"
local monitorStr = "monitor_2"
local boilerStr = "fluidTank_2"
local speed = peripheral.wrap("Create_RotationSpeedController_2")

local displayState = {
    
}

local remoteNetworks = {
    copperMine = {
        name = "Copppr Mine",
        connectionString = "Create_RotationSpeedController_2",
        connection = nil,
        relevantItems = {
            "minecraft:raw_copper",
            "minecraft:copper_ingot",
            "create:crushed_raw_copper"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 0
    },
    emeraldMine = {
        name = "Emerald Mine",
        connectionString = "Create_RotationSpeedController_5",
        connection = nil,
        relevantItems = {
            "createoreexcavation:raw_emerald",
            "minecraft:emerald",
            "create:emerald_ore"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 3
    }
}

for network, props in pairs(remoteNetworks) do
    remoteNetworks[network].connection = peripheral.wrap(connectionString)
end

local monitor = peripheral.wrap(monitorStr)
function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
    monitor.write(input)
end

function RenderDisplay()
    -- local line = 2
    -- monitor.setTextScale(1)
    -- monitor.clear()
    -- monitor.setCursorPos(2, line)
    -- monitor.setTextColor(8)
    -- monitor.write("Capacity Used")stress.getStress() / stress.getStressCapacity()
    -- RightJustify(string.format("%.2f",(((  () * 100 ) * 10) / 10)) .. "%", line)

    -- line = line + 2
    -- monitor.setCursorPos(2, line)
    -- monitor.setTextColor(8)
    -- monitor.write("Rotation Speed")
    -- RightJustify(speed.getSpeed() .. " RPM", line)
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
        props.setTargetSpeed(props.maxSpeed)
        props.currentSpeed = props.maxSpeed
    end
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

while true do
    Main()
    sleep(REFRESH_TIME)
end