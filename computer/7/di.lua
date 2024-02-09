rednet.open("back");

local proto = "delete_item"
rednet.broadcast(arg[1], proto)
print("delete request sent for", arg[1])
