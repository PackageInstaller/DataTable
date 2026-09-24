local var_0_0 = {}
local var_0_1 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_base_panel_return_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_base_panel_add_bg()
		self:set_panel_state(false)
	end

	function arg_1_0:__onClick_single_detail_return_btn()
		self:set_panel_state(true)
	end

	function arg_1_0:__onClick_detail_panel_lock()
		self:set_lock_interactable_state(false)
		var_0_1:req_LockFurnitureReq(self._now_furniture_data)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
