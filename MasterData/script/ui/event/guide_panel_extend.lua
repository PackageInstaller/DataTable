local var_0_0 = {}
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__on_btn_func_home_btn(arg_2_0, arg_2_1)
		local var_2_0 = var_0_3:getInstance("home")

		if var_2_0 then
			return var_2_0:get_guide_btn_pos_info(arg_2_1)
		end
	end

	function arg_1_0.__on_btn_func_dock_team_btn(arg_3_0, arg_3_1)
		local var_3_0 = var_0_3:getInstance("dock_team")

		if var_3_0 then
			return var_3_0:get_guide_btn_pos_info(arg_3_1)
		end
	end

	function arg_1_0.__on_btn_func_task_btn(arg_4_0, arg_4_1)
		local var_4_0 = var_0_3:getInstance("task")

		if var_4_0 then
			return var_4_0:get_guide_btn_pos_info(arg_4_1)
		end
	end

	function arg_1_0.__on_btn_func_main_menu_btn(arg_5_0, arg_5_1)
		local var_5_0 = var_0_3:getInstance("main_menu")

		if var_5_0 then
			return var_5_0:get_guide_btn_pos_info(arg_5_1)
		end
	end

	function arg_1_0.__on_btn_func_fight_prepare_btn(arg_6_0, arg_6_1)
		local var_6_0 = var_0_3:getInstance("fight_prepare")

		if var_6_0 then
			return var_6_0:get_guide_btn_pos_info(arg_6_1)
		end
	end

	function arg_1_0.__on_btn_func_go_fight_btn(arg_7_0, arg_7_1)
		local var_7_0 = var_0_3:getInstance("gotofight")

		if var_7_0 then
			return var_7_0:get_guide_btn_pos_info(arg_7_1)
		end
	end

	function arg_1_0.__on_btn_func_bathroom_btn(arg_8_0, arg_8_1)
		local var_8_0 = var_0_3:getInstance("bathroom")

		if var_8_0 then
			return var_8_0:get_guide_btn_pos_info(arg_8_1)
		end
	end

	function arg_1_0.__on_btn_func_dock_view_btn(arg_9_0, arg_9_1)
		local var_9_0 = var_0_3:getInstance("dock")

		if var_9_0 then
			return var_9_0:get_guide_btn_pos_info(arg_9_1)
		end
	end

	function arg_1_0.__on_btn_func_msg_view_btn(arg_10_0, arg_10_1)
		local var_10_0 = var_0_3:getInstance("msgbox")

		if var_10_0 then
			return var_10_0:get_guide_btn_pos_info(arg_10_1)
		end
	end

	function arg_1_0.__on_btn_func_fight_info_btn(arg_11_0, arg_11_1)
		local var_11_0 = var_0_3:getInstance("fight_info")

		if var_11_0 then
			return var_11_0:get_guide_btn_pos_info(arg_11_1)
		end
	end

	function arg_1_0.__on_btn_func_bathroom_repair_btn(arg_12_0, arg_12_1)
		local var_12_0 = var_0_3:getInstance("bathroom_repair")

		if var_12_0 then
			return var_12_0:get_guide_btn_pos_info(arg_12_1)
		end
	end

	function arg_1_0.__on_btn_func_dock_bet_btn(arg_13_0, arg_13_1)
		local var_13_0 = var_0_3:getInstance("dock_bet")

		if var_13_0 then
			return var_13_0:get_guide_btn_pos_info(arg_13_1)
		end
	end

	function arg_1_0.__on_btn_func_select_member_btn(arg_14_0, arg_14_1)
		local var_14_0 = var_0_3:getInstance("select_member")

		if var_14_0 then
			return var_14_0:get_guide_btn_pos_info(arg_14_1)
		end
	end

	function arg_1_0.__on_btn_func_msgbox_image_btn(arg_15_0, arg_15_1)
		local var_15_0 = var_0_3:getInstance("msgbox_image")

		if var_15_0 then
			-- block empty
		else
			var_15_0 = var_0_3:createInstance("msgbox_image")
		end

		return var_15_0:get_guide_btn_pos_info(arg_15_1)
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
