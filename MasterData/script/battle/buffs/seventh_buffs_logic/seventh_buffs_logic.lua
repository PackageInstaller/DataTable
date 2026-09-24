local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_3 = gamecore.BaseObject
local var_0_4 = gameconfig.pve_mix_buff_config
local var_0_5 = gameenum.battle_type

lx.define_class("seventh_buffs_logic", function(arg_1_0)
	function arg_1_0.set_damage(arg_2_0, arg_2_1)
		arg_2_0._damage = arg_2_1
	end

	function arg_1_0:get_damage()
		return self._damage
	end

	function arg_1_0.eventOnFrame(arg_4_0, arg_4_1, arg_4_2)
		return
	end

	function arg_1_0.__init(arg_5_0, arg_5_1, arg_5_2)
		if not arg_5_1 then
			return
		end

		arg_5_0._buff_type = arg_5_2

		if arg_5_2 == "seventh_buff" then
			arg_5_0._buff_data = var_0_4.find_object_by_id(arg_5_1)
		end

		if arg_5_2 == "seventh_node_buff" then
			arg_5_0._buff_data = {
				effect = arg_5_1
			}
		end
	end

	function arg_1_0:do_buff_logic(arg_6_1, arg_6_2, arg_6_3)
		if self._buff_type == "seventh_buff" then
			self:__on_seventh_buffs_func(arg_6_1, arg_6_2, arg_6_3)
		end

		if self._buff_type == "seventh_node_buff" then
			self:__on_seventh_buffs_func(arg_6_1, arg_6_2, arg_6_3)
		end
	end

	function arg_1_0:__on_seventh_buffs_func(arg_7_1, arg_7_2, arg_7_3)
		if not self._buff_data or not self._buff_data.effect then
			return
		end

		for iter_7_0, iter_7_1 in pairs(self._buff_data.effect) do
			local var_7_0 = var_0_2("__on_func_%s", (self:__get_seventh_buff_func_name(iter_7_1.type)))

			if not self[var_7_0] then
				return
			end

			self[var_7_0](self, iter_7_1, arg_7_1, arg_7_2, arg_7_3)
		end
	end

	function arg_1_0.__get_seventh_buff_func_name(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in pairs(var_0_5.seventh_buff_type) do
			if iter_8_1 == arg_8_1 then
				return iter_8_0
			end
		end
	end

	function arg_1_0.__get_buff_func_name(arg_9_0, arg_9_1, arg_9_2)
		if not arg_9_2 then
			return
		end

		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			if iter_9_1 == arg_9_1 then
				return iter_9_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_10_0)
	local var_10_0 = var_0_1.class("seventh_buffs_logic", var_0_3:inherit())

	var_10_0._count = 0
	var_10_0._damage = 0

	return var_10_0
end

return var_0_0
