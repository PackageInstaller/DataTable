local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = tostring
local var_0_3 = gameconfig.map_node_config
local var_0_4 = gameconfig.pve_active_map_node_config
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.monster_config
local var_0_9 = gameconfig.sixth_map_node_config
local var_0_10 = gameconfig.pve_mix_level_node_config
local var_0_11 = gameconfig.pve_eighth_level_node_config
local var_0_13 = gameconfig.abyss_map_node_config
local var_0_14 = gameenum.battle_type
local var_0_15 = gamecore.battle_util
local var_0_17 = gamecore.tactics_logic
local var_0_18 = gamecore.tower_buffs_logic
local var_0_19 = gamecore.ocean_cia_buffs_logic
local var_0_20 = gamecore.war_concerto_buffs_logic
local var_0_22 = string.sub
local var_0_23 = gameconfig.pve_mix_map_config
local var_0_24 = gameconfig.pve_eighth_map_config
local var_0_26 = gameconfig.score_map_node_config
local var_0_27 = gameconfig.pve_ninth_level_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:start(arg_2_1)
		local var_2_0 = "buff"

		self._start_step = "buff"

		local var_2_1 = self._battle_scene:get_fight_type()
		local var_2_2 = self._battle_scene:get_battle_point()
		local var_2_3 = self._battle_scene:get_battle_start_point()

		if var_2_1 == var_0_14.fight_type.plot_main then
			local var_2_4 = var_0_9.find_object_by_id(var_2_2)

			if var_2_4.movie[3] and var_2_4.movie[3][1] ~= 0 and not arg_2_1 then
				self._battle_processor:__onEvent_cinema_dialog(var_2_4)

				return
			end
		end

		if var_2_1 == var_0_14.fight_type.main then
			local var_2_5 = var_0_3.find_object_by_id(var_2_2)

			if var_2_5.night_atk == 1 then
				self._start_step = "night_war"
				var_2_0 = "night_war"
			end

			if var_2_5.node_type == 10 then
				self._start_step = "air_attack"
				var_2_0 = "buff"
			end
		end

		if var_2_1 == var_0_14.fight_type.push then
			local var_2_6 = var_0_4.find_object_by_id(var_2_2)

			if var_2_6.night_atk == 1 then
				self._start_step = "night_war"
				var_2_0 = "night_war"
			end

			if var_2_6.node_type == 10 then
				self._start_step = "air_attack"
				var_2_0 = "buff"
			end
		end

		if var_2_1 == var_0_14.fight_type.abyss or var_2_1 == var_0_14.fight_type.abyss_2 then
			local var_2_7 = var_0_13.find_object_by_id(var_2_2)

			if var_2_7.night_atk == 1 then
				self._start_step = "night_war"
				var_2_0 = "night_war"
			end

			if var_2_7.node_type == 10 then
				self._start_step = "air_attack"
				var_2_0 = "buff"
			end
		end

		if var_2_1 == var_0_14.fight_type.seventh then
			local var_2_8 = var_0_10.find_object_by_id(var_2_2)

			if var_2_8 then
				if var_2_8.night_atk == 1 then
					self._start_step = "night_war"
					var_2_0 = "night_war"
				end

				if var_2_8.node_type == 10 then
					self._start_step = "air_attack"
					var_2_0 = "buff"
				end
			end
		end

		if var_2_1 == var_0_14.fight_type.eighth then
			local var_2_9 = var_0_11.find_object_by_id(var_2_2)

			if var_2_9 then
				if var_2_9.night_atk == 1 then
					self._start_step = "night_war"
					var_2_0 = "night_war"
				end

				if var_2_9.node_type == 10 then
					self._start_step = "air_attack"
					var_2_0 = "buff"
				end
			end
		end

		if var_2_1 == var_0_14.fight_type.score then
			local var_2_10 = var_0_26.find_object_by_id_start_node_id(var_2_2, var_2_3)

			if var_2_10 then
				if var_2_10.night_atk == 1 then
					self._start_step = "night_war"
					var_2_0 = "night_war"
				end

				if var_2_10.node_type == 10 then
					self._start_step = "air_attack"
					var_2_0 = "buff"
				end
			end
		end

		if var_2_1 == var_0_14.fight_type.ninth then
			local var_2_11 = var_0_27.find_object_by_id_start_node_id(var_2_2, var_2_3)

			if var_2_11 then
				if var_2_11.night_atk == 1 then
					self._start_step = "night_war"
					var_2_0 = "night_war"
				end

				if var_2_11.node_type == 10 then
					self._start_step = "air_attack"
					var_2_0 = "buff"
				end
			end
		end

		self._battle_report = {}

		self:__excute_tactics_enhance_logic()
		self:__init_skill_by_stage(99)
		self:next_step(var_2_0)

		if not self.is_test then
			self._battle_processor:start(self._start_step)
		end
	end

	function arg_1_0:next_step(arg_3_1)
		if not arg_3_1 then
			return
		end

		if arg_3_1 == "open_missile_attack" or arg_3_1 == "open_antisub_attack" or arg_3_1 == "open_torpedo_attack" or arg_3_1 == "normal_attack" or arg_3_1 == "normal_attack2" or arg_3_1 == "close_missile_attack" or arg_3_1 == "day_war_end" or arg_3_1 == "close_torpedo_attack" or arg_3_1 == "air_attack" then
			self:check_is_alive()

			if self._battle_end then
				self:on_night_war_end()

				return
			end
		end

		local var_3_0 = string.format("on_%s", arg_3_1)

		if not self[var_3_0] then
			return
		end

		self[var_3_0](self)
	end

	function arg_1_0:on_buff()
		self:__init_skill_by_stage(0)

		self._battle_step = var_0_14.trigger_type.buff

		if not self._battle_scene:enter_skill_buff_step() then
			return self:next_step("support")
		end

		self:next_step("support")
	end

	function arg_1_0:on_support()
		self._battle_step = var_0_14.trigger_type.support

		if not self._battle_scene:enter_support_attack_step() then
			return self:next_step("air_attack")
		end

		self._battle_scene:support_attack()
		self:next_step("air_attack")
	end

	function arg_1_0:on_air_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(2)

		self._battle_step = var_0_14.trigger_type.air_attack

		if not self._battle_scene:enter_aircraft_attack() then
			return self:next_step("air_attack_recovery")
		end

		local var_6_0 = self._battle_scene:get_aircraft_ships()

		self._normal_index = 1

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(2)
			iter_6_1:aircraft_attack(self._normal_index)
		end

		for iter_6_2, iter_6_3 in pairs(var_6_0) do
			iter_6_3:reset_attack_times_in_aircraft_attack()
		end

		self:next_step("air_attack_recovery")
	end

	function arg_1_0:on_air_attack_recovery()
		self._battle_step = var_0_14.trigger_type.air_attack

		if not self:check_can_recovery("air_attack_recovery") then
			if self._start_step == "air_attack" then
				return self:next_step("day_war_end")
			else
				return self:next_step("open_missile_attack")
			end
		end

		if self._start_step == "air_attack" then
			self:next_step("day_war_end")
		else
			self:next_step("open_missile_attack")
		end
	end

	function arg_1_0:on_open_missile_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(8)

		self._battle_step = var_0_14.trigger_type.open_missile_attack

		local var_8_0, var_8_1 = self._battle_scene:enter_missile_attack()

		if not var_8_0 then
			return self:next_step("open_missile_attack_recovery")
		end

		self._normal_index = 1
		self.last_tmd_missile_value = 0
		self.last_tmd_missile_value_we = 0

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(8)

			self.last_tmd_missile_value, self.last_tmd_missile_value_we = iter_8_1:missile_attack("open_missile_attack", self._normal_index, self.last_tmd_missile_value, self.last_tmd_missile_value_we)
		end

		self:next_step("open_missile_attack_recovery")
	end

	function arg_1_0:on_open_missile_attack_recovery()
		self._battle_step = var_0_14.trigger_type.open_missile_attack

		if not self:check_can_recovery("open_missile_attack_recovery") then
			return self:next_step("open_antisub_attack")
		end

		self:next_step("open_antisub_attack")
	end

	function arg_1_0:on_open_antisub_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(3)

		self._battle_step = var_0_14.trigger_type.open_antisub_attack

		local var_10_0, var_10_1, var_10_2 = self._battle_scene:enter_antisub_attack()
		local var_10_3 = self._battle_scene:get_open_antisubb()
		local var_10_4, var_10_5, var_10_6, var_10_7 = self._battle_scene:have_sp_skill_enter_antisub_attack()

		if not var_10_2 and not var_10_5 and not var_10_0 then
			local var_10_8 = self._battle_scene:get_open_antisubb()

			if var_10_8 then
				self._normal_index = 1

				for iter_10_0, iter_10_1 in pairs((self._battle_scene:get_open_antisub_attack_ships(nil, true, false))) do
					for iter_10_2, iter_10_3 in pairs(var_10_8.ship_list) do
						if iter_10_1:getID() == iter_10_3 then
							self:__init_skill_by_stage(nil, true)
							self:__init_skill_by_stage(3)
							iter_10_1:antisub_attack("open_antisub_attack", self._normal_index)
						end
					end
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		elseif not var_10_0 and var_10_4 and not var_10_5 then
			if self._battle_scene:get_open_antisubb() then
				local var_10_9 = false
				local var_10_10 = {}

				self._normal_index = 1

				for iter_10_4, iter_10_5 in pairs((self._battle_scene:get_sp_open_antisub_skill_ships(true, false))) do
					if iter_10_5:get_attribute().skill_num.not_single_cross_can_antisub_gd then
						var_10_9 = true
						var_10_10 = iter_10_5:get_attribute().skill_num.not_single_cross_can_antisub_gd_type
					end
				end

				for iter_10_6, iter_10_7 in pairs((self._battle_scene:get_open_antisub_attack_ships(true, true, false))) do
					if var_10_9 then
						for iter_10_8, iter_10_9 in pairs(var_10_10) do
							if iter_10_7:get_ship_type() == iter_10_9 then
								self:__init_skill_by_stage(nil, true)
								self:__init_skill_by_stage(3)
								iter_10_7:antisub_attack("open_antisub_attack", self._normal_index)
							end
						end
					end
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		elseif var_10_2 and not var_10_1 then
			local var_10_11 = self._battle_scene:get_open_antisubb()
			local var_10_12 = self._battle_scene:get_open_antisub_attack_ships(false, false, true)

			self._normal_index = 1

			if var_10_11 then
				for iter_10_10, iter_10_11 in pairs((self._battle_scene:get_open_antisub_attack_ships(nil, true, false))) do
					for iter_10_12, iter_10_13 in pairs(var_10_11.ship_list) do
						if iter_10_11:getID() == iter_10_13 then
							self:__init_skill_by_stage(nil, true)
							self:__init_skill_by_stage(3)
							iter_10_11:antisub_attack("open_antisub_attack", self._normal_index)
						end
					end
				end

				for iter_10_14, iter_10_15 in pairs(var_10_12) do
					iter_10_15:antisub_attack("open_antisub_attack", self._normal_index)
				end
			else
				for iter_10_16, iter_10_17 in pairs(var_10_12) do
					iter_10_17:antisub_attack("open_antisub_attack", self._normal_index)
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		elseif not var_10_2 and var_10_5 and var_10_1 then
			if self._battle_scene:get_open_antisubb() then
				local var_10_13 = false
				local var_10_14 = {}

				self._normal_index = 1

				for iter_10_18, iter_10_19 in pairs((self._battle_scene:get_sp_open_antisub_skill_ships(false, true))) do
					if iter_10_19:get_attribute().skill_num.not_single_cross_can_antisub_gd then
						var_10_13 = true
						var_10_14 = iter_10_19:get_attribute().skill_num.not_single_cross_can_antisub_gd_type
					end
				end

				for iter_10_20, iter_10_21 in pairs((self._battle_scene:get_open_antisub_attack_ships(false, true, false))) do
					iter_10_21:antisub_attack("open_antisub_attack", self._normal_index)
				end

				for iter_10_22, iter_10_23 in pairs((self._battle_scene:get_open_antisub_attack_ships(true, false, true))) do
					if var_10_13 then
						for iter_10_24, iter_10_25 in pairs(var_10_14) do
							if iter_10_23:get_ship_type() == iter_10_25 then
								self:__init_skill_by_stage(nil, true)
								self:__init_skill_by_stage(3)
								iter_10_23:antisub_attack("open_antisub_attack", self._normal_index)
							end
						end
					end
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		elseif not var_10_2 and var_10_5 and var_10_6 and not var_10_4 then
			if self._battle_scene:get_open_antisubb() then
				local var_10_15 = false
				local var_10_16 = {}

				self._normal_index = 1

				for iter_10_26, iter_10_27 in pairs((self._battle_scene:get_sp_open_antisub_skill_ships(false, true))) do
					if iter_10_27:get_attribute().skill_num.not_single_cross_can_antisub_gd then
						var_10_15 = true
						var_10_16 = iter_10_27:get_attribute().skill_num.not_single_cross_can_antisub_gd_type
					end
				end

				for iter_10_28, iter_10_29 in pairs((self._battle_scene:get_open_antisub_attack_ships(true, false, true))) do
					if var_10_15 then
						for iter_10_30, iter_10_31 in pairs(var_10_16) do
							if iter_10_29:get_ship_type() == iter_10_31 then
								self:__init_skill_by_stage(nil, true)
								self:__init_skill_by_stage(3)
								iter_10_29:antisub_attack("open_antisub_attack", self._normal_index)
							end
						end
					end
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		elseif not var_10_0 and var_10_4 and var_10_5 then
			if self._battle_scene:get_open_antisubb() then
				local var_10_17 = false
				local var_10_18 = false
				local var_10_19 = {}
				local var_10_20 = {}

				self._normal_index = 1

				for iter_10_32, iter_10_33 in pairs((self._battle_scene:get_sp_open_antisub_skill_ships(true, false))) do
					if iter_10_33:get_attribute().skill_num.not_single_cross_can_antisub_gd then
						var_10_17 = true
						var_10_19 = iter_10_33:get_attribute().skill_num.not_single_cross_can_antisub_gd_type
					end
				end

				for iter_10_34, iter_10_35 in pairs((self._battle_scene:get_open_antisub_attack_ships(true, true, false))) do
					if var_10_17 then
						for iter_10_36, iter_10_37 in pairs(var_10_19) do
							if iter_10_35:get_ship_type() == iter_10_37 then
								self:__init_skill_by_stage(nil, true)
								self:__init_skill_by_stage(3)
								iter_10_35:antisub_attack("open_antisub_attack", self._normal_index)
							end
						end
					end
				end

				for iter_10_38, iter_10_39 in pairs((self._battle_scene:get_sp_open_antisub_skill_ships(false, true))) do
					if iter_10_39:get_attribute().skill_num.not_single_cross_can_antisub_gd then
						var_10_18 = true
						var_10_20 = iter_10_39:get_attribute().skill_num.not_single_cross_can_antisub_gd_type
					end
				end

				for iter_10_40, iter_10_41 in pairs((self._battle_scene:get_open_antisub_attack_ships(true, false, true))) do
					if var_10_18 then
						for iter_10_42, iter_10_43 in pairs(var_10_20) do
							if iter_10_41:get_ship_type() == iter_10_43 then
								self:__init_skill_by_stage(nil, true)
								self:__init_skill_by_stage(3)
								iter_10_41:antisub_attack("open_antisub_attack", self._normal_index)
							end
						end
					end
				end
			end

			return self:next_step("open_antisub_attack_recovery")
		end

		self._normal_index = 1

		for iter_10_44, iter_10_45 in pairs((self._battle_scene:get_open_antisub_attack_ships(false, var_10_1, var_10_2))) do
			iter_10_45:antisub_attack("open_antisub_attack", self._normal_index)
		end

		self:next_step("open_antisub_attack_recovery")
	end

	function arg_1_0:on_open_antisub_attack_recovery()
		self._battle_step = var_0_14.trigger_type.open_antisub_attack

		if not self:check_can_recovery("open_antisub_attack_recovery") then
			return self:next_step("open_torpedo_attack")
		end

		self:next_step("open_torpedo_attack")
	end

	function arg_1_0:on_open_torpedo_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(4)

		self._battle_step = var_0_14.trigger_type.open_torpedo_attack

		local var_12_0, var_12_1 = self._battle_scene:enter_open_torpedo()

		if not var_12_0 then
			return self:next_step("open_torpedo_attack_recovery")
		end

		self._normal_index = 1

		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if iter_12_1:hp_more_than_quarter() or iter_12_1:get_can_attack_in_broken() then
				self:__init_skill_by_stage(nil, true)
				self:__init_skill_by_stage(4)
				iter_12_1:torpedo_attack("open_torpedo_attack", self._normal_index)
			end
		end

		self:next_step("open_torpedo_attack_recovery")
	end

	function arg_1_0:on_open_torpedo_attack_recovery()
		self._battle_step = var_0_14.trigger_type.open_torpedo_attack

		if not self:check_can_recovery("open_torpedo_attack_recovery") then
			return self:next_step("normal_attack")
		end

		self:next_step("normal_attack")
	end

	function arg_1_0:on_normal_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(9)

		self._battle_step = var_0_14.trigger_type.first_normal_attack

		if not self._battle_scene:enter_normal_attack() then
			return self:next_step("close_torpedo_attack")
		end

		local var_14_0 = self._battle_scene:get_all_attack_ships("normal_attack")

		self._normal_index = 1

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if iter_14_1:get_is_alive() then
				self:__init_skill_by_stage(nil, true)
				self:__init_skill_by_stage(9)

				for iter_14_2, iter_14_3 in pairs((iter_14_1:normal_attack("normal_attack", self._normal_index))) do
					self:__detection_target_have_skill_of_fight_back(iter_14_3, function()
						self:__init_skill_by_stage(nil, true)
						self:__init_skill_by_stage(9)
						iter_14_3:normal_attack("normal_attack", self._normal_index, true, iter_14_1:getID())
					end, iter_14_1, var_14_0)
				end

				for iter_14_4, iter_14_5 in pairs(var_14_0) do
					self:__get_ship_shout_with_teammate(iter_14_5, function()
						iter_14_5:normal_attack("normal_attack", self._normal_index, false)
					end)
				end
			end
		end

		self:next_step("normal_attack2")
	end

	function arg_1_0:on_normal_attack2()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(10)

		self._battle_step = var_0_14.trigger_type.second_normal_attack

		if not self._battle_scene:enter_normal_attack2() then
			return self:next_step("close_torpedo_attack")
		end

		local var_17_0 = self._battle_scene:get_all_attack_ships("normal_attack2")

		self._normal_index = 1

		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			if iter_17_1:get_is_alive() then
				self:__init_skill_by_stage(nil, true)
				self:__init_skill_by_stage(10)

				for iter_17_2, iter_17_3 in pairs((iter_17_1:normal_attack("normal_attack2", self._normal_index))) do
					self:__detection_target_have_skill_of_fight_back(iter_17_3, function()
						self:__init_skill_by_stage(nil, true)
						self:__init_skill_by_stage(10)
						iter_17_3:normal_attack("normal_attack2", self._normal_index, true, iter_17_1:getID())
					end, iter_17_1, var_17_0)
				end

				for iter_17_4, iter_17_5 in pairs(var_17_0) do
					self:__get_ship_shout_with_teammate(iter_17_5, function()
						iter_17_5:normal_attack("normal_attack2", self._normal_index, false)
					end)
				end

				if iter_17_1:get_attribute().hit_complex_target and iter_17_1:get_attribute().skill_num.save_hit_complex_sub_target and iter_17_1:get_attribute().skill_num.save_hit_complex_sub_target.mixattack then
					iter_17_1:normal_attack("normal_attack2", self._normal_index, false)

					iter_17_1:get_attribute().skill_num.save_hit_complex_sub_target.mixattack = false
					iter_17_1:get_attribute().skill_num.save_hit_complex_sub_target.use_attack = false
				end
			end
		end

		self:next_step("close_torpedo_attack")
	end

	function arg_1_0:on_close_torpedo_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(6)

		self._battle_step = var_0_14.trigger_type.close_torpedo_attack

		if not self._battle_scene:enter_torpedo_attack() then
			return self:next_step("close_torpedo_attack_recovery")
		end

		self._normal_index = 1

		for iter_20_0, iter_20_1 in pairs((self._battle_scene:get_torpedo_ships())) do
			if iter_20_1:hp_more_than_quarter() or iter_20_1._battle_scene:get_attack_state_by_hp(nil, iter_20_1) or iter_20_1:get_can_attack_in_broken() then
				self:__init_skill_by_stage(nil, true)
				self:__init_skill_by_stage(6)
				iter_20_1:torpedo_attack("torpedo_attack", self._normal_index)
			end
		end

		self:next_step("close_torpedo_attack_recovery")
	end

	function arg_1_0:on_close_torpedo_attack_recovery()
		if not self:check_can_recovery("close_torpedo_attack_recovery") then
			return self:next_step("close_missile_attack")
		end

		self:next_step("close_missile_attack")
	end

	function arg_1_0:on_close_missile_attack()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(15)

		self._battle_step = var_0_14.trigger_type.close_missile_attack

		local var_22_0, var_22_1 = self._battle_scene:enter_close_missile_attack()

		if not var_22_0 then
			return self:next_step("close_missile_attack_recovery")
		end

		self._normal_index = 1

		for iter_22_0, iter_22_1 in pairs(var_22_1) do
			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(15)
			iter_22_1:missile_attack("close_missile_attack", self._normal_index)
		end

		self:next_step("close_missile_attack_recovery")
	end

	function arg_1_0:on_close_missile_attack_recovery()
		self._battle_step = var_0_14.trigger_type.close_missile_attack

		if not self:check_can_recovery("close_missile_attack_recovery") then
			return self:next_step("day_war_end")
		end

		self:next_step("day_war_end")
	end

	function arg_1_0:on_day_war_end()
		if self.is_test then
			if self.can_go_night then
				self:next_step("night_war")

				return
			else
				self:save_test_result()
				self._battle_processor:eventOnRecord(self:getRecord(), self:get_battle_result(), (self:get_damage_result()))

				return
			end
		end

		self:set_battle_result()
		self._order_mgr:dayWarEnd()

		local var_24_0 = false
		local var_24_1 = {}
		local var_24_2 = {}

		for iter_24_0, iter_24_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_14.obj_side.player))) do
			var_0_1(var_24_1, {
				now_oil = iter_24_1:get_oil(),
				max_oil = iter_24_1:get_max_oil(),
				percent = iter_24_1:get_oil() / iter_24_1:get_max_oil()
			})
			var_0_1(var_24_2, {
				now_bullet = iter_24_1:get_ammo(),
				max_bullet = iter_24_1:get_max_ammo(),
				percent = iter_24_1:get_ammo() / iter_24_1:get_max_ammo()
			})

			if iter_24_1:is_lowhp() then
				var_24_0 = true
			end
		end

		table.sort(var_24_1, function(arg_25_0, arg_25_1)
			return arg_25_0.percent < arg_25_1.percent
		end)
		table.sort(var_24_2, function(arg_26_0, arg_26_1)
			return arg_26_0.percent < arg_26_1.percent
		end)

		self._battle_report.day_war_end = {
			has_break = var_24_0,
			now_oil = var_24_1[1].now_oil,
			max_oil = var_24_1[1].max_oil,
			now_bullet = var_24_2[1].now_bullet,
			max_bullet = var_24_2[1].max_bullet
		}
	end

	function arg_1_0:on_night_war(arg_27_1)
		if arg_27_1 then
			self._battle_scene:set_damage_control_num(arg_27_1.damage_control_num)
		end

		if self._battle_scene:get_is_night_attack() then
			return
		end

		self._battle_scene:set_is_night_attack()
		self._battle_scene:set_day_or_night_attack(var_0_14.day_or_night.night)
		self:check_is_alive()
		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(7)
		self:add_attr_when_night_atk()

		self._battle_step = var_0_14.trigger_type.night_war
		self._normal_index = 1

		for iter_27_0, iter_27_1 in pairs((self._battle_scene:get_night_attack_ships())) do
			if iter_27_1:get_is_alive() and (not iter_27_1:is_lowhp() or iter_27_1._battle_scene:get_attack_state_by_hp(nil, iter_27_1) or iter_27_1:get_can_attack_in_broken()) then
				self:__init_skill_by_stage(nil, true)
				self:__init_skill_by_stage(7)
				self:check_is_alive()
				iter_27_1:night_attack(self._normal_index)
			end
		end

		self:next_step("night_war_end")

		if self._start_step == "night_war" then
			return
		end

		if self.is_test then
			return
		end

		self._battle_processor:on_night_war()
	end

	function arg_1_0:on_night_war_end()
		if self.is_test then
			self:save_test_result()
			self._battle_processor:eventOnRecord(self:getRecord(), self:get_battle_result(), (self:get_damage_result()))

			return
		end

		self:set_battle_result()
		self._battle_processor:eventOnRecord(self:getRecord(), self:get_battle_result(), self._damage_result)
		self:eventOnFinishBattle()
	end

	function arg_1_0:append_result(arg_29_1, arg_29_2, arg_29_3)
		if self.is_test then
			return
		end

		local var_29_0 = var_0_5.find_object_by_cid(arg_29_1) or var_0_6.find_object_by_id(arg_29_1)

		if not var_29_0 then
			return
		end

		if type(arg_29_1) == "number" then
			arg_29_1 = var_29_0.title
		end

		self._damage_result = self._damage_result or {}
		self._damage_result[self._index] = self._damage_result[self._index] or {}
		self._damage_result[self._index][arg_29_1] = self._damage_result[self._index][arg_29_1] or {}
		self._damage_result[self._index][arg_29_1][arg_29_2] = self._damage_result[self._index][arg_29_1][arg_29_2] or {}

		var_0_1(self._damage_result[self._index][arg_29_1][arg_29_2], arg_29_3)

		self._index = self._index + 1
	end

	function arg_1_0:append_test_result(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		self._damage_record = self._damage_record or {}
		self._damage_result[self._index + arg_30_1] = self._damage_result[self._index + arg_30_1] or {}

		local var_30_0 = self._damage_result[self._index + arg_30_1].模拟战斗结果 or {}

		self._damage_result[self._index + arg_30_1].模拟战斗结果 = var_30_0

		if not arg_30_4 then
			var_30_0[arg_30_2] = arg_30_3
		elseif not var_30_0[arg_30_2] then
			var_30_0[arg_30_2] = arg_30_3
		elseif var_30_0[arg_30_2] ~= arg_30_3 then
			var_30_0[arg_30_2][arg_30_4] = (var_30_0[arg_30_2][arg_30_4] or 0) + (arg_30_3[arg_30_4] or 0)
		end
	end

	function arg_1_0:add_test_value(arg_31_1, arg_31_2, arg_31_3)
		if type(arg_31_3) ~= "table" then
			return
		end

		local var_31_0 = "模拟战斗结果"
		local var_31_1 = (self._index or 1) + (arg_31_1 or 0)

		self._damage_result = self._damage_result or {}
		self._damage_result[var_31_1] = self._damage_result[var_31_1] or {}
		self._damage_result[var_31_1][var_31_0] = self._damage_result[var_31_1][var_31_0] or {}

		local var_31_2 = self._damage_result[var_31_1][var_31_0][arg_31_2]

		if type(self._damage_result[var_31_1][var_31_0][arg_31_2]) ~= "table" then
			var_31_2 = {}
			self._damage_result[var_31_1][var_31_0][arg_31_2] = var_31_2
		end

		for iter_31_0, iter_31_1 in pairs(arg_31_3) do
			var_31_2[iter_31_0] = type(iter_31_1) == "number" and (tonumber(var_31_2[iter_31_0]) or 0) + iter_31_1 or iter_31_1
		end
	end

	function arg_1_0:save_test_result()
		self:append_test_result(0, "是否默认进入夜战", 0, false)

		for iter_32_0, iter_32_1 in pairs((self:get_team_hurt_data())) do
			local var_32_0 = iter_32_0
			local var_32_1 = 0
			local var_32_2 = 0
			local var_32_3 = 0
			local var_32_4 = 0
			local var_32_5 = 0

			if iter_32_1.ship then
				var_32_1 = tonumber(iter_32_1.ship:get_total_crit()) or 0
				var_32_4 = tonumber(iter_32_1.ship:get_total_damage()) or 0
				var_32_3 = tonumber(iter_32_1.ship:get_attack_count_by_target()) or 0
				var_32_5 = tonumber(iter_32_1.ship:get_total_sink()) or 0

				local var_32_6 = iter_32_1.ship:get_total_hit_count()

				if type(var_32_6) == "table" then
					for iter_32_2, iter_32_3 in pairs(var_32_6) do
						var_32_2 = var_32_2 + (tonumber(iter_32_3) or 0)
					end
				end

				local var_32_7 = tonumber(iter_32_1.ship:get_pos())

				if var_32_7 and var_32_7 > 0 then
					var_32_0 = var_32_7
				end
			end

			self:add_test_value(1, iter_32_0, {
				["我方第" .. iter_32_0 .. "号位,"] = iter_32_1.name,
				号位 = tostring(var_32_0),
				中破次数 = iter_32_1.hurt_state == 1 and 1 or 0,
				大破次数 = iter_32_1.hurt_state == 2 and 1 or 0,
				暴击次数 = var_32_1,
				命中次数 = var_32_2,
				出手次数 = var_32_3,
				总输出 = var_32_4,
				击沉数 = var_32_5
			})
		end

		local var_32_8 = self._battle_obj_mgr:get_ships_by_side(var_0_14.obj_side.player)
		local var_32_9 = self._battle_obj_mgr:get_ships_by_side(var_0_14.obj_side.enemy)
		local var_32_10, var_32_11 = self:get_team_hp_data(var_32_8)
		local var_32_12, var_32_13 = self:get_team_hp_data(var_32_9)
		local var_32_14 = self:get_combat_grade({
			team_state = var_32_8,
			enemy_state = var_32_9
		}, self:get_combat_score(var_32_12, var_32_13), (self:get_combat_score(var_32_10, var_32_11)))
		local var_32_15 = 0
		local var_32_16 = 0

		for iter_32_4 in pairs(var_32_9) do
			var_32_15 = var_32_15 + 1
		end

		for iter_32_5, iter_32_6 in pairs(var_32_8) do
			var_32_16 = var_32_16 + (tonumber(iter_32_6:get_total_sink()) or 0)
		end

		self:add_test_value(2, 1, {
			SS胜次数 = var_32_14 == 1 and 1 or 0,
			S胜次数 = var_32_14 == 2 and 1 or 0,
			A胜次数 = var_32_14 == 3 and 1 or 0,
			B胜次数 = var_32_14 == 4 and 1 or 0,
			C败次数 = var_32_14 == 5 and 1 or 0,
			D败次数 = var_32_14 == 6 and 1 or 0,
			消灭血量 = var_32_12 - var_32_13,
			敌方总血 = var_32_12,
			击沉数 = var_32_16,
			敌舰数 = var_32_15
		})
	end

	function arg_1_0:get_team_hurt_data()
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_14.obj_side.player))) do
			var_33_0[iter_33_0] = {}
			var_33_0[iter_33_0].name = iter_33_1:get_ship_name()
			var_33_0[iter_33_0].hurt_state = iter_33_1:is_lowhp() and 2 or iter_33_1:is_medhp() and 1 or 0
			var_33_0[iter_33_0].ship = iter_33_1
		end

		return var_33_0
	end

	function arg_1_0.get_team_hp_data(arg_34_0, arg_34_1)
		local var_34_0 = 0
		local var_34_1 = 0

		for iter_34_0, iter_34_1 in pairs(arg_34_1) do
			var_34_0 = var_34_0 + iter_34_1:get_attribute().hp:get_final_value()
			var_34_1 = var_34_1 + iter_34_1:get_attribute().now_hp:get_final_value()
		end

		return var_34_0, var_34_1
	end

	function arg_1_0.get_hp_comprehensive(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = 0
		local var_35_1 = 0

		for iter_35_0, iter_35_1 in pairs(arg_35_1) do
			var_35_0 = var_35_0 + iter_35_1.hp
		end

		for iter_35_2, iter_35_3 in pairs(arg_35_2) do
			var_35_1 = var_35_1 + iter_35_3.hp
		end

		return var_35_0, var_35_1
	end

	function arg_1_0.get_combat_score(arg_36_0, arg_36_1, arg_36_2)
		return (arg_36_1 - arg_36_2) / arg_36_1
	end

	function arg_1_0.get_combat_grade(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
		local var_37_0 = true
		local var_37_1 = false
		local var_37_2 = true
		local var_37_3 = 0
		local var_37_4 = 0
		local var_37_5 = false

		for iter_37_0, iter_37_1 in pairs(arg_37_1.enemy_state) do
			if iter_37_1:get_attribute().now_hp:get_final_value() ~= 0 then
				var_37_0 = false
			else
				if iter_37_0 == 1 then
					var_37_5 = true
				end

				var_37_3 = var_37_3 + 1
			end

			var_37_4 = var_37_4 + 1
		end

		if arg_37_3 == 0 then
			var_37_1 = true
		end

		for iter_37_2, iter_37_3 in pairs(arg_37_1.team_state) do
			if iter_37_3:get_attribute().now_hp:get_final_value() == 0 then
				var_37_2 = false
			end
		end

		if var_37_0 == true and var_37_1 == true then
			return 1
		end

		if var_37_0 == true and var_37_2 == true then
			return 2
		end

		if var_37_2 == true then
			if var_37_4 == 6 and var_37_3 >= 4 then
				return 3
			elseif var_37_4 == 5 and var_37_3 == 3 then
				return 3
			elseif (var_37_4 == 4 or var_37_4 == 3) and var_37_3 == 2 then
				return 3
			elseif var_37_4 == 2 and var_37_3 == 1 then
				return 3
			elseif var_37_5 == true then
				return 4
			elseif var_37_1 == true and arg_37_2 ~= 0 then
				return 4
			elseif arg_37_2 > 2.5 * arg_37_3 then
				return 4
			else
				return 5
			end
		end

		return 6
	end

	function arg_1_0:get_damage_result()
		return self._damage_result
	end

	function arg_1_0:add_attr_when_night_atk()
		for iter_39_0, iter_39_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			local var_39_0 = iter_39_1:get_add_attrs_when_night_attack()
			local var_39_1 = iter_39_1:get_attribute()

			if var_39_0 then
				local var_39_2 = var_39_1.hit:get_final_value()

				var_39_1.hit:modify_to_value(var_39_2 + var_39_0.hit)
				self:append_result(iter_39_1:get_cid(), "夜战增加属性", (string.format("属性名:hit, 属性前:%f, 属性后:%f", var_39_2, (var_39_1.hit:get_final_value()))))
			end
		end
	end

	function arg_1_0:check_is_alive()
		for iter_40_0, iter_40_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			local var_40_0 = iter_40_1:get_attribute()

			var_40_0.skill_num = var_40_0.skill_num or {}

			if var_40_0.skill_num.have_recover_life then
				var_40_0.now_hp:modify_to_value(var_40_0.skill_num.have_recover_life)
				iter_40_1:set_is_alive(true)

				var_40_0.skill_num.have_recover_life = nil
			end

			if var_40_0.now_hp:get_final_value() <= 0 then
				iter_40_1:set_is_alive(false)

				if iter_40_1:get_side() == var_0_14.obj_side.player then
					self:eventOnPlayerDie(iter_40_1:getID())
				else
					self:eventOnEnemyDie(iter_40_1:getID())
				end
			end
		end
	end

	function arg_1_0:check_can_recovery(arg_41_1)
		if self._battle_scene:get_fight_type() == var_0_14.fight_type.maneuver then
			return false
		end

		local var_41_0

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.abyss_2 then
			do return false end

			var_41_0 = false
		end

		if self._battle_scene:get_damage_control_num() == 0 then
			var_41_0 = false
		end

		for iter_41_0, iter_41_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_14.obj_side.player))) do
			local var_41_1 = self._battle_scene:get_damage_control_num()
			local var_41_2 = iter_41_1:get_attribute()
			local var_41_3 = var_41_2.hp:get_final_value()

			if var_41_2.now_hp:get_final_value() == 0 and var_41_1 > 0 then
				iter_41_1:set_is_ignore_damage_protect(false)

				self._battle_report[arg_41_1] = self._battle_report[arg_41_1] or {}

				self._battle_scene:set_damage_control_last_hp_num(var_41_2.now_hp._damage_control_value, iter_41_1:get_character_id())
				var_41_2.now_hp:modify_to_value(var_41_3)
				self._battle_scene:set_damage_control_num(var_41_1 - 1)

				var_41_0 = true
				self._battle_report[arg_41_1][1] = {
					recovery_id = iter_41_1:getID(),
					now_hp = var_41_2.now_hp:get_final_value(),
					max_hp = var_41_3
				}
			end
		end

		return var_41_0
	end

	function arg_1_0:__detection_target_have_skill_of_fight_back(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
		if arg_42_1 then
			local var_42_0 = arg_42_1:get_num_of_beat_back()

			if var_42_0 and next(var_42_0) and arg_42_1:get_is_alive() and arg_42_1.can_back_hit then
				local var_42_1 = arg_42_1:get_attribute().now_hp
				local var_42_2 = var_42_1:get_final_value() / arg_42_1:get_attribute().hp:get_final_value()

				if (var_42_1 >= 0.25 or arg_42_1:get_can_attack_in_broken()) and var_42_0.num > 0 then
					arg_42_1:set_num_of_beat_back(var_42_0.num - 1, var_42_0.hurt_rate)
					arg_42_1:set_fight_back_target(arg_42_3)
					arg_42_2()
				end
			end

			if arg_42_1:get_is_alive() and (not arg_42_1:is_lowhp() or arg_42_1:get_can_attack_in_broken()) and arg_42_1.can_back_hit then
				local var_42_3 = arg_42_1:get_damage_of_beat_back()

				if var_42_3 and next(var_42_3) then
					arg_42_1:set_fight_back_target(arg_42_3)
					arg_42_2()
				end
			end

			if arg_42_1:get_num_of_beat_back_wihtout_hp_state() then
				local var_42_4 = false

				if arg_42_1:get_is_alive() and arg_42_1.can_back_hit then
					local var_42_5 = arg_42_1:is_medhp()
					local var_42_6 = arg_42_1:is_lowhp()

					arg_42_1.skill_num = arg_42_1.skill_num or {}

					if arg_42_1.skill_num.action_143_was_medhp == nil then
						if var_42_6 then
							arg_42_1.skill_num.action_143_was_medhp = true
							arg_42_1.skill_num.action_143_first_check_already_lowhp = true
						else
							arg_42_1.skill_num.action_143_was_medhp = var_42_5
							arg_42_1.skill_num.action_143_first_check_already_lowhp = false
						end
					end

					if var_42_5 then
						var_42_4 = true
						arg_42_1.skill_num.action_143_was_medhp = true
					elseif var_42_6 and arg_42_1.skill_num.action_143_was_medhp then
						var_42_4 = true
						arg_42_1.skill_num.action_143_was_medhp = false
					elseif not var_42_5 and not var_42_6 then
						arg_42_1.skill_num.action_143_was_medhp = false
					end
				end

				if var_42_4 then
					arg_42_1:set_fight_back_target(arg_42_3)
					arg_42_2()
				end
			end

			if arg_42_1:get_is_alive() and (not arg_42_1:is_lowhp() or arg_42_1:get_can_attack_in_broken()) and arg_42_1.can_back_hit then
				local var_42_7 = arg_42_1:get_back_hit_to_random_target_by_attr()

				if var_42_7 and next(var_42_7) then
					arg_42_1:set_fight_back_target(arg_42_4[self._battle_random:randRange(1, #arg_42_4)])
					arg_42_2()
				end
			end

			if arg_42_1:get_is_alive() and (not arg_42_1:is_lowhp() or arg_42_1:get_can_attack_in_broken()) and arg_42_1.can_back_hit then
				if self:__set_target_fight_back_by_tactics_pencertage(arg_42_1) then
					local var_42_8 = arg_42_1:get_carry_tactics_logic()

					arg_42_1:set_fight_back_target(arg_42_3)
					arg_42_1:trigger_counter_atk()

					arg_42_1.skill_num = arg_42_1.skill_num or {}
					arg_42_1.skill_num.is_tactics_back = true

					arg_42_2()
				end

				if arg_42_1:is_lowhp() and arg_42_1:get_attribute().num_of_beat_back_with_fix_damage and arg_42_1:get_attribute().num_of_beat_back_with_fix_damage.num > 0 then
					arg_42_2()

					arg_42_1:get_attribute().num_of_beat_back_with_fix_damage.num = arg_42_1:get_attribute().num_of_beat_back_with_fix_damage.num - 1
				end
			end
		end
	end

	function arg_1_0:__set_target_fight_back_by_tactics_pencertage(arg_43_1)
		if var_0_15:judge_stage(var_0_14.trigger_type.normal_attack, self._battle_step) then
			local var_43_0 = arg_43_1:get_carry_tactics_logic()

			if var_43_0 then
				var_43_0:on_tactics_func()

				if arg_43_1:get_attribute().fight_back_percentage then
					local var_43_1 = arg_43_1:get_attribute().fight_back_percentage.num

					if var_43_1 == var_0_14.tactics_const.rate_max then
						arg_43_1:set_tactics_trigger_count(1, arg_43_1:get_attribute().fight_back_percentage.id)

						arg_43_1:get_attribute().skill_num = arg_43_1:get_attribute().skill_num or {}
						arg_43_1:get_attribute().skill_num.fight_back_percentage = arg_43_1:get_attribute().fight_back_percentage.id

						return true
					end

					local var_43_2, var_43_3 = var_0_15:get_random_chance({
						var_43_1,
						100 - var_43_1
					}, self._battle_random)

					self:append_result(arg_43_1:get_cid(), "本次反击roll出的点数为", var_43_3)

					if var_43_2 == arg_43_1:get_attribute().fight_back_percentage.num then
						arg_43_1:set_tactics_trigger_count(1, arg_43_1:get_attribute().fight_back_percentage.id)

						arg_43_1:get_attribute().skill_num = arg_43_1:get_attribute().skill_num or {}
						arg_43_1:get_attribute().skill_num.fight_back_percentage = arg_43_1:get_attribute().fight_back_percentage.id

						return true
					end
				end
			end
		end

		return false
	end

	function arg_1_0:__get_ship_shout_with_teammate(arg_44_1, arg_44_2)
		arg_44_1:get_attribute().skill_num = arg_44_1:get_attribute().skill_num or {}

		if arg_44_1:get_is_alive() and arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list and next(arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list) and arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate and arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout and self._battle_step == var_0_14.trigger_type.first_normal_attack then
			for iter_44_0, iter_44_1 in pairs(arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list) do
				if iter_44_1:is_submarine() then
					table.remove(arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list, iter_44_0)
				end
			end

			for iter_44_2, iter_44_3 in pairs(arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list) do
				if iter_44_3:get_attribute().now_hp:get_final_value() <= 0 and not iter_44_3:get_is_alive() then
					arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list = {}
					arg_44_1:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout = false
				end
			end

			arg_44_2()
		end
	end

	function arg_1_0:__init_skill_by_stage(arg_45_1, arg_45_2)
		for iter_45_0, iter_45_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			if iter_45_1:get_init_hp() ~= 0 then
				iter_45_1:init_skill(arg_45_1, arg_45_2)
			end
		end
	end

	function arg_1_0:__excute_buff_enhance_logic()
		self._battle_scene:createObject(var_0_18):init()
		self._battle_scene:createObject(var_0_19):init()
		self._battle_scene:createObject(var_0_20):init()
	end

	function arg_1_0:__excute_tactics_enhance_logic()
		for iter_47_0, iter_47_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			iter_47_1:reset_tactics_trigger_count()

			local var_47_0 = self._battle_scene:createObject(var_0_17)

			var_47_0:init(iter_47_1:getID())
			iter_47_1:set_carry_tactics_logic(var_47_0)
		end
	end

	function arg_1_0:__ignore_tactics_by_map()
		local var_48_0 = self._battle_scene:get_map_id()
		local var_48_1 = self._battle_scene:get_battle_point()
		local var_48_2 = false
		local var_48_3 = var_0_22(var_0_2(var_48_1), 1, 3)
		local var_48_4 = var_0_22(var_0_2(var_48_1), 1, 4)

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.main then
			for iter_48_0, iter_48_1 in pairs(var_0_14.ignore_tactics_maps) do
				if var_48_3 == iter_48_1 then
					var_48_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.seventh then
			local var_48_6 = var_0_23.find_object_by_id(var_48_0)

			if var_48_6 then
				return var_48_6.difficulty == 0
			end
		end

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.eighth then
			local var_48_7 = var_0_24.find_object_by_id(var_48_0)

			if var_48_7 then
				return var_48_7.difficulty == 0
			end
		end

		if not var_48_1 then
			return true
		end

		if var_48_1 >= 953601 and var_48_1 <= 953919 then
			return true
		end

		for iter_48_2, iter_48_3 in pairs(var_0_14.ignore_tactics_battle_point) do
			if var_48_4 == iter_48_3 then
				var_48_2 = true
			end
		end

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.score then
			local var_48_8 = var_0_22(var_0_2(var_48_1), 1, 5)

			for iter_48_4, iter_48_5 in pairs(var_0_14.ignore_tactics_score_maps) do
				if var_48_8 == iter_48_5 then
					var_48_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.ninth then
			local var_48_9 = var_0_22(var_0_2(var_48_1), 1, 5)

			for iter_48_6, iter_48_7 in pairs(var_0_14.ignore_tactics_ninth_maps) do
				if var_48_9 == iter_48_7 then
					var_48_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_14.fight_type.campaign then
			return false
		end

		return var_48_2
	end
end

function var_0_0.extend_obj(arg_49_0)
	arg_49_0._start_step = nil
	arg_49_0._battle_step = nil
end

return var_0_0
