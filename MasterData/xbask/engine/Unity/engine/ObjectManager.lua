local var_0_0 = lx
local var_0_1 = assert
local var_0_2 = typeof
local var_0_3 = xbask.XbaskBehaviour
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5
local var_0_9 = 6
local var_0_10 = 7
local var_0_11 = 8

lx.define_class("ObjectManager", function(arg_1_0)
	function arg_1_0:AddComponentClass(arg_2_1, arg_2_2)
		local var_2_0 = self:__alloc_id()
		local var_2_1 = arg_2_1:AddComponent(var_0_2(var_0_3))
		local var_2_2 = arg_2_2:create(var_2_0, var_2_1)

		if not var_2_2:isTheClassType("BehaviourObject") then
			var_0_1(false)
		end

		self:__add_object(var_2_0, var_2_2)
		var_2_1:BindClass(var_2_2:getClassName(), var_2_0)

		return var_2_1
	end

	function arg_1_0:__event__Awake(arg_3_1)
		self:__find_object(arg_3_1):Awake()
	end

	function arg_1_0:__event__Start(arg_4_1)
		self:__find_object(arg_4_1):Start()
	end

	function arg_1_0:__event__Update(arg_5_1)
		self:__find_object(arg_5_1):Update()
	end

	function arg_1_0:__event__LateUpdate(arg_6_1)
		self:__find_object(arg_6_1):LateUpdate()
	end

	function arg_1_0:__event__FixedUpdate(arg_7_1)
		self:__find_object(arg_7_1):FixedUpdate()
	end

	function arg_1_0:__event__OnEnable(arg_8_1)
		self:__find_object(arg_8_1):OnEnable()
	end

	function arg_1_0:__event__OnDisable(arg_9_1)
		self:__find_object(arg_9_1):OnDisable()
	end

	function arg_1_0:__event__OnDestroy(arg_10_1)
		self:__find_object(arg_10_1):OnDestroy()
		self:__remove_object(arg_10_1)
	end

	function arg_1_0:__alloc_id()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id + 1
	end

	function arg_1_0:__add_object(arg_12_1, arg_12_2)
		self._set[arg_12_1] = arg_12_2
	end

	function arg_1_0:__remove_object(arg_13_1)
		self._set[arg_13_1] = nil
	end

	function arg_1_0:__find_object(arg_14_1)
		return self._set[arg_14_1]
	end

	function arg_1_0:__on_event(arg_15_1, ...)
		self._event_obj:dispatch(arg_15_1, ...)
	end

	function arg_1_0:reinitEventFunc()
		self._event_obj:registerEventFunc(var_0_4, self.__event__Awake)
		self._event_obj:registerEventFunc(var_0_5, self.__event__Start)
		self._event_obj:registerEventFunc(var_0_6, self.__event__Update)
		self._event_obj:registerEventFunc(var_0_7, self.__event__LateUpdate)
		self._event_obj:registerEventFunc(var_0_8, self.__event__FixedUpdate)
		self._event_obj:registerEventFunc(var_0_9, self.__event__OnEnable)
		self._event_obj:registerEventFunc(var_0_10, self.__event__OnDisable)
		self._event_obj:registerEventFunc(var_0_11, self.__event__OnDestroy)
	end

	function arg_1_0:destroy_instance()
		for iter_17_0, iter_17_1 in pairs(self._set) do
			-- block empty
		end

		self._set = {}
	end
end)

return function()
	local var_18_0 = var_0_0.class("ObjectManager")

	var_18_0._alloc_id = 0
	var_18_0._set = {}
	var_18_0._event_obj = var_0_0.event_dispatch:create(var_18_0)

	var_18_0._event_obj:setCoreArg(var_18_0)

	function _G.__xbask_behaviour__event__(...)
		return var_18_0:__on_event(...)
	end

	return var_18_0
end
