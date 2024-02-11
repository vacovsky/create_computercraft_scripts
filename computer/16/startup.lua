-- shell.openTab("warehouse_splitter")
rednet.open("right");

local warehouse = "minecolonies:warehouse_7"
local protocol = "mcwarehouselookup"

while true do
    local function clear() term.clear(); term.setCursorPos(1, 1); end
    sender, message = rednet.receive(protocol);
    clear();

    local response = {
        name = "message",
        count = 0
    }
    local warehouseContent = peripheral.wrap(warehouse).list()
    for slot, item in pairs(warehouseContent) do
        if message == item.name then
            response.count = response.count + item.count
        end
    end
    response.name = message
    rednet.send(sender, response, protocol)
end


