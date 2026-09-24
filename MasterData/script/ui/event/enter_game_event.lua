local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = lx.UserData
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_8 = gameenum.common_type
local var_0_9 = gamecore.AudioManager
local var_0_10 = gamecore.SceneManager
local var_0_12 = gamecore.NetworkManager
local var_0_13 = gamecore.PayManager
local var_0_15 = gamecore.AccountPlatform

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_single_server_bar_bar_bg(arg_2_0)
		return
	end

	function arg_1_0.__onClick_all_object_account_btn(arg_3_0)
		var_0_9:destroyCV()
		var_0_15:open_personal()
	end

	function arg_1_0:__onClick_all_object_enter_btn()
		local var_4_0 = app:getSystem():getChannel()

		self:__enabled_control(false)
		self._control.wait:SetActive(true)
		var_0_12:init({
			on_check_network_try_again = function(arg_5_0)
				local var_5_0 = var_0_5:getInstance("loading")

				if var_5_0 then
					var_5_0:show(false)
				end

				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("errorofnetwork"), arg_5_0, var_0_4:get((var_0_4:getNowLang("pveservererrortitle"))))
			end,
			on_system_busy_try_again = function(arg_6_0)
				local var_6_0 = var_0_5:getInstance("loading")

				if var_6_0 then
					var_6_0:show(false)
				end

				var_0_5:createInstance("msgbox"):showOne(var_0_4:get("系统繁忙，请重试"), arg_6_0, var_0_4:getNowLang("pveservererrortitle"))
			end,
			on_need_oauth_again = function()
				local var_7_0 = var_0_5:getInstance("loading")

				if var_7_0 then
					var_7_0:setVisible(false)
				end

				local var_7_1 = var_0_5:getInstance("reconnect")

				if var_7_1 then
					var_7_1:setVisible(false)
				end

				local var_7_2 = var_0_5:getInstance("enter_game")

				if var_7_2 then
					var_7_2:show_wait(false)
					var_0_15:login()
					var_0_3:show((var_0_4:getNowLang("neerloginagaintitle")))
				elseif var_0_10:getIsBattleScene() then
					var_0_10:loadScene("main", function()
						var_0_10:restart()
					end)
				else
					var_0_10:restart()
				end
			end,
			on_protocol_version_no_match = function()
				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("agreement_update"), function()
					if app:getSystem():getOSType() == "android" then
						if AndroidJavaQuitManager then
							AndroidJavaQuitManager.MyJavaQuit()
						else
							os.exit()
						end
					else
						os.exit()
					end
				end, var_0_4:getNowLang("ensure"))
			end,
			on_json_version_no_match = function()
				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("find_new_download"), function()
					if app:getSystem():getOSType() == "android" then
						if AndroidJavaQuitManager then
							AndroidJavaQuitManager.MyJavaQuit()
						else
							os.exit()
						end
					else
						os.exit()
					end
				end, var_0_4:getNowLang("ensure"))
			end,
			on_battle_version_no_match = function()
				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("find_new_download"), function()
					if app:getSystem():getOSType() == "android" then
						if AndroidJavaQuitManager then
							AndroidJavaQuitManager.MyJavaQuit()
						else
							os.exit()
						end
					else
						os.exit()
					end
				end, var_0_4:getNowLang("ensure"))
			end,
			on_need_real_name = function()
				self:show_wait(false)
				var_0_5:destroyInstance("loading")

				if not var_0_5:getInstance("real_name_box") then
					var_0_5:createInstance("real_name_box"):show(false)
				end
			end,
			need_real_name_again = function()
				self:show_wait(false)
				var_0_5:destroyInstance("loading")

				if not var_0_5:getInstance("real_name_box") then
					var_0_5:createInstance("real_name_box"):show(true)
				end
			end,
			on_prevent_addicted_limit = function()
				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("nonage_tip"), function()
					var_0_10:restart()
				end, var_0_4:getNowLang("ensure"))
			end,
			on_connect_succeed = function()
				return
			end,
			on_reconnect = function()
				var_0_5:createInstance("reconnect"):setVisible(true)
			end,
			on_disconnect = function()
				if gamecore.user and gamecore.user.change_enter_end_finish then
					gamecore.user:change_enter_end_finish(false)
				end
			end,
			on_close = function()
				local var_22_0 = var_0_5:getInstance("reconnect")

				if var_22_0 then
					var_22_0:setVisible(false)
				end
			end,
			on_send_request = function(arg_23_0, arg_23_1)
				var_0_5:createInstance("loading"):show(true, nil, true)
			end,
			on_recv_response = function(arg_24_0, arg_24_1)
				local var_24_0 = var_0_5:getInstance("loading")

				if var_24_0 then
					var_24_0:show(false, nil, true)
				end
			end,
			on_request_timeout = function(self)
				if self["user.EnterReq"] then
					return
				end

				var_0_5:createInstance("loading"):show(true, nil, false)
			end,
			on_server_close = function()
				local var_26_0 = var_0_5:getInstance("loading")

				if var_26_0 then
					var_26_0:show(false)
				end
			end,
			on_blacklist_limit = function()
				local var_27_0 = var_0_5:getInstance("loading")

				if var_27_0 then
					var_27_0:show(false)
				end

				local var_27_1 = var_0_5:getInstance("enter_game")

				if var_27_1 then
					var_27_1:show_wait(false)
				end

				local var_27_2

				if var_0_1:get_ban_time() then
					local var_27_3 = var_0_1:get_ban_time()
					local var_27_4 = tonumber(os.date("%H", var_27_3))
					local var_27_5 = tonumber(os.date("%M", var_27_3))
					local var_27_6 = tonumber(os.date("%S", var_27_3))

					if var_27_4 < 10 then
						var_27_4 = "0" .. var_0_6(var_27_4)
					end

					if var_27_5 < 10 then
						var_27_5 = "0" .. var_0_6(var_27_5)
					end

					if var_27_6 < 10 then
						var_27_6 = "0" .. var_0_6(var_27_6)
					end

					var_27_2 = var_0_6(var_0_4:getNowLang("account_ban"), (tostring(tonumber(os.date("%Y", var_27_3)) .. "-" .. tonumber(os.date("%m", var_27_3)) .. "-" .. tonumber(os.date("%d", var_27_3)) .. " " .. var_27_4 .. ":" .. var_27_5 .. ":" .. var_27_6)))
				else
					var_27_2 = var_0_4:getNowLang("errorcode-9998")
				end

				var_0_5:createInstance("msgbox"):showOne(var_27_2, nil, (var_0_4:getNowLang("signininvitecodebtn")))
			end,
			on_request_timeout_reconnect = function(self, arg_28_1)
				if self["user.EnterReq"] then
					return
				end

				if self["user.OrderPayDoneReq"] then
					local var_28_0 = app:getSystem():getChannel()

					if var_28_0 == "xiaomi" or var_28_0 == var_0_8.channel.android_xiaomi then
						local var_28_1 = lx.Time:getTime()
						local var_28_2 = var_0_13._xiaomi_order_pay_done_sent_ms
						local var_28_3 = var_0_13._xiaomi_quiet_network_reconnect_until_ms

						if var_0_13._xiaomi_internal_waiting_order_pay_done_resp == true or var_28_3 and var_28_1 < var_28_3 or var_28_2 and var_28_1 - var_28_2 < 15000 then
							return
						end
					end
				end

				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("errorofnetworknoconfirm"), arg_28_1, var_0_4:get((var_0_4:getNowLang("pveservererrortitle"))))
			end,
			on_all_request_finish = function()
				local var_29_0 = var_0_5:getInstance("loading")

				if var_29_0 then
					var_29_0:setVisible(false)
				end
			end,
			on_server_is_full_please_try_again_later = function(arg_30_0)
				local var_30_0 = var_0_5:getInstance("loading")

				if var_30_0 then
					var_30_0:show(false)
				end

				var_0_5:createInstance("msgbox"):showOne(var_0_4:get("服务器爆满，请稍后再试"), arg_30_0, var_0_4:getNowLang("pveservererrortitle"))
			end,
			on_in_other_local_login = function()
				var_0_5:createInstance("msgbox"):showOne(var_0_4:getNowLang("errorcode-9997"), function()
					if var_0_10:getIsBattleScene() then
						gamecore.BattleManager:exit(function()
							gamecore.SceneManager:loadScene("main", function()
								gamecore.SceneManager:restart()
							end)
						end)
					else
						var_0_10:restart()
					end
				end, (var_0_4:getNowLang("signininvitecodebtn")))
			end
		})
		var_0_12:setRequestTimeout(300)
		var_0_12:setRequestTimeoutReconnect(8000)

		local var_4_1 = var_0_5:getInstance("select_server")
		local var_4_2
		local var_4_3
		local var_4_4
		local var_4_5

		if not var_4_1 or var_4_1:getIP() == "" then
			var_4_2 = self:get_default_server_ip()
			var_4_3 = self:get_default_server_port()
			var_4_4 = self:get_default_server_other()
			var_4_5 = self:get_default_server_name()
		else
			var_4_2 = var_4_1:getIP()
			var_4_3 = var_4_1:getPort()
			var_4_4 = var_4_1:getOther()
			var_4_5 = var_4_1:getName()
		end

		local var_4_6 = var_0_15:getToken()
		local var_4_7 = var_0_15:getChannel()
		local var_4_8 = var_0_15:getUid()
		local var_4_9 = var_0_15:getChannelUid()
		local var_4_10 = var_0_15:getProductId()

		BuglyManager.SetUserId(tostring((self._account_data or nil) and (self._account_data.account_id or 0)) .. "|" .. app:getSystem():getDataVersion() .. "|" .. var_4_5)
		var_0_1:set_server_name(var_4_5)
		var_0_5:createInstance("loading"):show(true, nil, true)

		local var_4_11 = lx.connect_selector:create()

		var_4_11:set_default_ip_port(var_4_2, var_4_3)

		if var_4_4 then
			for iter_4_0, iter_4_1 in pairs(var_4_4) do
				var_4_11:add_ip_port(iter_4_1.ip, iter_4_1.port)
			end
		end

		var_4_11:set_func(function(arg_35_0, arg_35_1, arg_35_2)
			var_0_12:start(var_4_6, var_4_7, arg_35_0, arg_35_1, var_4_8, var_4_9, var_4_10)
		end)
		var_4_11:execute()
		var_0_2:setKeyData("custom_panel", 1)
	end

	function arg_1_0:__onClick_all_object_single_server_bar_bar_bg()
		var_0_5:createInstance("select_server"):show(true, self._server_list)
		self:select_server_control(false)
	end

	function arg_1_0:__onClick_all_object_common_mark_btn()
		self._control.all_object.common_mark_txt:SetActive(true)

		if self._channel == var_0_8.channel.android_yyb or self._channel == var_0_8.channel.android_xiaomi then
			self._control.hoolai_need:SetActive(false)
		end
	end

	function arg_1_0:__onClick_all_object_common_mark_txt_confim_btn()
		self._control.all_object.common_mark_txt:SetActive(false)

		if self._channel == var_0_8.channel.android_yyb or self._channel == var_0_8.channel.android_xiaomi then
			self._control.hoolai_need:SetActive(true)
		end
	end

	function arg_1_0.__onClick_yyb_agreement_button(arg_39_0)
		var_0_5:createInstance("msgbox_agreement_cn"):show(1)
	end

	function arg_1_0.__onClick_yyb_agreement_button1(arg_40_0)
		var_0_5:createInstance("msgbox_agreement_cn"):show(2)
	end

	function arg_1_0.__onToggle_yyb_agreement_toggle(arg_41_0)
		return
	end

	function arg_1_0.__onClick_test_btn(arg_42_0)
		var_0_5:createInstance("login_lua_new"):show()
	end

	function arg_1_0.__onClick_test_btn_two(arg_43_0)
		var_0_5:createInstance("user_info_wnd_lua"):show()
	end

	function arg_1_0.__onClick_yyb_agreement_button2(arg_44_0)
		var_0_5:createInstance("msgbox_agreement_cn_url"):show()
	end

	function arg_1_0.__onClick_yyb_agreement_button3(arg_45_0)
		var_0_5:createInstance("msgbox_agreement_cn"):show(4)
	end

	function arg_1_0.__onClick_yyb_agreement_button4(arg_46_0)
		var_0_5:createInstance("msgbox_agreement_cn"):show()
	end
end

function var_0_0.extend_obj(arg_47_0)
	return
end

return var_0_0
