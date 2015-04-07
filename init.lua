--
--Craftitem Bricks
--

--
--Bricks
--

minetest.register_craftitem("mudbrick:mudbrick", {
	description = "Mudbrick",
	inventory_image = "mudbrick_mudbrick.png",
	groups = {not_in_creative_inventory=1},
})


--
--Brick Blocks
--

minetest.register_node("mudbrick:mudbrick_1", {
	description = "Wet Mudbricks",
	tiles = {"mudbrick_mudbrick_wet.png"},
	paramtype = "light",
	groups = {crumbly=3, falling_node=1, mudbrick=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "mudbrick:mudbrick_2", {  
	description = "Mudbricks",
	tiles = { "mudbrick_mudbrick_dried.png"},
	paramtype = "light",
	groups = {cracky=3, stone=1, mudbrick=2},
	sounds = default.node_sound_stone_defaults(),
})


--
--Crafting
--

--
--Bricks
--

minetest.register_craft( {
type = 'shapeless',
        output = 'mudbrick:mudbrick 18',
        recipe = {'default:dirt', 'group:sand', 'farming:wheat', 'bucket:bucket_water'},
		replacements = {
			{'bucket:bucket_water', 'bucket:bucket_empty'},
		}
})

--
--Brick Blocks
--

minetest.register_craft({
        output = 'mudbrick:mudbrick_1',
        recipe = {
		{'mudbrick:mudbrick', 'mudbrick:mudbrick', 'mudbrick:mudbrick'},
		{'mudbrick:mudbrick', 'mudbrick:mudbrick', 'mudbrick:mudbrick'},
		{'mudbrick:mudbrick', 'mudbrick:mudbrick', 'mudbrick:mudbrick'},
	}
})

--
--Drying Mudbrick
--

minetest.register_abm({
	nodenames = {"group:mudbrick"},
	neighbors = {"group:cracky", "group:crumbly", "group:choppy"},
	interval = 600,
	chance = 2,
	action = function(pos, node)
		-- return if already complete
		if minetest.get_item_group(node.name, "mudbrick") == 2 then
			return
		end
		
		-- check light
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 1 then
			return
		end
		
		-- dry
		local height = minetest.get_item_group(node.name, "mudbrick") + 1
		minetest.set_node(pos, {name="mudbrick:mudbrick_"..height})
	end
})

--
--Stair and slab version of dry mudbrick
--

stairs.register_stair_and_slab("mudbrick", "mudbrick:mudbrick_2",
		{crumbly=2,cracky=2},
		{"mudbrick_mudbrick_dried.png"},
		"Mubdrick Stair",
		"Mudbrick Slab",
		default.node_sound_stone_defaults())