local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format

lx.define_class("BattleObjectManager", function(arg_1_0)
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
		var_3_1:bind(self._battlefield, self._battle_processor, self._battle_time, self._battle_random, self._battle_scene, self)

		self._object_set[var_3_0] = var_3_1

		self:eventOnCreateObject(var_3_1, ...)

		return var_3_1
	end

	function arg_1_0:removeObject(arg_4_1)
		if not self._object_set[arg_4_1] then
			var_0_1.error(var_0_2("removeObject, not find object, id:[%s]", tostring(arg_4_1)))
		end

		self._object_set[arg_4_1]:setRemoved()

		self._object_set[arg_4_1] = nil
	end

	function arg_1_0:initData(arg_5_1)
		self:eventOnInit(arg_5_1)
	end

	function arg_1_0:execute(arg_6_1, arg_6_2)
		self:__execute(arg_6_1, arg_6_2)
	end

	function arg_1_0:__alloc_object_id()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id
	end

	function arg_1_0:eventOnInit(arg_8_1)
		self:__eventOnInit(arg_8_1)
	end

	function arg_1_0:eventOnDestroy()
		self:__eventOnDestroy()
	end

	function arg_1_0:eventOnCreateObject(arg_10_1, ...)
		self:__eventOnCreateObject(arg_10_1, ...)
	end

	function arg_1_0:eventOnRemoveObject(arg_11_1)
		self:__eventOnRemoveObject(arg_11_1)
	end

	function arg_1_0:eventOnFrame(arg_12_1)
		self:__eventOnFrame(arg_12_1)
	end

	function arg_1_0:get_dunker_status()
		return self._is_all_dunker
	end

	function arg_1_0:bind()
		self._battle_processor = self._battlefield:getBattleProcessor()
		self._battle_time = self._battlefield:getBattleTime()
		self._battle_random = self._battlefield:getBattleRandom()
		self._battle_scene = self._battlefield:getBattleScene()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0, arg_15_1)
	local var_15_0 = var_0_1.class("BattleObjectManager")

	var_15_0._alloc_id = 1
	var_15_0._object_set = {}
	var_15_0._battlefield = arg_15_1
	var_15_0._battle_processor = nil
	var_15_0._battle_time = nil
	var_15_0._battle_random = nil
	var_15_0._battle_scene = nil
	var_15_0._is_all_dunker = true

	gamecore.extend_obj(var_15_0)

	return var_15_0
end

return var_0_0
