local var_0_0 = lx
local var_0_1 = {}
local var_0_5 = gameenum.battle_type.battle_event_type

lx.define_class("torpedo_logic", function(arg_1_0)
	function arg_1_0:get_owner()
		return self._owner
	end

	function arg_1_0:get_target()
		return self._target
	end

	function arg_1_0:__init_obj(arg_4_1)
		self._owner = self._battle_obj_mgr:findObject(arg_4_1.owner_id)
		self._target = self._battle_obj_mgr:findObject(arg_4_1.target_id)

		self:process(self._battle_event.event.register)
	end
end, "object_logic_base")

function var_0_1.create(arg_5_0)
	local var_5_0 = var_0_0.class("torpedo_logic", gamecore.object_logic_base:inherit())

	var_5_0._speed = 1
	var_5_0._delta_offset = {
		z = 0,
		x = 0,
		y = 0
	}
	var_5_0._direction = {
		z = 0,
		x = 0,
		y = 0
	}
	var_5_0._owner = nil
	var_5_0._target = nil
	var_5_0._battle_event = var_0_5.torpedo

	return var_5_0
end

return var_0_1
