local var_0_0 = {}
local var_0_2 = gamecore.util_func
local var_0_3 = gameconfig.ship_pve_buff_config
local var_0_4 = gamecore.UILoader

gamecore.UILoader:define("tower_layer_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		self:__init_panel(arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._control.buff_info.text.text = var_0_2.convert_rich_text(var_0_3.find_object_by_id(arg_3_1).desc)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_4:class("tower_layer_info"))
end

return var_0_0
