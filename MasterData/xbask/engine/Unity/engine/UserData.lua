local var_0_0 = UnityEngine.PlayerPrefs

lx.define_class("UserData", function(arg_1_0)
	function arg_1_0.setKeyData(arg_2_0, arg_2_1, arg_2_2)
		var_0_0.SetString(arg_2_1, arg_2_2)
		var_0_0.Save()
	end

	function arg_1_0.getKeyData(arg_3_0, arg_3_1)
		return var_0_0.GetString(arg_3_1, "")
	end
end)

return function()
	return (lx.class("UserData"))
end
