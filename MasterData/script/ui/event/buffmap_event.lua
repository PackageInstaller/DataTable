return {
	extend_method = function(arg_1_0)
		function arg_1_0:__onClick_return_btn()
			self:__close_panel()
		end

		function arg_1_0:__onClick_type_btn()
			self:__set_to_top(0)
			self:__show_quality_selection(true, 0)
		end

		function arg_1_0:__onClick_show_btn()
			self:__show_quality_selection(true, 1)
		end

		function arg_1_0:__onClick_type_selection()
			self:__set_to_top(1)
			self:__show_quality_selection(false)
		end

		function arg_1_0:__onClick_type_selection_type_buttons_type_all()
			self:__show_quality_selection(false)
			self:__update_reusable_cell(0)
			self:__update_selection_text(0)
		end

		function arg_1_0:__onClick_type_selection_type_buttons_type_1()
			self:__show_quality_selection(false)
			self:__update_reusable_cell(1)
			self:__update_selection_text(1)
		end

		function arg_1_0:__onClick_type_selection_type_buttons_type_2()
			self:__show_quality_selection(false)
			self:__update_reusable_cell(2)
			self:__update_selection_text(2)
		end

		function arg_1_0:__onClick_mask()
			self:show_mask(false)
		end

		function arg_1_0:__onClick_msg_box_main_quitbtn()
			self:__set_purchange_active(false)
		end

		function arg_1_0.__onClick_msg_box_main_confirmbtn(arg_11_0)
			return
		end

		function arg_1_0:__onClick_msg_box_main_closebtn()
			self:__set_purchange_active(false)
		end
	end,
	extend_obj = function(arg_13_0)
		return
	end
}
