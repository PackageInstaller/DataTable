local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_4 = gameconfig.pve_score_buff_config
local var_0_5 = gamecore.BaseObject
local var_0_6 = gameenum.battle_type

lx.define_class("score_push_buffs_logic", function(arg_1_0)
	function arg_1_0.eventOnFrame(arg_2_0, arg_2_1, arg_2_2)
		return
	end

	function arg_1_0.__init(arg_3_0, arg_3_1, arg_3_2)
		if not arg_3_1 then
			return
		end

		arg_3_0._buff_type = arg_3_2

		if arg_3_2 == "score_push_buff" then
			local var_3_0 = var_0_4.find_object_by_id(arg_3_1)

			if not var_3_0 then
				return
			end

			arg_3_0._buff_data = var_3_0
		end
	end

	function arg_1_0:do_buff_logic(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		if self._buff_type == "score_push_buff" then
			self:__on_score_push_buff_func(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		end
	end

	function arg_1_0:__on_score_push_buff_func(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if not self._buff_data or not self._buff_data.effect then
			return
		end

		for iter_5_0, iter_5_1 in pairs(self._buff_data.effect) do
			local var_5_0 = var_0_2("__on_func_%s", (self:__get_score_buff_func_name(iter_5_1.type)))

			if not self[var_5_0] then
				return
			end

			self[var_5_0](self, iter_5_1, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		end
	end

	function arg_1_0.__get_score_buff_func_name(arg_6_0, arg_6_1)
		for iter_6_0, iter_6_1 in pairs(var_0_6.score_push_buffs_type) do
			if iter_6_1 == arg_6_1 then
				return iter_6_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_7_0)
	return (var_0_1.class("score_push_buffs_logic", var_0_5:inherit()))
end

return var_0_0
