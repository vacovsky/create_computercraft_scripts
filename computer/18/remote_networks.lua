


local remoteNetworks = {
    quartzMine = {
        refinedResourceName = "Nether Quartz",
        name = "Quartz Mine",
        dimension = "nether",
        connectionString = "Create_RotationSpeedController_14",
        protocol = "nethermine",
        connection = nil,
        relevantItems = {
            "minecraft:quartz"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 128,
        currentSpeed = 0,
        priority = 2
    },
    glowstoneMine = {
        refinedResourceName = "Glowstone Dust",
        name = "Glowstone Mine",
        connectionString = "Create_RotationSpeedController_13",
        dimension = "nether",
        protocol = "nethermine",
        connection = nil,
        relevantItems = {
            "minecraft:glowstone_dust"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 128,
        currentSpeed = 0,
        priority = 3
    }
}

return remoteNetworks