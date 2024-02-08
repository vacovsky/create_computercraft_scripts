local proto = "delete_item"
rednet.broadcast(arg[1], proto)
senderId, message, protocol = rednet.broadcast(arg[1], proto)
print("delete request sent for", arg[1])
