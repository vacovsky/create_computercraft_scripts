rednet.open("right");


local protocol = "delete_item"
local trash_string = "create:chute_0"
local warehouse = peripheral.find("minecolonies:warehouse")
local trash = peripheral.wrap(trash_string)


function FindItemLocationsInWarehouse(itemId)
    print("searching for", itemId)
    local matchedSlots = {}
    for slot, item in pairs(warehouse.list()) do
        if item.name == itemId then
             table.insert(matchedSlots, slot)
        end
    end
    return matchedSlots
end

function PushToTrash(slots)
    for index, slot in pairs(slots) do
        print("deleting slot", slot)
        warehouse.pushItems(trash_string, slot, 64)
    end
end

print("Starting Trash Item API - BE CAREFUL")
while true do
    local sender, message = rednet.receive(protocol);
    print("delete request recieved for", message)
    local itemSlots = FindItemLocationsInWarehouse(message)
    if itemSlots ~= nil then
        PushToTrash(itemSlots)
    else
        print("item not found")
    end
end
