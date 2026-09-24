local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_return()
		self:__destroy_panel()
	end

	function arg_1_0:__onClick_main_top_btns_replay()
		self:play_video(var_0_2.video_path.fifth_event)
	end

	function arg_1_0:__onClick_main_top_btns_plot()
		var_0_1:createInstance("cinema_story_node"):show(self._story_id, true)
	end

	function arg_1_0:__onClick_main_top_btns_explain()
		self:__show_explain(true)
	end

	function arg_1_0:__onClick_main_top_btns_award()
		self:setVisible(false)
		var_0_1:createInstance("fifth_awardbox"):show()
	end

	function arg_1_0:__onClick_main_btn_joy_btn()
		self:__change_btn_event(false)
	end

	function arg_1_0:__onClick_main_btn_main_btn()
		self:__change_btn_event(true)
	end

	function arg_1_0.__onClick_main_bottom_joy_rebuild(arg_9_0)
		var_0_1:createInstance("fifth_restore_shop"):show()
	end

	function arg_1_0:__onClick_main_desc_panel_close_btn()
		self:__show_explain(false)
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
