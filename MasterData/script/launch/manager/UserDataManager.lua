local var_0_0 = lx
local var_0_1 = lx.UserData

lx.define_class("UserDataManager", function(arg_1_0)
	function arg_1_0.setDataByID(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		assert(type(arg_2_1) == "string" and type(arg_2_3) == "string")
		var_0_1:setKeyData(arg_2_1 .. tostring(arg_2_2), arg_2_3)
	end

	function arg_1_0.getDataByID(arg_3_0, arg_3_1, arg_3_2)
		return (var_0_1:getKeyData(arg_3_1 .. tostring(arg_3_2)))
	end
end)

return function()
	return (var_0_0.class("UserDataManager"))
end
