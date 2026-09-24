local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = gamecore.AccountServiceManager
local var_0_5 = gamecore.AccountPlatform
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.AuditServerManager
local var_0_9 = gamecore.AudioManager
local var_0_10 = lan_rand
local var_0_11 = string.format
local var_0_13 = typeof
local var_0_14 = table.insert
local var_0_15 = next
local var_0_16 = lx.UserData
local var_0_19 = {
	"\t1）本游戏是一款玩法简单、轻松休闲的放置类卡牌收集游戏，适用于年满 16 周岁及以上的用户，建议未成年人在家长的监护下使用本游戏产品。\n\t2）本游戏基于架空历史背景，用轻松诙谐的手法讲述另一个世界里发生的一件件小故事。游戏画面为近卡通风格。游戏玩法基于养成收集、副本探索展开，不需要投入太多的时间、金钱和精力，有丰富的音效来烘托游戏氛围。\n\t3）本游戏中有用户实名认证系统，认证为未成年人的用户将接受以下管理： 游戏中部分玩法和道具需要付费。未满 8 周岁的用户不能付费；8 周岁以上未满 16 周 岁的未成年人用户，单次充值金额不得超过 50 元人民币，每月充值金额累计不得超过 200 元人民币；16 周岁以上的未成年人用户，单次充值金额不得超过 100 元人民币，每月充值 金额累计不得超过 400 元人民币。 未成年人用户每日 22 点到次日 8 点不得使用，法定节假日每天不得使用超过 3 小时， 其他时间每天不得使用超过 1.5 小时。\n\t4）本游戏以角色养成为主题，氛围轻松，可以寓教于乐中帮助玩家了解一些平时不关注的小知识。游戏玩法简单，画面精美，能够带给玩家积极愉悦的情绪体验，放松心情，从而提高自信心与创造力。\n\t"
}

gamecore.UILoader:define("enter_game", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:__init_language()

		local var_2_0 = var_0_9:get_AudioManager_obj()

		self._channel = app:getSystem():getChannel()

		self._control.yyb_agreement:SetActive(false)

		if not self._audio_init_already then
			var_0_9:init()

			self._audio_init_already = true
		end

		if not var_2_0.Find("cv") then
			if not arg_2_1 then
				self:__show_title_cv()
			end
		elseif not var_2_0.Find("cv"):GetComponent(var_0_13(UnityEngine.AudioSource)).clip then
			if not arg_2_1 then
				self:__show_title_cv()
			end
		elseif var_2_0.Find("cv"):GetComponent(var_0_13(UnityEngine.AudioSource)).clip then
			-- block empty
		end

		local var_2_1 = app:getNotice()
		local var_2_2 = app:getSystem():getChannel()
		local var_2_3 = {}
		local var_2_4 = {}
		local var_2_5 = {}
		local var_2_6 = {}

		if var_2_2 == var_0_6.channel.android_xiaomi then
			for iter_2_0, iter_2_1 in pairs(self._server_list) do
				if iter_2_1.id == 302 then
					var_0_14(var_2_4, iter_2_1)
				end
			end

			self._server_list = var_0_15(var_2_4) and var_2_4 or var_0_7:getServer(var_2_2)
		elseif var_2_2 == var_0_6.channel.android_yyb then
			for iter_2_2, iter_2_3 in pairs(self._server_list) do
				if iter_2_3.id == 301 then
					var_0_14(var_2_3, iter_2_3)
				end
			end

			self._server_list = var_0_15(var_2_3) and var_2_3 or var_0_7:getServer(var_2_2)
		elseif var_2_2 == var_0_6.channel.hm_android_go_ios_small or var_2_2 == var_0_6.channel.hm_android_go_ios then
			for iter_2_4, iter_2_5 in pairs(self._server_list) do
				if iter_2_5.id > 100 and iter_2_5.id < 1000 then
					var_0_14(var_2_5, iter_2_5)
				end
			end

			self._server_list = var_0_15(var_2_5) and var_2_5 or var_0_7:getServer()
		elseif var_2_2 == var_0_6.channel.android_cn or var_2_2 == var_0_6.channel.taptap or var_2_2 == var_0_6.channel.android_cn_small then
			for iter_2_6, iter_2_7 in pairs(self._server_list) do
				if iter_2_7.id >= 1 and iter_2_7.id < 100 then
					var_0_14(var_2_6, iter_2_7)
				end
			end

			self._server_list = var_0_15(var_2_6) and var_2_6 or var_0_7:getServer()
		else
			self._server_list = var_0_7:getServer()
		end

		local var_2_7 = gamecore.AccountPlatform:getChannel()
		local var_2_8 = app:getSystem():getChannel()

		if var_2_8 ~= var_0_6.channel.android_xiaomi and var_2_8 ~= var_0_6.channel.android_yyb then
			self._server_list = var_0_7:getServer(var_2_7)
		end

		if not self._server_list then
			log.errorlog("no server")

			return
		end

		self._use_default = false

		var_0_16:setKeyData("Expires_in_game_time", (lx.ServerTime:getUtcTime()))

		local function var_2_9()
			var_0_4:req_account_server(var_0_5:getToken(), var_0_5:getChannel(), var_0_5:getChannelUid(), var_0_5:getProductId(), var_0_5:getUid())
		end

		local var_2_10

		var_0_4:init(function(arg_4_0)
			if not self._use_default then
				self._account_data = arg_4_0

				self:__load_server_cfg()
				self:setVisible(true)
				self:__enabled_control(true)
				self:__save_big_server_account_time()

				var_2_10 = self:show_server_repair()

				if self._seq then
					self._seq:Kill()

					self._seq = nil
				end
			else
				self._account_data = arg_4_0

				self:__enabled_control(true)
			end
		end, function(arg_5_0)
			self._use_default = true

			self:__enabled_control(true)
			self:__load_server_cfg()
			self:setVisible(true)
			self:show_server_repair()
		end, var_2_9)

		if nil then
			return
		end

		var_2_9()
		self:set_account_management(true)
		self:set_server_btn(true)
		self:__save_getRefreshRate()
		var_0_16:setKeyData("is_click_buy_ten", nil)
		var_0_16:setKeyData("is_click_buy_figurines", nil)
	end

	function arg_1_0:__save_getRefreshRate()
		self:__set_now_appversion_num()
		self:__set_now_refreshRate()
		self:__set_ref_high()
	end

	function arg_1_0:__set_now_appversion_num()
		self._version = 0

		local var_7_0 = app:getSystem():getAppVersion()

		for iter_7_0 = 1, #var_7_0 do
			local var_7_1 = tonumber((var_7_0:sub(iter_7_0, iter_7_0)))

			if var_7_1 then
				self._version = self._version + var_7_1
			end
		end
	end

	function arg_1_0:__set_now_refreshRate()
		self._have_refreshRate = false

		if not self._version or self._version == 0 then
			self:__set_now_appversion_num()
		end

		local var_8_0 = app:getSystem():getChannel()

		if var_8_0 and var_8_0 ~= "hm_ios_jp" and var_8_0 ~= "hm_ios" then
			if var_8_0 == "xiaomi" or var_8_0 == "yyb" then
				if self._version >= 14 then
					self._have_refreshRate = true
				end
			else
				self._have_refreshRate = true
			end
		end
	end

	function arg_1_0:__set_ref_high()
		if var_0_16:getKeyData("save_high_ref") ~= "" and self._have_refreshRate then
			UnityEngine.Application.targetFrameRate = var_0_16:getKeyData("save_high_ref")
		end
	end

	function arg_1_0:show_server_repair()
		if var_0_7:isOnMaintenance() then
			return
		end

		if self._now_repair == 1 then
			return
		end

		if self._default_server_state ~= var_0_6.server_state[4].state then
			return
		end

		self._now_repair = 1

		local var_10_0 = var_0_7:getMaintenanceTime()

		if var_10_0 ~= "" then
			var_10_0 = "\n" .. var_10_0
		end

		var_0_2:createInstance("msgbox"):showOne(var_0_1:getNowLang("serverinmaintainnotice") .. var_10_0, function()
			if gamecore.SceneManager:getIsBattleScene() then
				gamecore.SceneManager:loadScene("main", function()
					gamecore.SceneManager:restart()
				end)
			else
				gamecore.SceneManager:restart()
			end
		end, (var_0_1:getNowLang("signininvitecodebtn")))

		return true
	end

	function arg_1_0:__show_title_cv()
		self:playCV(var_0_11("title/title_%d.mp3", var_0_10(1, gamecore.SubPatchManager:getSelectCV() == "chinesecv" and gameenum.config_data.cv_num or 40)), false, "title")
	end

	function arg_1_0:hide()
		if self._seq then
			self._seq:Kill()

			self._seq = nil
		end

		self._control.wait:SetActive(false)
		self:setVisible(false)
	end

	function arg_1_0:show_wait(arg_15_1)
		self._control.wait:SetActive(arg_15_1)
	end

	function arg_1_0:show_account_management()
		self:setVisible(true)
		self:set_account_management(true)
		self:__enabled_control(true)
		self:set_server_btn(false)
	end

	function arg_1_0:set_account_management(arg_17_1)
		self._control.all_object.account_btn.canvasGroup.alpha = arg_17_1 == true and 1 or 0
		self._control.all_object.account_btn.canvasGroup.interactable = arg_17_1
		self._control.all_object.uid.canvasGroup.alpha = arg_17_1 == true and 1 or 0
	end

	function arg_1_0:set_server_btn(arg_18_1)
		self._control.all_object.enter_btn.canvasGroup.alpha = arg_18_1 == true and 1 or 0
		self._control.all_object.enter_btn.canvasGroup.interactable = arg_18_1
		self._control.all_object.single_server_bar.canvasGroup.alpha = arg_18_1 == true and 1 or 0
		self._control.all_object.single_server_bar.canvasGroup.interactable = arg_18_1
	end

	function arg_1_0:select_server_control(arg_19_1, arg_19_2)
		self._control.all_object.account_btn:SetActive(arg_19_1)
		self._control.all_object.single_server_bar:SetActive(arg_19_1)
		self._control.all_object.enter_btn:SetActive(arg_19_1)

		if arg_19_1 and arg_19_2 then
			self._default_server_ip = arg_19_2.ip
			self._default_server_port = arg_19_2.port
			self._default_server_other = arg_19_2.other
			self._default_server_name = arg_19_2.name
			self._default_server_state = arg_19_2.state
			self._control.all_object.single_server_bar.server_name.text.text = self._default_server_name

			self._control.all_object.single_server_bar.m_proleflag:SetActive(self:judge_server_history(arg_19_2.id))
			self:__set_server_state()
		end
	end

	function arg_1_0:get_default_server_ip()
		return self._default_server_ip
	end

	function arg_1_0:get_default_server_port()
		return self._default_server_port
	end

	function arg_1_0:get_default_server_other()
		return self._default_server_other
	end

	function arg_1_0:get_default_server_name()
		return self._default_server_name
	end

	function arg_1_0:__init_language()
		self._control.all_object.enter_btn.signinselectserverstart.text.text = var_0_1:getNowLang("signinselectserverstart")
		self._control.all_object.single_server_bar.signiinselctserverchangeserver.text.text = var_0_1:getNowLang("signinselectserverchangeserver")
		self._control.all_object.account_btn.ui_account_manager.text.text = var_0_1:getNowLang("ui_account_manager")
		self._control.all_object.common_mark_txt.txt.text.text = var_0_19[1]
	end

	function arg_1_0:__load_server_cfg()
		local var_25_0 = -1

		if self._account_data then
			for iter_25_0, iter_25_1 in pairs(self._account_data.server_list) do
				if 0 < iter_25_1 then
					var_25_0 = iter_25_0
				end
			end
		end

		local var_25_2 = {}
		local var_25_3 = false

		if self._server_list and var_0_15(self._server_list) then
			for iter_25_2, iter_25_3 in pairs(self._server_list) do
				if iter_25_3.id == var_25_0 then
					var_25_3 = true
					var_25_2 = iter_25_3
				end
			end
		end

		if not var_25_3 then
			var_25_0 = self._server_list[1].id
			var_25_2 = self._server_list[1]

			for iter_25_4, iter_25_5 in pairs(self._server_list) do
				if var_25_0 < iter_25_5.id then
					var_25_0 = iter_25_5.id
					var_25_2 = iter_25_5
				end
			end
		end

		self._default_server_name = var_25_2.name
		self._default_server_ip = var_25_2.ip
		self._default_server_port = var_25_2.port
		self._default_server_other = var_25_2.other
		self._default_server_state = var_25_2.state

		local var_25_4 = var_0_2:getInstance("select_server")

		if var_25_4 then
			var_25_4:__select_server(var_25_2.ip, var_25_2.port, var_25_2.other, var_25_2.name, true)
		end

		self._control.all_object.single_server_bar.server_name.text.text = self._default_server_name

		self._control.all_object.single_server_bar.m_proleflag:SetActive(self:judge_server_history(var_25_0))
		self:__set_server_state()
	end

	function arg_1_0.__save_big_server_account_time(arg_26_0)
		if var_0_5:getChannel() == "hm_sdk_android" or var_0_5:getChannel() == "taptap" then
			var_0_16:setKeyData("last_login_android_or_ios", "android")
		elseif var_0_5:getChannel() == "hm_sdk_ios" or var_0_5:getChannel() == "hm_android_to_ios" then
			var_0_16:setKeyData("last_login_android_or_ios", "ios")
		end
	end

	function arg_1_0:__enabled_control(arg_27_1)
		if self._control.all_object:Equals(nil) then
			self._control.all_object:SetActive(arg_27_1)
		end

		local var_27_0 = string.format("App %s  Res %s", app:getSystem():getAppVersion(), (app:getSystem():getDataVersion()))

		if self._account_data then
			self._control.all_object.uid.uuid.text.text = "UID:" .. self._account_data.account_id
		end

		self._control.all_object.uid.uuid:SetActive(self._account_data ~= nil)

		self._control.all_object.uid.versioncode.text.text = var_27_0
	end

	function arg_1_0:judge_server_history(arg_28_1)
		local var_28_0 = false

		if not self._account_data then
			return var_28_0
		end

		for iter_28_0, iter_28_1 in pairs(self._account_data.server_list) do
			if arg_28_1 == iter_28_0 then
				var_28_0 = true

				break
			end
		end

		return var_28_0
	end

	function arg_1_0:__set_server_state()
		for iter_29_0 = 1, self._control.all_object.single_server_bar.status_tip.transform.childCount do
			self._control.all_object.single_server_bar.status_tip.transform:GetChild(iter_29_0 - 1).gameObject:SetActive(false)
		end

		self._control.all_object.single_server_bar.status_tip.transform.transform:Find(var_0_6.server_state[self._default_server_state].rect_name).gameObject:SetActive(true)
	end

	function arg_1_0.__onUpdate(arg_30_0)
		return
	end

	function arg_1_0.__onReset(arg_31_0)
		arg_31_0._audio_init_already = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_32_0)
	local var_32_0 = var_0_2:class("enter_game")

	var_32_0._seq = nil
	var_32_0._default_server_name = nil
	var_32_0._default_server_ip = nil
	var_32_0._default_server_port = nil
	var_32_0._default_server_other = nil
	var_32_0._default_server_state = nil
	var_32_0._account_data = nil
	var_32_0._server_list = {}
	var_32_0._use_default = false
	var_32_0._now_cv_active = true
	var_32_0._now_uid = nil
	var_32_0._login_main_interface = 0
	var_32_0._now_repair = nil

	return var_32_0
end

return var_0_0
