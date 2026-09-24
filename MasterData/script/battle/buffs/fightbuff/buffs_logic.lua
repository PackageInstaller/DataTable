local var_0_0 = {}
local var_0_1 = lx
local var_0_4 = string.format
local var_0_5 = gamecore.BaseObject
local var_0_7 = gameenum.battle_type
local var_0_8 = gameconfig.ship_pve_buff_config
local var_0_9 = gameconfig.sixth_combat_buff_config
local var_0_11 = gameconfig.tower_buff_config

lx.define_class("buffs_logic", function(arg_1_0)
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

		if arg_5_2 == "combat_buff" then
			local var_5_0 = var_0_9.find_object_by_buff_id_level(arg_5_1.id, arg_5_1.level) or var_0_9.find_object_by_id(arg_5_1.id)

			if arg_5_1.point_effect and next(arg_5_1.point_effect) then
				var_5_0 = {
					effect = arg_5_1.point_effect
				}
			end

			if not var_5_0 then
				return
			end

			arg_5_0._buff_data = var_5_0
		end

		if arg_5_2 == "ship_pve_buff" then
			local var_5_1 = var_0_8.find_object_by_id(arg_5_1)

			if not var_5_1 then
				return
			end

			arg_5_0._buff_data = var_5_1
		end

		if arg_5_2 == "tower_buff" then
			local var_5_2 = var_0_11.find_object_by_id(arg_5_1)

			if not var_5_2 then
				return
			end

			arg_5_0._buff_data = var_5_2
		end
	end

	function arg_1_0:do_buff_logic(arg_6_1, arg_6_2, arg_6_3)
		if self._buff_type == "combat_buff" then
			self:__on_sixth_buffs_func(arg_6_1, arg_6_2, arg_6_3)
		end

		if self._buff_type == "ship_pve_buff" then
			for iter_6_0, iter_6_1 in pairs(self._buff_data.effect) do
				self:__on_main_buffs_func(iter_6_1, arg_6_1, arg_6_2, arg_6_3)
			end
		end

		if self._buff_type == "tower_buff" then
			self:__on_tower_buffs_func(self._buff_data, arg_6_1, arg_6_2, arg_6_3)
		end
	end

	function arg_1_0:__on_sixth_buffs_func(arg_7_1, arg_7_2, arg_7_3)
		if not self._buff_data or not self._buff_data.effect then
			return
		end

		for iter_7_0, iter_7_1 in pairs(self._buff_data.effect) do
			local var_7_0 = var_0_4("__on_func_%s", (self:__get_sixth_buff_func_name(iter_7_1.type)))

			if not self[var_7_0] then
				return
			end

			self[var_7_0](self, iter_7_1, arg_7_1, arg_7_2, arg_7_3)
		end
	end

	function arg_1_0:__on_main_buffs_func(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = var_0_4("__on_func_%s", (self:__get_main_buff_func_name(arg_8_1.type)))

		if not self[var_8_0] then
			return
		end

		self[var_8_0](self, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end

	function arg_1_0:__on_tower_buffs_func(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		if arg_9_3 then
			return
		end

		for iter_9_0, iter_9_1 in pairs(arg_9_1.effect) do
			local var_9_0 = var_0_4("__on_func_%s", (self:__get_buff_func_name(iter_9_1.type, var_0_7.main_fight_buff_type)))

			if not self[var_9_0] then
				return
			end

			if arg_9_1.side == 0 and arg_9_2:get_side() == var_0_7.obj_side.enemy then
				return
			end

			if arg_9_1.side == 1 and arg_9_2:get_side() == var_0_7.obj_side.player then
				return
			end

			self[var_9_0](self, iter_9_1, arg_9_2, arg_9_3, arg_9_4)
		end
	end

	function arg_1_0.__get_sixth_buff_func_name(arg_10_0, arg_10_1)
		for iter_10_0, iter_10_1 in pairs(var_0_7.sixth_buff_type) do
			if iter_10_1 == arg_10_1 then
				return iter_10_0
			end
		end
	end

	function arg_1_0.__get_main_buff_func_name(arg_11_0, arg_11_1)
		for iter_11_0, iter_11_1 in pairs(var_0_7.main_fight_buff_type) do
			if iter_11_1 == arg_11_1 then
				return iter_11_0
			end
		end
	end

	function arg_1_0.__get_buff_func_name(arg_12_0, arg_12_1, arg_12_2)
		if not arg_12_2 then
			return
		end

		for iter_12_0, iter_12_1 in pairs(arg_12_2) do
			if iter_12_1 == arg_12_1 then
				return iter_12_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_13_0)
	local var_13_0 = var_0_1.class("buffs_logic", var_0_5:inherit())

	var_13_0._count = 0
	var_13_0._damage = 0

	return var_13_0
end

return var_0_0
