json = require "json"

local colony = peripheral.find("colonyIntegrator")
-- local rs = peripheral.find("redstoneIntegrator")
local monitor = peripheral.find("monitor")
local colonyName = "New Nodnol"
monitor.setTextScale(1)


local watchedItems = {
    back = {
        name = "minecraft:iron_ingot",
        onStrength = 0,
        offStrength = 1,
        state = "Off"
    }
}

local WAIT_SECONDS = 5
--------------------------

function GetColonyRequests()
    local reqs = colony.getRequests()
    -- WriteToFile(json.encode(reqs), "requests.json", "w")
    return reqs
end

function Main()
    -- get all requests
    local reqs = GetColonyRequests()
    for direction, watchedItem in pairs(watchedItems) do
        local found = false
        for k, request in pairs(reqs) do
            for k2, item in pairs(request.items) do
                if item.name == watchedItem.name then
                    found = true
                end
            end
        end
        if found then watchedItems[direction].state = "On" else watchedItems[direction].state = "Off" end
        setRedstoneState(watchedItem, found, direction)
    end
    renderMonitor()
end

function setRedstoneState(item, state, direction)
    -- print(item, tostring(state), direction, strength)
    if state then
        -- print("order found for " .. item .. " | activating redstone to " .. direction .. " : " .. tostring(strength))
        redstone.setAnalogOutput(direction, item.onStrength)
    else
        redstone.setAnalogOutput(direction, item.offStrength)
    end
end


function renderMonitor()
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
    print("Loop finished. Next pass in "..WAIT_SECONDS.." seconds.")
end



-- json = require "json"

-- local colony = peripheral.find("colonyIntegrator")
-- -- local rs = peripheral.find("redstoneIntegrator")
-- local colonyName = "New Nodnol"
-- local targetItem = "minecraft:iron_ingot"
-- local hotDirection = "back"
-- local WAIT_SECONDS = 5
-- --------------------------



-- function GetColonyRequests()
--     local reqs = colony.getRequests()
--     WriteToFile(json.encode(reqs), "requests.json", "w")
--     return reqs
-- end

-- function Main()
--     -- get all requests
--     local reqs = GetColonyRequests()
--     local found = false
--     for k, request in pairs(reqs) do
--         for k2, item in pairs(request.items) do
--             if item.name == targetItem then
--                 found = true
--             end
--         end
--     end
--     setRedstoneState(found)
-- end

-- function setRedstoneState(state)
--     if state then
--         print("Found req for " .. targetItem)
--         redstone.setAnalogOutput(hotDirection, 0)
--     else
--         redstone.setAnalogOutput(hotDirection, 1)
--     end
-- end



-- function WriteToFile(input, fileName, mode)
--     local file = io.open(fileName, mode)
--     io.output(file)
--     io.write(input)
--     io.close(file)
--  end


 
-- while true do
--     Main()
--     sleep(WAIT_SECONDS)
--     print("Loop finished. Next pass in "..WAIT_SECONDS.." seconds.")
--  end

