

local colony = peripheral.find("colonyIntegrator")

local colonyInfo = colony.getInfo()
-- local buildings = colony.getBuildings()


function main() 
    refreshColonyInfo()
end 

function refreshColonyInfo()



    displayLatestColonyInfo()

    colonyInfo = colony.getInfo()
    -- buildings = colony.getBuildings()

    
end


-- monitor.setCursorPos(1, 1)
--     monitor.write(mc.getColonyName() .. ": " .. location.x  .. " " .. location.y .. " " .. location.z )

--     monitor.setCursorPos(1, 2)
--     monitor.write("Citizen Count: " .. mc.amountOfCitizens() .. " / " .. mc.maxOfCitizens())

--     monitor.setCursorPos(1, 3)
--     monitor.write("Happiness: " .. math.floor(mc.getHappiness()) .. " / 10" )

--     monitor.setCursorPos(1, 4)
--     monitor.write("Active Build Sites: " .. mc.amountOfConstructionSites())

--     monitor.setCursorPos(1, 5)
--     monitor.write("Under Attack: " .. underAttack)

--     monitor.setCursorPos(1,6)
--     monitor.write(textutils.formatTime(os.time()) .. "   ",true)


function displayLatestColonyInfo()
    term.setBackgroundColor(colours.black)  -- Set the background colour to black.
    term.clear()                            -- Paint the entire display with the current background colour.
    term.setCursorPos(1,1)

    print(colonyInfo.name, "(id:",colonyInfo.id..")")
    print("==========================")

    print()

    print("Style: ", colonyInfo.style)
    print("Happiness:", math.floor(colonyInfo.happiness), " / 10")
    print("Citizens: ", colonyInfo.citizens, "/", colonyInfo.maxCitizens)
    -- print("Buildings: ", #buildings)

    print()
    print()
    print("!!!!!   Alerts   !!!!!")
    print("==========================")
    print()
    if colonyInfo.raid then print("Colony is under attack!") end
    if colonyInfo.citizens + 2 >= colonyInfo.maxCitizens then print("- Open beds:", colonyInfo.maxCitizens - colonyInfo.citizens) end
    if colonyInfo.mourning then print("- Recent death") end
    if colonyInfo.happiness <= 8.5 then print("- Happiness is low:", math.floor(colonyInfo.happiness)) end
end

function getConstructionCount()
    local constructionSites = 0
    -- for k, v in pairs(buildings) do
    --     if v.wip then constructionSites = constructionSites + 1 end
    -- end 
    return constructionSites
end


while true do
    main()
    sleep(60)
end
