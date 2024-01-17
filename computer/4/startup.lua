json = require "json"
processors = require "processors"
recipes = require("processing_recipes")


local COLONY_NAME = "New Nodnol"
local WAIT_SECONDS = 5

local colony = peripheral.find("colonyIntegrator")
local warehouse = peripheral.find("minecolonies:warehouse")
local activeOrders = {}
local currentMatchingOrders = {}
local monitor = peripheral.find("monitor")


local warehouseContent = {}
--------------------------


function GetColonyRequests()
    local reqs = colony.getRequests()
    -- WriteToFile(json.encode(reqs), "requests.json", "w")
    return reqs
end

function Main()

    warehouseContent = warehouse.list()

    local reqs = GetColonyRequests()
        local foundRequest = nil
        local foundRecipe = nil
        local found = false

        for k, request in pairs(reqs) do
            for k2, item in pairs(request.items) do
                for mod, recipeItem in pairs(recipes) do
                    for rItem, recipe in pairs(recipes[mod]) do
                        -- print(recipe, item.name)
                        if recipe.name == item.name then
                            found = true
                            foundRequest = request
                            foundRecipe = recipe
                        end
                end
            end
        end
        if found then 
            activeOrders[foundRecipe.name] = foundRequest.minCount
            TransferItem(foundRecipe, foundRequest)
        end
    end
    renderMonitor()
end

-- determine if precursor exists in warehouse, and return slot if so
function LocateIngredients(item_name)
    local slotNum = nil
    for slot, wItem in pairs(warehouseContent) do
        if item_name == wItem.name then
            slotNum = slot
        end
    end
    print(item_name, slotNum)
    return slotNum
end

function TransferItem(recipe, request)
    local slot = LocateIngredients(recipe.input)
    print(recipe.name, request.minCount, slot, processors[recipe.operation])

    if slot ~= nil then
        local processor = peripheral.wrap(processors[recipe.operation])
        warehouse.pushItems(processors[recipe.operation], slot, request.minCount)
        -- warehouse.pushItems(peripheral.getName(processor), slot, request.minCount)
    end
end


function renderMonitor()
    monitor.setTextScale(2)
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Automated Processing")

    local counter = 3
    local noOrderCounter = counter
    for item, count in pairs(activeOrders) do
        monitor.setCursorPos(1, counter)
        monitor.write(count .. " " .. item)
        counter = counter + 1
    end
    if counter == noOrderCounter then
        monitor.setCursorPos(1, counter)
        monitor.write("No active orders.")
    end
    activeOrders = {}
end

function WriteToFile(input, fileName, mode)
    local file = io.open(fileName, mode)
    io.output(file)
    io.write(input)
    io.close(file)
 end


while true do
    term.setBackgroundColor(colours.black)  -- Set the background colour to black.
    term.clear()                            -- Paint the entire display with the current background colour.
    term.setCursorPos(1,1)
    pcall(Main)
    sleep(WAIT_SECONDS)

    -- print("Loop finished. Next pass in "..WAIT_SECONDS.." seconds.")
    -- renderMonitor()
end
