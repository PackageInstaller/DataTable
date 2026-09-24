local var_0_0 = lx
local var_0_3 = gamecore.UILoader

lx.define_class("profile", function(arg_1_0)
	function arg_1_0:start()
		self._profile = var_0_3:createInstance("profile")

		self._profile:start()
	end

	function arg_1_0:stop()
		if self._profile then
			self._profile:stop()
		end
	end
end)

return function()
	local var_4_0 = var_0_0.class("profile")

	var_4_0._profile = nil

	return var_4_0
end
