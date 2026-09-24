local var_0_0 = {}
local var_0_1 = gameenum.error_type
local var_0_2 = gamecore.UILoader
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ChangeDeskCollectionResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__change_wall_collection_success(arg_2_1)
		end

		var_0_5:set_collection_state(true)
	end

	function arg_1_0:ChangeWallCollectionResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:__change_wall_collection_success(arg_3_1)
		end
	end

	function arg_1_0:ChangeMedalResp(arg_4_1)
		if arg_4_1.result == 0 then
			self:__change_medal_success(arg_4_1)
		end
	end

	function arg_1_0:UpgradeMedalResp(arg_5_1)
		if arg_5_1.result == 0 then
			self:__up_grade_medal_success(arg_5_1)
		else
			var_0_4:show(var_0_1:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:ChangeBoxroomStyleResp(arg_6_1)
		if arg_6_1.result == 0 then
			self:__change_boxroom_style_success(arg_6_1)
		end
	end

	function arg_1_0.__change_desk_collection_success(arg_7_0)
		local var_7_0 = var_0_2:getInstance("show_room_collection")

		if var_7_0 then
			var_7_0:get_user_collection_data()
			var_7_0:get_user_use_collection_data()
			var_7_0:__update_cell()

			var_7_0._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
			var_7_0._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		end
	end

	function arg_1_0.__change_wall_collection_success(arg_8_0)
		local var_8_0 = var_0_2:getInstance("show_room_collection")

		if var_8_0 then
			var_8_0:get_user_collection_data()
			var_8_0:get_user_use_collection_data()
			var_8_0:__update_cell()

			var_8_0._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
			var_8_0._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		end

		local var_8_1 = var_0_2:getInstance("show_room")

		if var_8_1 then
			var_8_1:get_user_use_collection_data()
		end
	end

	function arg_1_0.__change_medal_success(arg_9_0)
		local var_9_0 = var_0_2:getInstance("show_room") or var_0_2:createInstance("show_room")

		var_9_0:show()
		var_9_0:get_user_use_collection_data()
	end

	function arg_1_0.__up_grade_medal_success(arg_10_0)
		local var_10_0 = var_0_2:createInstance("show_room_medal")

		var_10_0:set_user_madel_data()
		var_10_0:change_medal_type(var_10_0.now_tyep)
	end

	function arg_1_0.__change_boxroom_style_success(arg_11_0)
		return
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
