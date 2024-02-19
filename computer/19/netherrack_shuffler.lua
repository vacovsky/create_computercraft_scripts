
local nrbarrel_str = "minecraft:barrel_19"
local warehouse = peripheral.find("minecolonies:warehouse")

local nrbarrel = peripheral.wrap(nrbarrel_str)


function pushStuff(slot, destination)
    warehouse.pushItems(destination, slot, 64)
end

print("Starting SUPER NETHERRACK MOVER how stupid")

function Main() 
    for slot, item in pairs(warehouse.list()) do
        if item.name == "minecraft:netherrack" then
            pushStuff(slot, nrbarrel_str)
            print("Tried to push netherrack!")
        end
    end
end
while true do
    -- Main()
    pcall(Main)
    sleep(300)
end
