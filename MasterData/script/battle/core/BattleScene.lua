local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format

lx.define_class("BattleScene", function(arg_1_0)
	function arg_1_0:findObject(arg_2_1)
		return self._object_set[arg_2_1]
	end

	function arg_1_0:createObject(arg_3_1, ...)
		local var_3_0 = self:__alloc_object_id()
		local var_3_1 = arg_3_1:create()

		if not var_3_1:isTheClassType("BaseObject") then
			var_0_1.error("need to inherit from 'BaseObject'")
		end

		var_3_1:setID(var_3_0)
		var_3_1:bind(self._battlefield, self._battle_processor, self._battle_time, self._battle_random, self, self._battle_obj_mgr)

		self._object_set[var_3_0] = var_3_1

		self:eventOnCreateObject(var_3_1, ...)

		return var_3_1
	end

	function arg_1_0:removeObject(arg_4_1)
		if not self._object_set[arg_4_1] then
			var_0_1.error(var_0_2("removeObject, not find object, id:[%s]", tostring(arg_4_1)))
		end

		self._object_set[arg_4_1]:setRemoved()
		self:eventOnRemoveObject(self._object_set[arg_4_1])

		self._object_set[arg_4_1] = nil
	end

	function arg_1_0:initData(arg_5_1)
		self:eventOnInit(arg_5_1)
	end

	function arg_1_0:eventOnInit(arg_6_1)
		self:__eventOnInit(arg_6_1)
	end

	function arg_1_0:eventOnDestroy()
		self:__eventOnDestroy()
	end

	function arg_1_0:eventOnCreateObject(arg_8_1, ...)
		self:__eventOnCreateObject(arg_8_1, ...)
	end

	function arg_1_0:eventOnRemoveObject(arg_9_1)
		self:__eventOnRemoveObject(arg_9_1)
	end

	function arg_1_0:eventOnFrame(arg_10_1)
		self:__eventOnFrame(arg_10_1)
	end

	function arg_1_0:execute(arg_11_1, arg_11_2)
		if not self["order_on__" .. arg_11_1] then
			var_0_1.error(var_0_2("battle scene order not found, order:[%s]", tostring(arg_11_1)))

			return
		end

		self["order_on__" .. arg_11_1](self, arg_11_2)
	end

	function arg_1_0:__alloc_object_id()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id
	end

	function arg_1_0:bind()
		self._battle_processor = self._battlefield:getBattleProcessor()
		self._battle_time = self._battlefield:getBattleTime()
		self._battle_random = self._battlefield:getBattleRandom()
		self._battle_obj_mgr = self._battlefield:getBattleObjectManager()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_14_0, arg_14_1)
	local var_14_0 = var_0_1.class("BattleScene")

	var_14_0._alloc_id = 8001
	var_14_0._object_set = {}
	var_14_0._battlefield = arg_14_1
	var_14_0._battle_time = nil
	var_14_0._battle_random = nil
	var_14_0._battle_obj_mgr = nil
	var_14_0._battle_processor = nil

	gamecore.extend_obj(var_14_0)

	return var_14_0
end

return var_0_0
