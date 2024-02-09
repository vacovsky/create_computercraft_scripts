local whThreshold = 0.6
local vault_string = "minecraft:barrel_13"
local warehouse = peripheral.find("minecolonies:warehouse")
local vault = peripheral.wrap(vault_string)

function PushToOtherWarehouse(slot)
    print("moving slot", slot)
    -- warehouse.pushItems(peripheral.getName(vault), slot, 64)
    warehouse.pushItems(vault_string, slot, 64)
end

print("Starting Warehouse Stock Balancer")
while true do
    if #warehouse.list() / warehouse.size() > whThreshold then
        local pushedCounter = 0
        local balancedVal = warehouse.size() - (warehouse.size() * whThreshold)
        for slot, item in pairs(warehouse.list()) do
            if pushedCounter <= balancedVal then
                PushToOtherWarehouse(slot)
                pushedCounter = pushedCounter + 1
            end
        end
        print("Tried to push", pushedCounter, "slots")
    end
    sleep(300)
end
