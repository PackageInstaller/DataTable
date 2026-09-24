local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gameenum.battle_type
local var_0_3 = gameconfig.equip_config

lx.define_class("aircraft_logic", function(arg_1_0)
	function arg_1_0:get_owner()
		return self._owner
	end

	function arg_1_0:get_type()
		return self._aircraft_type
	end

	function arg_1_0:__init_obj(arg_4_1)
		self._aircraft_type = var_0_3.find_object_by_cid(arg_4_1.cid).type
		self._owner = self._battle_obj_mgr:findObject(arg_4_1.owner_id)

		self:process(self._battle_event.event.register)
	end
end, "object_logic_base")

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_1.class("aircraft_logic", gamecore.object_logic_base:inherit())

	var_5_0._battle_event = var_0_2.battle_event_type.aircraft
	var_5_0._owner = nil

	return var_5_0
end

return var_0_0
