local var_0_0 = {}
local var_0_1 = lx
local var_0_3 = tostring
local var_0_4 = string.format
local var_0_5 = gamecore.NetworkManager
local var_0_6 = gamecore.UILoader
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.prompt
local var_0_9 = gamecore.user
local var_0_10 = gameenum.error_type
local var_0_11 = table.insert
local var_0_12 = gamecore.Language
local var_0_13 = gamecore.SceneManager
local var_0_14 = gamecore.util_func
local var_0_15 = lx.ResourceLoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ErrorCodeNotify(arg_2_0, arg_2_1)
		if is_windows() then
			log.debuglog(var_0_4("[ErrorCode] code:[%s], msg:[%s]", var_0_3(arg_2_1.error_code), encode.utf8_to_ansi(arg_2_1.error_msg)))
		end
	end

	function arg_1_0.DebugLogNotify(arg_3_0, arg_3_1)
		if is_windows() then
			log.debuglog("[DEBUG LOG] " .. encode.utf8_to_ansi(arg_3_1.info))
		end
	end

	function arg_1_0.LastTimeInfoNotify(arg_4_0, arg_4_1)
		arg_4_0._last_offline_time = arg_4_1.offline_time
		arg_4_0._last_ip = arg_4_1.ip
	end

	function arg_1_0:LoadDataResp(arg_5_1)
		self._account_id = arg_5_1.account_id
		self._name = arg_5_1.name
		self._sex = arg_5_1.sex
		self._data = arg_5_1.data

		self:hmsdk_setExtData(var_0_7.UserExtDataKeys.ACTION_ENTER_SERVER, self._account_id, self._name, self._data.level, (self:get_zone_id()))
		pcall(function()
			if app:getSystem():getChannel() == "yyb" then
				if gamecore.AccountPlatform and gamecore.AccountPlatform.call_set_pay_info then
					gamecore.AccountPlatform:call_set_pay_info()
				end
			end
		end)
	end

	function arg_1_0.get_zone_id(arg_7_0)
		local var_7_0 = 0
		local var_7_1 = app:getSystem():getChannel()

		if var_7_1 == gameenum.common_type.channel.android_yyb then
			var_7_0 = 301
		elseif var_7_1 == gameenum.common_type.channel.android_xiaomi then
			var_7_0 = 302
		end

		return var_7_0
	end

	function arg_1_0.hmsdk_setExtData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		local var_8_0 = var_0_1.json_encode({
			ACTION = var_0_3(arg_8_1),
			ROLE_ID = var_0_3(arg_8_2),
			ROLE_NAME = var_0_3(arg_8_3),
			ROLE_LEVEL = var_0_3(arg_8_4),
			ZONE_ID = var_0_3(arg_8_5)
		})
		local var_8_1 = true
		local var_8_2 = false

		if app:getSystem():getChannel() == gameenum.common_type.channel.android_xiaomi then
			var_8_1 = false
			var_8_2 = true
		end

		if var_8_1 then
			local var_8_3, var_8_4 = pcall(function()
				HMSDKManager.Instance:SetExtData(var_8_0)
			end)

			if not var_8_3 then
				log.debuglog("hmsdk_setExtData: HMSDKManager.SetExtData failed, err=" .. var_0_3(var_8_4))
			end
		elseif var_8_2 then
			-- block empty
		end
	end

	function arg_1_0:TellWaitEnterNotify(arg_10_1)
		if self._is_waiting_for_enter_resp then
			var_0_8:show(var_0_12:getNowLang("operatingfastnotice"))

			return
		end

		self._is_waiting_for_enter_resp = true

		self:req_enter()

		self._enter_end_finish = true
		self._enter_end_func = nil

		if self._enter_end_func then
			self._enter_end_func()
		end
	end

	function arg_1_0:tryPushEnterEndDo(arg_11_1)
		if self._enter_end_finish then
			arg_11_1()

			return
		end

		self._enter_end_func = arg_11_1
	end

	function arg_1_0.change_enter_end_finish(arg_12_0, arg_12_1)
		arg_12_0._enter_end_finish = arg_12_1
	end

	function arg_1_0.DailyNoticeResp(arg_13_0)
		return
	end

	function arg_1_0:EnterResp(arg_14_1)
		self:onEnterGame()
		gamecore.PayManager:waitVerifyReceipt()

		if self:get_is_first_auth() then
			var_0_9:set_gotofight_memory_team_index(1)
		end

		self._is_waiting_for_enter_resp = false

		if not self._data.init_ship then
			local function var_14_0()
				if var_0_6:getInstance("home") then
					return
				end

				gamecore.PreloadManager:unload_battle_asset()
				var_0_6:destroyStateUISet("battle")
				var_0_6:destroyStateUISet("game")
				var_0_6:destroyStateUISet("guide")
				var_0_6:destroyInstance("login")
				self:event_on_enter_game()
				self:event_on_enter_home()

				local var_15_0 = var_0_9:get_character_num()
				local var_15_1 = 0

				local function var_15_2()
					var_15_1 = var_15_1 + 1

					if var_15_0 ~= var_15_1 then
						return
					end

					self:set_is_preload_completed(true)

					local var_16_0 = self:get_preload_xm_ship_callback_func()

					if next(var_16_0) then
						for iter_16_0, iter_16_1 in pairs(var_16_0) do
							iter_16_1()
						end
					end

					gamecore.AudioManager:destroyCV()
				end

				for iter_15_0, iter_15_1 in pairs((var_0_9:get_character_list())) do
					local var_15_3 = var_0_7:get_ship_icon(var_0_7.ship_icon.model_normal_xm, gameconfig.ship_config.find_object_by_cid(iter_15_1.cid).pic_id)

					if not gamecore.ResourceLoader:findPath(var_15_3) then
						var_15_2()
					else
						gamecore.PreloadManager:preload_ship_asset(var_15_3, var_15_2)
					end
				end
			end

			if var_0_6:getInstance(var_0_7:get_battle_name()) then
				-- block empty
			else
				(function()
					if var_0_13:getIsBattleScene() then
						var_0_13:loadScene("main", function()
							var_14_0()
						end)
					else
						var_14_0()
					end
				end)()
			end
		else
			var_0_6:createInstance("launch"):setVisible(false)
			var_0_6:createInstance("enter_game"):setVisible(false)
			var_0_6:createInstance("create_role"):show()
		end
	end

	function arg_1_0.DailyAwardNotify(arg_19_0, arg_19_1)
		var_0_9:set_close_sign(false)
		var_0_9:set_close_sp_sign(false)

		local var_19_0 = var_0_6:getInstance("home")

		if var_0_6:getInstance("announcement") and var_19_0 and not var_0_9:get_use_info_data().login_award.is_already_get then
			var_19_0:init_announcement()
		end
	end

	function arg_1_0.OnceDailyAwardNotify(arg_20_0, arg_20_1)
		local var_20_0 = var_0_6:getInstance("home")

		if not var_20_0 then
			return
		end

		if var_20_0._user_data.once_login_days == #var_20_0._user_data.once_login_award then
			var_20_0._control.bottom.main_float_content.main_float_5:SetActive(false)
		else
			var_20_0._control.bottom.main_float_content.main_float_5:SetActive(true)
		end

		var_20_0._control.bottom.main_float_content.main_float_5:SetActive(true)
	end

	function arg_1_0.PatchUpdateNotify(arg_21_0)
		local var_21_0 = var_0_6:getInstance("home")
		local var_21_1 = var_0_6:getInstance(var_0_7:get_battle_name())

		if var_21_0 and var_21_0._panel.activeSelf then
			if var_21_0._live2d then
				var_0_15:destroyGameObject(var_21_0._live2d)

				var_21_0._live2d = nil
			end

			var_0_6:createInstance("msgbox"):showOne(var_0_12:getNowLang("find_new_download"), function()
				var_21_0:setVisible(false)

				if app:getSystem():getOSType() == "android" then
					if AndroidJavaQuitManager then
						AndroidJavaQuitManager.MyJavaQuit()
					else
						os.exit()
					end
				else
					os.exit()
				end
			end, (var_0_12:getNowLang("signininvitecodebtn")))
		else
			var_0_9:set_update_hot(true)
		end
	end

	function arg_1_0.ProtocolUpdateNotify(arg_23_0)
		return
	end

	function arg_1_0.SystemDataNotify(arg_24_0, arg_24_1)
		return
	end

	function arg_1_0.DailyOnlineTimeLimitNotify(arg_25_0, arg_25_1)
		local var_25_0 = var_0_6:getInstance("home")

		if var_25_0 then
			if var_25_0._panel.activeSelf then
				var_0_6:createInstance("addiction_box"):show(arg_25_1)
			else
				var_0_9:set_addiction_flag(true, arg_25_1)
			end
		else
			var_0_9:set_addiction_flag(true, arg_25_1)
		end
	end

	function arg_1_0.GetDailyAwardResp(arg_26_0, arg_26_1)
		if arg_26_1.result == 0 then
			var_0_6:getInstance("home")._user_data = var_0_9:get_use_info_data()

			local var_26_2 = {}

			for iter_26_0, iter_26_1 in pairs(arg_26_1.reward) do
				if iter_26_1.type == 4 then
					var_0_11(var_26_2, iter_26_1)
				end
			end

			local var_26_3 = var_0_6:getInstance("signin")
			local var_26_4 = var_0_6:createInstance("sp_sign")
			local var_26_6 = var_0_9:get_use_info_data().once_login_award.cumulative_days

			if #var_26_2 ~= 0 then
				var_0_6:createInstance("new_ship_or_equip"):show(true, var_26_2[1], var_0_7.enter_get_ship_type.sign_and_task)

				if var_26_3 then
					var_26_3:play_in_out_animation(false, function()
						var_26_3:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
						var_26_3:setVisible(false)
					end)
				end
			else
				local var_26_8 = var_0_6:getInstance("msgbox")

				var_26_8 = var_26_8 or var_0_6:createInstance("msgbox")

				var_26_8:showOnes(arg_26_1.reward, function()
					if var_26_3 then
						var_26_3:play_in_out_animation(false, function()
							var_26_3:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
							var_26_3:setVisible(false)

							if var_26_6 > 10 then
								-- block empty
							elseif not var_0_9:get_close_sp_sign() then
								var_0_6:createInstance("sp_sign"):show()
							end
						end)
					end
				end, nil, var_0_12:getNowLang("logget"), var_0_7.msg_type.rewards)
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_26_1.result))
		end
	end

	function arg_1_0.GetOnceDailyAwardResp(arg_30_0, arg_30_1)
		if arg_30_1.result == 0 then
			local var_30_0 = var_0_6:getInstance("sp_sign")

			var_30_0:updata_info()
			var_30_0:__init_sign_list()
			var_30_0:__update_cell()

			local var_30_1 = {}

			for iter_30_0, iter_30_1 in pairs(arg_30_1.reward) do
				if iter_30_1.type == 4 then
					var_0_11(var_30_1, iter_30_1)
				end
			end

			local var_30_2 = var_0_6:getInstance("msgbox") or var_0_6:createInstance("msgbox")

			var_30_2:showOnes(arg_30_1.reward, function()
				var_30_2:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))

				if #var_30_1 ~= 0 then
					var_0_6:createInstance("new_ship_or_equip"):show(true, var_30_1[1], var_0_7.enter_get_ship_type.sign_and_task)
				end
			end, nil, var_0_12:getNowLang("logget"), var_0_7.msg_type.rewards, true)

			local var_30_3 = var_0_6:getInstance("home")

			var_30_3._user_data = var_0_9:get_use_info_data()

			var_30_3:update_sign_float()
		else
			var_0_8:show(var_0_10:get_err_msg(arg_30_1.result))
		end
	end

	function arg_1_0.GetLevelUpAwardResp(arg_32_0, arg_32_1)
		if arg_32_1.result == 0 then
			local var_32_0 = var_0_6:getInstance("home")

			for iter_32_0, iter_32_1 in pairs(arg_32_1.reward) do
				if iter_32_1.type == 4 then
					var_0_6:createInstance("new_ship_or_equip"):show(true, iter_32_1, var_0_7.enter_get_ship_type.up_award)
				end
			end

			var_32_0:update_sign_float()

			var_32_0._user_data = var_0_9:get_use_info_data()
			var_32_0._control.top.user_res_bar.right_upon.oil_bg.oil_txt.text.text = var_0_14.get_simplify_num(var_32_0._user_data.oil)
			var_32_0._control.top.user_res_bar.right_upon.steel_bg.steel_txt.text.text = var_0_14.get_simplify_num(var_32_0._user_data.fe)
			var_32_0._control.top.user_res_bar.right_upon.aluminum_bg.aluminum_txt.text.text = var_0_14.get_simplify_num(var_32_0._user_data.al)
			var_32_0._control.top.user_res_bar.right_upon.bullet_bg.bullet_txt.text.text = var_0_14.get_simplify_num(var_32_0._user_data.bullet)

			var_32_0:update_level_award_float()
		else
			var_0_8:show(var_0_10:get_err_msg(arg_32_1.result))
		end
	end

	function arg_1_0.GetFirstRewardResp(arg_33_0, arg_33_1)
		if arg_33_1.result == 0 then
			local var_33_0 = {}

			for iter_33_0, iter_33_1 in pairs(arg_33_1.reward) do
				if iter_33_1.type == 4 then
					var_0_11(var_33_0, iter_33_1)
				end
			end

			if #var_33_0 ~= 0 then
				var_0_6:createInstance("new_ship_or_equip"):show(true, var_33_0[1], var_0_7.enter_get_ship_type.sign_and_task)
			end

			local var_33_1 = var_0_6:getInstance("firsttopup")

			var_33_1._control.main.gain.text.text.text = var_0_12:getNowLang("marketinghaveget")
			var_33_1._control.main.gain.scaleButton.interactable = false

			local var_33_2 = var_0_6:getInstance("home")

			var_33_2._user_data = var_0_9:get_use_info_data()
			var_33_2._control.top.user_res_bar.right_upon.oil_bg.oil_txt.text.text = var_33_2._user_data.oil
			var_33_2._control.top.user_res_bar.right_upon.steel_bg.steel_txt.text.text = var_33_2._user_data.fe
			var_33_2._control.top.user_res_bar.right_upon.aluminum_bg.aluminum_txt.text.text = var_33_2._user_data.al
			var_33_2._control.top.user_res_bar.right_upon.bullet_bg.bullet_txt.text.text = var_33_2._user_data.bullet

			var_33_2:update_first_top_up_float()
		end
	end

	function arg_1_0.ChangeNameResp(arg_34_0, arg_34_1)
		local var_34_0 = var_0_6:getInstance("create_role")

		if arg_34_1.result then
			arg_34_0._name = arg_34_1.name

			if var_34_0 then
				var_34_0:select_init_ship()
			end
		else
			var_0_8:show(var_0_12:getNowLang("errorcode-119"))

			if var_34_0 then
				var_34_0._control.input_name.InputField.inputField.text = var_34_0:__get_name()
			end
		end
	end

	function arg_1_0:GetNewPlayerShipResp(arg_35_1)
		if arg_35_1.result then
			var_0_6:destroyInstance("create_role")
			gamecore.main:onEnterGame()
			gamecore.main:onEnterHome()
			self:hmsdk_setExtData(var_0_7.UserExtDataKeys.ACTION_CREATE_ROLE, self._account_id, self._name, self._data.level, (self:get_zone_id()))
		end
	end

	function arg_1_0.MSG_CHANGE_SEX_RESULT(arg_36_0, arg_36_1)
		return
	end

	function arg_1_0.ActiveAutoSupplyResp(arg_37_0, arg_37_1)
		if arg_37_1.result ~= 0 then
			return
		end

		local var_37_0 = var_0_6:getActiveInstance("fight_prepare")

		if var_37_0 then
			var_37_0:update_auto_supply_toggle()
		end
	end

	function arg_1_0.ShipSupplyResp(arg_38_0, arg_38_1)
		local var_38_0 = var_0_6:getInstance("fight_prepare")

		if arg_38_1.result == 0 or arg_38_1.result == var_0_10.NOT_NEED_SUPPLY then
			local var_38_1 = var_0_6:getInstance("dock_team")

			if var_38_1 then
				var_38_1:ship_supply_refresh(arg_38_1)
			end

			if var_38_0 then
				var_38_0:ship_supply_refresh(arg_38_1)
			end
		end

		if var_38_0 then
			var_38_0:set_supply_btn_state(true)
		end

		if arg_38_1.result ~= 0 and arg_38_1.result ~= var_0_10.NOT_NEED_SUPPLY then
			var_0_8:show(var_0_10:get_err_msg(arg_38_1.result))
		end
	end

	function arg_1_0.TeamSupplyResp(arg_39_0, arg_39_1)
		if arg_39_1.result == 0 or arg_39_1.result == var_0_10.NOT_NEED_SUPPLY then
			local var_39_0 = var_0_6:getInstance("dock_team")

			if var_39_0 then
				var_39_0:team_supply_refresh(arg_39_1)
			end

			local var_39_1 = var_0_6:getInstance("fight_prepare")

			if var_39_1 then
				var_39_1._support_supply_full = true

				var_39_1:team_supply_refresh(arg_39_1)
			end
		elseif arg_39_1.result ~= var_0_10.NOT_NEED_SUPPLY then
			var_0_8:show(var_0_10:get_err_msg(arg_39_1.result))
		end
	end

	function arg_1_0.AllShipSupplyResp(arg_40_0, arg_40_1)
		if arg_40_1.result == 0 or arg_40_1.result == var_0_10.NOT_RESOURCE then
			local var_40_0 = var_0_6:getInstance("dock_team")

			if var_40_0 then
				var_40_0:team_supply_refresh(arg_40_1)
				var_40_0:shut_down_sp_ani()
			end
		end
	end

	function arg_1_0.TeamRepairResp(arg_41_0, arg_41_1)
		if arg_41_1.result == 0 then
			local var_41_0 = var_0_6:getInstance("fight_prepare")

			if var_41_0 then
				var_41_0:team_repair_refresh()
			end
		end
	end

	function arg_1_0.RealNameAuthResp(arg_42_0, arg_42_1)
		if arg_42_1.error_code ~= 0 then
			var_0_8:show(var_0_12:getNowLang("verify_error"))
		else
			var_0_8:show(var_0_12:getNowLang("verify_success"))

			local var_42_0 = var_0_6:getInstance("enter_game")
			local var_42_1 = var_0_6:getInstance("loading")

			if var_0_6:getInstance("real_name_box") then
				var_0_6:destroyInstance("real_name_box")
			end

			if var_42_1 then
				var_42_1:show(false)
			end

			if var_42_0 then
				var_42_0._control.wait:SetActive(false)
			end
		end
	end

	function arg_1_0.SecretaryShipAdjustResp(arg_43_0, arg_43_1)
		if arg_43_1.result == 0 then
			var_0_8:show(var_0_12:getNowLang("adjustment_set"))
		else
			var_0_8:show(var_0_10:get_err_msg(arg_43_1.result))
		end
	end

	function arg_1_0.TellDeviceResp(arg_44_0, arg_44_1)
		return
	end

	function arg_1_0:ChangeStarSetResp(arg_45_1)
		if arg_45_1.result == 0 then
			local var_45_0 = var_0_6:getInstance("ship_detail")
			local var_45_1 = var_0_6:getInstance("select_member")

			if var_45_0 then
				var_45_0:set_custom_info()

				if self._set_custom_ship then
					var_0_8:show(var_0_12:getNowLang("custom_success"))
				else
					var_0_8:show(var_0_12:getNowLang("custom_cancel"))
				end
			elseif var_45_1 then
				var_45_1:__onClick_all_ship_info_custom_ship_2()
			end

			if var_45_1 then
				-- block empty
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_45_1.result))
		end
	end

	function arg_1_0.ActivityDurationResp(arg_46_0, arg_46_1)
		local var_46_0 = var_0_6:getInstance("ninth_main_map")

		if var_46_0 then
			var_46_0:init_show_guide_panel()
		end
	end

	function arg_1_0.ChangeSecretaryDataResp(arg_47_0, arg_47_1)
		if arg_47_1.result == 0 then
			local var_47_0 = var_0_6:getInstance("ship_clerk_prepare")

			if var_47_0 then
				var_47_0:__init_data()
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_47_1.result))
		end
	end

	function arg_1_0.ChangeMiddleBrokenResp(arg_48_0, arg_48_1)
		if arg_48_1.result == 0 then
			local var_48_0 = var_0_6:getInstance("ship_clerk_prepare")

			if var_48_0 then
				var_48_0:_set_right_button_show()
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_48_1.result))
		end
	end

	function arg_1_0.ChangeRandSecretaryResp(arg_49_0, arg_49_1)
		if arg_49_1.result == 0 then
			local var_49_0 = var_0_6:getInstance("ship_clerk_prepare")

			if var_49_0 then
				var_49_0:_set_right_button_show()
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_49_1.result))
		end
	end

	function arg_1_0.BindingPhoneResp(arg_50_0, arg_50_1)
		if arg_50_1.result == 0 then
			local var_50_0 = var_0_6:getInstance("home")

			if var_50_0 then
				var_50_0:update_phone_bind_float()
			end
		else
			var_0_8:show(var_0_10:get_err_msg(arg_50_1.result))
		end
	end

	function arg_1_0.SensitiveWordsResp(arg_51_0, arg_51_1)
		return
	end

	function arg_1_0.__reinit_response(arg_52_0)
		var_0_5:bindProtocolProcessor(arg_52_0)
	end

	function arg_1_0.TokenRefreshResp(arg_53_0, arg_53_1)
		log.print_r(arg_53_1, "data刷新结束返回值")
	end

	function arg_1_0.__reset_account_data(arg_54_0)
		var_0_9:reset_mail_data()
		var_0_9:reset_school_data()
		var_0_9:reset_friend_data()
		var_0_9:reset_equipment_data()
		var_0_9:reset_shop_data()
		var_0_9:reset_skin_data()
		var_0_9:reset_team_data()
		var_0_9:reset_character_list()
		var_0_9:reset_cardbook_data()
		var_0_9:reset_restaurant_data()
		var_0_9:reset_captainroom_data()
		var_0_9:reset_bathroom_data()
		var_0_9:reset_dormiyory_data()
		var_0_9:reset_bootyshop_data()
		var_0_9:reset_sign_data()
		var_0_9:reset_map_data()
		var_0_9:reset_collection_data()
		var_0_9:reset_story_data()
		var_0_9:reset_item_data()
		var_0_9:reset_task_data()
		var_0_9:reset_guide_state()
		var_0_9:reset_map_expedition()
		var_0_9:reset_workshop_data()
		var_0_9:reset_announcement_data()
		var_0_9:reset_sp_sign_data()
		var_0_9:reset_supportlist_data()
		var_0_9:reset_combatshop_data()
		var_0_9:reset_tower_data()
		var_0_9:reset_strike_award_data()
		var_0_9:reset_six_year_data()
		var_0_9:reset_fifth_event_data()
		var_0_9:reset_ocean_data()
		var_0_9:reset_battle_data()
		var_0_9:reset_abyss_data()
		var_0_9:reset_push_random_buff_data()
		var_0_9:reset_seventh_data()
		var_0_9:reset_answer_data()

		arg_54_0._is_waiting_for_enter_resp = false
	end
end

function var_0_0.extend_obj(arg_55_0)
	return
end

return var_0_0
