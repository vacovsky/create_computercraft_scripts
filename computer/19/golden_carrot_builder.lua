local carrot_barrel = "minecraft:barrel_17"
local nugget_barrel = "minecraft:barrel_16"
local warehouse = peripheral.find("minecolonies:warehouse")

local carrots = peripheral.wrap(carrot_barrel)
local nuggets = peripheral.wrap(nugget_barrel)

function pushCarrotStyff(slot, destination)
    warehouse.pushItems(destination, slot, 64)
end

print("Starting SUPER CARROT BUILDER")

function Main() 
    for slot, item in pairs(warehouse.list()) do
        if item.name == "minecraft:carrot" then
            pushCarrotStyff(slot, carrot_barrel)
            print("Tried to push carrots!")
        elseif item.name == "minecraft:gold_nugget" then
            pushCarrotStyff(slot, nugget_barrel)
            print("Tried to push gold nuggets!")
        end
    end
end
while true do
    Main()
    -- pcall(Main)
    sleep(30)
end
