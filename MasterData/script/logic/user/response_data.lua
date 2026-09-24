local var_0_0 = {}
local var_0_1 = lx
local var_0_3 = tostring
local var_0_5 = gamecore.UILoader
local var_0_6 = gameenum.common_type
local var_0_7 = lx.json_decode
local var_0_8 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.TaskUpdate(arg_2_0, arg_2_1)
		return
	end

	function arg_1_0.FriendInfoUpdate(arg_3_0, arg_3_1)
		return
	end

	function arg_1_0.LevelInfoUpdate(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0.TeamUpdate(arg_5_0, arg_5_1)
		return
	end

	function arg_1_0.LoginBonusRecordUpdate(arg_6_0, arg_6_1)
		return
	end

	function arg_1_0.EquipmentInfoUpdate(arg_7_0, arg_7_1)
		return
	end

	function arg_1_0.ItemInfoUpdate(arg_8_0, arg_8_1)
		return
	end

	function arg_1_0.ShopUpdate(arg_9_0, arg_9_1)
		return
	end

	function arg_1_0.StoryUpdate(arg_10_0, arg_10_1)
		return
	end

	function arg_1_0.EquipmentUpdate(arg_11_0, arg_11_1)
		return
	end

	function arg_1_0.MailUpdate(arg_12_0, arg_12_1)
		return
	end

	function arg_1_0.HarborUpdate(arg_13_0, arg_13_1)
		return
	end

	function arg_1_0.ExpeditionInfoUpdate(arg_14_0, arg_14_1)
		return
	end

	function arg_1_0:UserInfoUpdate(arg_15_1)
		if not arg_15_1.user_info then
			return
		end

		for iter_15_0, iter_15_1 in pairs(arg_15_1.user_info) do
			if self._data then
				self._data[iter_15_0] = iter_15_1
			end
		end

		local var_15_0 = var_0_5:getInstance("home")

		if var_15_0 and var_15_0._panel.activeSelf then
			var_15_0:updata_user_res()
			var_15_0:update_combatshop_mysterious_textbook_buff_float()
			var_15_0:update_combatshop_tactics_textbook_buff_float()
		end

		local var_15_1 = var_0_5:getInstance("dormitory_game")

		if var_15_1 and var_15_1._panel.activeSelf and arg_15_1.user_info.racing_count then
			var_15_1:check_get_buff_num(arg_15_1.user_info.racing_count)
		end
	end

	function arg_1_0.ShortMessageUpdate(arg_16_0, arg_16_1)
		return
	end

	function arg_1_0.MapInfoUpdate(arg_17_0, arg_17_1)
		return
	end

	function arg_1_0.ArchiveUpdate(arg_18_0, arg_18_1)
		return
	end

	function arg_1_0.FurnitureUpdate(arg_19_0)
		return
	end

	function arg_1_0.MansionStyleUpdate(arg_20_0)
		return
	end

	function arg_1_0:BuildInfoNotify(arg_21_1)
		for iter_21_0, iter_21_1 in pairs(arg_21_1.info) do
			if iter_21_0 == "repair_pool" then
				self:set_dock_data({
					type = var_0_6.pool_type.repair,
					data = iter_21_1
				})
				self:set_repair_info(iter_21_1)

				local var_21_0 = var_0_5:getActiveInstance("dock_team")

				if var_21_0 then
					var_21_0:refresh_info_list()
				end

				local var_21_1 = var_0_5:getActiveInstance("fight_prepare")

				if var_21_1 then
					local var_21_2 = var_0_8:get_come_in_panel_style()

					if var_21_1._current_content_type == var_0_6.fight_prepare_right_panel_type.strike then
						var_21_1:__init_strike_prepare(true)
					elseif var_21_2 == 12 then
						-- block empty
					else
						var_21_1:refresh_info_list(true)
					end
				end

				local var_21_3 = var_0_5:getActiveInstance("select_member")

				if var_21_3 then
					var_21_3:update_data()
				end
			elseif iter_21_0 == "ship_build_pool" then
				self:set_dock_data({
					type = var_0_6.pool_type.ship_build,
					data = iter_21_1
				})

				local var_21_4 = var_0_5:getInstance("dock")

				if var_21_4 then
					var_21_4:update_data()
				end
			elseif iter_21_0 == "equipment_build_pool" then
				self:set_dock_data({
					type = var_0_6.pool_type.equipment_build,
					data = iter_21_1
				})

				local var_21_5 = var_0_5:getInstance("dock")

				if var_21_5 then
					var_21_5:update_data()
				end
			end
		end

		self:set_previous_dock_data(arg_21_1.resource)
	end

	function arg_1_0.SystemDataNotify(arg_22_0, arg_22_1)
		arg_22_0._can_pay = var_0_7(arg_22_1.system_data).pay
		arg_22_0._is_harmony = var_0_7(arg_22_1.system_data).harmony
	end

	function arg_1_0.ShipArchiveUpdate(arg_23_0)
		return
	end

	function arg_1_0.EquipmentArchiveUpdate(arg_24_0)
		return
	end

	function arg_1_0.ClassroomInfoUpdate(arg_25_0)
		return
	end

	function arg_1_0.TeacherInfoUpdate(arg_26_0)
		return
	end

	function arg_1_0.RankTaskUpdate(arg_27_0)
		return
	end

	function arg_1_0.SpoilsShopInfoUpdate(arg_28_0)
		return
	end

	function arg_1_0.GuideUpdate(arg_29_0)
		return
	end

	function arg_1_0.RepairStyleUpdate(arg_30_0)
		return
	end

	function arg_1_0.BoxroomWallUpdate(arg_31_0)
		return
	end

	function arg_1_0.BoxroomDeskUpdate(arg_32_0)
		return
	end

	function arg_1_0.BoxroomMedalUpdate(arg_33_0)
		return
	end

	function arg_1_0.BoxroomStyleUpdate(arg_34_0)
		return
	end

	function arg_1_0.MedalUpdate(arg_35_0)
		return
	end

	function arg_1_0.RankSupportInfoUpdate(arg_36_0)
		return
	end

	function arg_1_0.CampaignInfoUpdate(arg_37_0)
		return
	end

	function arg_1_0.SixthShopInfoUpdate(arg_38_0, arg_38_1)
		return
	end

	function arg_1_0.SixthInfoUpdate(arg_39_0, arg_39_1)
		return
	end

	function arg_1_0.WorkshopInfoUpdate(arg_40_0, arg_40_1)
		return
	end

	function arg_1_0.WorkshopScoreUpdate(arg_41_0, arg_41_1)
		return
	end

	function arg_1_0.OnceDailyAwardNotify(arg_42_0, arg_42_1)
		return
	end

	function arg_1_0:SecretaryShipAdjustUpdate(arg_43_1)
		if arg_43_1 and next(arg_43_1) then
			for iter_43_0, iter_43_1 in pairs(arg_43_1.updates) do
				self:__main_ship__action(iter_43_1.action, iter_43_1.info)
			end
		end
	end

	function arg_1_0:EmergencyInfoUpdate(arg_44_1)
		if arg_44_1 and next(arg_44_1) then
			self:set_emergency_info(arg_44_1.updates)
		end
	end

	function arg_1_0:__main_ship__action(arg_45_1, arg_45_2)
		if arg_45_1 == var_0_6.update_modify then
			self:__main__update_ship_info(arg_45_2)
		elseif arg_45_1 == var_0_6.update_add then
			self:__main__add_ship_info(arg_45_2)
		elseif arg_45_1 == var_0_6.update_remove then
			self:__main__remove_ship_info(arg_45_2)
		end
	end

	function arg_1_0:StarSetUpdate(arg_46_1)
		if arg_46_1 and next(arg_46_1) then
			if arg_46_1.ids[1] == 0 then
				self:set_custom_ship_list({})
			else
				self:set_custom_ship_list(arg_46_1.ids)
			end
		end
	end

	function arg_1_0:SecretaryInfoUpdate(arg_47_1)
		if arg_47_1 then
			self:set_secretary_info(arg_47_1)
		end
	end

	function arg_1_0.TokenRefreshUpdate(arg_48_0, arg_48_1)
		if arg_48_1 then
			local var_48_0 = var_0_1.json_decode(arg_48_1.token)

			if var_48_0 then
				print("刷新成功")
				gamecore.AccountPlatform:setToken(var_0_3(var_48_0.access_token))
			end
		end
	end
end

function var_0_0.extend_obj(arg_49_0)
	return
end

return var_0_0
