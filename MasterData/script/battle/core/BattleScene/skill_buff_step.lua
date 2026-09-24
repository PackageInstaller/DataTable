local var_0_0 = {}
local var_0_1 = gameconfig.skill_config
local var_0_2 = gameconfig.ship_skill_buff_config
local var_0_3 = gameenum.battle_type
local var_0_4 = table.insert
local var_0_5 = gamecore.action_logic
local var_0_6 = gamecore.condition_logic

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_skill_buff_step()
		local var_2_0 = false
		local var_2_1 = self._battle_obj_mgr:get_alive_ships_by_side(var_0_3.obj_side.player)
		local var_2_2 = self._battle_obj_mgr:get_alive_ships_by_side(var_0_3.obj_side.enemy)

		self:__sort_ships_by_index(var_2_1)
		self:__sort_ships_by_index(var_2_2)

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			local var_2_3, var_2_4, var_2_5 = self:__get_curr_skill_id(iter_2_1)
			local var_2_6 = var_0_1.find_object_by_skill_id(var_2_3)

			if var_2_6 and var_0_2.find_object_by_cid((var_2_6 or nil) and (var_2_6.buff_cid or 0)) and self:__get_skill_state(var_2_6) then
				local var_2_8, var_2_9 = self:__get_buff_target_list(iter_2_1:getID())

				if #var_2_8 ~= 0 then
					self._battlefield._battle_report.buff = self._battlefield._battle_report.buff or {}
					self._battlefield._battle_report.buff.player_buff = self._battlefield._battle_report.buff.player_buff or {}

					var_0_4(self._battlefield._battle_report.buff.player_buff, {
						source_id = iter_2_1:getID(),
						skill_id = var_2_3,
						target_list = var_2_8,
						target_id_list = var_2_9,
						skill_type = var_2_4,
						skill_level = var_2_5
					})

					var_2_0 = true
				end
			end
		end

		for iter_2_2, iter_2_3 in pairs(var_2_2) do
			local var_2_10, var_2_11, var_2_12 = self:__get_curr_skill_id(iter_2_3)
			local var_2_13 = var_0_1.find_object_by_skill_id(var_2_10)

			if var_2_13 and var_0_2.find_object_by_cid((var_2_13 or nil) and (var_2_13.buff_cid or 0)) and self:__get_skill_state(var_2_13) then
				local var_2_15, var_2_16 = self:__get_buff_target_list(iter_2_3:getID())

				if #var_2_15 ~= 0 then
					self._battlefield._battle_report.buff = self._battlefield._battle_report.buff or {}
					self._battlefield._battle_report.buff.enemy_buff = self._battlefield._battle_report.buff.enemy_buff or {}

					var_0_4(self._battlefield._battle_report.buff.enemy_buff, {
						source_id = iter_2_3:getID(),
						skill_id = var_2_10,
						target_list = var_2_15,
						target_id_list = var_2_16,
						skill_type = var_2_11,
						skill_level = var_2_12
					})

					var_2_0 = true
				end
			end
		end

		return var_2_0
	end

	function arg_1_0.__sort_ships_by_index(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return
		end

		table.sort(arg_3_1, function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_0:get_index() or 0
			local var_4_1 = arg_4_1:get_index() or 0

			if var_4_0 ~= var_4_1 then
				return var_4_0 < var_4_1
			end

			return (arg_4_0:getID() or 0) < (arg_4_1:getID() or 0)
		end)
	end

	function arg_1_0.__get_skill_state(arg_5_0, arg_5_1)
		if not arg_5_1 then
			return false
		end

		for iter_5_0, iter_5_1 in pairs(arg_5_1.effect) do
			if iter_5_1.type == var_0_3.skill_type.buff then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_buff_target_list(arg_6_1)
		local var_6_0 = {}
		local var_6_1 = {}

		if self._effect_config_data then
			for iter_6_0, iter_6_1 in pairs(self._effect_config_data) do
				if iter_6_1.type == var_0_3.skill_type.buff then
					local var_6_2 = self:__get_target_by_config(iter_6_1, arg_6_1)

					if #var_6_2 ~= 0 then
						var_0_4(var_6_0, var_6_2)

						for iter_6_2, iter_6_3 in pairs(var_6_2) do
							if not self:have_data(var_6_1, iter_6_3.target_id) then
								var_0_4(var_6_1, iter_6_3.target_id)
							end
						end
					end
				end
			end
		end

		return var_6_0, var_6_1
	end

	function arg_1_0:__get_curr_skill_id(arg_7_1)
		local var_7_0 = 0
		local var_7_1 = 0
		local var_7_2 = 0

		self._effect_config_data = nil

		local var_7_3

		if not arg_7_1._skill_data then
			return var_7_0
		end

		var_7_3 = arg_7_1:get_side() == var_0_3.obj_side.player and self:__get_player_skill_config_info(arg_7_1) or self:__get_enemy_skill_config_info(arg_7_1)

		if var_7_3 then
			var_7_0 = var_7_3.skill_id
			self._effect_config_data = var_7_3.effect
			var_7_1 = var_7_3.skill_type
			var_7_2 = var_7_3.skill_level
		end

		return var_7_0, var_7_1, var_7_2
	end

	function arg_1_0.__get_player_skill_config_info(arg_8_0, arg_8_1)
		return arg_8_1._battle_scene:get_fight_type() == var_0_3.fight_type.plot_main and var_0_1.find_object_by_skill_id(arg_8_1._skill_data.skill_id) or var_0_1.find_object_by_skill_type_skill_level(arg_8_1._skill_data.skill, arg_8_1._skill_data.skill_level)
	end

	function arg_1_0.__get_enemy_skill_config_info(arg_9_0, arg_9_1)
		return arg_9_1._battle_scene:get_fight_type() == var_0_3.fight_type.maneuver and var_0_1.find_object_by_skill_type_skill_level(arg_9_1._skill_data.skill, arg_9_1._skill_data.skill_level) or var_0_1.find_object_by_skill_id(arg_9_1._skill_data.skill_id)
	end

	function arg_1_0:__get_target_by_config(arg_10_1, arg_10_2)
		local var_10_0 = {}
		local var_10_2 = self._battle_obj_mgr:findObject(arg_10_2)

		if arg_10_1 then
			local var_10_3, var_10_4 = self:__get_buff_effect_enhance_type(arg_10_1)

			if self:__get_skill_conditioin_by_config(arg_10_1, arg_10_2) then
				local var_10_5 = var_0_5:create()

				var_10_5:bind(self._battlefield)

				for iter_10_0, iter_10_1 in pairs(arg_10_1.buff_target or {
					{
						type = 7
					}
				}) do
					var_10_5:init(nil, nil, arg_10_2)

					local var_10_6 = self:_get_copy_target_by_effect_type(arg_10_1, var_10_2, (var_10_5:get_target_func(iter_10_1, var_10_4)))

					if var_10_6 and #var_10_6 ~= 0 then
						for iter_10_2, iter_10_3 in pairs(var_10_6) do
							if iter_10_3:get_is_alive() then
								if iter_10_3:get_side() == var_10_2:get_side() and var_10_3 == var_0_3.buff_type.none then
									var_0_4(var_10_0, {
										target_id = iter_10_3:getID(),
										buff_type = var_10_3
									})
								else
									var_0_4(var_10_0, {
										target_id = iter_10_3:getID(),
										buff_type = var_10_3
									})
								end
							end
						end
					end
				end
			end
		end

		return var_10_0
	end

	function arg_1_0.__get_buff_effect_enhance_type(arg_11_0, arg_11_1)
		local var_11_0 = var_0_3.buff_type.none
		local var_11_1 = false

		if arg_11_1.effect then
			for iter_11_0, iter_11_1 in pairs(arg_11_1.effect) do
				for iter_11_2, iter_11_3 in pairs(iter_11_1) do
					if iter_11_2 ~= "type" and tonumber(iter_11_3) and iter_11_1.type ~= 90 then
						var_11_0 = iter_11_3 < 0 and var_0_3.buff_type.down or var_0_3.buff_type.up
					end
				end

				if iter_11_1.type and iter_11_1.type == 6 then
					var_11_0 = var_0_3.buff_type.down
				elseif iter_11_1.type and iter_11_1.type == 127 then
					var_11_0 = var_0_3.buff_type.up
				elseif iter_11_1.type and iter_11_1.type == 128 then
					var_11_0 = var_0_3.buff_type.up
				elseif iter_11_1.type and iter_11_1.type == 129 then
					var_11_0 = var_0_3.buff_type.up
				elseif iter_11_1.type and iter_11_1.type == 144 then
					var_11_0 = var_0_3.buff_type.up
				elseif iter_11_1.type and iter_11_1.type == var_0_3.action_type.copy_target_skill then
					var_11_1 = true
				end
			end
		end

		return (arg_11_1.buff_show or nil) and arg_11_1.buff_show[1], var_11_1
	end

	function arg_1_0._get_copy_target_by_effect_type(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		if arg_12_1.effect then
			for iter_12_0, iter_12_1 in pairs(arg_12_1.effect) do
				if iter_12_1.type and iter_12_1.type == var_0_3.action_type.copy_target_skill then
					arg_12_3 = arg_12_2.copy_target or {}

					table.insert(arg_12_3, arg_12_2)
				end
			end
		end

		return arg_12_3
	end

	function arg_1_0:__get_skill_conditioin_by_config(arg_13_1, arg_13_2)
		if not arg_13_1.condition then
			return true
		end

		local var_13_0 = false
		local var_13_1 = var_0_6:create()

		var_13_1:bind(self._battlefield)

		for iter_13_0, iter_13_1 in pairs(arg_13_1.condition) do
			var_13_1:init(iter_13_1, arg_13_2)

			local var_13_2 = var_13_1:onConditionFunc(iter_13_1)

			if var_13_2 then
				var_13_0 = var_13_2

				break
			end
		end

		return var_13_0
	end

	function arg_1_0.have_data(arg_14_0, arg_14_1, arg_14_2)
		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			if iter_14_1 == arg_14_2 then
				return true
			end
		end

		return false
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
