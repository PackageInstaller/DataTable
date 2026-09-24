local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	gamecore.start_register()

	for iter_1_0, iter_1_1 in pairs({}) do
		gamecore.register_enum(iter_1_1.name, arg_1_0(iter_1_1.path))
	end

	for iter_1_2, iter_1_3 in pairs((not arg_1_1 or nil) and {}) do
		gamecore.register_class_extend(iter_1_3.name, iter_1_3.path)
	end

	for iter_1_4, iter_1_5 in pairs({}) do
		gamecore.register_class_extend(iter_1_5.name, iter_1_5.path)
	end

	for iter_1_6, iter_1_7 in pairs({
		{
			path = "battle.battle_processor",
			name = "battle_processor"
		},
		{
			path = "visual.base_visual",
			name = "base_visual"
		},
		{
			path = "visual.character.character_visual",
			name = "character_visual"
		},
		{
			path = "visual.aircraft.aircraft_visual",
			name = "aircraft_visual"
		},
		{
			path = "visual.bomb.bomb_visual",
			name = "bomb_visual"
		},
		{
			path = "visual.torpedo.torpedo_visual",
			name = "torpedo_visual"
		},
		{
			path = "visual.depthcharge.depthcharge_visual",
			name = "depthcharge_visual"
		},
		{
			path = "visual.missile.missile_visual",
			name = "missile_visual"
		},
		{
			path = "visual.booster.booster_visual",
			name = "booster_visual"
		},
		{
			path = "visual.projectile.projectile_visual",
			name = "projectile_visual"
		},
		{
			path = "visual.effect",
			name = "effect"
		}
	}) do
		gamecore.register_class_module(iter_1_7.name, iter_1_7.path)
	end

	for iter_1_8, iter_1_9 in pairs({}) do
		gamecore.register_class_module(iter_1_9.name, iter_1_9.path)
	end

	for iter_1_10, iter_1_11 in pairs({
		{
			path = "battle.BattleManager",
			name = "BattleManager"
		}
	}) do
		gamecore.register_instance(iter_1_11.name, iter_1_11.path)
	end

	gamecore.finish_register(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_1(arg_2_0, arg_2_1)
	gamecore.BattleManager:checkInit()

	return true
end

return var_0_0
