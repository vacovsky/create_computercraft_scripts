
local xpbarrel_str = "minecraft:barrel_20"
local warehouse = peripheral.find("minecolonies:warehouse")

local xpbarrel = peripheral.wrap(xpbarrel_str)


function pushStuff(slot, destination)
    warehouse.pushItems(destination, slot, 64)
end

print("Starting SUPER lapis machine")

function Main()
    for slot, item in pairs(warehouse.list()) do
        if item.name == "minecraft:lapis_lazuli" then
            pushStuff(slot, xpbarrel_str)
            print("Tried to push lapis")
        end
    end
end
while true do
    -- Main()
    pcall(Main)
    sleep(300)
end
