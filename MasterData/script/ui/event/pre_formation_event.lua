local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_4 = gamecore.UILoader
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_widget_return_btn()
		self:__exit_pre_formation()

		local var_2_0 = var_0_4:getInstance("fight_prepare")

		if var_2_0 then
			var_2_0:setVisible(true)

			if var_2_0._current_content_type == var_0_2.fight_prepare_right_panel_type.strike then
				var_2_0:__init_strike_prepare(var_0_2.fight_prepare_right_panel_type.strike)
			end
		end

		local var_2_1 = var_0_4:getInstance("dock_team")

		if var_2_1 then
			var_2_1:setVisible(true)
		end

		var_0_5:set_all_select_member_list()
	end

	function arg_1_0:__onClick_top_widget_left_btn()
		self._now_page_num = self._now_page_num - 1

		if self._now_page_num <= 0 then
			self._now_page_num = 3
		end

		self:_set_now_preteam_index(self._now_page_num)
	end

	function arg_1_0:__onClick_top_widget_right_btn()
		self._now_page_num = self._now_page_num + 1

		if self._now_page_num > 3 then
			self._now_page_num = 1
		end

		self:_set_now_preteam_index(self._now_page_num)
	end

	function arg_1_0:__onClick_top_widget_page_index_one_not_image()
		self._now_page_num = 1

		self:_set_now_preteam_index(self._now_page_num)
	end

	function arg_1_0:__onClick_top_widget_page_index_two_not_image()
		self._now_page_num = 2

		self:_set_now_preteam_index(self._now_page_num)
	end

	function arg_1_0:__onClick_top_widget_page_index_three_not_image()
		self._now_page_num = 3

		self:_set_now_preteam_index(self._now_page_num)
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
