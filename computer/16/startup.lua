rednet.open("right");

local hyperXpStr = "minecolonies_warehouse"
local protocol = "mcwarehouselookup"

while true do
    local function clear() term.clear(); term.setCursorPos(1, 1); end
    sender, message = rednet.receive(protocol);
    clear();

    local response = 0
    local warehouseContent = warehouse.list()
    for slot, item in pairs(warehouseContent) do
        if message == item.name then
            response = response +  item.count
        end
    end

    rednet.send(sender, response, protocol)
end


