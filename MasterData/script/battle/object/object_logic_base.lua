local var_0_0 = {}
local var_0_1 = lx

lx.define_class("object_logic_base", function(arg_1_0)
	function arg_1_0.set_side(arg_2_0, arg_2_1)
		arg_2_0._side = arg_2_1
	end

	function arg_1_0:get_side()
		return self._side
	end

	function arg_1_0:set_pos(arg_4_1)
		self._pos = self._pos or {}
		self._pos.x = arg_4_1.x
		self._pos.y = arg_4_1.y
		self._pos.z = arg_4_1.z
	end

	function arg_1_0:get_pos()
		return self._pos
	end

	function arg_1_0:get_battle_event()
		return self._battle_event
	end

	function arg_1_0:execute(arg_7_1, arg_7_2)
		local var_7_0 = string.format("__onExecute_%s", arg_7_1)

		if not self[var_7_0] then
			return
		end

		self[var_7_0](self, arg_7_2)
	end

	function arg_1_0:process(arg_8_1, arg_8_2)
		if not arg_8_1 then
			return
		end

		if self._battlefield.is_test then
			return
		end

		self._battle_processor:onEvent({
			id = self:getID(),
			name = self._battle_event.name,
			type = arg_8_1,
			info = arg_8_2
		})
	end

	function arg_1_0.eventOnFrame(arg_9_0, arg_9_1, arg_9_2)
		return
	end

	function arg_1_0:__eventOnInit(...)
		self:__init_obj(...)
	end

	function arg_1_0.__init_obj(arg_11_0, ...)
		var_0_1.error("need override")
	end
end, "BaseObject")

function var_0_0.inherit(arg_12_0)
	local var_12_0 = var_0_1.class("object_logic_base", gamecore.BaseObject:inherit())

	var_12_0._battle_event = nil
	var_12_0._side = 0
	var_12_0._pos = nil

	return var_12_0
end

return var_0_0
