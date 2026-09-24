local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = assert

lx.define_class("BaseObject", function(arg_1_0)
	function arg_1_0:getID()
		return self._id
	end

	function arg_1_0:setID(arg_3_1)
		if self._id ~= nil then
			var_0_2(self._id == nil)
		end

		self._id = arg_3_1
	end

	function arg_1_0:isRemoved()
		return self._removed
	end

	function arg_1_0.setRemoved(arg_5_0)
		arg_5_0._removed = true
	end

	function arg_1_0:getBattleRandom()
		return self._battle_random
	end

	function arg_1_0:getBattleProcessor()
		return self._battle_processor
	end

	function arg_1_0.bind(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
		arg_8_0._battlefield = arg_8_1
		arg_8_0._battle_processor = arg_8_2
		arg_8_0._battle_time = arg_8_3
		arg_8_0._battle_random = arg_8_4
		arg_8_0._battle_scene = arg_8_5
		arg_8_0._battle_obj_mgr = arg_8_6
	end

	function arg_1_0:__eventOnInit(...)
		self:__init(...)
	end

	function arg_1_0.__eventOnDestroy(arg_10_0)
		return
	end

	function arg_1_0:__eventOnFrame(arg_11_1)
		self._last_time = self._last_time or arg_11_1

		self:eventOnFrame(arg_11_1, arg_11_1 - self._last_time)

		self._last_time = arg_11_1
	end

	function arg_1_0.execute(arg_12_0, arg_12_1, arg_12_2)
		var_0_1.error("need override this method")
	end
end)

function var_0_0.inherit(arg_13_0)
	local var_13_0 = var_0_1.class("BaseObject")

	var_13_0._id = nil
	var_13_0._removed = false
	var_13_0._owner = nil
	var_13_0._battlefield = nil
	var_13_0._battle_random = nil
	var_13_0._battle_time = nil
	var_13_0._battle_scene = nil
	var_13_0._battle_obj_mgr = nil
	var_13_0._battle_processor = nil

	return var_13_0
end

return var_0_0
