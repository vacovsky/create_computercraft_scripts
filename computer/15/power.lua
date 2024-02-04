

local REFRESH_TIME = 5
local stressStr = "Create_Stressometer_0"
local speedStr = "Create_Speedometer_0"
local monitorStr = "monitor_2"
local boilerStr = "fluidTank_2"
-- local stress = peripheral.wrap(stressStr)
-- local speed = peripheral.wrap(speedStr)
-- local boiler = peripheral.wrap(boilerStr)

peripheral.wrap("Create_RotationSpeedController_2")
local remoteNetworks = {
    copperMine = {
        name = "Copppr Mine",
        connectionString = "Create_RotationSpeedController_2",
        connection = nil
    }
}


for network, props in pairs(remoteNetworks) do
    remoteNetworks[network].connection = peripheral.wrap(connectionString)
end



local monitor = peripheral.wrap(monitorStr)



function RightJustify(input, line)
    monitor.setCursorPos(monitor.getSize() - string.len(input), line)
    monitor.write(input)
end

function RenderDisplay()

    for network, props in pairs(remoteNetworks) do
        network.connection.
    end
        -- local line = 2
    -- monitor.setTextScale(1)
    -- monitor.clear()
    -- monitor.setCursorPos(2, line)
    -- monitor.setTextColor(8)
    -- monitor.write("Capacity Used")
    -- RightJustify(string.format("%.2f",(((  (stress.getStress() / stress.getStressCapacity()) * 100 ) * 10) / 10)) .. "%", line)

    -- line = line + 2
    -- monitor.setCursorPos(2, line)
    -- monitor.setTextColor(8)
    -- monitor.write("Rotation Speed")
    -- RightJustify(speed.getSpeed() .. " RPM", line)


    

end


function Main()




    RenderDisplay()
end



while true do
    Main()
    -- print("Stress: ", stress.getStress(), " / ",stress.getStressCapacity())
    -- print("Speed: ", speed.getSpeed())

    -- pcall(Main)
    sleep(REFRESH_TIME)
end