local var_0_0 = {}
local var_0_3 = lx.clone_table
local var_0_4 = gameenum.common_type
local var_0_6 = gameconfig.tactics_config
local var_0_8 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:find_character_by_id(arg_2_1)
		return self:__character__find_by_id(arg_2_1)
	end

	function arg_1_0:find_character_by_cid(arg_3_1)
		return self:__character__find_by_cid(arg_3_1)
	end

	function arg_1_0:get_character_num()
		local var_4_0 = 0

		for iter_4_0, iter_4_1 in pairs(self._character_data.character) do
			var_4_0 = var_4_0 + 1
		end

		return var_4_0
	end

	function arg_1_0:get_character_list()
		self._character_list = self._character_data.character

		return self._character_list
	end

	function arg_1_0:reset_character_list()
		self._character_data.character = {}
	end

	function arg_1_0:get_character_level_data()
		local var_7_0 = false

		for iter_7_0, iter_7_1 in pairs(self._character_data.character) do
			if iter_7_1.level >= 90 then
				var_7_0 = true

				break
			end
		end

		return var_7_0
	end

	function arg_1_0:get_character_intensify(arg_8_1)
		local var_8_0 = self:__character__find_by_id(arg_8_1)

		if not var_8_0 then
			return
		end

		return var_8_0.intensify
	end

	function arg_1_0:get_character_attribute(arg_9_1)
		return self._character_attribute[arg_9_1]
	end

	function arg_1_0:get_character_attribute_by_calculate(arg_10_1)
		local var_10_0 = var_0_3(self:get_character_attribute(arg_10_1))

		self:__calculate_attribute_by_intensify(arg_10_1, var_10_0)
		self:__calculate_attribute_by_equips(arg_10_1, var_10_0)

		return var_10_0
	end

	function arg_1_0:get_character_attribute_by_calculate_no_equips(arg_11_1)
		local var_11_0 = var_0_3(self:get_character_attribute(arg_11_1))

		self:__calculate_attribute_by_intensify(arg_11_1, var_11_0)

		return var_11_0
	end

	function arg_1_0:get_attribute_effect_by_equip(arg_12_1)
		return self._attribute_effect_by_equip[arg_12_1]
	end

	function arg_1_0:get_learning_tactic(arg_13_1)
		local var_13_0 = 0
		local var_13_2 = self:get_character_list()[arg_13_1] or self:find_abyss_character_by_id(arg_13_1)

		for iter_13_0, iter_13_1 in pairs((var_13_2 and var_13_2.all_tactics or nil) and var_13_2.all_tactics) do
			if iter_13_1.state == var_0_4.stactic_state.study then
				var_13_0 = iter_13_1.id

				break
			end
		end

		return var_13_0
	end

	function arg_1_0:get_bullet_limit_by_tactic(arg_14_1, arg_14_2)
		local var_14_1 = (arg_14_2 and arg_14_2 or self:get_character_list())[arg_14_1]

		if not (arg_14_2 and arg_14_2 or self:get_character_list())[arg_14_1] then
			var_14_1 = self:find_abyss_character_by_id(arg_14_1)
		end

		local var_14_2

		if var_14_1 then
			var_14_2 = var_14_1.bullet

			if var_14_1.tactics then
				for iter_14_0, iter_14_1 in pairs(var_14_1.tactics) do
					local var_14_3 = var_0_6.find_object_by_cid(iter_14_1)

					if var_14_3 and var_14_3.tactics_id == 10001774 then
						var_14_2 = math.floor((1 + var_14_3.effect.a / 10) * var_14_1.bullet)
					end
				end
			end
		else
			var_14_2 = 0
		end

		return var_14_2
	end

	function arg_1_0:__character__add_character_info(arg_15_1)
		local var_15_0 = var_0_8.find_object_by_cid(arg_15_1.cid)

		if arg_15_1.name == "" then
			if not var_15_0 then
				log.writelog_debug(arg_15_1.cid)
			else
				arg_15_1.name = var_15_0.title
			end
		end

		arg_15_1.equipment_num = var_15_0.equipment_num
		self._character_data.character[arg_15_1.id] = arg_15_1

		self:__update_character_attribute(arg_15_1)
		self:__upd_ship_lock_state(arg_15_1)

		if arg_15_1.marry then
			self:add_marrystate_ship(arg_15_1)
		end
	end

	function arg_1_0:__character__update_character_info(arg_16_1)
		local var_16_0 = var_0_8.find_object_by_cid(arg_16_1.cid)

		if arg_16_1.name == "" then
			arg_16_1.name = var_16_0.title
		end

		arg_16_1.equipment_num = var_16_0.equipment_num
		self._character_data.character[arg_16_1.id] = arg_16_1

		self:__update_character_attribute(arg_16_1)
		self:__upd_ship_lock_state(arg_16_1)

		if arg_16_1.marry then
			self:add_marrystate_ship(arg_16_1)
		end
	end

	function arg_1_0:is_character_station_state(arg_17_1)
		if not self._character_data.character[arg_17_1] then
			return false
		end

		return self._character_data.character[arg_17_1].state == var_0_4.ship_state.station
	end

	function arg_1_0:__character__remove_character_info(arg_18_1)
		self._character_data.character[arg_18_1.id] = nil

		self:__remove_character_attribute_by_id(arg_18_1.id)
		self:__remove_ship_lock_state(arg_18_1.id)

		if arg_18_1.marry then
			self:remove_marrystate_ship(arg_18_1)
		end
	end

	function arg_1_0:__character__find_by_id(arg_19_1)
		if not self._character_data.character[arg_19_1] then
			return
		end

		local var_19_0 = var_0_8.find_object_by_cid(self._character_data.character[arg_19_1].cid)

		if var_19_0 then
			self._character_data.character[arg_19_1].equipment_num = var_19_0.equipment_num
		end

		return self._character_data.character[arg_19_1]
	end

	function arg_1_0:__character__find_by_cid(arg_20_1)
		if not self._character_data.character then
			return false
		end

		for iter_20_0, iter_20_1 in pairs(self._character_data.character) do
			if arg_20_1 == iter_20_1.cid then
				return true
			end
		end

		return false
	end

	function arg_1_0:__upd_ship_lock_state(arg_21_1)
		self._lock_character = self._lock_character or {}
		self._lock_character[arg_21_1.id] = arg_21_1.lock
	end

	function arg_1_0:__remove_ship_lock_state(arg_22_1)
		if not self._lock_character then
			self._lock_character = {}

			return
		end

		self._lock_character[arg_22_1] = nil
	end

	function arg_1_0:get_ship_lock_state(arg_23_1)
		return self._lock_character[arg_23_1]
	end

	function arg_1_0.set_save_remake_skill(arg_24_0, arg_24_1)
		arg_24_0._save_skill_info = arg_24_1
	end

	function arg_1_0:get_save_remake_skill()
		return self._save_skill_info
	end

	function arg_1_0.set_remove_equip_temp(arg_26_0, arg_26_1)
		arg_26_0._remove_equip_temp = arg_26_1
	end

	function arg_1_0:get_remove_equip_temp()
		return self._remove_equip_temp
	end

	function arg_1_0.set_gotofight_team_info(arg_28_0, arg_28_1)
		arg_28_0.all_team_speed = arg_28_1
	end

	function arg_1_0:get_gotofight_team_info()
		return self.all_team_speed
	end

	function arg_1_0.set_new_ship_info(arg_30_0, arg_30_1)
		arg_30_0.new_ship_info = arg_30_1
	end

	function arg_1_0:get_new_ship_info()
		return self.new_ship_info
	end

	function arg_1_0:add_marrystate_ship(arg_32_1)
		self._character_marry_list[arg_32_1.id] = arg_32_1.cid
	end

	function arg_1_0:remove_marrystate_ship(arg_33_1)
		self._character_marry_list[arg_33_1.id] = nil
	end

	function arg_1_0:get_marrystate_ship()
		return self._character_marry_list
	end
end

function var_0_0.extend_obj(arg_35_0)
	arg_35_0._character_data = {
		character = {}
	}
	arg_35_0._lock_character = {}
	arg_35_0._character_list = {}
	arg_35_0._save_skill_info = nil
	arg_35_0._character_marry_list = {}
end

return var_0_0
