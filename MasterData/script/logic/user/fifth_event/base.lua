local var_0_0 = {}
local var_0_3 = gameconfig.ship_config
local var_0_4 = gameconfig.equip_config
local var_0_5 = gameconfig.fifth_map_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__set_concerto_info(arg_2_1, arg_2_2)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.info) do
			self._concerto_info[iter_2_0] = iter_2_1
		end

		if not arg_2_2 then
			self._concerto_info.station = {}
		end
	end

	function arg_1_0:get_comp_task_list()
		return self._comp_task_info or {}
	end

	function arg_1_0:get_fifth_station(arg_4_1)
		if self._station_info and self._station_info[arg_4_1] then
			return self._station_info[arg_4_1]
		end
	end

	function arg_1_0:get_fifth_station_info()
		return self._station_info or {}
	end

	function arg_1_0:set_fifth_cur_boss(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		self._fifth_cur_boss_info = self._fifth_cur_boss_info or {}
		self._fifth_cur_boss_info[arg_6_1] = {}
		self._fifth_cur_boss_info[arg_6_1].id = arg_6_2
		self._fifth_cur_boss_info[arg_6_1].hp = arg_6_3
		self._fifth_cur_boss_info[arg_6_1].max_hp = arg_6_4
	end

	function arg_1_0:get_fifth_cur_boss(arg_7_1)
		self._fifth_cur_boss_info = self._fifth_cur_boss_info or {}

		return self._fifth_cur_boss_info[arg_7_1]
	end

	function arg_1_0:set_fifth_boss_info(arg_8_1, arg_8_2, arg_8_3)
		self._fifth_boss_info = self._fifth_boss_info or {}
		self._fifth_boss_info[arg_8_1] = {}
		self._fifth_boss_info[arg_8_1].hp = arg_8_2
		self._fifth_boss_info[arg_8_1].max_hp = arg_8_3
	end

	function arg_1_0:get_fifth_boss_info(arg_9_1)
		self._fifth_boss_info = self._fifth_boss_info or {}

		return self._fifth_boss_info[arg_9_1]
	end

	function arg_1_0:get_concerto_info()
		return self._concerto_info
	end

	function arg_1_0:get_fifth_map_data(arg_11_1)
		if not arg_11_1 then
			return self._fifth_map_data
		else
			return self._fifth_map_data[arg_11_1]
		end
	end

	function arg_1_0:is_war_concerto_map_node_pass(arg_12_1, arg_12_2)
		local var_12_0 = false

		if self._fifth_map_data[arg_12_1] and self._fifth_map_data[arg_12_1].pass_point then
			for iter_12_0, iter_12_1 in ipairs(self._fifth_map_data[arg_12_1].pass_point) do
				if arg_12_2 == iter_12_1.id then
					var_12_0 = true
				end
			end
		end

		return var_12_0
	end

	function arg_1_0:__fifth_map__add_info(arg_13_1)
		self._fifth_gener_boss_list = self._fifth_gener_boss_list or {}
		self._fifth_gener_boss_list[arg_13_1.id] = arg_13_1.new
		self._fifth_map_data[arg_13_1.id] = arg_13_1
	end

	function arg_1_0:__fifth_map__update_info(arg_14_1)
		self._fifth_gener_boss_list = self._fifth_gener_boss_list or {}
		self._fifth_gener_boss_list[arg_14_1.id] = arg_14_1.new
		self._fifth_map_data[arg_14_1.id] = arg_14_1
	end

	function arg_1_0:__fifth_map__remove_info(arg_15_1)
		self._fifth_gener_boss_list = {}
		self._fifth_map_data[arg_15_1.id] = nil
	end

	function arg_1_0:is_fifth_new_boss(arg_16_1)
		return self._fifth_gener_boss_list[arg_16_1]
	end

	function arg_1_0:comp_fifth_new_boss(arg_17_1)
		self._fifth_gener_boss_list[arg_17_1] = false
	end

	function arg_1_0:get_fifth_boss_state_list()
		return self._fifth_gener_boss_list
	end

	function arg_1_0.reset_fifth_event_data(arg_19_0)
		arg_19_0._level_cfg = nil
		arg_19_0._concerto_info = {}
		arg_19_0._station_info = nil
		arg_19_0._fifth_buff = {}
		arg_19_0._fifth_event_data = {}
		arg_19_0._joy_map_data = {}
		arg_19_0._now_map_node = nil
		arg_19_0._fifth_normal_now_node = nil
		arg_19_0._fifth_gener_boss_list = {}
		arg_19_0.fifth_hide_node_list = {}
		arg_19_0.fifth_hide_route_list = {}
	end

	function arg_1_0.set_fifth_level_cfg(arg_20_0, arg_20_1)
		arg_20_0._level_cfg = arg_20_1
	end

	function arg_1_0:get_fifth_level_cfg()
		return self._level_cfg
	end

	function arg_1_0:get_fifth_team_data()
		return self._fifth_event_data.member or {}
	end

	function arg_1_0:get_fifth_ship_list()
		local var_23_0 = {}

		for iter_23_0, iter_23_1 in pairs(self._fifth_event_data.ship_set) do
			table.insert(var_23_0, (self:get_fake_ship_data(iter_23_1)))
		end

		return var_23_0
	end

	function arg_1_0.get_fake_ship_data(arg_24_0, arg_24_1)
		local var_24_0 = var_0_3.find_object_by_cid(arg_24_1)
		local var_24_1 = {}

		for iter_24_0, iter_24_1 in ipairs(var_24_0.equipment) do
			table.insert(var_24_1, {
				num = 1,
				carry_type = 1,
				id = var_0_4.find_object_by_cid(iter_24_1).cid
			})
		end

		local var_24_2 = {
			skin = 0,
			exp = 0,
			state = 1,
			love = 0,
			level = 100,
			marry = false,
			id = -1,
			skill_level = 0,
			now_skill = 0,
			room = 0,
			lock = false,
			cid = arg_24_1,
			name = var_24_0.title,
			star = var_24_0.star,
			type = var_24_0.type,
			hp = var_24_0.hp,
			atk = var_24_0.atk,
			def = var_24_0.def,
			miss = var_24_0.miss,
			capacity = var_24_0.capacity,
			speed = var_24_0.speed,
			range = var_24_0.range,
			torpedo = var_24_0.torpedo,
			air_def = var_24_0.air_def,
			antisub = var_24_0.antisub,
			radar = var_24_0.radar,
			luck = var_24_0.luck,
			hit = var_24_0.hit,
			equip_num = var_24_0.equipment_num,
			equips = var_24_1,
			skills = var_24_0.skills,
			intensify = {},
			now_hp = var_24_0.hp_max,
			now_oil = var_24_0.max_oil,
			now_bullet = var_24_0.max_ammo,
			bullet = var_24_0.max_ammo,
			oil = var_24_0.max_oil,
			record = var_24_1,
			tactics = {
				0,
				0,
				0
			},
			statistics = {}
		}

		return var_24_2, var_24_0, {
			missile_tmd = 0,
			missile_hit = 0,
			air_def_correct = 0,
			aircraft_atk = 0,
			id = -1,
			now_bullet = var_24_2.now_bullet,
			hit = var_24_2.hit,
			hp = var_24_2.hp,
			atk = var_24_2.atk,
			def = var_24_2.def,
			miss = var_24_2.miss,
			capacity = var_24_2.capacity,
			range = var_24_2.range,
			torpedo = var_24_2.torpedo,
			air_def = var_24_2.air_def,
			antisub = var_24_2.antisub,
			radar = var_24_2.radar,
			speed = var_24_2.speed,
			now_hp = var_24_2.now_hp,
			luck = var_24_2.luck,
			now_oil = var_24_2.now_oil
		}
	end

	function arg_1_0:is_first_open_joy()
		self._fifth_event_data._is_first_unlock_joy = false

		return self._fifth_event_data._is_first_unlock_joy or false
	end

	function arg_1_0:__update_joy_map_data(arg_26_1)
		if not self._joy_map_data or not next(self._joy_map_data) then
			for iter_26_0, iter_26_1 in pairs(arg_26_1.updates) do
				self._joy_map_data[iter_26_0] = iter_26_1.info
			end

			return
		end

		for iter_26_2, iter_26_3 in pairs(arg_26_1.updates) do
			for iter_26_4, iter_26_5 in pairs(self._joy_map_data) do
				if iter_26_5.id == iter_26_3.info.id then
					self._joy_map_data[iter_26_4] = iter_26_3.info

					break
				end
			end
		end
	end

	function arg_1_0:get_joy_map_data(arg_27_1)
		for iter_27_0, iter_27_1 in pairs(self._joy_map_data) do
			if iter_27_1.id == arg_27_1 then
				return self._joy_map_data[iter_27_0]
			end
		end
	end

	function arg_1_0:is_already_get_score(arg_28_1)
		if self._level_cfg and self._level_cfg.points_already_get_score then
			for iter_28_0, iter_28_1 in pairs(self._level_cfg.points_already_get_score) do
				if iter_28_1 == arg_28_1 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0.set_now_team_data(arg_29_0, arg_29_1)
		arg_29_0._now_team_data = arg_29_1
	end

	function arg_1_0:get_now_team_data()
		return self._now_team_data
	end

	function arg_1_0.set_now_node(arg_31_0, arg_31_1)
		arg_31_0._now_map_node = arg_31_1
	end

	function arg_1_0:get_now_node()
		return self._now_map_node
	end

	function arg_1_0.set_fifth_now_node(arg_33_0, arg_33_1)
		arg_33_0._fifth_normal_now_node = arg_33_1
	end

	function arg_1_0:get_fifth_now_node()
		return self._fifth_normal_now_node
	end

	function arg_1_0:get_fifth_next_node()
		local var_35_0 = var_0_5.find_object_by_id(self._fifth_normal_now_node)

		if var_35_0 and var_35_0.next_node and next(var_35_0.next_node) then
			return var_35_0.next_node
		end
	end

	function arg_1_0:check_recreation_point_increase(arg_36_1)
		local var_36_0 = self:get_concerto_info()
		local var_36_1

		if var_36_0 and var_36_0._my_joy_rp_add ~= 0 then
			var_36_1 = var_36_0._my_joy_rp_add

			if not arg_36_1 then
				local var_36_2 = {
					info = {}
				}

				var_36_2.info._my_joy_rp_add = 0

				self:__set_concerto_info(var_36_2)
			end
		end

		return var_36_1
	end

	function arg_1_0:check_joy_love_increase(arg_37_1)
		local var_37_0 = self:get_concerto_info()

		if var_37_0 and var_37_0._my_joy_love_add ~= 0 then
			if not arg_37_1 then
				local var_37_1 = {
					info = {}
				}

				var_37_1.info._my_joy_love_add = 0

				self:__set_concerto_info(var_37_1)
			end

			return var_37_0._my_joy_love_add, var_37_0.love
		end
	end

	function arg_1_0:set_fifth_buff(arg_38_1, arg_38_2)
		self._fifth_buff = self._fifth_buff or {}
		self._fifth_buff[arg_38_1] = arg_38_2
	end

	function arg_1_0:get_fifth_buff()
		return self._fifth_buff
	end

	function arg_1_0.set_fifth_hide_node(arg_40_0, arg_40_1)
		arg_40_0.fifth_hide_node_list = arg_40_1
	end

	function arg_1_0.set_fifth_hide_route(arg_41_0, arg_41_1)
		arg_41_0.fifth_hide_route_list = arg_41_1
	end

	function arg_1_0:get_fifth_hide_node()
		return self.fifth_hide_node_list or {}
	end

	function arg_1_0:get_fifth_hide_route()
		return self.fifth_hide_route_list or {}
	end

	function arg_1_0:set_after_station_flag(arg_44_1)
		self._fifth_after_station = self._fifth_after_station or {}
		self._fifth_after_station[arg_44_1] = true
	end

	function arg_1_0:is_after_station(arg_45_1)
		self._fifth_after_station = self._fifth_after_station or {}
		self._fifth_after_station[arg_45_1] = false

		return self._fifth_after_station[arg_45_1]
	end

	function arg_1_0:set_after_battle_flag(arg_46_1)
		self._fifth_after_battle = self._fifth_after_battle or {}
		self._fifth_after_battle[arg_46_1] = true
	end

	function arg_1_0:is_after_battle(arg_47_1)
		self._fifth_after_battle = self._fifth_after_battle or {}
		self._fifth_after_battle[arg_47_1] = false

		return self._fifth_after_battle[arg_47_1]
	end

	function arg_1_0.__check_and_insert_ship_list(arg_48_0, arg_48_1)
		return
	end
end

function var_0_0.extend_obj(arg_49_0)
	arg_49_0._concerto_info = {}
	arg_49_0._fifth_map_data = {}
	arg_49_0._fifth_event_data = {}
	arg_49_0._level_cfg = nil
	arg_49_0._fifth_team_data = {}
	arg_49_0._fifth_ship_data = {}
	arg_49_0._joy_map_data = {}
	arg_49_0._now_team_data = {}
	arg_49_0._now_map_node = {}
end

return var_0_0
