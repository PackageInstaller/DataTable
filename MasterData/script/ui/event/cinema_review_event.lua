local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_return_btn(arg_2_0)
		var_0_1:destroyInstance("cinema_review")
		var_0_1:createInstance("cinema"):setVisible(true)
	end

	function arg_1_0:__onToggle_btn_group_main_story_btn()
		self:show_scroll_by_index(1)
		self:init_story_cell_list()
	end

	function arg_1_0:__onToggle_btn_group_chara_story_btn()
		self:show_scroll_by_index(2)
		self:init_story_cell_list()
	end

	function arg_1_0:__onScaleButtonClick_return_btn()
		self:__onClick_return_btn()
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
