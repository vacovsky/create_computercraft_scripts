rednet.open("left");

local hyperXpStr = "fluidTank_4"
local xpStr = "fluidTank_5"
local protocol = "xpfarm"

while true do
    local function clear() term.clear(); term.setCursorPos(1, 1); end
    sender, message = rednet.receive(protocol);
    clear();
    if message == "list" then
        local response = {
            hyper = peripheral.wrap(hyperXpStr).getInfo(),
            xp = peripheral.wrap(xpStr).getInfo()
        }
        rednet.broadcast(response, protocol)
    end
end


