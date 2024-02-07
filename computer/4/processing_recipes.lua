local processing_recipes = { _version = "0.0.1" }


local processing_recipes = {
    minecraft = {
        soul_sand = {
            name = "minecraft:soul_sand",
            input = {"minecraft:sand"},
            operation = "haunt"
        },
        prismarine_shard = {
            name = "minecraft:prismarine_shard",
            input = {"minecraft:lapis_lazuli"},
            operation = "haunt"
        },
        prismarine_crystals = {
            name = "minecraft:prismarine_crystals",
            input = {"minecraft:lapis_lazuli"},
            operation = "haunt"
        },
        soul_soil = {
            name = "minecraft:soul_soil",
            input = {"minecraft:dirt"},
            operation = "haunt"
        },
        gravel = {
            name = "minecraft:gravel",
            input = {"minecraft:cobblestone"},
            operation = "crush"
        },
        clay_ball = {
            name = "minecraft:clay_ball",
            input = {"minecraft:gravel"},
            operation = "wash"
        },
        gold_nugget = {
            name = "minecraft:gold_nugget",
            input = {"minecraft:gold_ingot"},
            operation = "breakdown"
        },
        iron_nugget = {
            name = "minecraft:iron_nugget",
            input = {"minecraft:iron_ingot"},
            operation = "breakdown"
        },
        quartz = {
            name = "minecraft:quartz",
            input = {"minecraft:soul_sand"},
            operation = "wash"
        },
        -- stone = {
        --     name = "minecraft:stone",
        --     input = "minecraft:cobblestone",
        --     operation = "smelt"
        -- },
        sand = {
            name = "minecraft:sand",
            input = {"minecraft:gravel"},
            operation = "crush"
        },
        smooth_stone = {
            name = "minecraft:smooth_stone",
            input = {"minecraft:stone"},
            operation = "smelt"
        },
        deepslate = {
            name = "minecraft:deepslate",
            input = {"minecraft:cobbled_deepslate"},
            operation = "smelt"
        },
        cobbled_deepslate = {
            name = "minecraft:cobbled_deepslate",
            input = {"minecraft:deepslate"},
            operation = "crush"
        },
        black_dye = {
            name = "minecraft:black_dye",
            input = {"minecraft:charcoal"},
            operation = "crush"
        },
        cracked_stone_bricks = {
            name = "minecraft:cracked_stone_bricks",
            input = {"minecraft:stone_bricks"},
            operation = "smelt"
        },
        string = { 
            name = "minecraft:string",
            input = {"minecraft:white_wool"},
            operation = "crush"
        },
        red_sand = { 
            name = "minecraft:red_sand",
            input = {"minecraft:terracotta", "minecraft:granite"},
            operation = "crush"
        },
        glass = { 
            name = "minecraft:glass",
            input = {"minecraft:sand"},
            operation = "smelt"
        },
        terracotta = { 
            name = "minecraft:terracotta",
            input = {"minecraft:clay"},
            operation = "smelt"
        },
        smooth_quartz = {
            name = "minecraft:smooth_quartz",
            input = {"minecraft:quartz_block"},
            operation = "smelt"
        },
        brick = {
            name = "minecraft:brick",
            input = {"minecraft:clay_ball"},
            operation = "smelt"
        },
        nether_brick = {
            name = "minecraft:nether_brick",
            input = {"minecraft:netherrack"},
            operation = "smelt"
        },
        sugar = {
            name = "minecraft:sugar",
            input = {"minecraft:sugarcane"},
            operation = "crush"
        },
        crying_obsidian = {
            name = "minecraft:crying_obsidian",
            input = {"minecraft:obsidian"},
            operation = "haunt"
        },
        popped_chorus_fruit = {
            name = "minecraft:popped_chorus_fruit",
            input = {"minecraft:chorus_fruit"},
            operation = "smelt"
        },
        copper_ingot = {
            name = "minecraft:copper_ingot",
            input = {"minecraft:raw_copper", "minecraft:copper_ore", "minecraft:deepslate_copper_ore", "create:crushed_raw_copper"},
            operation = "smelt"
        },
        gold_ingot = {
            name = "minecraft:gold_ingot",
            input = {"minecraft:raw_gold", "minecraft:gold_ore", "minecraft:deepslate_gold_ore", "create:crushed_raw_gold"},
            operation = "smelt"
        },
        stripped_oak_log = {
            name = "minecraft:stripped_oak_log",
            input = {"minecraft:oak_log"},
            operation = "saw"
        },
        stripped_spruce_log = {
            name = "minecraft:stripped_spruce_log",
            input = {"minecraft:spruce_log"},
            operation = "saw"
        },
        stripped_dark_oak_log = {
            name = "minecraft:stripped_dark_oak_log",
            input = {"minecraft:dark_oak_log"},
            operation = "saw"
        },
        bamboo_planks = {
            name = "minecraft:bamboo_planks",
            input = {"minecraft:bamboo_block"},
            operation = "breakdown"
        },
        blackstone = {
            name = "minecraft:blackstone",
            input = {"minecraft:cobblestone"},
            operation = "haunt"
        },
        emerald = {
            name = "minecraft:emerald",
            input = {"createoreexcavation:raw_emerald"},
            operation = "saw"
        },
        diamond = {
            name = "minecraft:diamond",
            input = {"createoreexcavation:raw_diamond"},
            operation = "saw"
        },
        steak = {
            name = "minecraft:steak",
            input = {"minecraft:raw_beef"},
            operation = "cook"
        },
        dried_kelp = {
            name = "minecraft:dried_kelp",
            input = {"minecraft:kelp"},
            operation = "cook"
        },
        cracked_deepslate_bricks = {
            name = "minecraft:cracked_deepslate_bricks",
            input = {"minecraft:deepslate_bricks"},
            operation = "smelt"
        },
        cracked_polished_blackstone_bricks = {
            name = "minecraft:cracked_polished_blackstone_bricks",
            input = {"minecraft:polished_blackstone_bricks"},
            operation = "smelt"
        }
    },
    create = {
        cinder_flour = {
            name = "create:cinder_flour",
            input = {"minecraft:netherrack"},
            operation = "crush"
        },
        blaze_cake_base = {
            name = "create:blaze_cake_base",
            input = {"minecraft:egg", "minecraft:sugar", "create:cinder_flour"},
            operation = "press"
        },
        copper_sheet = {
            name = "create:copper_sheet",
            input = {"minecraft:copper_ingot"},
            operation = "press"
        },
        brass_sheet = {
            name = "create:brass_sheet",
            input = {"minecraft:brass_ingot"},
            operation = "press"
        },
        gold_sheet = {
            name = "create:golden_sheet",
            input = {"minecraft:gold_ingot"},
            operation = "press"
        },
        wheat_flour = {
            name = "create:wheat_flour",
            input = {"minecraft:wheat"},
            operation = "crush"
        },
        dough = {
            name = "create:dough",
            input = {"create:wheat_flour"},
            operation = "mixwater"
        },
        iron_sheet = {
            name = "create:iron_sheet",
            input = {"minecraft:iron_ingot"},
            operation = "press"
        }
    }
}

return processing_recipes