local var_0_0 = lx
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.ResourceLoader

lx.define_class("PreloadManager", function(arg_1_0)
	function arg_1_0.reset(arg_2_0)
		arg_2_0._battle_asset_path = {}
		arg_2_0._dormitory_asset_path = {}
		arg_2_0._ship_asset_path = {}
		arg_2_0._gotofight_map_asset_path = {}
	end

	function arg_1_0:preload_battle_asset(arg_3_1, arg_3_2, arg_3_3)
		if not arg_3_1 then
			return
		end

		local var_3_0 = 0

		local function var_3_1()
			var_3_0 = var_3_0 + 1

			if var_3_0 == 5 and arg_3_3 then
				arg_3_3()

				arg_3_3 = nil
			end
		end

		self:load_battle_bg_day(arg_3_1.bg_sea, var_3_1)
		self:load_battle_bg_night(arg_3_1.bg_sea, var_3_1)
		self:load_battle_weather_front(arg_3_1.bg_sea, var_3_1)
		self:load_player_unit(arg_3_2.player, var_3_1)
		self:load_enemy_unit(arg_3_2.enemy, var_3_1)
	end

	function arg_1_0:load_battle_music(arg_5_1)
		for iter_5_0, iter_5_1 in pairs((var_0_2:preload_battle_music_asset_list(arg_5_1))) do
			local var_5_1 = var_0_2:get_audio_url(var_0_2.common_icon.music_path, iter_5_1)

			var_0_3:preloadAsset(var_5_1)
			self:insert_loaded_ab(var_5_1)
		end
	end

	function arg_1_0:load_battle_prefab()
		for iter_6_0, iter_6_1 in pairs((var_0_2:preload_battle_prefab_asset_list())) do
			var_0_3:preloadAsset(iter_6_1)
			self:insert_loaded_ab(iter_6_1)
		end
	end

	function arg_1_0:load_battle_bg_day(arg_7_1, arg_7_2)
		local var_7_0 = var_0_2:get_final_battle_prefab_path(var_0_2.bg_spine.bg_day_path, arg_7_1)

		var_0_3:preloadAsset(var_7_0, arg_7_2)
		self:insert_loaded_ab(var_7_0)
	end

	function arg_1_0:load_battle_bg_night(arg_8_1, arg_8_2)
		local var_8_0 = var_0_2:get_final_battle_prefab_path(var_0_2.bg_spine.bg_night_path, arg_8_1)

		var_0_3:preloadAsset(var_8_0, arg_8_2)
		self:insert_loaded_ab(var_8_0)
	end

	function arg_1_0:load_battle_weather_front(arg_9_1, arg_9_2)
		local var_9_0 = var_0_2:get_weather_front(arg_9_1)

		if not var_9_0 then
			arg_9_2()

			return
		end

		local var_9_1 = var_0_2:get_final_battle_prefab_path(var_0_2.weather_type.weather_front, var_9_0)

		var_0_3:preloadAsset(var_9_1, arg_9_2)
		self:insert_loaded_ab(var_9_1)
	end

	function arg_1_0:load_battle_sea(arg_10_1)
		local var_10_0 = var_0_2:get_final_battle_prefab_path(var_0_2.bg_spine.sea_path)

		var_0_3:preloadAsset(var_10_0, arg_10_1)
		self:insert_loaded_ab(var_10_0)
	end

	function arg_1_0:load_battle_submarine_sea(arg_11_1)
		local var_11_0 = var_0_2:get_final_battle_prefab_path(var_0_2.bg_spine.bg_submarine)

		var_0_3:preloadAsset(var_11_0, arg_11_1)
		self:insert_loaded_ab(var_11_0)
	end

	function arg_1_0:load_player_unit(arg_12_1, arg_12_2)
		if not arg_12_1 then
			arg_12_2()

			return
		end

		local var_12_0 = gameconfig.ship_config
		local var_12_1 = 0

		local function var_12_2()
			var_12_1 = var_12_1 + 1

			if var_12_1 == #arg_12_1 * 2 then
				arg_12_2()
			end
		end

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			self:__preload_character(var_12_0.find_object_by_cid(iter_12_1.cid), gameconfig.skin_config, iter_12_1, var_12_2)
		end
	end

	function arg_1_0:load_enemy_unit(arg_14_1, arg_14_2)
		if not arg_14_1 then
			return
		end

		local var_14_0 = gameconfig.ship_config
		local var_14_1 = gameconfig.skin_config
		local var_14_3 = 0

		local function var_14_4()
			var_14_3 = var_14_3 + 1

			if var_14_3 == #arg_14_1 * 2 then
				arg_14_2()
			end
		end

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			self:__preload_character((iter_14_1.monster_type == gameenum.battle_type.enemy_type.monster or iter_14_1.monster_type == gameenum.battle_type.enemy_type.robot) and gameconfig.monster_config.find_object_by_id(iter_14_1.cid) or var_14_0.find_object_by_cid(iter_14_1.cid), var_14_1, iter_14_1, var_14_4)
		end
	end

	function arg_1_0:insert_loaded_ab(arg_16_1)
		if self._battle_asset_path[arg_16_1] then
			return
		end

		self._battle_asset_path[arg_16_1] = arg_16_1
	end

	function arg_1_0.unload_battle_asset(arg_17_0)
		var_0_3:clearPreload()

		if gamecore.BattleManager and gamecore.BattleManager.reset then
			gamecore.BattleManager:destroyBattleRes()
		end

		if gamecore.BattleRevampManager and gamecore.BattleRevampManager.reset then
			gamecore.BattleRevampManager:destroyBattleRes()
		end

		var_0_3:destroyAllUnusedAssets()
		System.GC.Collect()
		collectgarbage("collect")
	end

	function arg_1_0:preload_dormitory_asset(arg_18_1, arg_18_2)
		local var_18_0 = gameconfig.furniture_config.find_object_by_cid(arg_18_1.cid)

		if not var_18_0 then
			return
		end

		if var_18_0.star <= 0 or not var_18_0.star then
			-- block empty
		end

		local var_18_2 = var_0_2:get_ship_icon(var_0_2.furniture_s_img, var_18_0.icon)

		var_0_3:preloadAsset(var_18_2, arg_18_2)

		if self._dormitory_asset_path[var_18_2] then
			return
		end

		self._dormitory_asset_path[var_18_2] = var_18_2
	end

	function arg_1_0.unload_dormitory_asset(arg_19_0)
		var_0_3:clearPreload()
	end

	function arg_1_0:preload_gotofight_map_asset(arg_20_1, arg_20_2)
		local var_20_0 = string.format(var_0_2.map_path, arg_20_1.id, arg_20_1.id)

		var_0_3:preloadAsset(var_20_0, arg_20_2)

		self._gotofight_map_asset_path = self._gotofight_map_asset_path or {}

		if self._gotofight_map_asset_path[var_20_0] then
			return
		end

		self._gotofight_map_asset_path[var_20_0] = var_20_0
	end

	function arg_1_0.unload_gotofight_map_asset(arg_21_0)
		var_0_3:clearPreload()
	end

	function arg_1_0:preload_ship_asset(arg_22_1, arg_22_2)
		var_0_3:preloadAsset(arg_22_1, arg_22_2)

		if self._ship_asset_path[arg_22_1] then
			return
		end

		self._ship_asset_path[arg_22_1] = arg_22_1
	end

	function arg_1_0:__preload_character(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		local var_23_0 = arg_23_1.pic_id
		local var_23_1 = string.format(var_0_2.gunfire_spine.gun_spine_asset, "universal", "universal")

		if arg_23_3.skin_id and arg_23_3.skin_id ~= 0 then
			local var_23_2 = arg_23_2.find_object_by_cid(arg_23_3.skin_id)

			if var_23_2 then
				var_23_0 = var_23_2.icon

				if var_23_2.gun_type ~= "universal" then
					var_23_1 = string.format(var_0_2.gunfire_spine.gun_spine_asset, var_23_2.gun_type, var_23_2.gun_type)
				end
			end
		end

		local var_23_3, var_23_4 = var_0_3:get_hd_sprite((string.format(var_0_2.ship_icon.model_normal_l, var_23_0, var_23_0)))
		local var_23_5 = string.format(var_0_2.ship_spine, var_23_0, var_23_0)

		var_0_3:preloadAsset(var_23_1)
		var_0_3:preloadAsset(var_23_4, arg_23_4)
		var_0_3:preloadAsset(var_23_5, arg_23_4)
		self:insert_loaded_ab(var_23_1)
		self:insert_loaded_ab(var_23_4)
		self:insert_loaded_ab(var_23_5)
	end
end)

return function()
	local var_24_0 = var_0_0.class("PreloadManager")

	var_24_0:reset()

	return var_24_0
end
