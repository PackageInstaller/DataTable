local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_container_close_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_unlock_btn()
		self:go_dialog_event()
	end

	function arg_1_0:__onClick_lock_btn()
		self:go_story_event(self.now_link_info)
	end

	function arg_1_0.__onClick_tps_main_back(arg_5_0)
		var_0_1:destroyInstance("cinema_link_info")
		var_0_1:getInstance("cinema_link"):show()
	end

	function arg_1_0:__onClick_tps_main_confirm()
		self:go_dialog_event(self.now_link_info)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
