local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("music_node", function(arg_1_0)
	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_2_0)
	return (var_0_1:class("music_node"))
end

return var_0_0
