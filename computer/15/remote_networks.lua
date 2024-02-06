


local remoteNetworks = {
    copperMine = {
        refinedResourceName = "Copper Ingot",
        name = "Copper Mine",
        connectionString = "Create_RotationSpeedController_2",
        connection = nil,
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
    emeraldMine = {
        refinedResourceName = "Emerald",
        name = "Emerald Mine",
        connectionString = "Create_RotationSpeedController_5",
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