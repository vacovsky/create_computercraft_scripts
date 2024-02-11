

local REFRESH_TIME = 1
local stressStr = "Create_Stressometer_0"
local speedStr = "Create_Speedometer_0"
local monitorStr = "monitor_1"
local boilerStr = "fluidTank_2"

local stress = peripheral.wrap(stressStr)
local speed = peripheral.wrap(speedStr)
-- local boiler = peripheral.wrap(boilerStr)
local monitor = peripheral.wrap(monitorStr)



function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
    monitor.write(input)
end

function RenderDisplay()
    local line = 2
    monitor.setTextScale(1)
    monitor.clear()
    monitor.setCursorPos(2, line)
    monitor.setTextColor(8)
    monitor.write("Capacity Used")
    RightJustify(string.format("%.2f",(((  (stress.getStress() / stress.getStressCapacity()) * 100 ) * 10) / 10)) .. "%", line)

    line = line + 2
    monitor.setCursorPos(2, line)
    monitor.setTextColor(8)
    monitor.write("Rotation Speed")
    RightJustify(speed.getSpeed() .. " RPM", line)
end


function Main()
    RenderDisplay()
end



while true do
    -- Main()
    print("Stress: ", stress.getStress(), " / ",stress.getStressCapacity())
    print("Speed: ", speed.getSpeed())

    pcall(Main)
    sleep(REFRESH_TIME)
end