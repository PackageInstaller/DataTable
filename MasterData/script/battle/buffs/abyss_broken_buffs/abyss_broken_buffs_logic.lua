local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_4 = gameconfig.abyss_buff_config
local var_0_5 = gamecore.BaseObject
local var_0_6 = gameenum.battle_type

lx.define_class("abyss_broken_buffs_logic", function(arg_1_0)
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

		if arg_4_2 == "abyss_buff" then
			local var_4_0 = var_0_4.find_object_by_id(arg_4_1)

			if not var_4_0 then
				return
			end

			arg_4_0._buff_data = var_4_0
		end
	end

	function arg_1_0:do_buff_logic(arg_5_1, arg_5_2, arg_5_3)
		if not arg_5_1 then
			return
		end

		if self._buff_type == "abyss_buff" then
			if self._buff_data.side == 1 and self._battle_scene:get_fight_type() == var_0_6.fight_type.abyss then
				self:__on_abyss_broken_buffs_func(self._buff_data.effect, arg_5_1, arg_5_2, arg_5_3)
			end

			if self._buff_data.side == 2 and self._battle_scene:get_fight_type() == var_0_6.fight_type.abyss_2 then
				self:__on_abyss_broken_buffs_func(self._buff_data.effect, arg_5_1, arg_5_2, arg_5_3)
			end
		end
	end

	function arg_1_0:__on_abyss_broken_buffs_func(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			local var_6_0 = var_0_2("__on_func_%s", (self:__get_buff_func_name(iter_6_1.type, var_0_6.abyss_broken_buffs_type)))

			if not self[var_6_0] then
				return
			end

			if arg_6_2:get_side() ~= var_0_6.obj_side.player then
				return
			end

			self[var_6_0](self, iter_6_1, arg_6_2, arg_6_3, arg_6_4)
		end
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
	local var_8_0 = var_0_1.class("abyss_broken_buffs_logic", var_0_5:inherit())

	var_8_0._buff_data = {}
	var_8_0._buff_type = {}

	return var_8_0
end

return var_0_0
