local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_3 = gamecore.BaseObject
local var_0_5 = gameenum.battle_type
local var_0_8 = gameconfig.tactics_config

lx.define_class("tactics_logic", function(arg_1_0)
	function arg_1_0:init(arg_2_1)
		local var_2_0 = {}
		local var_2_1 = {}

		self._owner = self._battle_obj_mgr:findObject(arg_2_1)

		local var_2_2 = self._owner:get_tactics() or {}

		self._tactics_cid = self._owner:get_learning_tactic()

		for iter_2_0, iter_2_1 in pairs(var_2_2) do
			repeat
				if iter_2_1 == 0 then
					break
				end

				local var_2_3 = var_0_8.find_object_by_cid(iter_2_1)

				if not var_2_3 then
					break
				end

				table.insert(var_2_0, var_2_3)
				table.insert(var_2_1, var_2_3.tactics_id)
			until true
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.plot_main then
			return
		end

		if self._tactics_cid == 0 then
			-- block empty
		end

		self._tactics_conf = var_2_0
		self._tactics_ids = var_2_1

		self._owner:set_curr_carry_tactics_id(self._tactics_ids)
		self._owner:set_ignore_add_tactics_exp((self:__ignore_tactics_by_map()))
		self:on_special_tactics_func()
	end

	function arg_1_0:on_tactics_func(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
		local var_3_0 = {}
		local var_3_4, var_3_5 = self:get_tactics_func_name()

		if not var_3_5 then
			return nil
		end

		local var_3_6 = {
			num = {},
			tactic_id = {}
		}

		for iter_3_0, iter_3_1 in pairs(var_3_4) do
			table.insert(var_3_0, (var_0_2("__%s", iter_3_1)))
		end

		local var_3_7
		local var_3_8

		if arg_3_1 then
			var_3_7 = self._battle_obj_mgr:findObject(arg_3_1)
			var_3_8 = self._battle_obj_mgr:findObject(arg_3_2)
		end

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			local var_3_9, var_3_10, var_3_11 = self[iter_3_3](self, var_3_5[iter_3_2], self._owner, var_3_7, var_3_8, arg_3_3, arg_3_4, arg_3_5)

			if var_3_9 ~= nil then
				var_3_6.num[var_3_10] = var_3_6.num[var_3_10] or 0
				var_3_6.num[var_3_10] = var_3_6.num[var_3_10] + var_3_9
				var_3_6.tactic_id[var_3_10] = var_3_11
			end
		end

		return var_3_6
	end

	function arg_1_0:get_tactics_func_name()
		local var_4_0 = {}
		local var_4_1 = {}
		local var_4_2 = 0

		if not next(self._tactics_ids) then
			return var_4_1, var_4_0
		end

		for iter_4_0, iter_4_1 in pairs(self._tactics_ids) do
			var_4_2 = var_4_2 + 1

			for iter_4_2, iter_4_3 in pairs(var_0_5.tactics_type) do
				if iter_4_3.value == iter_4_1 then
					table.insert(var_4_0, var_4_2)
					table.insert(var_4_1, iter_4_3.func_name)
				end
			end
		end

		return var_4_1, var_4_0
	end

	function arg_1_0:on_special_tactics_func()
		local var_5_0 = {}
		local var_5_4, var_5_5, var_5_6 = self:get_special_tactics_func_name()

		self._only_add_exp = nil

		for iter_5_0, iter_5_1 in pairs(var_5_4) do
			var_5_0[iter_5_0] = var_0_2("__%s", iter_5_1)
		end

		for iter_5_2, iter_5_3 in pairs(var_5_0) do
			self[iter_5_3](self, var_5_5[iter_5_2], self._owner, var_5_6[iter_5_2], self._tactics_ids[iter_5_2])
		end
	end

	function arg_1_0:get_special_tactics_func_name()
		local var_6_0 = {}
		local var_6_1 = {}
		local var_6_2 = {}
		local var_6_3 = 0

		if not next(self._tactics_ids) then
			return var_6_1, var_6_0, var_6_2
		end

		local var_6_4 = self._battle_scene:get_effect_tactics()

		for iter_6_0, iter_6_1 in pairs(self._tactics_ids) do
			var_6_3 = var_6_3 + 1

			for iter_6_2, iter_6_3 in pairs(var_0_5.tactics_special_type) do
				if iter_6_3.value == iter_6_1 then
					var_6_0[iter_6_0] = var_6_3
					var_6_1[iter_6_0] = iter_6_3.func_name

					local var_6_5 = false

					for iter_6_4, iter_6_5 in pairs(var_6_4) do
						if iter_6_3.value == iter_6_5 then
							var_6_5 = true
						end
					end

					var_6_2[iter_6_0] = var_6_5

					if not var_6_5 then
						self._battle_scene:set_effect_tactics(iter_6_3.value)
					end
				end
			end
		end

		return var_6_1, var_6_0, var_6_2
	end

	function arg_1_0.eventOnFrame(arg_7_0, arg_7_1, arg_7_2)
		return
	end

	function arg_1_0.__init(arg_8_0, ...)
		return
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_1.class("tactics_logic", var_0_3:inherit())

	var_9_0._owner = nil
	var_9_0._tactics_cid = 0
	var_9_0._tactics_id = 0
	var_9_0._tactics_ids = {}
	var_9_0._tactics_conf = nil

	return var_9_0
end

return var_0_0
