rednet.open("back");
local function clear() term.clear(); term.setCursorPos(1, 1); end
rednet.broadcast("list", "xpfarm");

senderId, message, protocol = rednet.receive("xpfarm",5)
for name, props in pairs(message) do
    print(name, props.amount, "/", props.capacity)
end


local warehouseProtocol = "mcwarehouselookup"
local itemQuery = "minecraft:emerald"

rednet.broadcast(itemQuery, warehouseProtocol);
senderId, message, protocol = rednet.receive(warehouseProtocol,5)
print(itemQuery, message.count)


print("== nether host check ==")
rednet.broadcast("stress", "nethermine", 5)
senderId, message, protocol = rednet.receive("nethermine" ,5)
print(message)

rednet.broadcast("status", "nethermine", 5)
senderId, message, protocol = rednet.receive("nethermine", 5)
for i, ii in pairs(message) do
    print(i,ii)
end

