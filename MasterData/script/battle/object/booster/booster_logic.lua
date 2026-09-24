local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.object_logic_base

lx.define_class("booster_logic", function(arg_1_0)
	function arg_1_0:get_owner()
		return self._owner
	end

	function arg_1_0:__init_obj(arg_3_1)
		self._owner = self._battle_obj_mgr:findObject(arg_3_1.owner_id)

		self:process(self._battle_event.event.register)
	end
end, "object_logic_base")

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_1.class("booster_logic", var_0_3:inherit())

	var_4_0._battle_event = var_0_2.battle_event_type.booster
	var_4_0._owner = nil

	return var_4_0
end

return var_0_0
