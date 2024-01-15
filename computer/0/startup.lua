json = require "json"

local colony = peripheral.find("colonyIntegrator")
local rs = peripheral.find("redstoneIntegrator")
local colonyName = "New Nodnol"
local targetItem = "minecraft:iron_ingot"
local hotDirection = "east"
local WAIT_SECONDS = 5
--------------------------



function GetColonyRequests()
    local reqs = colony.getRequests()
    WriteToFile(json.encode(reqs), "requests.json", "w")
    return reqs
end

function Main()
    -- get all requests
    local reqs = GetColonyRequests()
    local found = false
    for k, request in pairs(reqs) do
        for k2, item in pairs(request.items) do
            if item.name == targetItem then
                found = true
            end
        end
    end
    setRedstoneState(found)
end

function setRedstoneState(state)
    if state then
        print("Found req for " .. targetItem)
        rs.setOutput(hotDirection, false)
    else
        rs.setOutput(hotDirection, true)
    end
end



function WriteToFile(input, fileName, mode)
    local file = io.open(fileName, mode)
    io.output(file)
    io.write(input)
    io.close(file)
 end


 
while true do
    Main()
    sleep(WAIT_SECONDS)
    print("Loop finished. Next pass in "..WAIT_SECONDS.." seconds.")
 end

