

local colony = peripheral.find("colonyIntegrator")

local buildings = nil
local citizens = nil
local requests = nil
local research = nil
local visitors = nil

function main() 
    if colony.isInColony() then
        refreshColonyInfo()
    else
        displayOutOfRangeWarning()
    end
end


function displayOutOfRangeWarning()
    term.setBackgroundColor(colors.red)  -- Set the background colour to black.
    term.clear()                            -- Paint the entire display with the current background colour.
    term.setCursorPos(0,10)
    printWithFormat("&0!!!!!  OUT  OF  RANGE  !!!!")
end

function refreshColonyInfo()
    citizens = colony.getCitizens()
    buildings = colony.getBuildings()
    requests = colony.getRequests()
    visitors = colony.getVisitors()
    -- research = colony.getResearch()
    displayLatestColonyInfo()
end


function printWithFormat(...)
    local s = "&1"
    for k, v in ipairs(arg) do
            s = s .. v
    end
    s = s .. "&0"

    local fields = {}
    local lastcolor, lastpos = "0", 0
    for pos, clr in s:gmatch"()&(%x)" do
            table.insert(fields, {s:sub(lastpos + 2, pos - 1), lastcolor})
            lastcolor, lastpos = clr , pos
    end

    for i = 2, #fields do
            term.setTextColor(2 ^ (tonumber(fields[i][2], 16)))
            io.write(fields[i][1])
    end
end

function displayLatestColonyInfo()
    term.setBackgroundColor(colors.black)  -- Set the background colour to black.
    term.clear()                            -- Paint the entire display with the current background colour.
    term.setCursorPos(1,1)

    printWithFormat("&3", colony.getColonyName(), "(id:", colony.getColonyID() .. ")")
    print("==========================")

    printWithFormat("&0")

    print("Style: ", colony.getColonyStyle())
    print("Happiness:", math.floor(colony.getHappiness()), " / 10")
    print("Citizens: ", colony.amountOfCitizens(), "/", colony.maxOfCitizens())
    print("Buildings:", #buildings, "~ ".. getConstructionCount() )
    print("Visitors: ", #visitors )
    -- print("Research:", getResearchedCount(), "/", #research)

    print()
    print()
    printWithFormat("&e!!!!!!!   Alerts   !!!!!!!")
    print("==========================")
    printWithFormat("&0")

    if colony.isUnderAttack() then
        printWithFormat("&e")
        print("- Colony is under attack!")
        printWithFormat("&0")
    end

    if getIdleBuilders() > 0 then 
        printWithFormat("&4")
        print("-", getIdleBuilders(), "idle builders")
        printWithFormat("&0")
    end

    if colony.amountOfCitizens() + 2 >= colony.maxOfCitizens() then
        printWithFormat("&6")
        print("-", colony.maxOfCitizens() - colony.amountOfCitizens(), "open beds")
        printWithFormat("&0")
    end

    if getOpenRequestsCount() > 0 then
        printWithFormat("&4")
        print("-", getOpenRequestsCount(), "open requests")
        printWithFormat("&0")
    end

    
    if getGuardedBuildingsCount() < #buildings then
        printWithFormat("&4")
        print("-", #buildings - getGuardedBuildingsCount(), "unguarded buildings")
        printWithFormat("&0")
    end

    if colony.getHappiness() <= 8.5 then
        printWithFormat("&3")
        print("- Happiness is low:", math.floor(colony.getHappiness()))
        printWithFormat("&0")
    end
    
    -- if colony.mourning then print("- Recent death") end
end

function getConstructionCount()
    local count = 0
    for k, v in pairs(buildings) do
        if not v.built then count = count + 1 end
    end
    return count
end

function getActiveResearchCount()
    local count = 0
    for k, v in pairs(research) do
        if not v.built then count = count + 1 end
    end
    return count
end

function getGuardedBuildingsCount()
    local count = 0
    for k, v in pairs(buildings) do
        if v.guarded then count = count + 1 end
    end
    return count
end

function getResearchedCount()
    local count = 0
    for k, v in pairs(research) do
        print(v.status)
        -- if not v.built then constructionSites = constructionSites + 1 end
    end
    return count
end

function getOpenRequestsCount()
    local count = 0
    for k, v in pairs(requests) do
        count = count + 1
    end
    return count
end

function getIdleBuilders()
    local count = 0
    for k, v in pairs(citizens) do
        if v.work.job == "com.minecolonies.job.builder" and v.isIdle then
            print(v.work.job)
            count = count + 1 
        end
    end
    return count
end




while true do
    main()
    sleep(30)
end
