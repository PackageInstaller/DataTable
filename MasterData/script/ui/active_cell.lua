local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_pve_active_config

gamecore.UILoader:define("active_cell", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._control.pic_icon.image.sprite = self:loadSprite(string.format(var_0_4.sixth_activity_image, var_0_5.find_object_by_id(arg_3_1.id).pic))
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_3:class("active_cell")

	gamecore.extend_obj(var_4_0)

	return var_4_0
end

return var_0_0
