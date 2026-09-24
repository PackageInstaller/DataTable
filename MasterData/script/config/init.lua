local var_0_0 = {}
local var_0_1 = {
	"level",
	"ship",
	"ship_level",
	"equip",
	"map",
	"skill",
	"map_node",
	"monster",
	"monster_audit",
	"monster_formation",
	"skin",
	"skin_voucher_shop",
	"login_award",
	"music",
	"task",
	"shop",
	"cook_style",
	"expedition",
	"cook_book",
	"item",
	"role_name",
	"teacher",
	"tactics",
	"furniture",
	"medal",
	"chat_head",
	"bathhouse",
	"support",
	"spoils_shop",
	"guide",
	"ship_cg",
	"story_list",
	"cinema_story_list",
	"cinema_story_id_list",
	"cinema_link_list",
	"main_story_1",
	"main_story_2",
	"main_story_3",
	"main_story_4",
	"main_story_5",
	"main_story_6",
	"main_story_7",
	"main_story_8",
	"main_story_9",
	"main_story_10",
	"main_story_11",
	"main_story_12",
	"main_story_13",
	"main_story_14",
	"main_story_15",
	"main_story_16",
	"main_story_17",
	"main_story_18",
	"main_story_19",
	"main_story_20",
	"main_story_21",
	"main_story_22",
	"main_story_23",
	"main_story_24",
	"main_story_25",
	"character_story_1",
	"character_story_2",
	"character_story_3",
	"character_story_4",
	"character_story_5",
	"character_story_6",
	"character_story_7",
	"character_story_8",
	"character_story_9",
	"character_story_10",
	"ship_rule",
	"furniture_shop",
	"furniture_collection",
	"achievement",
	"furniture_case",
	"room_prefab",
	"support_atk",
	"robot",
	"ship_skill_buff",
	"map_campaign",
	"combats_shop",
	"sixth_map",
	"workshop",
	"specil_login_award",
	"sixth_map_node",
	"sixth_adjutant",
	"sixth_combat_buff",
	"ship_pve_buff",
	"ship_pve_combat_active",
	"ship_pve_active",
	"sixth_combat_chapter",
	"tower_map",
	"tower_buff_stone",
	"tower_buff",
	"ship_medal",
	"pevent_task",
	"pve_guide",
	"pve_ocean_cia",
	"pve_ocean_level",
	"pve_fifth_level",
	"ocean_map_node",
	"fifth_map_node",
	"pve_fifth_restore_shop",
	"pve_fifth_situations",
	"strike_award",
	"strike_weather",
	"strike_map_node",
	"strike_map",
	"strike_buff",
	"strike_intensify_buff",
	"pve_fifth_task",
	"pve_fifth_award",
	"room_animation",
	"joy_buff",
	"config",
	"abyss_map",
	"abyss_map_node",
	"abyss_chapter",
	"abyss_award",
	"abyss_buff",
	"abyss_combination_quality",
	"abyss_combination_type",
	"pve_active_map",
	"pve_active_map_node",
	"pve_active_buff",
	"pve_mix_map",
	"pve_mix_level",
	"pve_mix_level_node",
	"pve_mix_buff",
	"pve_score_answer",
	"pve_score_award",
	"pve_score_task",
	"pve_score_level",
	"pve_score_buff",
	"score_map_node",
	"ship_research",
	"research_equip",
	"pve_eighth_map",
	"pve_eighth_level",
	"pve_eighth_level_node",
	"pve_eighth_buff",
	"pve_eighth_enemy_buff",
	"pve_eighth_supportfleet",
	"pve_eighth_task",
	"pve_mist_ship",
	"pve_mist_chapter",
	"pve_mist_level",
	"pve_mist_level_node",
	"pve_mist_buff",
	"pve_mist_treasurebox",
	"pve_mist_award",
	"pve_mist_skill",
	"drop_available",
	"pve_ninth_task",
	"pve_ninth_task_server",
	"pve_ninth_award",
	"pve_ninth_level_node",
	"pve_ninth_buff",
	"pve_ninth_level",
	"sensitive_words",
	"ship_notice"
}

local function var_0_2()
	function gameconfig.guide_config.get_hinge_set()
		return gameconfig.__config_data__.guide_config.hinge_set
	end
end

local function var_0_3()
	function gameconfig.ship_level_config.get_total_exp_set()
		return gameconfig.__config_data__.ship_level_config.total_exp_set
	end
end

local function var_0_4()
	function gameconfig.ocean_map_node_config.get_start_node_id_by_id(arg_6_0)
		for iter_6_0, iter_6_1 in pairs(gameconfig.__config_data__.ocean_map_node_config.sequence) do
			if iter_6_1.id == arg_6_0 then
				return iter_6_1.start_node_id
			end
		end

		return nil
	end
end

local function var_0_5()
	function gameconfig.score_map_node_config.get_start_node_id_by_id(arg_8_0)
		for iter_8_0, iter_8_1 in pairs(gameconfig.__config_data__.score_map_node_config.sequence) do
			if iter_8_1.id == arg_8_0 then
				return iter_8_1.start_node_id
			end
		end

		return nil
	end
end

local function var_0_6()
	function gameconfig.pve_ninth_level_node_config.get_start_node_id_by_id(arg_10_0)
		for iter_10_0, iter_10_1 in pairs(gameconfig.__config_data__.pve_ninth_level_node_config.sequence) do
			if iter_10_1.id == arg_10_0 then
				return iter_10_1.start_node_id
			end
		end

		return nil
	end
end

local function var_0_7()
	function gameconfig.ship_config.find_abyss_object_by_cid(arg_12_0)
		if not gameconfig.__config_data__.ship_config.unique_cid[arg_12_0] then
			return nil
		end

		local var_12_0 = lx.clone_table(gameconfig.__config_data__.ship_config.sequence[gameconfig.__config_data__.ship_config.unique_cid[arg_12_0]])

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			if iter_12_0 == "equipment" or iter_12_0 == "equips" then
				local var_12_1 = {}

				for iter_12_2, iter_12_3 in pairs(iter_12_1) do
					table.insert(var_12_1, {
						id = iter_12_3
					})
				end

				if iter_12_0 == "equipment" then
					var_12_0.equipment = var_12_1

					break
				end

				if iter_12_0 == "equips" then
					var_12_0.equips = var_12_1
				end

				break
			end
		end

		return var_12_0
	end
end

local function var_0_8()
	function gameconfig.ship_config.get_h_model_normal_l_list()
		return gameconfig.__config_data__.ship_config.h_model_normal_l_list
	end

	function gameconfig.ship_config.get_h_model_normal_m_list()
		return gameconfig.__config_data__.ship_config.h_model_normal_m_list
	end

	function gameconfig.ship_config.get_h_model_normal_s_list()
		return gameconfig.__config_data__.ship_config.h_model_normal_s_list
	end

	function gameconfig.ship_config.get_h_model_normal_xm_list()
		return gameconfig.__config_data__.ship_config.h_model_normal_xm_list
	end
end

local function var_0_9()
	var_0_2()
	var_0_3()
	var_0_4()
	var_0_5()
	var_0_6()
	var_0_8()
	var_0_7()
end

function var_0_0.link(arg_19_0, arg_19_1)
	gamecore.config_loader.set_lua_root_path("script/config/")
	gamecore.config_loader.register_all(var_0_1)
end

function var_0_0.init(arg_20_0, arg_20_1)
	local var_20_0 = app:getSystem():getWritePath() .. "config.conf"

	lx_core_x.remove_data_packet(var_20_0)
	lx_core_x.add_data_packet(var_20_0)

	local var_20_1 = gamecore.config_loader

	if app:isPC() then
		-- block empty
	end

	local var_20_2 = app:getSystem():getChannel()
	local var_20_3 = "config/json/"

	if app:isPC() then
		var_20_3 = (var_20_2 == gameenum.common_type.channel.android_jp or var_20_2 == gameenum.common_type.channel.iOS_jp) and "config_jp/json/" or var_20_2 == gameenum.common_type.channel.android_cbt and "config_cbt/json/" or (var_20_2 == gameenum.common_type.channel.android_cn or var_20_2 == gameenum.common_type.channel.iOS_cn) and "config_cn/json/" or "config_cn/json/"
	end

	var_20_1.set_data_root_path(var_20_3)
	var_20_1.set_data_type("json")

	if app.sync_init then
		collectgarbage("stop")

		for iter_20_0, iter_20_1 in pairs(var_0_1) do
			local var_20_5 = ".json"
			local var_20_6 = var_20_3 .. iter_20_1 .. ".json"
			local var_20_7 = gameenum.common_type
			local var_20_8 = app:getSystem():getChannel()
			local var_20_9 = gameenum.common_type.open_broken
			local var_20_10 = var_20_1.get_change_config(gameenum.common_type.open_broken_list, iter_20_1)

			if not (var_20_8 == gameenum.common_type.channel.android_jp or var_20_8 == var_20_7.channel.iOS_jp or var_20_8 == var_20_7.iOS_cbt) and var_20_9 and var_20_10 then
				var_20_6 = var_20_3 .. var_20_10 .. var_20_5
			end

			local var_20_11 = var_20_1.get_change_config(var_20_7.open_audit_list, iter_20_1)

			if not var_20_1.init_one(iter_20_1, (gamecore.AuditServerManager:isAuditVersion() and var_20_11 or nil) and var_20_3 .. var_20_11 .. var_20_5) then
				log.errorlog("init all config failed!")

				return false
			end
		end

		collectgarbage("restart")
		collectgarbage("collect")
		var_0_9()
	else
		local var_20_12 = lx.QueueLoader

		for iter_20_2, iter_20_3 in pairs(var_0_1) do
			var_20_12:addTask(function()
				var_20_1.init_one(iter_20_3)

				return true
			end)
		end

		var_20_12:addTask(function()
			var_0_9()

			return true
		end)
	end

	return true
end

return var_0_0
