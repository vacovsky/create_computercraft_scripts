
local xpbarrel_str = "minecraft:barrel_21"
local warehouse = peripheral.find("minecolonies:warehouse")

local xpbarrel = peripheral.wrap(xpbarrel_str)


function pushStuff(slot, destination)
    warehouse.pushItems(destination, slot, 64)
end

print("Starting SUPER glow ink machine")

function Main() 
    for slot, item in pairs(warehouse.list()) do
        if item.name == "minecraft:glow_ink_sac" then
            pushStuff(slot, xpbarrel_str)
            print("Tried to push glow")
        end
    end
end
while true do
    -- Main()
    pcall(Main)
    sleep(300)
end
