local var_0_0 = {}
local var_0_1 = lx
local var_0_5 = gamecore.BaseObject
local var_0_6 = gameenum.battle_type

lx.define_class("rank_support_buffs_logic", function(arg_1_0)
	function arg_1_0.init(arg_2_0)
		return
	end

	function arg_1_0.eventOnFrame(arg_3_0, arg_3_1, arg_3_2)
		return
	end

	function arg_1_0.__init(arg_4_0, arg_4_1, arg_4_2)
		if not arg_4_1 then
			return
		end

		arg_4_0._buff_type = arg_4_2

		if arg_4_2 == "rank_support_buff" then
			arg_4_0._buff_data = arg_4_1
		end
	end

	function arg_1_0:do_buff_logic(arg_5_1, arg_5_2, arg_5_3)
		if self._buff_type == "rank_support_buff" and self._buff_data then
			self:__on_rank_support_buffs_func(self._buff_data, arg_5_1, arg_5_2, arg_5_3)
		end
	end

	function arg_1_0:__on_rank_support_buffs_func(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		local var_6_0 = string.format("__on_func_%s", (self:__get_buff_func_name(self._buff_data.type, var_0_6.rank_buffs_type)))

		if not self[var_6_0] then
			return
		end

		self[var_6_0](self, self._buff_data, arg_6_2, arg_6_3, arg_6_4)
	end

	function arg_1_0.__get_buff_func_name(arg_7_0, arg_7_1, arg_7_2)
		if not arg_7_2 then
			return
		end

		for iter_7_0, iter_7_1 in pairs(arg_7_2) do
			if iter_7_1 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_1.class("rank_support_buffs_logic", var_0_5:inherit())

	var_8_0._buff_data = {}
	var_8_0._buff_type = {}
	var_8_0._count = 0
	var_8_0._damage = 0

	return var_8_0
end

return var_0_0
