local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.error_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ClassroomExtendResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__get_classroom_Extend_success()
		else
			var_0_1:show(var_0_3:getNowLang("money_not_enough"))
		end
	end

	function arg_1_0:ReplaceTeacherResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:__get_replace_teacher_success()
		else
			var_0_1:show(var_0_4:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:StartStudyResp(arg_4_1)
		if arg_4_1.result == 0 then
			self:__get_start_study_success()
		elseif arg_4_1.result == 84 then
			var_0_1:show(var_0_3:getNowLang("tactics_teacher_leisure"))
		else
			var_0_1:show(var_0_4:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0:StopStudyResp(arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_2:getInstance("class_info_view")

			if var_5_0 then
				self:set_now_statics_seat(var_5_0._seat_list)
			end

			self:__get_stop_study_success()
		elseif arg_5_1.result == 1 then
			var_0_1:show(var_0_3:getNowLang("shipexpedition"))
		else
			var_0_1:show(var_0_4:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.__get_classroom_Extend_success(arg_6_0)
		local var_6_0 = var_0_2:getInstance("college_expand_view")
		local var_6_1 = var_0_2:getInstance("school")

		if var_6_0 then
			var_6_0:update_class_data()
		end

		if var_6_1 then
			var_6_1:__init_btn_set()
			var_6_1:update_now_class_data(var_6_1._on_click_num)
		end
	end

	function arg_1_0:__get_start_study_success()
		local var_7_0 = var_0_2:getInstance("class_info_view")

		if var_7_0 then
			self:set_now_statics_seat(var_7_0._seat_list)
			var_7_0:setVisible(false)
		end

		local var_7_1 = var_0_2:getInstance("school")

		if var_7_1 then
			var_7_1:update_data()
			var_7_1:update_enter_student_data()
		end

		local var_7_2 = var_0_2:getInstance("select_tactis_view")

		if var_7_2 then
			var_7_2:__onClick_baseboard_return_btn()
			var_7_2:setVisible(false)
		end

		local var_7_3 = var_0_2:getInstance("tactics_select_member")

		if var_7_3 then
			var_7_3:__init_panel()
		end
	end

	function arg_1_0.__get_stop_study_success(arg_8_0)
		local var_8_0 = var_0_2:getInstance("class_info_view")

		if var_8_0 then
			var_8_0:setVisible(false)
		end

		local var_8_1 = var_0_2:getInstance("school")

		if var_8_1 then
			var_8_1:update_data()
			var_8_1:update_stop_student_data()
		end
	end

	function arg_1_0.__get_replace_teacher_success(arg_9_0)
		local var_9_0 = var_0_2:getInstance("change_instructor_view")

		if var_9_0 then
			var_9_0:update_teacher_teach_state()
		end

		local var_9_1 = var_0_2:getInstance("school")

		if var_9_1 then
			var_9_1:update_now_class_data((var_9_1:get_curr_class()))
			var_9_1:set_now_class_teacher()
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
