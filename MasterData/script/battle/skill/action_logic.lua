local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = string.format
local var_0_4 = gameenum.battle_type

lx.define_class("action_logic", function(arg_1_0)
	function arg_1_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self._action_data = arg_2_1
		self._target_data = arg_2_2
		self._owner = self._battle_obj_mgr:findObject(arg_2_3)
		self._atk_type = arg_2_4
		self._attr_snapshot = arg_2_5
	end

	function arg_1_0:apply()
		local var_3_0 = {}

		if not self._target_data or not next(self._target_data) then
			var_0_2(var_3_0, self._owner)
		end

		if self._target_data then
			for iter_3_0, iter_3_1 in pairs(self._target_data) do
				local var_3_1 = self:get_target_func(iter_3_1, self._action_data.type == var_0_4.action_type.copy_target_skill)

				if not var_3_1 then
					return
				end

				if var_3_1[1] then
					for iter_3_2, iter_3_3 in pairs(var_3_1) do
						local var_3_3 = false

						for iter_3_4, iter_3_5 in pairs(var_3_0) do
							if iter_3_3:getID() == iter_3_5:getID() then
								var_3_3 = true
							end
						end

						if var_3_3 == false then
							var_0_2(var_3_0, iter_3_3)
						end
					end
				end
			end
		end

		for iter_3_6, iter_3_7 in pairs(var_3_0) do
			self:onActionEvent(self._action_data, iter_3_7)

			if self._action_data.type == var_0_4.action_type.show_special_cutin_and_animation and self._action_data.effect_type == 2 then
				self._owner:get_attribute().atk_type = var_0_4.attack_round.normal
			end
		end
	end

	function arg_1_0:onActionEvent(arg_4_1, arg_4_2)
		if not arg_4_1.type then
			return
		end

		local var_4_0 = var_0_3("__onActionFunc_%s", (var_0_4:get_action_type(arg_4_1.type)))

		if not self[var_4_0] then
			return
		end

		return self[var_4_0](self, arg_4_1, arg_4_2)
	end

	function arg_1_0:get_target_func(arg_5_1, arg_5_2)
		if not arg_5_1 then
			return
		end

		local var_5_0 = var_0_3("__getTarget_%s", (var_0_4:get_action_target_type(arg_5_1.type)))

		if not self[var_5_0] then
			return
		end

		return self[var_5_0](self, arg_5_1, arg_5_2)
	end

	function arg_1_0.bind(arg_6_0, arg_6_1)
		arg_6_0._battlefield = arg_6_1
		arg_6_0._battle_obj_mgr = arg_6_1:getBattleObjectManager()
		arg_6_0._battle_random = arg_6_1:getBattleRandom()
		arg_6_0._battle_scene = arg_6_1:getBattleScene()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_1.class("action_logic")

	var_7_0._owner = nil
	var_7_0._action_data = nil
	var_7_0._action_num = 0

	gamecore.extend_obj(var_7_0)

	return var_7_0
end

return var_0_0
