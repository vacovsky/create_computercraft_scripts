json = require "json"

local colony = peripheral.find("colonyIntegrator")
-- local rs = peripheral.find("redstoneIntegrator")
-- local monitor = peripheral.find("monitor")
local sourceVault = peripheral.find("minecraft:chest")
local destinationVault = peripheral.find("minecraft:hopper")
local trash = peripheral.find("create:chute")
local passCount = 0
local colonyName = "New Nodnol"
local WAIT_SECONDS = 5
--------------------------


function GetColonyRequests()
    local reqs = colony.getRequests()
    -- WriteToFile(json.encode(reqs), "requests.json", "w")
    return reqs
end

function Main()
    local reqs = GetColonyRequests()
    for slot, vitem in pairs(sourceVault.list()) do
        local found = false
        for k, request in pairs(reqs) do
            for k2, item in pairs(request.items) do
                if item.name == vitem.name then
                    found = true
                end
            end
        end
        if not found then TransferItem(vitem, slot, trash) end
        print(passCount, "Trashing", vitem.name)
        
        -- SetRedstoneState(watchedItem.name, found, direction, watchedItem.strength)
        
        if found then
            print(passCount, "Delivering", vitem.name)
            TransferItem(vitem, slot, destinationVault) 
        end
        
    end
    -- renderMonitor()
end

function TransferItem(item, sourceSlot, destination)
    -- print(item.name, sourceSlot, destination)
    sourceVault.pushItems(peripheral.getName(destination), sourceSlot)
    -- print(json.encode(item))
end

function SetRedstoneState(item, state, direction, strength)
    print(item, tostring(state), direction, strength)
    if state then
        -- print("order found for " .. item .. " | activating redstone to " .. direction .. " : " .. tostring(strength))
        redstone.setAnalogOutput(direction, strength)
    else
        redstone.setAnalogOutput(direction, strength)
    end
end


function renderMonitor()
monitor.setTextScale(1)

    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Automatic Order Fulfillment")

    local counter = 3
    for direction, watchedItem in pairs(watchedItems) do
        monitor.setCursorPos(1, counter)
        monitor.write(direction .. "\t" .. watchedItem.name:gsub("minecraft:", "").. "\t" .. watchedItem.state .. "   ")
        counter = counter + 1
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
    passCount = passCount + 1
    -- term.clear()
    -- print("Loop finished. Next pass in "..WAIT_SECONDS.." seconds.")
end
