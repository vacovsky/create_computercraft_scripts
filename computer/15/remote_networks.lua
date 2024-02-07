


local remoteNetworks = {
    copperMine = {
        refinedResourceName = "Copper Ingot",
        name = "Copper Mine",
        connectionString = "Create_RotationSpeedController_2",
        connection = nil,
        dimension = "world",
        relevantItems = {
            "minecraft:raw_copper",
            "minecraft:copper_ingot",
            "create:crushed_raw_copper"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 0
    },
    quartzMine = {
        refinedResourceName = "Nether Quartz",
        name = "Quartz Mine",
        dimension = "nether",
        connectionString = nil,
        protocol = "nethermine",
        connection = nil,
        relevantItems = {
            "minecraft:quartz"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 188,
        currentSpeed = 0,
        priority = 2
    },
    glowstoneMine = {
        refinedResourceName = "Glowstone Dust",
        name = "Glowstone Mine",
        connectionString = nil,
        dimension = "nether",
        protocol = "nethermine",
        connection = nil,
        relevantItems = {
            "minecraft:glowstone_dust"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 188,
        currentSpeed = 0,
        priority = 3
    },
    emeraldMine = {
        refinedResourceName = "Emerald",
        name = "Emerald Mine",
        connectionString = "Create_RotationSpeedController_5",
        dimension = "world",
        connection = nil,
        relevantItems = {
            "createoreexcavation:raw_emerald",
            "minecraft:emerald",
            "create:emerald_ore"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 3
    },
    ironGenerator = {
        refinedResourceName = "Iron Ingot",
        name = "Iron Generator",
        connectionString = "Create_RotationSpeedController_10",
        dimension = "world",
        connection = nil,
        relevantItems = {
            "minecraft:iron_ingot",
            "create:crushed_raw_iron"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 0
    },
    goldMine = {
        refinedResourceName = "Gold Ingot",
        name = "Gold Mine",
        connectionString = "Create_RotationSpeedController_8",
        dimension = "world",
        connection = nil,
        relevantItems = {
            "minecraft:raw_gold",
            "minecraft:gold_ingot",
            "create:crushed_raw_gold"
        }, 
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 0
    },
    lapisMine = {
        refinedResourceName = "Lapiz Lazuli",
        name = "Lapis Lazuli Mine",
        connectionString = "Create_RotationSpeedController_9",
        dimension = "world",
        connection = nil,
        relevantItems = {
            "minecraft:lapis_lazuli"
        },
        maximumStock = 2048,
        minSpeed = 64,
        maxSpeed = 256,
        currentSpeed = 0,
        priority = 3
    }
}

return remoteNetworks