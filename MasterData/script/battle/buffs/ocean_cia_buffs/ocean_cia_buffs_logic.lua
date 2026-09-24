local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_4 = gameconfig.pve_ocean_cia_config
local var_0_5 = gamecore.BaseObject
local var_0_6 = gameenum.battle_type

lx.define_class("ocean_cia_buffs_logic", function(arg_1_0)
	function arg_1_0:init()
		self:__init_ocean_cia_buffs_data()
	end

	function arg_1_0.eventOnFrame(arg_3_0, arg_3_1, arg_3_2)
		return
	end

	function arg_1_0.__init(arg_4_0, ...)
		return
	end

	function arg_1_0:__init_ocean_cia_buffs_data()
		if not self:__get_curr_fight_type() then
			return
		end

		local var_5_0 = self._battle_scene:get_ocean_cia_buffs_data()

		if not var_5_0 then
			return
		end

		if not next(var_5_0) then
			return
		end

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			local var_5_1 = var_0_4.find_object_by_id(iter_5_1)

			if var_5_1 then
				self:__init_call_func(var_5_1.effect)
			end
		end
	end

	function arg_1_0:__init_call_func(arg_6_1)
		if arg_6_1.buff_type and arg_6_1.buff_type == 1 then
			return
		end

		for iter_6_0, iter_6_1 in pairs(arg_6_1.effect) do
			self:__on_buffs_func(iter_6_1)
		end
	end

	function arg_1_0:__on_buffs_func(arg_7_1)
		if not arg_7_1.type then
			return
		end

		local var_7_0 = var_0_2("__on_func_%s", (var_0_6:get_pve_ocean_cia_buffs_type(arg_7_1.type)))

		if not self[var_7_0] then
			return
		end

		return self[var_7_0](self, arg_7_1)
	end

	function arg_1_0:__get_curr_fight_type()
		if self._battle_scene:get_fight_type() ~= var_0_6.fight_type.ocean_attack then
			return false
		end

		return true
	end

	gamecore.extend_method(arg_1_0)
end, "BaseObject")

function var_0_0.create(arg_9_0)
	return (var_0_1.class("ocean_cia_buffs_logic", var_0_5:inherit()))
end

return var_0_0
