local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("loading", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:setVisible(arg_2_1)
		self:set_mask_active(false)
		self:set_wait_active(not arg_2_3)
		self:set_txt_info(arg_2_4)

		if arg_2_2 then
			arg_2_2()
		end
	end

	function arg_1_0:set_mask_active(arg_3_1)
		self._control.mask:SetActive(arg_3_1)
	end

	function arg_1_0:set_wait_active(arg_4_1)
		self._control.wait:SetActive(arg_4_1)
		self._control.info:SetActive(arg_4_1)
	end

	function arg_1_0:set_txt_info(arg_5_1)
		self._control.info.text.text = not arg_5_1 and "loading" or arg_5_1
	end
end)

function var_0_0.create(arg_6_0)
	return (var_0_1:class("loading"))
end

return var_0_0
