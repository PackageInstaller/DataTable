local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		var_0_4:set_to_school(false)
		self:__reset_talk_tween()
		self:__reset_animation_state()

		self._on_click_num = 1

		self:setVisible(false)

		local var_2_0 = var_0_1:createInstance("living_areas")

		var_2_0:show()
		var_2_0:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, "dormitory"))
		self:destroy_panel()
		var_0_4:set_statics_common_state(false)
	end

	function arg_1_0:__onClick_home_btn()
		self:__reset_talk_tween()
		self:__reset_animation_state()

		self._on_click_num = 1

		self:setVisible(false)

		local var_3_0 = var_0_1:getInstance("home")

		var_3_0:show()
		var_3_0:into_home_bgm()
		self:destroy_panel()
		var_0_4:set_statics_common_state(false)
	end

	function arg_1_0:__onClick_change_btn()
		var_0_1:createInstance("change_instructor_view"):show(self._now_class_teacher_index)
	end

	function arg_1_0:__onClick_role_btn()
		var_0_1:createInstance("change_instructor_view"):show(self._now_class_teacher_index)
	end

	function arg_1_0:__onClick_furniture_table_next_table_4()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.first_group)
	end

	function arg_1_0:__onClick_table_last_table_1()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.second_group)
	end

	function arg_1_0:__onClick_furniture_table_next_table_5()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.third_group)
	end

	function arg_1_0:__onClick_table_last_table_2()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.four_group)
	end

	function arg_1_0:__onClick_furniture_table_next_table_6()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.five_group)
	end

	function arg_1_0:__onClick_table_last_table_3()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.six_group)
	end

	function arg_1_0:__set_now_select_ship_data(arg_12_1)
		self:update_seat_data(arg_12_1)

		if #self._total_class_data == 0 then
			self:__show_study_state_data(false)

			return
		end

		for iter_12_0, iter_12_1 in pairs(self._total_class_data) do
			if iter_12_1.id == self._now_class and iter_12_1.seat[arg_12_1] ~= nil then
				if iter_12_1.seat[arg_12_1] > 0 then
					self:get_tactics_by_ship_id(iter_12_1.seat[arg_12_1])
					self:__show_study_state_data(true)
				else
					self:__show_study_state_data(false)
				end
			elseif iter_12_1.id == self._now_class and not iter_12_1.seat[arg_12_1] then
				self:__show_school_expand_panel()
			end
		end
	end

	function arg_1_0:__show_study_state_data(arg_13_1)
		if arg_13_1 then
			var_0_1:createInstance("class_info_view"):show(self._now_tactics_data, "school")
		else
			var_0_1:createInstance("select_tactis_view"):show(self._now_teacher_data)
		end
	end

	function arg_1_0.__show_school_expand_panel(arg_14_0)
		var_0_1:createInstance("college_expand_view"):show()
	end

	function arg_1_0:__reset_animation_state()
		for iter_15_0, iter_15_1 in pairs(self._role_ani_list) do
			iter_15_1:Kill()
		end
	end

	function arg_1_0:__onClick_class_btn_set_class_one()
		self:__reset_animation_state()
		var_0_4:set_now_class_num(1)
		self:update_now_class_data(1)
	end

	function arg_1_0:__onClick_class_btn_set_class_two()
		self:__reset_animation_state()

		if self._now_class_num >= 2 then
			var_0_4:set_now_class_num(2)
			self:update_now_class_data(2)
		else
			self:__show_school_expand_panel()
		end
	end

	function arg_1_0:__onClick_class_btn_set_class_three()
		self:__reset_animation_state()

		if self._now_class_num >= 3 then
			var_0_4:set_now_class_num(3)
			self:update_now_class_data(3)
		else
			self:__show_school_expand_panel()
		end
	end

	function arg_1_0:__onClick_progress_bar_set_progress_one()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.second_group)
	end

	function arg_1_0:__onClick_progress_bar_set_progress_two()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.four_group)
	end

	function arg_1_0:__onClick_progress_bar_set_progress_three()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.six_group)
	end

	function arg_1_0:__onClick_progress_bar_set_progress_four()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.first_group)
	end

	function arg_1_0:__onClick_progress_bar_set_progress_five()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.third_group)
	end

	function arg_1_0:__onClick_progress_bar_set_progress_six()
		self:__set_now_select_ship_data(var_0_3.college_const.chair_data.five_group)
	end
end

function var_0_0.extend_obj(arg_25_0)
	return
end

return var_0_0
