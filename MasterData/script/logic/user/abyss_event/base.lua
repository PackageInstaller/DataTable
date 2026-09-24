local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gameconfig.ship_config
local var_0_3 = gamecore.UILoader
local var_0_4 = lx.clone_table
local var_0_5 = gameconfig.abyss_map_config
local var_0_6 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:reset_abyss_data()
		self._abyss_main_info = {}
		self._abyss_world_boss_info = {}
		self._abyss_map_info_dic = {}
		self._abyss_pass_point_dic = {}
		self._abyss_user_award = {}

		self:reset_abyss_character_list()

		self._abyss_character_attribute = {}
		self._abyss_attribute_effect_by_equip = {}

		self:reset_abyss_power()
		self:reset_abyss_enter_repair_time()

		self._abyss_player_fighting = false
	end

	function arg_1_0.set_boss_chapter_config(arg_3_0, arg_3_1)
		arg_3_0._abyss_boss_chapter_config = arg_3_1
	end

	function arg_1_0:get_boss_chapter_config()
		return self._abyss_boss_chapter_config or {}
	end

	function arg_1_0.set_sub_chapter_config(arg_5_0, arg_5_1)
		arg_5_0._abyss_sub_chapter_config = arg_5_1
	end

	function arg_1_0:get_sub_chapter_config()
		return self._abyss_sub_chapter_config or {}
	end

	function arg_1_0.set_abyss_level_cfg(arg_7_0, arg_7_1)
		arg_7_0._abyss_level_cfg = arg_7_1
	end

	function arg_1_0:get_abyss_level_cfg(arg_8_1)
		if self._abyss_level_cfg then
			return self._abyss_level_cfg[arg_8_1]
		end
	end

	function arg_1_0:abyss_level_cfg_load_comp()
		if self._abyss_level_cfg and next(self._abyss_level_cfg) then
			return true
		end
	end

	function arg_1_0:__set_abyss_info(arg_10_1)
		if not arg_10_1.info then
			return
		end

		for iter_10_0, iter_10_1 in pairs(arg_10_1.info) do
			self._abyss_main_info[iter_10_0] = iter_10_1
		end
	end

	function arg_1_0:check_abyss_first_in()
		if self._abyss_main_info then
			return self._abyss_main_info.guide
		end
	end

	function arg_1_0:get_user_abyss_point()
		if self._abyss_main_info then
			return self._abyss_main_info.score or 0
		end

		return 0
	end

	function arg_1_0:get_user_abyss_boss_count()
		if self._abyss_main_info then
			return self._abyss_main_info.boss_count or 0
		end

		return 0
	end

	function arg_1_0:__set_user_abyss_award(arg_14_1)
		if not next(self._abyss_user_award) then
			self._abyss_user_award = arg_14_1

			return
		end

		if arg_14_1.id ~= self._abyss_user_award[1].id then
			table.insert(self._abyss_user_award, {
				id = arg_14_1[1].id
			})
		end

		if arg_14_1.id then
			for iter_14_0, iter_14_1 in ipairs(arg_14_1.id) do
				self._abyss_user_award[iter_14_1] = true
			end
		end
	end

	function arg_1_0:get_user_abyss_award()
		return self._abyss_user_award or {}
	end

	function arg_1_0:check_abyss_user_award(arg_16_1)
		self._abyss_user_award = self._abyss_user_award or {}

		return self._abyss_user_award[arg_16_1]
	end

	function arg_1_0:get_abyss_now_chapter_cfg()
		return self._abyss_now_chapter_cfg
	end

	function arg_1_0.set_abyss_now_chapter_cfg(arg_18_0, arg_18_1)
		arg_18_0._abyss_now_chapter_cfg = arg_18_1
	end

	function arg_1_0.set_abyss_preview_now_page(arg_19_0, arg_19_1)
		arg_19_0._abyss_preview_now_page = arg_19_1
	end

	function arg_1_0:get_abyss_preview_now_page()
		return self._abyss_preview_now_page or 0
	end

	function arg_1_0:set_abyss_world_boss_info(arg_21_1)
		self._abyss_world_boss_info = self._abyss_world_boss_info or {}

		if arg_21_1 then
			for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
				self._abyss_world_boss_info[iter_21_1.chapter_id] = iter_21_1
			end
		end
	end

	function arg_1_0:get_abyss_world_boss_info(arg_22_1)
		self._abyss_world_boss_info = self._abyss_world_boss_info or {}

		return self._abyss_world_boss_info[arg_22_1]
	end

	function arg_1_0.setAbyssBossInfoRespCallback(arg_23_0, arg_23_1)
		arg_23_0._AbyssBossInfoResp_callback = arg_23_1
	end

	function arg_1_0:AbyssBossInfoRespCallback()
		if self._AbyssBossInfoResp_callback then
			self._AbyssBossInfoResp_callback()

			self._AbyssBossInfoResp_callback = nil
		end
	end

	function arg_1_0.setAbyssAwardBoxRespCallback(arg_25_0, arg_25_1)
		arg_25_0._AbyssAwardBoxResp_callback = arg_25_1
	end

	function arg_1_0:AbyssAwardBoxRespCallback()
		if self._AbyssAwardBoxResp_callback then
			self._AbyssAwardBoxResp_callback()
		end

		self._AbyssAwardBoxResp_callback = nil
	end

	function arg_1_0:__analyze_abyss_map_info(arg_27_1)
		self._abyss_map_info_dic = self._abyss_map_info_dic or {}
		self._abyss_pass_point_dic = self._abyss_pass_point_dic or {}

		if arg_27_1 then
			for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
				local var_27_0 = var_0_5.find_object_by_id(iter_27_1.info.id)

				if var_27_0 then
					local var_27_1 = self._abyss_map_info_dic[var_27_0.pve_id] or {
						levels = {}
					}

					var_27_1.levels[iter_27_1.info.id] = iter_27_1.info.state

					local var_27_2 = 0

					for iter_27_2, iter_27_3 in pairs(var_27_1.levels) do
						var_27_2 = var_27_2 + iter_27_3
					end

					var_27_1.state = var_27_2 == 4
					self._abyss_map_info_dic[var_27_0.pve_id] = var_27_1
				end

				if iter_27_1.info.pass_point then
					for iter_27_4, iter_27_5 in ipairs(iter_27_1.info.pass_point) do
						self._abyss_pass_point_dic[iter_27_5.id] = iter_27_5.info
					end
				end
			end
		end
	end

	function arg_1_0:check_chapter_pass(arg_28_1)
		self._abyss_map_info_dic = self._abyss_map_info_dic or {}

		return (self._abyss_map_info_dic[arg_28_1] or nil) and (self._abyss_map_info_dic[arg_28_1].state or false)
	end

	function arg_1_0.set_boss_open(arg_29_0, arg_29_1)
		arg_29_0._is_boss_open = arg_29_1
	end

	function arg_1_0:get_boss_open()
		return self._is_boss_open
	end

	function arg_1_0:get_abyss_pass_point_info(arg_31_1)
		self._abyss_pass_point_dic = self._abyss_pass_point_dic or {}

		return self._abyss_pass_point_dic[arg_31_1]
	end

	function arg_1_0:get_normal_team_info()
		return self._normal_team_members
	end

	function arg_1_0:get_abyss_team_info()
		return self._abyss_team_members
	end

	function arg_1_0.set_normal_team_info(arg_34_0, arg_34_1)
		arg_34_0._normal_team_members = arg_34_1
	end

	function arg_1_0.set_abyss_team_info(arg_35_0, arg_35_1)
		arg_35_0._abyss_team_members = arg_35_1
	end

	function arg_1_0:set_abyss_team_buff_info(arg_36_1)
		self._abyss_buff_info = arg_36_1
		self._abyss_map_buff = {}

		local var_36_0 = arg_36_1.info.map_buff

		if not self._abyss_map_buff or not next(arg_36_1.info.map_buff) then
			self._abyss_map_buff = {}
		end

		if var_36_0 then
			for iter_36_0, iter_36_1 in pairs(var_36_0) do
				self._abyss_map_buff[iter_36_1.point_id] = iter_36_1.buff_id
			end
		end
	end

	function arg_1_0:get_abyss_ship_node_buff(arg_37_1)
		if self._abyss_map_buff then
			return self._abyss_map_buff[arg_37_1]
		end
	end

	function arg_1_0:get_abyss_ship_map_node_buff()
		if self._abyss_map_buff then
			return self._abyss_map_buff
		end
	end

	function arg_1_0.set_abyss_team_buff_info_empty(arg_39_0)
		arg_39_0._abyss_map_buff = nil
	end

	function arg_1_0:get_abyss_team_buff_info()
		return self._abyss_buff_info.info
	end

	function arg_1_0:check_if_get_abyss_buff(arg_41_1)
		local var_41_0 = self:get_abyss_team_buff_info()

		if var_41_0 and next(var_41_0.map_buff) then
			local var_41_1 = 0

			for iter_41_0, iter_41_1 in pairs(var_41_0.map_buff) do
				if iter_41_1.point_id == arg_41_1 then
					var_41_1 = iter_41_1.buff_id
				end
			end

			if math.floor(arg_41_1 / 100) == var_41_0.map_id_1 then
				if var_0_6.have_data(var_41_0.buff_1, var_41_1) then
					return true
				end
			elseif math.floor(arg_41_1 / 100) == var_41_0.map_id_2 and var_0_6.have_data(var_41_0.buff_2, var_41_1) then
				return true
			end
		end

		return false
	end

	function arg_1_0:find_abyss_character_by_id(arg_42_1)
		return self._abyss_character_data.character[arg_42_1]
	end

	function arg_1_0:get_abyss_character_list()
		return self._abyss_character_data.character
	end

	function arg_1_0:reset_abyss_character_list()
		self._abyss_character_data.character = {}
	end

	function arg_1_0:get_abyss_character_intensify(arg_45_1)
		local var_45_0 = self:find_abyss_character_by_id(arg_45_1)

		if not var_45_0 then
			return
		end

		return var_45_0.intensify or {}
	end

	function arg_1_0:get_abyss_character_attribute(arg_46_1)
		return self._abyss_character_attribute[arg_46_1] or {}
	end

	function arg_1_0:get_abyss_character_attribute_by_calculate(arg_47_1)
		local var_47_0 = self._abyss_character_attribute_by_calculate[arg_47_1]

		if not self._abyss_character_attribute_by_calculate[arg_47_1] then
			var_47_0 = var_0_4(self._abyss_character_attribute[arg_47_1])

			local var_47_1 = {
				[arg_47_1] = var_47_0
			}

			self:__calculate_abyss_attribute_by_intensify(arg_47_1, var_47_1)
			self:__calculate_abyss_attribute_by_equips(arg_47_1, var_47_1)

			self._abyss_character_attribute_by_calculate[arg_47_1] = var_47_0
		end

		return var_47_0
	end

	function arg_1_0:get_abyss_character_attribute_by_calculate_no_equips(arg_48_1)
		local var_48_0 = self._abyss_character_attribute_by_calculate_no_equips[arg_48_1]

		if not self._abyss_character_attribute_by_calculate_no_equips[arg_48_1] then
			var_48_0 = var_0_4(self._abyss_character_attribute[arg_48_1])

			self:__calculate_abyss_attribute_by_intensify(arg_48_1, {
				[arg_48_1] = var_48_0
			})

			self._abyss_character_attribute_by_calculate_no_equips[arg_48_1] = var_48_0
		end

		return var_48_0
	end

	function arg_1_0:get_abyss_attribute_effect_by_equip(arg_49_1)
		return self._abyss_attribute_effect_by_equip[arg_49_1]
	end

	function arg_1_0.__abyss_team__save_team_ok(arg_50_0)
		local var_50_0 = var_0_3:getInstance("abyss_dock_team")

		if var_50_0 then
			var_50_0:refresh_info_list()
		end

		local var_50_1 = var_0_3:getInstance("fight_prepare")

		if var_50_1 then
			var_50_1:update_abyss_model_team_list(var_50_1:get_curr_content_type(), (var_50_1:get_team_type()))
			var_50_1:__set_total_props_panel_data()
		end

		local var_50_2 = var_0_3:getInstance("pre_formation")

		if var_50_2 then
			var_50_2:refresh_info_list()
		end
	end

	function arg_1_0.__abyss_team__save_team_error(arg_51_0, arg_51_1)
		local var_51_0 = var_0_3:getInstance("pre_formation")

		if var_51_0 then
			var_51_0:team_save_error(arg_51_1)

			return
		end

		local var_51_1 = var_0_3:getInstance("fight_prepare")

		if var_51_1 then
			var_51_1:team_save_error(arg_51_1)
		end

		local var_51_2 = var_0_3:getInstance("abyss_dock_team")

		if var_51_2 then
			var_51_2:team_save_error(arg_51_1)
		end
	end

	function arg_1_0:__abyss_add_character_info(arg_52_1)
		self._abyss_character_data.character[arg_52_1.id] = self:__compound_data(arg_52_1)

		self:__update_abyss_character_attribute(self:__compound_data(arg_52_1))
	end

	function arg_1_0:__abyss_update_character_info(arg_53_1)
		self._abyss_character_data.character[arg_53_1.id] = self:__compound_data(arg_53_1)

		self:__update_abyss_character_attribute(self:__compound_data(arg_53_1))
	end

	function arg_1_0:__abyss_remove_character_info(arg_54_1)
		self._abyss_character_data.character[arg_54_1.id] = nil

		self:__remove_abyss_character_attribute_by_id(arg_54_1.id)
	end

	function arg_1_0.__compound_data(arg_55_0, arg_55_1)
		local var_55_0 = var_0_2.find_abyss_object_by_cid(arg_55_1.cid)

		return {
			bullet = 0,
			skin = 0,
			oil = 0,
			love = 0,
			now_bullet = 0,
			now_oil = 0,
			id = arg_55_1.id,
			cid = arg_55_1.cid,
			level = arg_55_1.level,
			exp = arg_55_1.exp,
			evo_cid = var_55_0.evo_cid,
			star = var_55_0.star,
			name = var_55_0.title,
			type = var_55_0.type,
			hp = var_55_0.hp,
			atk = var_55_0.atk,
			def = var_55_0.def,
			miss = var_55_0.miss,
			capacity = var_55_0.capacity,
			speed = var_55_0.speed,
			range = var_55_0.range,
			torpedo = var_55_0.torpedo,
			air_def = var_55_0.air_def,
			antisub = var_55_0.antisub,
			radar = var_55_0.radar,
			luck = var_55_0.luck,
			hit = var_55_0.hit,
			equip_num = var_55_0.equip_num,
			equips = var_55_0.equipment,
			now_skill = var_55_0.now_skill,
			skill_level = var_55_0.skill_level,
			intensify = var_55_0.intensify,
			record = var_55_0.record,
			now_hp = arg_55_1.now_hp,
			boss = var_55_0.boss,
			can_evo = var_55_0.can_evo,
			evo_to_cid = var_55_0.evo_to_cid,
			evo_level = var_55_0.evo_level,
			skill_id = var_55_0.skill_id,
			evo_need_resource = var_55_0.evo_need_resource,
			title = var_55_0.title,
			class_no = var_55_0.class_no,
			country = var_55_0.country,
			pic_id = var_55_0.pic_id,
			statistics = {
				create_time = arg_55_1.create_time
			}
		}
	end

	function arg_1_0.set_abyss_fight_info_param(arg_56_0, arg_56_1)
		arg_56_0._abyss_fight_info_param = arg_56_1
	end

	function arg_1_0:get_abyss_fight_info_param()
		return self._abyss_fight_info_param
	end

	function arg_1_0.set_abyss_fight_team_detail(arg_58_0, arg_58_1)
		arg_58_0._abyss_fight_team_detail_info = arg_58_1
	end

	function arg_1_0:get_abyss_fight_team_detail()
		return self._abyss_fight_team_detail_info or {}
	end

	function arg_1_0.sava_abyss_power(arg_60_0, arg_60_1)
		arg_60_0._abyss_team_power = arg_60_1.info.abyss_power == 0 and 30 or arg_60_1.info.abyss_power
	end

	function arg_1_0:get_abyss_power()
		return self._abyss_team_power or 30
	end

	function arg_1_0.reset_abyss_power(arg_62_0)
		arg_62_0._abyss_team_power = nil
	end

	function arg_1_0:record_abyss_enter_repair_point()
		self._abyss_enter_repair_time = self:get_abyss_enter_repair_time() + 1
	end

	function arg_1_0.reset_abyss_enter_repair_time(arg_64_0)
		arg_64_0._abyss_enter_repair_time = 0
	end

	function arg_1_0:get_abyss_enter_repair_time()
		return self._abyss_enter_repair_time or 0
	end

	function arg_1_0.set_abyss_now_team(arg_66_0, arg_66_1)
		if arg_66_1 and arg_66_1 == var_0_1.team_type.abyss_owner_team then
			arg_66_0._abyss_now_repair_team = var_0_1.team_type.abyss_owner_team or var_0_1.team_type.abyss_team
		end

		if arg_66_1 and arg_66_1 == var_0_1.team_type.abyss_owner_team then
			arg_66_0._abyss_another_repair_team = var_0_1.team_type.abyss_team or var_0_1.team_type.abyss_owner_team
		end
	end

	function arg_1_0:get_abyss_repair_team()
		return self._abyss_now_repair_team, self._abyss_another_repair_team
	end

	function arg_1_0.is_abyss_fighting(arg_68_0, arg_68_1)
		arg_68_0._abyss_player_fighting = arg_68_1
	end

	function arg_1_0:check_abyss_state()
		return self._abyss_player_fighting
	end

	function arg_1_0:record_fight_info_pass(arg_70_1, arg_70_2)
		self._fight_info_pass_objs = self._fight_info_pass_objs or {}
		self._fight_info_pass_objs[arg_70_1] = arg_70_2
	end

	function arg_1_0.reset_fight_info_pass(arg_71_0)
		arg_71_0._fight_info_pass_objs = {}
	end

	function arg_1_0:is_fight_info_pass(arg_72_1)
		return self._fight_info_pass_objs[arg_72_1]
	end

	function arg_1_0.set_abyss_ship_move_callback(arg_73_0, arg_73_1)
		arg_73_0._abyss_ship_move_callback = arg_73_1
	end

	function arg_1_0:call_abyss_ship_move_callback()
		if self._abyss_ship_move_callback then
			self._abyss_ship_move_callback()

			self._abyss_ship_move_callback = nil

			return true
		end
	end

	function arg_1_0:set_abyss_fight_start_point(arg_75_1, arg_75_2)
		self._abyss_fight_start_point = self._abyss_fight_start_point or {}
		self._abyss_fight_start_point[arg_75_1] = arg_75_2
	end

	function arg_1_0:get_abyss_fight_start_point(arg_76_1)
		self._abyss_fight_start_point = self._abyss_fight_start_point or {}

		return self._abyss_fight_start_point[arg_76_1]
	end

	function arg_1_0.reset_abyss_fight_start_point(arg_77_0)
		arg_77_0._abyss_fight_start_point = {}
	end

	function arg_1_0:set_abyss_fight_cam(arg_78_1, arg_78_2, arg_78_3)
		if not arg_78_1 or not self._abyss_fight_cam_pos or not self._abyss_fight_ship_pos then
			self._abyss_fight_cam_pos = {}
			self._abyss_fight_ship_pos = {}
		end

		if arg_78_1 then
			self._abyss_fight_cam_pos[arg_78_1] = arg_78_2
			self._abyss_fight_ship_pos[arg_78_1] = arg_78_3
		end
	end

	function arg_1_0:get_abyss_fight_cam(arg_79_1)
		if not self._abyss_fight_cam_pos or not self._abyss_fight_ship_pos then
			self._abyss_fight_cam_pos = {}
			self._abyss_fight_ship_pos = {}
		end

		return self._abyss_fight_cam_pos[arg_79_1], self._abyss_fight_ship_pos[arg_79_1]
	end

	function arg_1_0:set_award_item_info(arg_80_1)
		self._func_award = arg_80_1

		return self._func_award
	end

	function arg_1_0:get_award_item_info()
		return self._func_award
	end

	function arg_1_0:set_abyss_prepare_to_fight_type(arg_82_1)
		self._abyss_prepare_to_fight_type = arg_82_1

		return self._abyss_prepare_to_fight_type
	end

	function arg_1_0:get_abyss_prepare_to_fight_type()
		return self._abyss_prepare_to_fight_type
	end

	function arg_1_0.set_need_clear_panel_info(arg_84_0, arg_84_1)
		arg_84_0._clear_panel_info = arg_84_1
	end

	function arg_1_0:get_need_clear_panel_info()
		return self._clear_panel_info
	end

	function arg_1_0.gm_abyss_record_jump_node(arg_86_0, arg_86_1)
		arg_86_0._gm_abyss_jump_node = arg_86_1
	end

	function arg_1_0:gm_abyss_get_jump_node()
		return self._gm_abyss_jump_node
	end

	function arg_1_0.set_goto_abyss(arg_88_0, arg_88_1)
		arg_88_0._goto_abyss = arg_88_1
	end

	function arg_1_0:get_goto_abyss()
		return self._goto_abyss
	end
end

function var_0_0.extend_obj(arg_90_0)
	arg_90_0._abyss_fight_info_param = {}
	arg_90_0._abyss_boss_chapter_config = {}
	arg_90_0._abyss_sub_chapter_config = {}
	arg_90_0._normal_team_members = {}
	arg_90_0._abyss_team_members = {}
	arg_90_0._abyss_level_cfg = {}
	arg_90_0._abyss_main_info = {}
	arg_90_0._abyss_user_award = {}
	arg_90_0._abyss_buff_info = {}
	arg_90_0._abyss_now_chapter_cfg = {}
	arg_90_0._abyss_map_buff = {}
	arg_90_0._is_boss_open = false
	arg_90_0._abyss_character_data = {
		character = {}
	}
	arg_90_0._abyss_map_buff_point_list = {}
	arg_90_0._clear_panel_info = nil
	arg_90_0._AbyssBossInfoResp_callback = nil
end

return var_0_0
