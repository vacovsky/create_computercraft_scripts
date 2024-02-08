local proto = "delete_item"
rednet.broadcast(arg[1],proto);
senderId, message, protocol = rednet.receive(proto, 5)
print(message)