local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("guide_panel_mask", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:set_mask_state(false)
	end

	function arg_1_0:set_mask_state(arg_3_1)
		self._control.mask.image.raycastTarget = arg_3_1
	end

	function arg_1_0:set_mask_bg_state(arg_4_1)
		self._control.mask_bg:SetActive(arg_4_1)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_1:class("guide_panel_mask"))
end

return var_0_0
