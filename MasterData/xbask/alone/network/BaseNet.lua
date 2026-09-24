local var_0_0 = {}
local var_0_1 = lx
local var_0_3 = lx.BaseNetworkManager

lx.define_class("BaseNet", function(arg_1_0)
	function arg_1_0:getID()
		return self._id
	end

	function arg_1_0.run_once(arg_3_0)
		var_0_1.error("need override this method")
	end

	function arg_1_0:__on_destroy()
		var_0_3:removeNetObject(self._id)
	end
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_1.class("BaseNet")

	var_5_0._id = var_0_3:addNetObject(var_5_0)

	return var_5_0
end

return var_0_0
