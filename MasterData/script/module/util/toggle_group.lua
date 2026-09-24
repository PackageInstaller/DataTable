local var_0_0 = {}

lx.define_class("toggle_group", function(arg_1_0)
	function arg_1_0:isOn(arg_2_1)
		return self[self._set[arg_2_1]].set[arg_2_1]
	end

	function arg_1_0:toggleOn(arg_3_1, arg_3_2)
		self[self._set[arg_3_1]].set[arg_3_1] = arg_3_2

		if arg_3_2 then
			if self:__check_all_equal_the_isOn(self[self._set[arg_3_1]], true) then
				self:__set_the_rule_isOn(self[self._turn[self._set[arg_3_1]]], self[self._set[arg_3_1]].all_isOn.turn_isOn)
			else
				self:__set_the_rule_isOn(self[self._turn[self._set[arg_3_1]]], false)
			end
		elseif self:__check_all_equal_the_isOn(self[self._set[arg_3_1]], false) then
			if self[self._set[arg_3_1]].all_not_isOn.turn_isOn == nil then
				if self:__check_all_equal_the_isOn(self[self._turn[self._set[arg_3_1]]], self[self._set[arg_3_1]].all_not_isOn.self_rule.condition_turn_all_isOn) then
					self:__set_the_rule_isOn(self[self._set[arg_3_1]], self[self._set[arg_3_1]].all_not_isOn.self_rule.self_isOn)
				end
			else
				self:__set_the_rule_isOn(self[self._turn[self._set[arg_3_1]]], self[self._set[arg_3_1]].all_not_isOn.turn_isOn)
			end
		end
	end

	function arg_1_0:toggleOnOnly(arg_4_1, arg_4_2, arg_4_3)
		self[self._set[arg_4_1]].set[arg_4_1] = arg_4_2

		if arg_4_2 then
			if self:__check_all_equal_the_isOn(self[self._set[arg_4_1]], true) then
				self:__set_the_rule_isOn(self[self._turn[self._set[arg_4_1]]], self[self._set[arg_4_1]].all_isOn.turn_isOn)
			else
				self:__make_only_set(self[self._set[arg_4_1]], arg_4_1, arg_4_2)
				self:__set_the_rule_isOn(self[self._turn[self._set[arg_4_1]]], false)
			end
		else
			if arg_4_3 then
				self._directly = arg_4_3

				self:__set_the_rule_isOn(self[self._set[arg_4_1]], arg_4_2)

				return
			end

			if self._directly then
				self._directly = nil

				return
			end

			if self:__check_all_equal_the_isOn(self[self._set[arg_4_1]], false) then
				if self[self._set[arg_4_1]].all_not_isOn.turn_isOn == nil then
					if self:__check_all_equal_the_isOn(self[self._turn[self._set[arg_4_1]]], self[self._set[arg_4_1]].all_not_isOn.self_rule.condition_turn_all_isOn) then
						self:__set_the_rule_isOn(self[self._set[arg_4_1]], self[self._set[arg_4_1]].all_not_isOn.self_rule.self_isOn)
					end
				else
					self:__set_the_rule_isOn(self[self._turn[self._set[arg_4_1]]], self[self._set[arg_4_1]].all_not_isOn.turn_isOn)
				end
			end
		end
	end

	function arg_1_0:__make_only_set(arg_5_1, arg_5_2, arg_5_3)
		if arg_5_3 then
			for iter_5_0, iter_5_1 in pairs(arg_5_1.set) do
				if iter_5_0 == arg_5_2 then
					arg_5_1.set[iter_5_0] = arg_5_3
				else
					arg_5_1.set[iter_5_0] = false
					self._control[iter_5_0].toggle.isOn = false
				end
			end
		else
			arg_5_1.set[arg_5_2] = arg_5_3
		end
	end

	function arg_1_0:__set_the_rule_isOn(arg_6_1, arg_6_2)
		if arg_6_2 == nil then
			return
		end

		for iter_6_0, iter_6_1 in pairs(arg_6_1.set) do
			arg_6_1.set[iter_6_0] = arg_6_2
			self._control[iter_6_0].toggle.isOn = arg_6_2
		end
	end

	function arg_1_0.__check_all_equal_the_isOn(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in pairs(arg_7_1.set) do
			if iter_7_1 ~= arg_7_2 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__add_to_rule(arg_8_1, arg_8_2, arg_8_3)
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			if self._set[iter_8_1] then
				assert(false)
			end

			self._set[iter_8_1] = arg_8_3
			arg_8_2.set[iter_8_1] = self._control[iter_8_1].toggle.isOn
		end
	end
end)

function var_0_0.create(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = lx.class("toggle_group")

	var_9_0._rule_a = {
		all_isOn = {
			turn_isOn = false
		},
		all_not_isOn = {
			self_rule = {
				self_isOn = true,
				condition_turn_all_isOn = false
			}
		},
		set = {}
	}
	var_9_0._rule_b = {
		all_isOn = {
			turn_isOn = true
		},
		all_not_isOn = {
			turn_isOn = true
		},
		set = {}
	}
	var_9_0._set = {}
	var_9_0._turn = {
		_rule_b = "_rule_a",
		_rule_a = "_rule_b"
	}
	var_9_0._control = arg_9_3

	var_9_0:__add_to_rule(arg_9_1, var_9_0._rule_a, "_rule_a")
	var_9_0:__add_to_rule(arg_9_2, var_9_0._rule_b, "_rule_b")

	return var_9_0
end

return var_0_0
