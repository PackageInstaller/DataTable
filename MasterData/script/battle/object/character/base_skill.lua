local var_0_0 = {}
local var_0_1 = gameconfig.skill_config
local var_0_2 = gamecore.skill_logic
local var_0_4 = gameenum.battle_type
local var_0_5 = gameconfig.sixth_adjutant_config
local var_0_6 = gamecore.action_logic

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:init_skill(arg_2_1, arg_2_2)
		if arg_2_1 == 99 then
			self:__init_sixth_adjutant_skill_buff()

			self.copy_skill = nil
			self.copy_target = nil
			self.show_skill_type = nil

			self:__init_copy_skill()

			self._reduction_data = self.clone_data(self, self)
			self._reduction_attribut_data = self:clone_data(self:get_attribute())
			self._reduction_attribut_data_by_num = self:clone_data_by_num(self:get_attribute())

			return
		end

		if arg_2_2 then
			self.reset_data(self, self, self._reduction_data)
			self:reset_data(self:get_attribute(), self._reduction_attribut_data)

			for iter_2_0, iter_2_1 in pairs(self:get_attribute()) do
				if iter_2_0 ~= "all_equip_airdef" and iter_2_0 ~= "now_hp" and iter_2_0 ~= "skill_num" and type(iter_2_1) == "table" and self:get_attribute()[iter_2_0]._base_value then
					self:get_attribute()[iter_2_0]:modify_to_value(self._reduction_attribut_data_by_num[iter_2_0])
				end
			end

			self._skill_id = nil

			return
		end

		local var_2_0 = {}
		local var_2_1 = false
		local var_2_2 = var_0_1.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if self._battle_scene:get_fight_type() == var_0_4.fight_type.plot_main and self._skill_data.skill_id ~= 0 then
			var_2_2 = var_0_1.find_object_by_skill_id(self._skill_data.skill_id)
		end

		if not var_2_2 then
			return
		end

		if not var_2_2.effect or not var_2_2.effect[1] then
			return
		end

		if not arg_2_1 then
			return
		end

		for iter_2_2, iter_2_3 in pairs(var_2_2.effect) do
			var_2_0[iter_2_2] = false

			for iter_2_4, iter_2_5 in pairs(iter_2_3.stage) do
				if arg_2_1 == iter_2_5 or iter_2_5 == 0 or iter_2_5 == 12 and arg_2_1 ~= 7 then
					var_2_0[iter_2_2] = true
					var_2_1 = true
				end

				if iter_2_5 == 5 and (arg_2_1 == 9 or arg_2_1 == 10) then
					var_2_0[iter_2_2] = true
					var_2_1 = true
				end
			end
		end

		local var_2_3 = #var_2_2.effect

		if self.copy_skill then
			for iter_2_6, iter_2_7 in pairs(self.copy_skill) do
				var_2_0[iter_2_6 + var_2_3] = false

				for iter_2_8, iter_2_9 in pairs(iter_2_7.stage) do
					if arg_2_1 == iter_2_9 or iter_2_9 == 0 or iter_2_9 == 12 and arg_2_1 ~= 7 then
						var_2_0[iter_2_6 + var_2_3] = true
						var_2_1 = true
					end

					if iter_2_9 == 5 and (arg_2_1 == 9 or arg_2_1 == 10) then
						var_2_0[iter_2_6 + var_2_3] = true
						var_2_1 = true
					end
				end
			end
		end

		if var_2_1 == true then
			self:set_now_satge_skill(var_2_0)
			self:set_skill(var_2_2.skill_id)
			self._battle_scene:createObject(var_0_2, self:getID())
		end
	end

	function arg_1_0.clone_data(arg_3_0, arg_3_1)
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			var_3_0[iter_3_0] = iter_3_1
		end

		return var_3_0
	end

	function arg_1_0.double_clone_data(arg_4_0, arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			local var_4_1 = {}

			if type(iter_4_1) == "table" then
				for iter_4_2, iter_4_3 in pairs(iter_4_1) do
					local var_4_2 = {}

					if type(iter_4_3) == "table" then
						for iter_4_4, iter_4_5 in pairs(iter_4_3) do
							var_4_2[iter_4_4] = iter_4_5
						end

						var_4_1[iter_4_2] = var_4_2
					else
						var_4_1[iter_4_2] = iter_4_3
					end
				end
			else
				var_4_1 = iter_4_1
			end

			var_4_0[iter_4_0] = var_4_1
		end

		return var_4_0
	end

	function arg_1_0.clone_data_by_num(arg_5_0, arg_5_1)
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			if iter_5_0 ~= "all_equip_airdef" and iter_5_0 ~= "now_hp" and iter_5_0 ~= "skill_num" and type(iter_5_1) == "table" and iter_5_1._final_value then
				var_5_0[iter_5_0] = iter_5_1._final_value
			end
		end

		return var_5_0
	end

	function arg_1_0.reset_data(arg_6_0, arg_6_1, arg_6_2)
		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			local var_6_1 = true

			for iter_6_2, iter_6_3 in pairs(arg_6_2) do
				if iter_6_0 == iter_6_2 then
					var_6_1 = false
				end
			end

			if var_6_1 == true and iter_6_0 ~= "_reduction_data" and iter_6_0 ~= "_reduction_attribut_data" and iter_6_0 ~= "skill_num" and iter_6_0 ~= "_reduction_attribut_data_by_num" then
				arg_6_1[iter_6_0] = nil
			end
		end
	end

	function arg_1_0:__init_sixth_adjutant_skill_buff()
		local var_7_0, var_7_1 = self._battle_scene:get_adjutant_skill_buff()

		if var_7_0 then
			return
		end

		self._battle_scene:reset_adjutant_skill_buff()

		if self._battle_scene:get_fight_type() ~= var_0_4.fight_type.sixth then
			return
		end

		local var_7_2 = self._battle_scene:get_sixth_adjutant_skill_buff()

		if not next(var_7_2) then
			return
		end

		if not var_7_2.buff_state then
			return
		end

		local var_7_3 = var_0_5.find_object_by_id(var_7_2.id).effect

		if var_7_2.skill_level == 0 then
			return
		end

		local var_7_4 = var_7_3[var_7_2.skill_level].num

		if var_7_3[var_7_2.skill_level].type == var_0_4.adjutant_buff_type.enhance_damage then
			var_7_4 = var_7_4 / 100
		end

		self._battle_scene:record_adjutant_skill_buff(var_7_4)
	end

	function arg_1_0:__init_copy_skill()
		if self._battle_scene:get_fight_type() == var_0_4.fight_type.maneuver then
			return
		end

		local var_8_0 = var_0_1.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if not var_8_0 or not var_8_0.effect or not var_8_0.effect[1] then
			return
		end

		local var_8_1
		local var_8_2

		for iter_8_0, iter_8_1 in pairs(var_8_0.effect) do
			for iter_8_2, iter_8_3 in pairs(iter_8_1.effect) do
				if iter_8_3.type == var_0_4.action_type.copy_target_skill then
					if iter_8_1.buff_target then
						var_8_1 = iter_8_1.buff_target
					end

					var_8_2 = iter_8_3
				end
			end
		end

		if var_8_1 then
			local var_8_4 = var_0_6:create()

			var_8_4:bind(self._battlefield)
			var_8_4:init(nil, nil, self:getID())

			for iter_8_4, iter_8_5 in pairs(var_8_1) do
				local var_8_5 = var_8_4:get_target_func(iter_8_5, true)

				for iter_8_6, iter_8_7 in pairs(var_8_5) do
					local var_8_6 = var_0_1.find_object_by_skill_type_skill_level(iter_8_7._skill_data.skill, iter_8_7._skill_data.skill_level)

					self.copy_target = var_8_5

					if not var_8_6 or not var_8_6.effect or not var_8_6.effect[1] then
						return
					end

					self.show_skill_type = var_8_6.skill_type

					local var_8_7 = {}

					for iter_8_8, iter_8_9 in pairs(var_8_6.effect) do
						table.insert(var_8_7, (self:double_clone_data(iter_8_9)))
					end

					self.copy_skill = self:__set_be_copy_skill_by_rule(var_8_7, var_8_2)
				end
			end
		end
	end

	function arg_1_0.__set_be_copy_skill_by_rule(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			var_9_0[iter_9_0] = iter_9_1

			if iter_9_1.rate and arg_9_2 and arg_9_2.rate then
				var_9_0[iter_9_0].rate = arg_9_2.rate
			end

			if iter_9_1.effect then
				local var_9_1 = {}
				local var_9_2 = true

				for iter_9_2, iter_9_3 in pairs(iter_9_1.effect) do
					var_9_1[iter_9_2] = iter_9_3

					if iter_9_3.type == var_0_4.action_type.probability_triggering and arg_9_2 and arg_9_2.rate then
						var_9_1[iter_9_2].effect_rate = arg_9_2.rate
					end

					if iter_9_3.type == var_0_4.action_type.copy_target_skill then
						var_9_2 = false
					end
				end

				if var_9_2 then
					var_9_0[iter_9_0].effect = var_9_1
				end
			end
		end

		return var_9_0
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
