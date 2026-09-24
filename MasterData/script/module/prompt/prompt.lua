local var_0_0 = lx
local var_0_3 = gamecore.UILoader

lx.define_class("prompt", function(arg_1_0)
	function arg_1_0.show(arg_2_0, arg_2_1, arg_2_2)
		var_0_3:__load_ui("prompt"):show(arg_2_1, arg_2_2)
	end
end)

return function()
	return (var_0_0.class("prompt"))
end
