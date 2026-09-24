local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.init_hook(arg_2_0, arg_2_1)
		if UnityEngine.Screen.width / UnityEngine.Screen.height >= 1.3 and UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.4 then
			arg_2_0._hook = 1.3333333333333333
		elseif UnityEngine.Screen.width / UnityEngine.Screen.height >= 1.7 and UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.8 then
			arg_2_0._hook = 1
		end
	end

	function arg_1_0:get_hook(arg_3_1)
		if arg_3_1 and arg_3_1.y then
			arg_3_1.y = arg_3_1.y * (self._hook or 1)
		end

		return arg_3_1
	end

	function arg_1_0.release_hook(arg_4_0)
		arg_4_0._hook = 1
	end
end

function var_0_0.extend_obj(arg_5_0)
	arg_5_0._hook = 1
end

return var_0_0
