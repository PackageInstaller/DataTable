SettingLayer = class("SettingLayer", function()
	return cc.Layer:create()
end)

local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_2 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")

local Utility = require("common.Utility")

function SettingLayer.create(arg_2_0)
	local var_2_0 = SettingLayer.new()

	var_2_0:init()

	return var_2_0
end

local var_0_4 = "fonts/new.ttf"
local var_0_5 = "fonts/new1.ttf"
local var_0_7 = "https://static.account.aojiaostudio.com/feedback/index.html"

function SettingLayer.fullScreen(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:setContentSize(GameDisplay.getScreenSize())
	arg_3_1:setPositionY(arg_3_1:getPositionY() - GameDisplay.fix_y)
	arg_3_2:setPositionY(arg_3_2:getPositionY() + 2 * GameDisplay.fix_y - GameDisplay.notch_height)
end

function SettingLayer:init()
	self.rootLayout = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "settingLayer.json" or "settingLayer.ExportJson")

	self:addChild(self.rootLayout)

	self.active = true

	playermodel:getCustomerServiceInfo(function(arg_5_0)
		if not self.active then
			return
		end

		if arg_5_0.result == 1 then
			if arg_5_0.info:find("^http") then
				var_0_7 = arg_5_0.info
			else
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer1"):setString(arg_5_0.info)
			end
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("UPDATE_VOLUME", function(arg_6_0)
		self:updataProgressBar(self.progressbar1, cc.UserDefault:getInstance():getIntegerForKey("music_volume", 2))
	end), self)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer1"):setString("")
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer2"):setString(LABEL2)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer2"):setPosition(cc.p(70, 150))
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer3"):setString(LABEL3)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer3"):setPosition(cc.p(70, 100))
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer4"):setString(LABEL4)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_customer4"):setPosition(cc.p(70, 50))

	self.progressbar1 = ccui.Helper:seekWidgetByName(self.rootLayout, "bgm_bg"):getChildByName("bar"):getChildByName("ProgressBar_32")
	self.progressbar2 = ccui.Helper:seekWidgetByName(self.rootLayout, "effect_bg"):getChildByName("bar"):getChildByName("ProgressBar_32")
	self.progressbar3 = ccui.Helper:seekWidgetByName(self.rootLayout, "cv_bg"):getChildByName("bar"):getChildByName("ProgressBar_32")

	ccui.Helper:seekWidgetByName(self.rootLayout, "bgm_bg"):getChildByName("bgm_img"):getChildByName("bgm_label"):setString(L_SETTING_LAYER[1])
	ccui.Helper:seekWidgetByName(self.rootLayout, "effect_bg"):getChildByName("effect_img"):getChildByName("bgm_label"):setString(L_SETTING_LAYER[2])
	ccui.Helper:seekWidgetByName(self.rootLayout, "cv_bg"):getChildByName("cv_img"):getChildByName("bgm_label"):setString(L_SETTING_LAYER[3])

	self.panel_custom = ccui.Helper:seekWidgetByName(self.rootLayout, "panel_custom")
	self.button_custom = ccui.Helper:seekWidgetByName(self.rootLayout, "button_custom")

	local account_manager = require("controller.account_manager")

	self.button_custom:setVisible(account_manager:getChannel() ~= "270055" and account_manager:getChannel() ~= "270048" and account_manager:getChannel() ~= "270054" and account_manager:getChannel() ~= "270057")
	self.panel_custom:setVisible(false)
	self.button_custom:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:needRequestPermission() then
			self:requestPermissionOnCustomService()

			return
		end

		if DeviceManager.getPackageChannel() == "FY" then
			FeiyuManager.showServiceAfterEnterGame(require("controller.account_manager"):getUserID(), FeiyuManager.getServerID(), FeiyuManager.getServerID(), tostring(playermodel.playerid), playermodel.nickname, (tostring(playermodel.grade)))
		else
			DeviceManager.openURL(global_get_custom_jump_url())
		end
	end)
	self.panel_custom:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.panel_custom:setVisible(false)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_80"):setString(L_SET_TWIST_TEN)
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_24"):setString(L_SETTING_LAYER[5])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_gift"):setString(L_SETTING_LAYER[6])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_53"):setString(L_SETTING_LAYER[8])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_55"):setString(L_SETTING_LAYER[9])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_56"):setString(L_SETTING_LAYER[10])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_54"):setString(L_SETTING_LAYER[11])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_80"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootLayout, "button_live2d"):setVisible(true)

	self.button_live2d = ccui.Helper:seekWidgetByName(self.rootLayout, "button_live2d")

	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_71"):setString(L_SETTING_LAYER[12])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_73"):setString(L_SETTING_LAYER[13])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_59"):setString(L_SETTING_LAYER[14])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_74"):setString(L_SETTING_LAYER[15])
	ccui.Helper:seekWidgetByName(self.rootLayout, "Label_76"):setString(L_SETTING_LAYER[16])
	ccui.Helper:seekWidgetByName(self.rootLayout, "title_new"):setPositionY(GameDisplay.getUiScreenSize().height - ccui.Helper:seekWidgetByName(self.rootLayout, "title_new"):getContentSize().height - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayout, "title_new"):setPositionX(0)
	ccui.Helper:seekWidgetByName(self.rootLayout, "title_new"):setZOrder(100)
	self:initBottomList()

	local var_4_1 = ccui.Button:create("settingLayer/new_musicdi.png", "settingLayer/new_musicdi.png", "settingLayer/new_musicdi.png", var_0_2)

	var_4_1:setScale9Enabled(true)
	var_4_1:setContentSize(cc.size(606, 372 + GameDisplay.fix_y / 2))
	var_4_1:setPosition(cc.p(303, 186))
	ccui.Helper:seekWidgetByName(self.rootLayout, "sound_panel"):addChild(var_4_1, -1)

	local var_4_2 = ccui.Helper:seekWidgetByName(self.rootLayout, "push_panel")
	local var_4_3 = 168

	if global_check_is_show_push_open() then
		ccui.Helper:seekWidgetByName(self.rootLayout, "Button_explored"):setPositionY(70)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Button_energy"):setPositionY(20)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Button_diningRoom"):setPositionY(20)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Button_edition"):setPositionY(70)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_53"):setPositionY(70)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_54"):setPositionY(20)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_55"):setPositionY(70)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_56"):setPositionY(20)

		var_4_3 = 231

		local var_4_4 = ccui.Layout:create()

		var_4_4:setContentSize(cc.size(40, 36))
		var_4_4:setTouchEnabled(true)
		var_4_4:setName("pushOpen")
		var_4_4:setPosition(cc.p(60, 100))
		var_4_2:addChild(var_4_4)

		local var_4_5 = ccui.ImageView:create("settingLayer/new_wugou.png", var_0_2)

		var_4_5:setAnchorPoint(cc.p(0, 0))
		var_4_5:setName("bg")

		local var_4_6 = ccui.ImageView:create("settingLayer/new_gou.png", var_0_2)

		var_4_6:setAnchorPoint(cc.p(0, 0))
		var_4_6:setName("click")

		local var_4_7 = ccui.Text:create(L_SETTING_LAYER[7], FONT_DES, 22)

		var_4_7:setColor(cc.c3b(173, 191, 211))
		var_4_7:setName("title")
		var_4_7:setPosition(cc.p(60, 5))
		var_4_7:setAnchorPoint(cc.p(0, 0))
		var_4_4:addChild(var_4_5)
		var_4_4:addChild(var_4_6)
		var_4_4:addChild(var_4_7)

		var_4_4.isPush = playermodel.pushopen or false
		var_4_4.pushInfo = "pushopen"
	end

	local var_4_8 = ccui.Button:create("settingLayer/new_tuisongdi.png", "settingLayer/new_tuisongdi.png", "settingLayer/new_tuisongdi.png", var_0_2)

	var_4_8:setScale9Enabled(true)
	var_4_8:setContentSize(cc.size(606, var_4_3))
	var_4_8:setPosition(cc.p(303, 91))
	var_4_2:addChild(var_4_8, -1)

	local var_4_9 = ccui.Button:create("settingLayer/new_gameset.png", "settingLayer/new_gameset.png", "settingLayer/new_gameset.png", var_0_2)

	var_4_9:setScale9Enabled(true)
	var_4_9:setCapInsets(cc.rect(0, 80, 567, 50))
	var_4_9:setContentSize(cc.size(606, 140 + GameDisplay.fix_y / 2))
	var_4_9:setPosition(cc.p(303, 90))
	ccui.Helper:seekWidgetByName(self.rootLayout, "service_panel"):addChild(var_4_9, -1)

	local var_4_10 = ccui.Button:create("settingLayer/new_other.png", "settingLayer/new_other.png", "settingLayer/new_other.png", var_0_2)

	var_4_10:setScale9Enabled(true)
	var_4_10:setContentSize(cc.size(606, 190 + GameDisplay.fix_y / 2))
	var_4_10:setPosition(cc.p(303, 113))
	ccui.Helper:seekWidgetByName(self.rootLayout, "other_panel"):addChild(var_4_10, -1)

	self.bgm_buttons = {}
	self.effect_buttons = {}
	self.cv_buttons = {}

	self:initSoundButtons()

	self.pushActivity = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_explored")
	self.pushLab = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_energy")
	self.pushPatrol = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_diningRoom")
	self.pushOffline = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_edition")
	self.XPeffect_button = ccui.Helper:seekWidgetByName(self.rootLayout, "button_XPeffect")
	self.unShowGiftBtn = ccui.Helper:seekWidgetByName(self.rootLayout, "button_unshow_gift")
	self.pushActivity.isPush = playermodel.pushactivity
	self.pushLab.isPush = playermodel.pushlab
	self.pushPatrol.isPush = playermodel.pushpatrol
	self.pushOffline.isPush = playermodel.pushoffline
	self.XPeffect_button.isPush = cc.UserDefault:getInstance():getBoolForKey("XPeffect", true)
	self.button_live2d.isPush = cc.UserDefault:getInstance():getBoolForKey("twistTenPop", false)
	self.unShowGiftBtn.isPush = cc.UserDefault:getInstance():getBoolForKey("unShowGift", false)
	self.pushActivity.pushInfo = "pushactivity"
	self.pushLab.pushInfo = "pushlab"
	self.pushPatrol.pushInfo = "pushpatrol"
	self.pushOffline.pushInfo = "pushoffline"
	self.XPeffect_button.pushInfo = "XPeffect"
	self.button_live2d.pushInfo = "twistTenPop"
	self.unShowGiftBtn.pushInfo = "unShowGift"

	self:addMainCityShowGirlMoveSetBtn()

	local function var_4_11(arg_9_0)
		if arg_9_0.isPush then
			arg_9_0:loadTextures("settingLayer/new_gou.png", "settingLayer/new_gou.png", "", var_0_2)
		else
			arg_9_0:loadTextures("settingLayer/new_wugou.png", "settingLayer/new_wugou.png", "", var_0_2)
		end

		if arg_9_0.pushInfo == "XPeffect" then
			playermodel.showXPEffect = arg_9_0.isPush

			cc.UserDefault:getInstance():setBoolForKey("XPeffect", arg_9_0.isPush)
		elseif arg_9_0.pushInfo == "twistTenPop" then
			playermodel.twistTenPop = arg_9_0.isPush

			cc.UserDefault:getInstance():setBoolForKey("twistTenPop", arg_9_0.isPush)
		elseif arg_9_0.pushInfo == "unShowGift" then
			playermodel.unShowGift = arg_9_0.isPush

			cc.UserDefault:getInstance():setBoolForKey("unShowGift", arg_9_0.isPush)
		elseif arg_9_0.pushInfo == "moveShowGirl" then
			playermodel.moveShowGirl = arg_9_0.isPush

			cc.UserDefault:getInstance():setBoolForKey("moveShowGirl", arg_9_0.isPush)
		else
			playermodel:updatePushSetting(arg_9_0.pushInfo, arg_9_0.isPush)
		end

		AnalyticManager.push_settings({
			is_push_open = playermodel.pushopen,
			is_new_activity_on = self.pushActivity.isPush,
			is_offline_get_on = self.pushOffline.isPush,
			is_lab_research_on = self.pushLab.isPush,
			is_patrol_on = self.pushPatrol
		})
		AnalyticManager.game_settings({
			is_l2d_on = self.button_live2d.isPush,
			is_XPeffect_on = self.XPeffect_button.isPush
		})
	end

	var_4_11(self.pushActivity)
	var_4_11(self.pushLab)
	var_4_11(self.pushPatrol)
	var_4_11(self.pushOffline)
	var_4_11(self.XPeffect_button)
	var_4_11(self.button_live2d)
	var_4_11(self.unShowGiftBtn)
	var_4_11(self.moveShowGirlBtn)

	local function var_4_12(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if global_check_is_show_push_open() and playermodel.pushopen ~= true and ({
			pushlab = 1,
			pushactivity = 1,
			pushpatrol = 1,
			pushoffline = 1
		})[arg_10_0.pushInfo] == 1 then
			return
		end

		arg_10_0.isPush = not arg_10_0.isPush

		var_4_11(arg_10_0)
		self:updateAntiHexie()
	end

	self.pushActivity:addTouchEventListener(var_4_12)
	self.pushLab:addTouchEventListener(var_4_12)
	self.pushPatrol:addTouchEventListener(var_4_12)
	self.pushOffline:addTouchEventListener(var_4_12)
	self.XPeffect_button:addTouchEventListener(var_4_12)
	self.button_live2d:addTouchEventListener(var_4_12)
	self.unShowGiftBtn:addTouchEventListener(var_4_12)
	self.moveShowGirlBtn:addTouchEventListener(var_4_12)

	if global_check_is_show_push_open() then
		local var_4_13 = var_4_2:getChildByName("pushOpen")

		Utility:setToggleCallback(var_4_13, function(arg_11_0)
			local var_11_0 = {
				"Button_explored",
				"Button_energy",
				"Button_diningRoom",
				"Button_edition"
			}

			if arg_11_0 ~= true then
				for iter_11_0, iter_11_1 in pairs(var_11_0) do
					local var_11_1 = ccui.Helper:seekWidgetByName(self.rootLayout, iter_11_1)

					var_11_1:setOpacity(127.5)

					var_11_1.isPush = false

					var_4_11(var_11_1)
				end

				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_53"):setOpacity(127.5)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_54"):setOpacity(127.5)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_55"):setOpacity(127.5)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_56"):setOpacity(127.5)
			else
				for iter_11_2, iter_11_3 in pairs(var_11_0) do
					ccui.Helper:seekWidgetByName(self.rootLayout, iter_11_3):setOpacity(255)
				end

				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_53"):setOpacity(255)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_54"):setOpacity(255)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_55"):setOpacity(255)
				ccui.Helper:seekWidgetByName(self.rootLayout, "Label_56"):setOpacity(255)
			end

			var_4_13.isPush = arg_11_0

			playermodel:updatePushSetting("pushopen", arg_11_0)
			self:updateAntiHexie()
			umeng_pushSwitch(arg_11_0)
		end, playermodel.pushopen or false)
	end

	local var_4_14 = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_bug")
	local var_4_15 = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_question")

	var_4_14:setPositionX(var_4_14:getPositionX())

	local var_4_16 = ccui.Helper:seekWidgetByName(self.rootLayout, "other_panel")

	var_4_16:getChildByName("Label_74"):setPositionX(var_4_16:getChildByName("Label_74"):getPositionX())
	var_4_16:getChildByName("Label_74"):setString("缺陷反馈")
	self.button_custom:setPositionX(self.button_custom:getPositionX())
	var_4_14:setVisible(false)
	var_4_16:getChildByName("Label_74"):setVisible(false)

	self.cdk_input = ccui.Helper:seekWidgetByName(self.rootLayout, "TextField_CDKinput")
	self.cdk_input_label = config._DEBUG and cc.EditBox:create(cc.size(306, 26), cc.Scale9Sprite:create("public/panelbg/editBoxBG.png")) or cc.EditBox:create(cc.size(306, 26), cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png"))

	self.cdk_input_label:setName("cdk_input_label")
	self.cdk_input_label:setAnchorPoint(cc.p(0, 0.5))
	self.cdk_input_label:setPosition(cc.p(0, 10))
	self.cdk_input_label:setFontName(var_0_5)
	self.cdk_input_label:setPlaceholderFont(var_0_5, 20)
	self.cdk_input_label:setFontSize(20)
	self.cdk_input_label:setFontColor(cc.c3b(245, 244, 244))
	self.cdk_input_label:setPlaceHolder(L_SETTING_OTHER_FUNCTION[3])
	self.cdk_input_label:setMaxLength(30)
	self.cdk_input_label:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.cdk_input_label:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	self.cdk_input_label:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_ALL_CHARACTERS)
	self.cdk_input:addChild(self.cdk_input_label, 1)

	self.cdk_button = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_exchange")

	self.cdk_button:setTitleFontName(var_0_4)
	self.cdk_button:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self:cdkCharge(function()
			arg_12_0:setBright(true)
		end)
	end)

	if not playermodel.isShowGiftbag then
		self.cdk_input:setVisible(false)
		self.cdk_input_label:setVisible(false)
		self.cdk_button:setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_71"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_73"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Image_inputBg"):setVisible(false)

		local var_4_17 = var_4_14:getParent():getContentSize().height / 2

		var_4_14:setPositionY(var_4_17)
		ccui.Helper:seekWidgetByName(self.rootLayout, "Label_74"):setPositionY(var_4_17 - 5)
		var_4_15:setPositionY(var_4_17)
		self.button_custom:setPositionY(var_4_17)
		var_4_15:setPositionY(var_4_17)
	end

	self:initL2dDownloadBtn()
	self:initTestShareBtn()
	self:initAntiHexieTags()
	self:updateAntiHexie()
	self:registerScriptHandler(function(arg_14_0)
		if arg_14_0 == "exit" then
			self.active = false
		end
	end)
	self:fullScreen(self.panel_custom, (ccui.Helper:seekWidgetByName(self.rootLayout, "Panel_82")))

	return true
end

function SettingLayer:initL2dDownloadBtn()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_question")
	local download_l2d_helper = require("controller.filedownloader.download_l2d_helper")

	if not download_l2d_helper:needDownload() then
		var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords("资源已下载完成")
		end)

		return
	end

	local function var_15_2(arg_17_0)
		if arg_17_0 > 1073741824 then
			return string.format("%.1fG", arg_17_0 / 1073741824)
		elseif arg_17_0 > 1048576 then
			return string.format("%.1fM", arg_17_0 / 1048576)
		elseif arg_17_0 > 1024 then
			return string.format("%.1fK", arg_17_0 / 1024)
		else
			return tostring(arg_17_0)
		end
	end

	local function var_15_3()
		var_15_0:scheduleUpdateWithPriorityLua(function(arg_19_0)
			local var_19_0 = download_l2d_helper:getTotalSize()
			local var_19_1 = download_l2d_helper:getDownloadedSize()

			if var_19_0 <= var_19_1 then
				var_15_0:getChildByName("Label_59"):setString("下载完成")
				var_15_0:unscheduleUpdate()

				return
			end

			var_15_0:getChildByName("Label_59"):setString(string.format("已下载%.1f%%", var_19_1 / var_19_0 * 100))
		end, 0)
	end

	local function var_15_4()
		require("view.Layer.DialogLayer")
		self:addChild(DialogLayer:create(L_LOGOUT_MSG[5].Title, string.format("是否下载live2d资源(%s)", var_15_2(download_l2d_helper:getTotalSize() - download_l2d_helper:getDownloadedSize())), 500, 250, function()
			download_l2d_helper:startDownload()
			var_15_3()
		end, function()
			return
		end, true), 10001)
	end

	if download_l2d_helper:isDownloading() then
		local var_15_5 = download_l2d_helper:getTotalSize()
		local var_15_6 = download_l2d_helper:getDownloadedSize()

		var_15_3()
	end

	var_15_0:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if download_l2d_helper:isDownloading() then
			download_l2d_helper:stopDownload()
			var_15_0:unscheduleUpdate()
			var_15_0:getChildByName("Label_59"):setString("live2d资源下载")
		else
			if not download_l2d_helper:needDownload() then
				global_ShowBlockWords("资源已下载完成")

				return
			end

			var_15_4()
		end
	end)
end

function SettingLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("MainLayer")
	end, conf)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.bottomList, 1000)
end

function SettingLayer:cdkCharge(arg_26_1)
	local var_26_0 = self.cdk_input_label:getText()

	if var_26_0 == "" then
		global_ShowBlockWords(L_SETTING_CDK_WARNING[1])
		audio_manager:playeffectMusicTest("sound/invalid")

		if arg_26_1 then
			arg_26_1()
		end

		return
	end

	if var_26_0 == "gamedebug" then
		global_ShowBlockWords(L_SETTING_CDK_WARNING[1])
		self:addAntiHexieCDKTag()

		if arg_26_1 then
			arg_26_1()
		end

		return
	end

	require("network.network"):rpc("use_certificate_code", {
		code = var_26_0,
		channel = DeviceManager.getChannelID()
	}, function(arg_27_0)
		if arg_27_0.result == 1 then
			AnalyticManager.cdk_exchange_success({
				cdk_times = playermodel.havecdktime
			})
			global_gain({
				gold = arg_27_0.gold,
				diamond = arg_27_0.diamond,
				sp = arg_27_0.sp,
				honor = arg_27_0.honor,
				items = arg_27_0.items
			})
		elseif arg_27_0.result == 2 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[2])
		elseif arg_27_0.result == 3 then
			global_ShowBlockWords(L_SETTING_CDK_WARNING[3])
		else
			global_ShowBlockWords(L_SETTING_CDK_WARNING[4])
		end

		if arg_26_1 then
			arg_26_1()
		end
	end)
	self.cdk_input_label:setText("")
end

function SettingLayer.updataProgressBar(arg_28_0, arg_28_1, arg_28_2)
	arg_28_1:setPercent(math.floor(100 * arg_28_2 / 3))
end

function SettingLayer:initSoundButtons()
	self:updataProgressBar(self.progressbar1, cc.UserDefault:getInstance():getIntegerForKey("music_volume", 2))
	self:updataProgressBar(self.progressbar2, cc.UserDefault:getInstance():getIntegerForKey("effect_volume", 2))
	self:updataProgressBar(self.progressbar3, cc.UserDefault:getInstance():getIntegerForKey("voice_volume", 2))

	local function var_29_0()
		for iter_30_0 = 0, 3 do
			self.bgm_buttons[iter_30_0] = self.bgm_buttons[iter_30_0] or ccui.Helper:seekWidgetByName(self.rootLayout, "bgm_button_" .. iter_30_0)

			if iter_30_0 == audio_manager.music_volume then
				self.bgm_buttons[iter_30_0]:loadTextures("settingLayer/new_volum4.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.bgm_buttons[iter_30_0].open = true
			else
				self.bgm_buttons[iter_30_0]:loadTextures("settingLayer/new_volum3.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.bgm_buttons[iter_30_0].open = false
			end

			self.bgm_buttons[iter_30_0].id = iter_30_0
		end
	end

	var_29_0()

	for iter_29_0 = 0, 3 do
		self.bgm_buttons[iter_29_0]:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_31_0.open then
				return
			end

			self:updataProgressBar(self.progressbar1, arg_31_0.id)

			audio_manager.music_volume = arg_31_0.id

			cc.UserDefault:getInstance():setIntegerForKey("music_volume", arg_31_0.id)
			audio_manager:setMusicVolume()
			var_29_0()
			AnalyticManager.changeBGMVoiceVolume({
				sound_volume = arg_31_0.id
			})
			self:updateAntiHexie()
		end)
	end

	local function var_29_1()
		for iter_32_0 = 0, 3 do
			self.effect_buttons[iter_32_0] = self.effect_buttons[iter_32_0] or ccui.Helper:seekWidgetByName(self.rootLayout, "effect_button_" .. iter_32_0)

			if iter_32_0 == audio_manager.effect_volume then
				self.effect_buttons[iter_32_0]:loadTextures("settingLayer/new_volum4.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.effect_buttons[iter_32_0].open = true
			else
				self.effect_buttons[iter_32_0]:loadTextures("settingLayer/new_volum3.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.effect_buttons[iter_32_0].open = false
			end

			self.effect_buttons[iter_32_0].id = iter_32_0
		end
	end

	var_29_1()

	for iter_29_1 = 0, 3 do
		self.effect_buttons[iter_29_1]:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_33_0.open then
				return
			end

			self:updataProgressBar(self.progressbar2, arg_33_0.id)

			audio_manager.effect_volume = arg_33_0.id

			cc.UserDefault:getInstance():setIntegerForKey("effect_volume", arg_33_0.id)
			audio_manager:setEffectVolume()
			var_29_1()
			AnalyticManager.changeEffectVoiceVolume({
				effect_volume = arg_33_0.id
			})
			self:updateAntiHexie()
		end)
	end

	local function var_29_2()
		for iter_34_0 = 0, 3 do
			self.cv_buttons[iter_34_0] = self.cv_buttons[iter_34_0] or ccui.Helper:seekWidgetByName(self.rootLayout, "cv_button_" .. iter_34_0)

			if iter_34_0 == audio_manager.voice_volume then
				self.cv_buttons[iter_34_0]:loadTextures("settingLayer/new_volum4.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.cv_buttons[iter_34_0].open = true
			else
				self.cv_buttons[iter_34_0]:loadTextures("settingLayer/new_volum3.png", "settingLayer/new_volum4.png", "", var_0_2)

				self.cv_buttons[iter_34_0].open = false
			end

			self.cv_buttons[iter_34_0].id = iter_34_0
		end
	end

	var_29_2()

	for iter_29_2 = 0, 3 do
		self.cv_buttons[iter_29_2]:addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_35_0.open then
				return
			end

			self:updataProgressBar(self.progressbar3, arg_35_0.id)

			audio_manager.voice_volume = arg_35_0.id

			cc.UserDefault:getInstance():setIntegerForKey("voice_volume", arg_35_0.id)
			audio_manager:setVoiceVolume()
			var_29_2()
			AnalyticManager.changeCVVoiceVolume({
				cv_volume = arg_35_0.id
			})
			self:updateAntiHexie()
		end)
	end
end

function SettingLayer:initTestShareBtn()
	local var_36_0 = ccui.Helper:seekWidgetByName(self.rootLayout, "Button_question")

	require("controller.share_manager"):get_test_share_data(function(arg_37_0, arg_37_1)
		if arg_37_0 == 1 then
			var_36_0:getChildByName("Label_59"):setString("分享测试")
			var_36_0:addTouchEventListener(function(arg_38_0, arg_38_1)
				if arg_38_1 ~= ccui.TouchEventType.ended then
					return
				end

				print("dddddddddddddddddddddddddddddddddddddd")

				if config.packagechannel == "feiyu" then
					if FeiyuManager.canShare and FeiyuManager.canShare() then
						FeiyuManager.share(arg_37_1.content, arg_37_1.title, "web", arg_37_1.url)
					end
				else
					print("tttttttttttttttttttttttttttttt")
					print(dump(arg_37_1))
				end
			end)
		end
	end)
end

function SettingLayer.initAntiHexieTags(arg_39_0)
	arg_39_0._bgmTag = false
	arg_39_0._effectTag = false
	arg_39_0._roleTag = false
	arg_39_0._pushTag = false
	arg_39_0._setttingTag = false
	arg_39_0._btnCdkTag = 0
end

function SettingLayer:updateAntiHexie()
	if require("controller.antihexie_assets_manager"):isAntiHexieNow() then
		return false
	end

	self._bgmTag = audio_manager.music_volume == 3
	self._effectTag = audio_manager.effect_volume == 1
	self._roleTag = audio_manager.voice_volume == 0
	self._setttingTag = self.XPeffect_button.isPush and self.unShowGiftBtn.isPush and not self.button_live2d.isPush
end

function SettingLayer:checkAntiHexie()
	if require("controller.antihexie_assets_manager"):isAntiHexieNow() then
		return false
	end

	return self._bgmTag and self._effectTag and self._roleTag and self._pushTag and self._setttingTag
end

function SettingLayer:addAntiHexieCDKTag()
	if not self:checkAntiHexie() then
		return
	end

	self._btnCdkTag = self._btnCdkTag + 1

	print("Add AntiHexieTag: ", self._btnCdkTag)

	if self._btnCdkTag >= 1 then
		self:showDownloadDialog()
	end
end

function SettingLayer:showDownloadDialog()
	if DeviceManager.platform ~= "windows" then
		local var_43_4 = DeviceManager.getInternetConnectionStatus()
	end

	local var_43_5 = cc.Layer:create()

	var_43_5:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_43_5:setTouchEnabled(true)
	self:addChild(var_43_5, 5)

	local var_43_6 = cc.Sprite:create("update/box.png")

	var_43_6:setPosition(cc.p(320, 635))
	var_43_5:addChild(var_43_6)

	local var_43_7 = cc.Label:createWithTTF("下载更新", "fonts/name.ttf", 28)

	var_43_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_43_7:setPosition(cc.p(320, 680))
	var_43_7:setColor(cc.c3b(182, 189, 203))
	var_43_5:addChild(var_43_7, 1)

	local var_43_8 = cc.Label:createWithTTF("", "fonts/number.ttf", 24)

	var_43_8:setString("是否进入开发者模式")
	var_43_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_43_8:setPosition(cc.p(320, 630))
	var_43_8:setColor(cc.c3b(18, 19, 26))
	var_43_8:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_43_5:addChild(var_43_8, 5)

	local var_43_9 = ccui.Button:create("update/button.png", nil, "update/button_off.png")

	var_43_9:setPosition(cc.p(320, 520))
	var_43_5:addChild(var_43_9, 6)
	var_43_9:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_44_0:isBright() then
			return
		end

		arg_44_0:setBright(false)
		var_43_5:runAction(cc.RemoveSelf:create())
		require("controller.antihexie_assets_manager"):enableAntiHexie()
	end)
end

function SettingLayer:addMainCityShowGirlMoveSetBtn()
	self.moveShowGirlBtn = self.unShowGiftBtn:clone()

	local var_45_0 = self.unShowGiftBtn:getParent()

	if var_45_0 then
		var_45_0:addChild(self.moveShowGirlBtn)
		self.moveShowGirlBtn:setPosition(cc.p(self.button_live2d:getPositionX(), self.unShowGiftBtn:getPositionY()))

		self.moveShowGirlBtn.isPush = cc.UserDefault:getInstance():getBoolForKey("moveShowGirl", true)
		self.moveShowGirlBtn.pushInfo = "moveShowGirl"

		local var_45_1 = ccui.Helper:seekWidgetByName(self.rootLayout, "Label_gift"):clone()

		var_45_1:setString(L_SETTING_LAYER[4])
		var_45_0:addChild(var_45_1)

		local var_45_2 = ccui.Helper:seekWidgetByName(self.rootLayout, "Label_80")

		var_45_1:setPosition(cc.p(var_45_2:getPositionX(), (ccui.Helper:seekWidgetByName(self.rootLayout, "Label_gift").getPositionY(var_45_2))))
	end
end

function SettingLayer.needRequestPermission(arg_46_0)
	if config.packagechannel ~= "feiyu" then
		return false
	end

	if require("controller.account_manager"):getChannel() ~= "270054" then
		return false
	end

	if not FySDK.showPermissionDialog then
		return false
	end

	if not cc.UserDefault:getInstance():getBoolForKey("agreehuaweipermission", false) then
		return true
	end

	return not cc.UserDefault:getInstance():getBoolForKey("haveShowHuaweipermission", false)
end

function SettingLayer.requestPermissionOnCustomService(arg_47_0)
	local function var_47_0()
		FeiyuManager.showServiceAfterEnterGame(require("controller.account_manager"):getUserID(), FeiyuManager.getServerID(), FeiyuManager.getServerID(), tostring(playermodel.playerid), playermodel.nickname, (tostring(playermodel.grade)))
	end

	FySDK.registerEventHandler(FySDK.EventType.REQUESTPERMISSION, function(arg_49_0)
		if arg_49_0 == 1 then
			cc.UserDefault:getInstance():setBoolForKey("agreehuaweipermission", true)
			var_47_0()
		else
			cc.UserDefault:getInstance():setBoolForKey("agreehuaweipermission", false)
		end
	end)
	FySDK.showPermissionDialog({
		存储 = "手动上传本地图片已更准确的向客服反馈问题"
	}, false, true)
	cc.UserDefault:getInstance():setBoolForKey("haveShowHuaweipermission", true)
end
