local var_0_0 = {}
local var_0_1 = lx

lx.define_class("BehaviourObject", function(arg_1_0)
	function arg_1_0:getID()
		return self._id
	end

	function arg_1_0:getGameObject()
		return self._gameObject
	end

	function arg_1_0.Awake(arg_4_0)
		return
	end

	function arg_1_0.Start(arg_5_0)
		return
	end

	function arg_1_0.Update(arg_6_0)
		return
	end

	function arg_1_0.LateUpdate(arg_7_0)
		return
	end

	function arg_1_0.FixedUpdate(arg_8_0)
		return
	end

	function arg_1_0.OnEnable(arg_9_0)
		return
	end

	function arg_1_0.OnDisable(arg_10_0)
		return
	end

	function arg_1_0.OnDestroy(arg_11_0)
		return
	end
end)

function var_0_0.inherit(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_1.class("BehaviourObject", arg_12_2)

	var_12_0._id = arg_12_1
	var_12_0._gameObject = arg_12_2

	return var_12_0
end

return var_0_0
