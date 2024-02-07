local stressStr = "Create_Stressometer_1"
local stress = peripheral.wrap(stressStr)
local statusFile = "state"
local protocol = "nethermine"
print("Starting Status API")


function ReadFile(fileName)
    -- local hRead = fs.open(fileName, "r")
    -- local t = textutils.unserialize(hRead.readLine())
    -- hRead.close()

    local t = assert(io.open(fileName, "rb"))
    local content = t:read("*all")
    t:close()

    print(t)
    return textutils.unserialize(content)
end

function GetSystemStressLevel() -- 0 thru 1
    return stress.getStress() / stress.getStressCapacity()
end

while true do
    local sender, message = rednet.receive(protocol);
    if message == "status" then
        local sf = ReadFile(statusFile)
        print(sf)
        rednet.send(sender, sf, protocol)
    end
    if message == "stress" then
        rednet.send(sender, string.format("%.2f",((((GetSystemStressLevel()) * 100 ) * 10) / 10)), protocol)
    end
    print("Served", sender, message)
end
