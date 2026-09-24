local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.LayoutRoomResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("dormitory")

			if not var_2_0 then
				return
			end

			var_2_0:update_room_furniture()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.ShipEnterRoomResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("dormitory")

			if var_3_0 then
				var_3_0:update_room_role()
			end

			local var_3_1 = var_0_1:getInstance("select_member")

			if var_3_1 then
				var_3_1:setVisible(false)
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.getFurnitureCoollectRewardResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("dormitory_collection")

			if not var_4_0 then
				return
			end

			var_4_0:get_award_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0:BuyFurnitureBoxResp(arg_5_1)
		if arg_5_1.result == 0 then
			self:__notice_exchange_refresh_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:MultiBuyFurnitureBoxResp(arg_6_1)
		if arg_6_1.result == 0 then
			self:__notice_exchange_refresh_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0:LockFurnitureResp(arg_7_1)
		if arg_7_1.result == 0 then
			self:__notice_warhouse_refresh_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0:ResolveFurnitureResp(arg_8_1)
		if arg_8_1.result == 0 then
			self:__notice_warhouse_recycle_refresh_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0.GetExhibitionResp(arg_9_0, arg_9_1)
		local var_9_0 = var_0_1:getInstance("dormitory")

		if var_9_0 then
			var_9_0:setVisible(false)
		end

		local var_9_1 = var_0_1:getInstance("dormitory_design_list") or var_0_1:createInstance("dormitory_design_list")

		if not var_0_1:getInstance("dormitory_design_detail") then
			local var_9_2 = var_0_1:createInstance("dormitory_design_detail")
		end

		if not var_9_1 then
			return
		end

		if not arg_9_1.exhibition then
			return
		end

		if var_9_1:isVisible() == false then
			var_9_1:show(arg_9_1.exhibition)
		end

		var_9_0._exhibition_come_in_flag = 0
	end

	function arg_1_0.AddExhibitionCollectResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			local var_10_0 = var_0_1:getInstance("dormitory_design_list")

			if var_10_0 then
				var_10_0:update_cell()
			end

			local var_10_1 = var_0_1:getInstance("dormitory_design_detail")

			if not var_10_1 then
				return
			end

			var_10_1:collect_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_10_1.result))
		end
	end

	function arg_1_0.RemoveExhibitionCollectResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("dormitory_design_list")

			if var_11_0 then
				var_11_0:update_cell()
			end

			local var_11_1 = var_0_1:getInstance("dormitory_design_detail")

			if not var_11_1 then
				return
			end

			var_11_1:cancel_collect_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_11_1.result))
		end
	end

	function arg_1_0.EvaluateExhibitionResp(arg_12_0, arg_12_1)
		if arg_12_1.result == 0 then
			local var_12_0 = var_0_1:getInstance("dormitory_design_detail")

			if not var_12_0 then
				return
			end

			var_12_0:evaluate_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_12_1.result))
		end
	end

	function arg_1_0.UserExhibitionResp(arg_13_0, arg_13_1)
		if arg_13_1.result == 0 then
			local var_13_0 = var_0_1:getInstance("dormitory")

			if not var_13_0 then
				return
			end

			var_13_0:update_room_furniture()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_13_1.result))
		end
	end

	function arg_1_0.RecordRoomResp(arg_14_0, arg_14_1)
		if arg_14_1.result == 0 then
			local var_14_0 = var_0_1:getInstance("dormitory_record")

			if not var_14_0 then
				return
			end

			var_14_0:save_record_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_14_1.result))
		end
	end

	function arg_1_0.UseRecordResp(arg_15_0, arg_15_1)
		if arg_15_1.result == 0 then
			local var_15_0 = var_0_1:getInstance("dormitory")

			if not var_15_0 then
				return
			end

			var_15_0:update_room_furniture()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_15_1.result))
		end
	end

	function arg_1_0.UploadRecordResp(arg_16_0, arg_16_1)
		if arg_16_1.result == 0 then
			local var_16_0 = var_0_1:getInstance("dormitory_record")

			if not var_16_0 then
				return
			end

			var_16_0:upload_record_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_16_1.result))
		end
	end

	function arg_1_0.ResetRecordResp(arg_17_0, arg_17_1)
		if arg_17_1.result == 0 then
			local var_17_0 = var_0_1:getInstance("dormitory_record")

			if not var_17_0 then
				return
			end

			var_17_0:reset_record_resp()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_17_1.result))
		end
	end

	function arg_1_0.RoomExtendResp(arg_18_0, arg_18_1)
		if arg_18_1.result == 0 then
			local var_18_0 = var_0_1:getInstance("dormitory_expand_view")

			if var_18_0 then
				var_18_0:update_curr_dormitory_capacity()
				var_18_0:setVisible(false)
			end

			local var_18_1 = var_0_1:getInstance("dormitory")

			if var_18_1 then
				var_18_1:__refresh_room_select_menu()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_18_1.result))
		end
	end

	function arg_1_0.RoomInteractResp(arg_19_0, arg_19_1)
		local var_19_0 = var_0_1:getInstance("dormitory")

		if var_19_0 then
			var_19_0:touch_head_add_love_resp(arg_19_1.result)
		end
	end

	function arg_1_0.RoomCropResp(arg_20_0, arg_20_1)
		if arg_20_1.result == 0 and var_0_1:getInstance("dormitory") then
			-- block empty
		end
	end

	function arg_1_0.RacingResp(arg_21_0, arg_21_1)
		return
	end

	function arg_1_0.DollMachineResp(arg_22_0, arg_22_1)
		return
	end

	function arg_1_0.__notice_exchange_refresh_data(arg_23_0)
		local var_23_0 = var_0_1:getInstance("exchange_shop_panel")

		if var_23_0 then
			var_23_0:update_res_data()
		end
	end

	function arg_1_0.__notice_warhouse_refresh_data(arg_24_0)
		local var_24_0 = var_0_1:getInstance("dorm_warehouse")

		if var_24_0 then
			var_24_0:update_furniture_lock_data()
		end

		local var_24_1 = var_0_1:getInstance("furniture_detail_panel")

		if var_24_1 then
			var_24_1:update_lock_data()
			var_24_1:set_lock_interactable_state(true)
		end
	end

	function arg_1_0.__notice_warhouse_recycle_refresh_data(arg_25_0)
		local var_25_0 = var_0_1:getInstance("dorm_warehouse")

		if var_25_0 then
			var_25_0:update_furniture_data()
		end

		local var_25_1 = var_0_1:getInstance("furniture_recycle_panel")

		if var_25_1 then
			var_25_1:update_furniture_recycle_handle_data()
		end
	end
end

function var_0_0.extend_obj(arg_26_0)
	return
end

return var_0_0
