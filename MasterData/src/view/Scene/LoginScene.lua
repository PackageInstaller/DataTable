LoginScene = class("LoginScene", function()
	return cc.Scene:create()
end)

if config.packagechannel == "palmpi" then
	require("view.Scene.LoginScenePalmpi")
end

require("data.constants")

local audio_manager = require("controller.audio_manager")
local account_manager = require("controller.account_manager")
local login_bg_manager = require("controller.login_bg_manager")
local network = require("network.network")
local net_requesting = require("network.net_requesting")
local net_waitinglayer = require("network.net_waitinglayer")
local l2utils = require("controller.l2utils")

AnalyticManager = require("controller.analysis_bridge")
SpineCacheManager = require("controller.spinecache_manager")

local function var_0_7()
	require("controller.texture_manager"):loadLayerTextures({
		"login",
		"SelectPlayerLayer"
	})
end

local function var_0_8()
	require("controller.texture_manager"):removeLayerTextures({
		"login",
		"SelectPlayerLayer"
	})
end

function global_get_custom_jump_url()
	local var_4_0 = account_manager:getChannelUid()
	local var_4_1 = account_manager:getUserID()
	local var_4_2 = DeviceManager.getPackageChannel()
	local var_4_3 = account_manager:getUserPlayerid()

	return "https://work.weixin.qq.com/kfid/kfcc5212037dffaacea"
end

function global_on_key_exit_game(arg_5_0, arg_5_1)
	if arg_5_0 ~= cc.KeyCode.KEY_BACKSPACE and arg_5_0 ~= cc.KeyCode.KEY_BACK then
		return
	end

	if SDKManager.exit then
		SDKManager.registerExitGameHandler(function(arg_6_0)
			if arg_6_0 == 0 then
				cc.Director:getInstance():endToLua()
			end
		end)
		SDKManager.exit()
	else
		local var_5_0 = cc.Director:getInstance():getRunningScene()

		if var_5_0:getChildByName("BACK_LAYER") then
			return
		end

		require("view.Layer.DialogLayer")

		local var_5_1 = DialogLayer:create(L_LOGIN_EXIT_DIALOG.Title, {
			"",
			L_LOGIN_EXIT_DIALOG.Content
		}, 500, 200, function()
			cc.Director:getInstance():endToLua()
		end, nil, true)

		var_5_1:setName("BACK_LAYER")
		var_5_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_0:addChild(var_5_1, 10005)
	end
end

function global_showHelpQQPanel(arg_8_0)
	local var_8_0 = arg_8_0 or cc.Director:getInstance():getRunningScene()
	local var_8_1 = var_8_0:getChildByName("helpQQPanel")

	if not var_8_1 then
		local var_8_2 = DeviceManager.getChannelID()
		local var_8_3 = {
			["270100"] = "官网版本",
			["270020"] = "今日头条",
			["270058"] = "魅族",
			["270071"] = "美图CPS",
			["270057"] = "小米",
			["270103"] = "人人视频",
			["270050"] = "好游快爆",
			["270106"] = "乐信",
			["270067"] = "夜神模拟器",
			["270096"] = "官网版本",
			["999"] = "抖音",
			["270066"] = "三星",
			["25"] = "4399",
			["270048"] = "bilibili",
			["270054"] = "华为",
			["270051"] = "官网版本",
			["270060"] = "应用宝",
			["270001"] = "ios版本",
			["270052"] = "九游",
			["270049"] = "taptap",
			["270055"] = "OPPO",
			["270111"] = "荣耀",
			["270086"] = "联想",
			["32"] = "小七",
			["270063"] = "MuMu模拟器",
			["270056"] = "vivo",
			["270053"] = "4399"
		}

		var_8_1 = ccui.Layout:create()

		var_8_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_8_1:setTouchEnabled(true)
		var_8_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_8_1:setCascadeOpacityEnabled(false)
		var_8_1:setBackGroundColorOpacity(122)
		var_8_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_8_0:addChild(var_8_1, 50)
		var_8_1:setName("helpQQPanel")

		local var_8_4 = cc.Sprite:create("update/box.png")

		var_8_4:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		var_8_1:addChild(var_8_4)

		local var_8_5 = cc.Label:createWithTTF("联系客服", "fonts/name.ttf", 28)

		var_8_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_5:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 45))
		var_8_5:setColor(cc.c3b(182, 189, 203))
		var_8_1:addChild(var_8_5, 1)

		local var_8_6 = cc.Label:createWithTTF("    添加QQ 509220336，专属客服为您解答游戏问题！", "fonts/number.ttf", 24)

		var_8_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_6:setContentSize(cc.size(600, 300))
		var_8_6:setPosition(cc.p(GameDisplay.cx + 20, GameDisplay.cy - 5))
		var_8_6:setColor(cc.c3b(18, 19, 26))
		var_8_6:setMaxLineWidth(600)
		var_8_1:addChild(var_8_6, 5)

		local var_8_7 = cc.Label:createWithTTF("当前渠道: " .. (var_8_3[var_8_2] or "官网版本"), "fonts/number.ttf", 24)

		var_8_7:setAnchorPoint(cc.p(1, 0.5))
		var_8_7:setPosition(cc.p(620, GameDisplay.cy - 47))
		var_8_7:setColor(cc.c3b(18, 19, 26))
		var_8_7:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_8_1:addChild(var_8_7, 5)

		local var_8_8 = ccui.Button:create("update/btn_privacy_sure.png", nil, "update/btn_privacy_sure.png")

		var_8_8:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 115))
		var_8_1:addChild(var_8_8, 6)
		var_8_8:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_9_0:isBright() then
				return
			end

			var_8_1:setVisible(false)
		end)
	end

	var_8_1:setVisible(true)
end

function LoginScene.createScene(arg_10_0, arg_10_1)
	local var_10_0 = LoginScene.new()

	var_10_0:setName("LoginScene")
	var_0_7()
	var_10_0:init(arg_10_1)

	return var_10_0
end

function LoginScene:init(arg_11_1)
	self:createStatusBarCover()

	if not arg_11_1 then
		require("controller.filedownloader.download_manager"):init()
	end

	self:playLoginAudio()
	self:initLocalAccountSystem()
	self:initLoginBG()
	self:initLoginLayer()
	self:initKeyEvent()
	self:registerCustomEventListener()
	self:initStatement()
	self:checkPackageChannel(function()
		self:initSDK(arg_11_1)
	end)
	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "exit" then
			self:endConnectionCheck()
			l2utils:performWithDelay(var_0_8, 0.5)
		end
	end)
end

function LoginScene:checkPackageChannel(arg_14_1)
	if DeviceManager.getPackageChannel() == "FY" then
		self:needDownloadNewVersion(arg_14_1)
	elseif arg_14_1 then
		arg_14_1()
	end
end

function LoginScene:initSDK(arg_15_1)
	if arg_15_1 then
		self:onEnterLoginScene(arg_15_1)

		return
	end

	if DeviceManager.getPackageChannel() == "FY" then
		self:initFeiyuSDK()
	else
		self:onEnterLoginScene(arg_15_1)
	end
end

function LoginScene.initFeiyuSDK(arg_16_0)
	local function var_16_0(arg_17_0)
		local var_17_0, var_17_1, var_17_2, var_17_3 = arg_17_0:match("(%d+).(%d+).(%d+).(%d+)")

		return string.format("%s.%s", var_17_0, var_17_1)
	end

	local function var_16_1(arg_18_0, arg_18_1)
		local var_18_0

		var_18_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_18_0)
			arg_18_0()
		end, arg_18_1, false)

		return nil
	end

	local var_16_2 = 1

	if umeng_initWhenConsentProtocol then
		umeng_initWhenConsentProtocol()
	end

	FeiyuManager.registerInitHandler(function(arg_20_0)
		print("Feiyu InitCallback: ", arg_20_0)

		if initfinished then
			return
		end

		if arg_20_0 == 0 then
			TrackingManager.init("3f0ea28038c246a770f893b96c623ad6", FeiyuManager.getchannelid())
			FeiyuManager.initAntiAddict()

			if buglyInitCrashReport then
				buglyInitCrashReport()
			end

			arg_16_0:onEnterLoginScene(false)
		else
			var_16_1(function()
				FeiyuManager.init(var_16_0(config.version))
			end, var_16_2)

			var_16_2 = var_16_2 * 2
		end
	end)
	FeiyuManager.init(var_16_0(config.version))
end

function LoginScene:needDownloadNewVersion(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setTouchEnabled(true)
	self:addChild(var_22_0, 50)

	local var_22_1 = cc.Sprite:create("update/box.png")

	var_22_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_22_0:addChild(var_22_1)

	local var_22_2 = cc.Label:createWithTTF("下载新客户端", "fonts/name.ttf", 28)

	var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 45))
	var_22_2:setColor(cc.c3b(182, 189, 203))
	var_22_0:addChild(var_22_2, 1)

	local var_22_3 = cc.Label:createWithTTF("    由于账号系统升级，老包已停止使用，请班长前往应用商店下载最新包体~", "fonts/number.ttf", 24)

	var_22_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_3:setContentSize(cc.size(600, 300))
	var_22_3:setPosition(cc.p(GameDisplay.cx + 20, GameDisplay.cy - 5))
	var_22_3:setColor(cc.c3b(18, 19, 26))
	var_22_3:setMaxLineWidth(600)
	var_22_0:addChild(var_22_3, 5)

	local var_22_4 = DeviceManager.getChannelID()
	local var_22_5 = {
		["270050"] = "https://www.3839.com/a/90063.htm",
		["270096"] = "https://www.h-college.com",
		["270054"] = "https://appgallery.huawei.com/app/C100822287",
		["270001"] = "https://apps.apple.com/cn/app/id1455051196",
		["270057"] = "https://app.mi.com/details?id=com.feiyu.hcollege.mi",
		["270060"] = "http://a.app.qq.com/o/simple.jsp?pkgname=com.tencent.tmgp.hqxy",
		["270061"] = "https://www.h-college.com",
		["25"] = "http://a.4399.cn/game-id-103034.html",
		["270058"] = "https://www.h-college.com",
		palmpi = "https://www.h-college.com",
		["270055"] = "https://www.h-college.com",
		["270048"] = "https://www.biligame.com/detail/?id=102020",
		["1000"] = "https://www.h-college.com",
		["270051"] = "https://www.h-college.com",
		["270052"] = "https://www.9game.cn/hqxy/",
		["270049"] = "https://www.taptap.com/app/42949",
		["270086"] = "https://www.h-college.com",
		["32"] = "https://www.x7sy.com/gameDetail/9031?gid=9031&gametype=1&surface=",
		["270063"] = "https://mumu.163.com/games/8796.html",
		["270056"] = "https://game.vivo.com.cn/#detail/70535",
		["270053"] = "http://a.4399.cn/game-id-103034.html",
		["270104"] = "https://www.h-college.com"
	}
	local var_22_6 = cc.Label:createWithTTF("当前渠道: " .. (({
		["270100"] = "官网版本",
		["270020"] = "今日头条",
		["270058"] = "魅族",
		["270071"] = "美图CPS",
		["270057"] = "小米",
		["270103"] = "人人视频",
		["270050"] = "好游快爆",
		["270106"] = "乐信",
		["270067"] = "夜神模拟器",
		["270096"] = "官网版本",
		["999"] = "抖音",
		["270066"] = "三星",
		["25"] = "4399",
		["270048"] = "bilibili",
		["270054"] = "华为",
		["270051"] = "官网版本",
		["270060"] = "应用宝",
		["270001"] = "ios版本",
		["270052"] = "九游",
		["270049"] = "taptap",
		["270055"] = "OPPO",
		["270111"] = "荣耀",
		["270086"] = "联想",
		["32"] = "小七",
		["270063"] = "MuMu模拟器",
		["270056"] = "vivo",
		["270053"] = "4399"
	})[var_22_4] or "官网版本"), "fonts/number.ttf", 24)

	var_22_6:setAnchorPoint(cc.p(1, 0.5))
	var_22_6:setPosition(cc.p(620, GameDisplay.cy - 47))
	var_22_6:setColor(cc.c3b(18, 19, 26))
	var_22_6:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_22_0:addChild(var_22_6, 5)

	local var_22_7 = ccui.Button:create("update/btn_goDow.png", nil, "update/btn_goDow.png")

	var_22_7:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 115))
	var_22_0:addChild(var_22_7, 6)
	var_22_7:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_23_0:isBright() then
			return
		end

		DeviceManager.openURL(var_22_5[var_22_4] or "https://www.h-college.com")
	end)
end

function LoginScene:createStatusBarCover()
	if not GameDisplay.hasNotchInScreen() then
		return
	end

	local var_24_0 = ccui.Layout:create()

	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.statusbar_height + 10))
	var_24_0:setPosition(cc.p(0, GameDisplay.height))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_24_0:setBackGroundColorOpacity(255)
	var_24_0:setTouchEnabled(true)
	self:addChild(var_24_0, 20000)
end

function LoginScene.playLoginAudio(arg_25_0)
	audio_manager:init()
end

function LoginScene.initLocalAccountSystem(arg_26_0)
	account_manager:init()
end

function LoginScene:initLoginBG()
	local var_27_0 = cc.Label:createWithTTF(L_ICP_BEIAN, "fonts/number.ttf", 18)

	var_27_0:setAnchorPoint(cc.p(1, 1))
	var_27_0:setPosition(cc.p(630 + GameDisplay.fix_x, GameDisplay.height - 5))
	self:addChild(var_27_0, 2)

	local var_27_1 = ccui.Layout:create()

	var_27_1:setContentSize(cc.size(500, 40))
	var_27_1:setAnchorPoint(cc.p(1, 1))
	var_27_1:setPosition(cc.p(630 + GameDisplay.fix_x, GameDisplay.height - 5))
	var_27_1:setTouchEnabled(true)
	self:addChild(var_27_1, 3)
	var_27_1:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		DeviceManager.openURL("https://beian.miit.gov.cn/#/Integrated/index")
	end)

	local var_27_2 = cc.Label:createWithTTF(string.format(L_VERSION, config.version), "fonts/number.ttf", 20)

	var_27_2:setAnchorPoint(cc.p(1, 1))
	var_27_2:setPosition(cc.p(630 + GameDisplay.fix_x, GameDisplay.height - 30))
	self:addChild(var_27_2, 2)

	local var_27_3, var_27_4, var_27_5, var_27_6 = login_bg_manager:getLoginBg()

	self:addChild(var_27_3, 2)
	self:addChild(var_27_4)

	self.loginwaitpath = var_27_5.waitpath
	self.loginlightpath = var_27_5.lightpath

	self:playBGM(var_27_6)
end

function LoginScene.playBGM(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 or LOADING_BGM

	audio_manager:loadAudio(arg_29_1 .. ".ogg", function()
		audio_manager:playbackgroundMusic(arg_29_1, true)
	end)
end

function LoginScene:initLoginLayer()
	local var_31_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "login.json" or "login.ExportJson")

	self:addChild(var_31_0, 1)

	self.panelList = {}
	self.panelList.enter = ccui.Helper:seekWidgetByName(var_31_0, "panel_enter")

	self.panelList.enter:setVisible(false)
	self.panelList.enter:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))

	self.panelList.choose = ccui.Helper:seekWidgetByName(var_31_0, "panel_login")

	self.panelList.choose:setVisible(false)

	self.panelList.activate = ccui.Helper:seekWidgetByName(var_31_0, "panel_activate")

	self.panelList.activate:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.panelList.activate:getChildByName("fitpanel"):setPositionY(GameDisplay.fit_y)
	self.panelList.activate:getChildByName("fitpanel"):setCascadeOpacityEnabled(true)
	self.panelList.activate:setVisible(false)

	self.panelList.selectserver = ccui.Helper:seekWidgetByName(var_31_0, "panel_selectserver")

	self.panelList.selectserver:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.panelList.selectserver:getChildByName("panelbg"):setPositionY(GameDisplay.cy)
	self.panelList.selectserver:setVisible(false)

	self.panelList.switchaccount = self:createPanelSwitchAccount()

	self.panelList.switchaccount:setVisible(false)

	if config.packagechannel == "palmpi" then
		self:initPalmpiAccountLayer()
	end

	for iter_31_0, iter_31_1 in pairs(self.panelList) do
		iter_31_1:setOpacity(0)
	end

	ccui.Helper:seekWidgetByName(var_31_0, "label_id_num"):setPositionY(GameDisplay.height - 10 - 55)

	local var_31_2 = account_manager:getChannel()
	local var_31_3 = ccui.Button:create("mainScenebg/login/setting/btn_privacy_2.png", nil, "mainScenebg/login/setting/btn_privacy_2.png")

	var_31_3:setAnchorPoint(cc.p(1, 0.5))
	var_31_3:setPosition(cc.p(630, GameDisplay.height - 105))
	self:addChild(var_31_3, 10)
	var_31_3:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkPrivacy()
	end)

	local var_31_4 = ccui.Helper:seekWidgetByName(var_31_0, "Button_7")

	var_31_4:loadTextures("mainScenebg/login/setting/btn_switch.png", "mainScenebg/login/setting/btn_switch.png", "mainScenebg/login/setting/btn_switch.png")
	var_31_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_4:setPositionX(610)
	var_31_4:setPositionY(GameDisplay.height - 75 - 130)

	local var_31_5 = ccui.Button:create("mainScenebg/login/setting/btn_setting.png", nil, "mainScenebg/login/setting/btn_setting.png")

	var_31_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_5:setPosition(cc.p(610, GameDisplay.height - 75 - 80))
	self.panelList.enter:addChild(var_31_5, 10)
	var_31_5:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showSettingPanel()
	end)

	local var_31_6 = ccui.Button:create("mainScenebg/login/setting/btn_notice.png", nil, "mainScenebg/login/setting/btn_notice.png")

	var_31_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_6:setPosition(cc.p(610, GameDisplay.height - 75 - 180))
	self.panelList.enter:addChild(var_31_6, 10)
	var_31_6:addTouchEventListener(function(arg_34_0, arg_34_1)
		local var_34_0

		if arg_34_1 ~= ccui.TouchEventType.ended then
			do return end

			var_34_0 = account_manager:getServerID() or 1
		end

		local var_34_1 = string.format("http://horcruxgm.aojiaostudio.com/noticeSite/newsList.html?server=%d&channel=%s", var_34_0, account_manager:getChannel())

		if DeviceManager.platform == "windows" then
			DeviceManager.openURL(var_34_1)
		else
			self:createNotice(var_34_1)
		end
	end)

	local var_31_7 = ccui.Button:create("mainScenebg/login/setting/btn_service.png", nil, "mainScenebg/login/setting/btn_service.png")

	var_31_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_7:setPosition(cc.p(610, GameDisplay.height - 75 - 230))
	self.panelList.enter:addChild(var_31_7, 10)
	var_31_7:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if DeviceManager.getPackageChannel() == "FY" then
			local var_35_0 = account_manager:getUserID()

			if var_35_0 then
				FeiyuManager.showServiceBeforeEnterGame(var_35_0)
			else
				FeiyuManager.showServiceBeforeLogin()
			end
		else
			DeviceManager.openURL(global_get_custom_jump_url())
		end
	end)

	if ({
		["270057"] = true,
		["270048"] = true,
		["270054"] = true,
		["270055"] = true
	})[DeviceManager.getChannelID()] then
		var_31_7:setVisible(false)
	else
		var_31_7:setVisible(true)
	end

	local var_31_8 = ccui.Button:create("mainScenebg/loginwarn.png")

	var_31_8:setPosition(cc.p(20, 80))
	var_31_8:setAnchorPoint(cc.p(0, 0.5))
	var_31_8:setScale(0.1)
	self:addChild(var_31_8, 2)
	var_31_8:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		DeviceManager.openURL("https://www.h-college.com/privacyChild.html")
	end)

	local var_31_9 = cc.Label:createWithTTF("", FONT_DES, 12)

	var_31_9:setAnchorPoint(cc.p(0.5, 1))
	var_31_9:setString("本网络游戏适合年满16周岁以上用户使用：请您确定已如实进行实名注册。为了您的健康，请合理控制游戏时间。抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。")
	var_31_9:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_31_9:setDimensions(400, 0)
	var_31_9:setPosition(cc.p(320, 55))
	var_31_9:setOpacity(100)
	self:addChild(var_31_9, 2)
end

function LoginScene:showSettingPanel()
	if not self.panelSetting then
		self:createSetingPanel()
	end

	self.panelSetting:setVisible(true)
end

function LoginScene:hideSettingPanel()
	if not self.panelSetting then
		return
	end

	self.panelSetting:setVisible(false)
end

function LoginScene:createSetingPanel()
	local var_39_0 = ccui.Layout:create()

	var_39_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_39_0:setTouchEnabled(true)
	self:addChild(var_39_0, 5)
	var_39_0:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:hideSettingPanel()
	end)

	local var_39_1 = ccui.ImageView:create("mainScenebg/login/setting/bg.png")

	var_39_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_39_0:addChild(var_39_1)

	local var_39_2 = var_39_1:getContentSize().width / 2

	local function var_39_3(arg_42_0)
		local var_42_0, var_42_1, var_42_2, var_42_3 = arg_42_0:match("(%d+).(%d+).(%d+).(%d+)")

		if GAME_STORAGE_FOLDER then
			return string.format("%s/v%s%s/", GAME_STORAGE_FOLDER, var_42_0, var_42_1)
		else
			return string.format("v%s%s/", var_42_0, var_42_1)
		end
	end

	local function var_39_4()
		return cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_39_3(config.version)
	end

	local var_39_5 = {
		{
			"btn_download.png",
			cc.p(var_39_2 - 120, 320),
			function(arg_41_0, arg_41_1)
				if arg_41_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:generateAllLackResources()
			end
		},
		{
			"btn_clean.png",
			cc.p(var_39_2 + 120, 320),
			function(arg_44_0, arg_44_1)
				if arg_44_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_44_0 = L_LOGOUT_MSG[5].Title

				require("view.Layer.DialogLayer")
				self:addChild(DialogLayer:create(var_44_0, "是否清除缓存数据", 500, 250, function()
					local var_45_0 = var_39_4()

					print("RemoveDir: ", var_45_0)
					cc.FileUtils:getInstance():removeDirectory(var_45_0)
					require("view.Scene.RestartScene")
					cc.Director:getInstance():replaceScene(RestartScene:createScene(true))
				end, nil, true), 10001)
			end
		},
		{
			"btn_privacy.png",
			cc.p(var_39_2 - 120, 320 - 100),
			function(arg_46_0, arg_46_1)
				if arg_46_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:checkPrivacy()
			end
		},
		{
			"btn_logoff.png",
			cc.p(var_39_2 + 120, 320 - 100),
			function(arg_49_0, arg_49_1)
				if arg_49_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_49_0 = "如您申请注销《魂器学院》游戏账号，请联系客服。企业QQ："

				var_49_0 = account_manager:getChannel() == "270048" and var_49_0 .. "800864530" or var_49_0 .. "509220336"

				self:openLogOffPanel({
					content = var_49_0
				})
			end
		},
		{
			"btn_custom.png",
			cc.p(var_39_2 + 120, 320 - 200),
			function(arg_47_0, arg_47_1)
				if arg_47_1 ~= ccui.TouchEventType.ended then
					return
				end

				if account_manager:getChannel() == "270048" then
					return
				end

				if DeviceManager.getPackageChannel() == "FY" then
					local var_47_0 = account_manager:getUserID()

					if var_47_0 then
						FeiyuManager.showServiceBeforeEnterGame(var_47_0)
					else
						FeiyuManager.showServiceBeforeLogin()
					end
				else
					DeviceManager.openURL(global_get_custom_jump_url())
				end
			end
		}
	}
	local var_39_6 = account_manager:getChannel()

	if ({
		["270001"] = true,
		palmpi = true,
		["270096"] = true,
		["270049"] = true,
		["1000"] = true
	})[var_39_6] then
		table.insert(var_39_5, {
			"btn_bindmail.png",
			cc.p(var_39_2 - 120, 320 - 200),
			function(arg_48_0, arg_48_1)
				if arg_48_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_48_0 = "https://passport.737.com/migrate/email/login"

				if DeviceManager.platform == "windows" then
					DeviceManager.openURL(var_48_0)
				else
					self:createNotice(var_48_0)
				end
			end
		})
	end

	for iter_39_0, iter_39_1 in ipairs(var_39_5) do
		local var_39_7 = ccui.Button:create("mainScenebg/login/setting/" .. iter_39_1[1], nil, "mainScenebg/login/setting/" .. iter_39_1[1])

		var_39_7:setPosition(iter_39_1[2])
		var_39_1:addChild(var_39_7)
		var_39_7:addTouchEventListener(iter_39_1[3])

		if iter_39_1[1] == "btn_custom.png" then
			var_39_7:setVisible(false)
		end

		if iter_39_1[1] == "btn_logoff.png" then
			var_39_7:setVisible(var_39_6 ~= "270057")
		end
	end

	self.panelSetting = var_39_0
end

function LoginScene:openLogOffPanel(arg_50_1)
	self:hideSettingPanel()

	if self.logOffPanel == nil then
		self.logOffPanel = ccui.Layout:create()

		self.logOffPanel:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
		self.logOffPanel:setName("logOffPanel")
		self:addChild(self.logOffPanel, 999)
		self.logOffPanel:setTouchEnabled(true)
		self.logOffPanel:addTouchEventListener(function(arg_51_0, arg_51_1)
			if arg_51_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.logOffPanel:setVisible(false)
			self:showSettingPanel()
		end)

		local var_50_0 = ccui.ImageView:create("mainScenebg/login/setting/bg.png")

		var_50_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		var_50_0:setTouchEnabled(true)
		self.logOffPanel:addChild(var_50_0)

		local var_50_1 = ccui.Text:create("???", FONT_NAME, 22)

		var_50_1:setName("content")
		var_50_1:setPosition(cc.p(GameDisplay.cx + 10, GameDisplay.cy))
		var_50_1:setContentSize(cc.size(480, 200))
		var_50_1:ignoreContentAdaptWithSize(false)

		local var_50_2, var_50_3 = var_50_1:getPosition()

		self.logOffPanel:addChild(var_50_1)
	end

	self.logOffPanel:setVisible(true)
	self.logOffPanel:getChildByName("content"):setString(arg_50_1.content or "")
end

function LoginScene:generateAllLackResources()
	require("view.Layer.DownloadAllAssetsLayer")

	if self.statementPanel then
		self.statementPanel:runAction(cc.RemoveSelf:create())
	end

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_ALL_RESOURCE_DOWNLOAD_COMPLETE", function(arg_53_0)
		self:hideSettingPanel()
	end), self)
	self:addChild(DownloadAllAssetsLayer:create(), 100)
end

function LoginScene:createPanelSwitchAccount()
	local var_54_0 = ccui.Layout:create()

	var_54_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_54_0:setTouchEnabled(true)
	self:addChild(var_54_0, 1)

	local var_54_1 = ccui.ImageView:create("login/bg_switchaccount.png", config._DEBUG and 0 or 1)

	var_54_1:setName("bg")
	var_54_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_54_0:addChild(var_54_1)

	local var_54_2 = ccui.Button:create("login/btn_switchaccount.png", nil, "login/btn_switchaccount.png", config._DEBUG and 0 or 1)

	var_54_2:setName("switchaccount")
	var_54_2:setPosition(cc.p(var_54_1:getContentSize().width / 2 - 130, var_54_1:getContentSize().height / 2))

	local var_54_3 = cc.Label:createWithTTF("切换账号", FONT_DES, 28)

	var_54_3:setColor(cc.c3b(0, 0, 0))
	var_54_3:setPosition(cc.p(var_54_2:getContentSize().width / 2, var_54_2:getContentSize().height / 2))
	var_54_2:addChild(var_54_3)
	var_54_1:addChild(var_54_2, 1)

	local var_54_4 = ccui.Button:create("login/btn_switchplayer.png", nil, "login/btn_switchplayer.png", config._DEBUG and 0 or 1)

	var_54_4:setName("switchplayer")
	var_54_4:setPosition(cc.p(var_54_1:getContentSize().width / 2 + 130, var_54_1:getContentSize().height / 2))

	local var_54_5 = cc.Label:createWithTTF("切换角色", FONT_DES, 28)

	var_54_5:setColor(cc.c3b(0, 0, 0))
	var_54_5:setPosition(cc.p(var_54_4:getContentSize().width / 2, var_54_4:getContentSize().height / 2))
	var_54_4:addChild(var_54_5)
	var_54_1:addChild(var_54_4, 1)

	if DeviceManager.getChannelID() == "270111" then
		var_54_2:setVisible(false)
		var_54_4:setPositionX(var_54_1:getContentSize().width / 2)
	end

	return var_54_0
end

function LoginScene:initKeyEvent()
	local var_55_0 = cc.EventListenerKeyboard:create()

	if DeviceManager.getPackageChannel() == "FY" then
		var_55_0:registerScriptHandler(function(arg_56_0, arg_56_1)
			if arg_56_0 ~= cc.KeyCode.KEY_BACK then
				return
			end

			if self:getChildByName("BACK_LAYER") then
				return
			end

			local function var_56_0()
				FeiyuManager.logout()
				TrackingManager.exit()
				cc.Director:getInstance():endToLua()
			end

			FeiyuManager.registerExitGameHandler(function(arg_58_0)
				if arg_58_0 ~= 0 then
					require("view.Layer.DialogLayer")

					local var_58_0 = DialogLayer:create(L_LOGIN_EXIT_DIALOG.Title, L_LOGIN_EXIT_DIALOG.Content, 500, 200, var_56_0, nil, true)

					var_58_0:setName("BACK_LAYER")
					var_58_0:setAnchorPoint(cc.p(0.5, 0.5))
					self:addChild(var_58_0, 10005)
				else
					var_56_0()
				end
			end)
			FeiyuManager.exitgame()
		end, cc.Handler.EVENT_KEYBOARD_RELEASED)
	else
		var_55_0:registerScriptHandler(global_on_key_exit_game, cc.Handler.EVENT_KEYBOARD_RELEASED)
	end

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_55_0, self)
end

function LoginScene:onEnterLoginScene(arg_59_1)
	local function var_59_0()
		self:playerLogin()
	end

	local function var_59_1()
		self._netconnected = false

		if arg_59_1 == 4 then
			self:playerLogin()
		elseif arg_59_1 == 6 then
			self:playerLogin()
		elseif arg_59_1 == "switchplayer" then
			self:onSwitchPlayer()
		elseif arg_59_1 == "feiyuswitchaccount" then
			self:onSwitchAccount()
		elseif arg_59_1 == "accountlogout" then
			self:switchPanel("choose")
		elseif arg_59_1 == "feiyulogoutaccount" then
			self:playerLogOut()
		else
			self:switchPanel("selectserver")
		end
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		if arg_59_1 then
			var_59_1(arg_59_1)
		else
			var_59_0()
		end

		if #WELCOME_SOUND > 0 then
			audio_manager:playeffectMusic("role_voice/" .. WELCOME_SOUND[#WELCOME_SOUND > 1 and math.random(1, #WELCOME_SOUND) or 1], false, 1)
		end
	end)))
end

function LoginScene:switchPanel(arg_63_1, ...)
	if arg_63_1 == "selectserver" then
		return
	end

	if self.curpanel then
		self.panelList[self.curpanel]:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create()))
	end

	self.curpanel = arg_63_1

	print("switchPanel: ", arg_63_1)
	self.panelList[arg_63_1]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.FadeIn:create(0.2)))

	if self["initPanel" .. arg_63_1] then
		self["initPanel" .. arg_63_1](self, ...)
	end
end

function LoginScene:initPanelchoose()
	local var_64_0 = self.panelList.choose:getChildByName("button_guest")
	local var_64_1 = self.panelList.choose:getChildByName("button_accout")

	if config.packagechannel ~= "palmpi" then
		var_64_0:setVisible(false)
		var_64_1:setAnchorPoint(cc.p(0.5, 0))
		var_64_1:setPositionX(320)
		var_64_1:loadTextures("mainScenebg/btn_login.png", "mainScenebg/btn_login.png", "mainScenebg/btn_login.png")
		var_64_1:getChildByName("label_accout"):setVisible(false)
	end

	var_64_0:addTouchEventListener(function(arg_65_0, arg_65_1)
		if arg_65_1 ~= ccui.TouchEventType.ended then
			return
		end

		if config.packagechannel ~= "palmpi" then
			return
		end

		if self:needCheckHuaweiPrivacy() then
			self:showPrivacyInfo()
		else
			self:connectToChannelServer()
		end
	end)
	var_64_1:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:needCheckHuaweiPrivacy() then
			self:showPrivacyInfo()
		else
			self:showAccountPanel()
		end
	end)
end

local var_0_9 = {
	"login/tag_maintain.png",
	"login/tag_smooth.png",
	"login/tag_crowed.png"
}
local var_0_10 = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九",
	"十"
}

function LoginScene:initPanelenter()
	local var_67_0 = account_manager:getUserPlayerid()

	print("initPanelEnter: ", var_67_0)

	local var_67_1 = self.panelList.enter

	self.panelList.enter:setBright(true)

	if var_67_0 then
		var_67_1:getChildByName("label_id_num"):setVisible(true)
		var_67_1:getChildByName("label_id_num"):setString("编号: " .. var_67_0)
	else
		var_67_1:getChildByName("label_id_num"):setVisible(false)
	end

	local var_67_2 = var_67_1:getChildByName("btn_select_server")
	local var_67_3 = account_manager:getServerInfo()

	var_67_2:getChildByName("img_tag"):loadTexture(var_0_9[var_67_3.tag + 1], config._DEBUG and 0 or 1)
	var_67_2:getChildByName("label_name"):setString(var_67_3.name)
	var_67_2:getChildByName("label_id"):setString(var_0_10[var_67_3.id] .. "区")
	var_67_2:setVisible(false)
	var_67_2:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._activitylock then
			return
		end

		if self._loginlock then
			return
		end

		self:switchPanel("selectserver")
	end)
	var_67_1:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._activitylock then
			return
		end

		if self._loginlock then
			return
		end

		if not arg_69_0:isBright() then
			return
		end

		arg_69_0:setBright(false)

		if account_manager.playerNeedRealName then
			-- block empty
		end

		if account_manager:getAccountPlayerRealCount() <= 1 then
			(function()
				local function var_70_0(arg_71_0)
					AnalyticManager.entergame(account_manager:collectPlayerInfoOnLogin(arg_71_0))
					require("view.Scene.LoadingScene")
					cc.Director:getInstance():replaceScene(LoadingScene:createScene(arg_71_0))
				end

				account_manager:login(account_manager:getUserPlayerIndex(), function(arg_72_0, arg_72_1)
					if arg_72_0 == 1 then
						var_70_0(arg_72_1)
					else
						arg_69_0:setBright(true)

						if arg_72_1 then
							self:showErrMsg(arg_72_1)
						end
					end
				end)
			end)()
		else
			self:showUserPlayerInfoLayer()
		end
	end)
	var_67_1:getChildByName("Button_7"):addTouchEventListener(function(arg_73_0, arg_73_1)
		if arg_73_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel("switchaccount")
	end)

	if account_manager:getChannel() == "270049" and tonumber(DeviceManager.getPackageAssetsVersion()) < 23 then
		self:showUpdateAlertLayer()
	end
end

function LoginScene:showUpdateAlertLayer()
	local var_74_0 = ccui.Layout:create()

	var_74_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_74_0:setTouchEnabled(true)
	var_74_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_74_0:setBackGroundColor(cc.c3b(10, 10, 10))
	var_74_0:setBackGroundColorOpacity(100)
	self:addChild(var_74_0, 100)

	local var_74_1 = ccui.ImageView:create("mainScenebg/activity/popsdkupdate/bg1.png")

	var_74_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_74_0:addChild(var_74_1)
	var_74_0:addTouchEventListener(function(arg_75_0, arg_75_1)
		if arg_75_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	local var_74_2 = account_manager:getChannel()
	local var_74_3 = ({
		["270051"] = "https://www.h-college.com",
		["270096"] = "https://www.h-college.com",
		["270054"] = "https://appgallery.huawei.com/app/C100822287",
		["270050"] = "https://www.3839.com/a/90063.htm",
		["270057"] = "https://app.mi.com/details?id=com.feiyu.hcollege.mi",
		["270001"] = "https://apps.apple.com/cn/app/id1455051196",
		["270061"] = "http://m.appstore.nubia.com/detailedness.html?SoftId=1690942&SoftItemId=4547108",
		["270058"] = "http://app.flyme.cn/games/public/detail?package_name=com.feiyu.hcollege.mz",
		palmpi = "https://www.h-college.com",
		["270048"] = "https://www.biligame.com/detail/?id=102020",
		["1000"] = "https://www.h-college.com",
		["270060"] = "http://a.app.qq.com/o/simple.jsp?pkgname=com.tencent.tmgp.hqxy",
		["270052"] = "https://www.9game.cn/hqxy/",
		["270049"] = "https://www.taptap.com/app/42949",
		["270086"] = "https://www.lenovomm.com/appdetail/com.feiyu.hcollege.lenovo/0",
		["270056"] = "https://game.vivo.com.cn/#detail/70535",
		["270053"] = "http://a.4399.cn/game-id-103034.html",
		["270104"] = "https://www.ourplay.net/rank/detail/118641"
	})[var_74_2]

	if var_74_3 then
		local var_74_4 = ccui.Button:create("mainScenebg/activity/popsdkupdate/btn_sure.png", "mainScenebg/activity/popsdkupdate/btn_sure.png", "mainScenebg/activity/popsdkupdate/btn_sure.png")

		var_74_4:setPosition(cc.p(var_74_1:getContentSize().width / 2, 150))
		var_74_1:addChild(var_74_4)
		var_74_4:addTouchEventListener(function(arg_76_0, arg_76_1)
			if arg_76_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_74_2 == "270049" and cc.Native:hasInstalledTapTap() then
				DeviceManager.openURL("taptap://taptap.com/app?app_id=42949&source=outer|update")
			else
				DeviceManager.openURL(var_74_3)
			end
		end)
	end
end

function LoginScene:initPanelswitchaccount()
	local var_77_0 = self.panelList.switchaccount

	self.panelList.switchaccount:addTouchEventListener(function(arg_78_0, arg_78_1)
		if arg_78_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel("enter")
	end)
	self.panelList.switchaccount:getChildByName("bg"):getChildByName("switchaccount"):addTouchEventListener(function(arg_79_0, arg_79_1)
		if arg_79_1 ~= ccui.TouchEventType.ended then
			return
		end

		if config.packagechannel == "palmpi" then
			return
		end

		local function var_79_0(arg_80_0)
			self:stopConnectAni()

			if arg_80_0 == 1 then
				self:switchPanel("enter")
			elseif arg_80_0 == 3 then
				self:switchPanel("activate")
			else
				self:switchPanel("choose")
			end

			self._activitylock = false
			self._loginlock = false
		end

		local function var_79_1(arg_81_0)
			if arg_81_0 == 1 then
				account_manager:getPlayerData(account_manager:getUserID(), var_79_0)
			else
				self._activitylock = false
				self._loginlock = false

				self:stopConnectAni()
			end
		end

		self:activityLock()
		account_manager:switchaccount(function(arg_82_0, arg_82_1, arg_82_2)
			if arg_82_0 == 1 then
				self._loginlock = true

				self:playConnectAni()
				account_manager:verifyChannelPlayerid(arg_82_1, arg_82_2, var_79_1)
			end

			self._activitylock = false
		end)
	end)
	self.panelList.switchaccount:getChildByName("bg"):getChildByName("switchplayer"):addTouchEventListener(function(arg_83_0, arg_83_1)
		if arg_83_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_83_0:isBright() then
			return
		end

		arg_83_0:setBright(false)

		if account_manager.playerNeedRealName then
			-- block empty
		end

		;(function()
			var_77_0:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create()))
			self:showUserPlayerInfoLayer()
		end)()
	end)
end

function LoginScene:showRealNameDialog()
	require("view.Layer.DialogLayer")

	local var_85_0 = DialogLayer:create(L_LOGOUT_MSG[6].Title, L_LOGOUT_MSG[6].Info, 500, 200, function()
		FeiyuManager.realName(account_manager:getUserID(), account_manager.realNameInfo.identityName, account_manager.realNameInfo.identityNo, account_manager.realNameInfo.identityBirthday, account_manager.realNameInfo.identityAge)
	end, nil, true)

	var_85_0:setAnchorPoint(cc.p(0.5, 0.5))
	self:addChild(var_85_0, 10004)
end

local function var_0_11(arg_87_0)
	local var_87_0 = ccui.Button:create("login/bg_server.png", nil, "login/bg_server.png", config._DEBUG and 0 or 1)
	local var_87_1 = ccui.ImageView:create("login/img_crowed.png", config._DEBUG and 0 or 1)

	var_87_1:setName("img_tag")
	var_87_1:setPosition(cc.p(var_87_0:getContentSize().width / 2 - 156, var_87_0:getContentSize().height / 2))
	var_87_0:addChild(var_87_1)

	local var_87_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 24)

	var_87_2:setName("label_id")
	var_87_2:setAnchorPoint(cc.p(0, 0.5))
	var_87_2:setPosition(cc.p(var_87_0:getContentSize().width / 2 - 138, var_87_0:getContentSize().height / 2))
	var_87_0:addChild(var_87_2)

	local var_87_3 = cc.Label:createWithTTF("", "fonts/number.ttf", 24)

	var_87_3:setName("label_name")
	var_87_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_87_3:setPosition(cc.p(var_87_0:getContentSize().width / 2, var_87_0:getContentSize().height / 2))
	var_87_0:addChild(var_87_3)

	local var_87_4 = ccui.ImageView:create("role/wuji/2100.png")

	var_87_4:setName("img_role")
	var_87_4:setScale(0.4)
	var_87_4:setPosition(cc.p(var_87_0:getContentSize().width / 2 + 110, var_87_0:getContentSize().height / 2 + 8))
	var_87_0:addChild(var_87_4)

	local var_87_5 = cc.Label:createWithTTF("", "fonts/number.ttf", 20)

	var_87_5:setName("label_num")
	var_87_5:setAnchorPoint(cc.p(0, 0.5))
	var_87_5:setPosition(cc.p(var_87_0:getContentSize().width / 2 + 150, var_87_0:getContentSize().height / 2))
	var_87_0:addChild(var_87_5)

	local var_87_6 = ccui.ImageView:create("login/tag_recommend.png", config._DEBUG and 0 or 1)

	var_87_6:setName("img_recommend")
	var_87_6:setPosition(cc.p(var_87_0:getContentSize().width / 2 - 168, var_87_0:getContentSize().height / 2 + 24))
	var_87_0:addChild(var_87_6, 2)
	arg_87_0:addChild(var_87_0)

	return var_87_0
end

function LoginScene.update_server_btn(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	arg_88_2 = arg_88_2 or var_0_11(arg_88_3)

	arg_88_2:getChildByName("img_tag"):loadTexture(var_0_9[arg_88_1.tag + 1], config._DEBUG and 0 or 1)
	arg_88_2:getChildByName("img_recommend"):setVisible(arg_88_1.recommend ~= nil)
	arg_88_2:getChildByName("label_id"):setString(var_0_10[arg_88_1.id] .. "区")
	arg_88_2:getChildByName("label_name"):setString(arg_88_1.name)

	if arg_88_1.rolenum and arg_88_1.rolenum > 0 then
		arg_88_2:getChildByName("img_role"):loadTexture("role/wuji/2100.png")
		arg_88_2:getChildByName("img_role"):setVisible(true)
		arg_88_2:getChildByName("label_num"):setString("x" .. arg_88_1.rolenum)
		arg_88_2:getChildByName("label_num"):setVisible(true)
	else
		arg_88_2:getChildByName("img_role"):setVisible(false)
		arg_88_2:getChildByName("label_num"):setVisible(false)
	end

	arg_88_2:addTouchEventListener(function(arg_89_0, arg_89_1)
		if arg_89_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("Select Server: ", arg_88_1.id)

		if arg_88_0._switchingserver then
			return
		end

		if arg_88_1.id == account_manager:getServerInfo().id and network:isConnected() then
			arg_88_0:switchPanel("enter")
		else
			arg_88_0:selectServer(arg_88_1.id)
		end
	end)

	return arg_88_2
end

function LoginScene:initPanelselectserver()
	self.panelList.selectserver:addTouchEventListener(function(arg_91_0, arg_91_1)
		if arg_91_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel("enter")
	end)

	self.serverlist = self.serverlist or {}

	if self._getting_serverlist then
		return
	end

	local var_90_0 = self.panelList.selectserver:getChildByName("panelbg")

	var_90_0:getChildByName("panel_close"):setVisible(false)
	var_90_0:getChildByName("panel_all"):setVisible(false)

	self._getting_serverlist = true

	account_manager:getServerList(function(arg_92_0, arg_92_1, arg_92_2)
		if arg_92_0 == 0 then
			print("Get List Error!!!!!!")

			return
		end

		local var_92_0 = account_manager:getServerInfo()
		local var_92_1 = false

		if arg_92_2 then
			self:update_server_btn(arg_92_2, var_90_0:getChildByName("panel_close"):getChildByName("btn_server"), var_90_0:getChildByName("panel_close"))

			var_92_1 = true
		end

		var_90_0:getChildByName("panel_close"):setVisible(var_92_1)
		var_90_0:getChildByName("panel_all"):setVisible(true)

		local var_92_2 = var_90_0:getChildByName("panel_all"):getChildByName("panel_list")

		var_90_0:getChildByName("panel_all"):setPositionY((var_92_1 or nil) and (var_90_0:getContentSize().height / 2 - 17 or var_90_0:getContentSize().height / 2 - 17 + 130))
		var_92_2:setPositionY(var_92_1 and -300 or -430)

		local var_92_3 = 40
		local var_92_4 = math.max(var_92_1 and 450 or 580, var_92_3 + 70 * #arg_92_1)

		var_92_2:setContentSize(cc.size(500, var_92_1 and 450 or 580))
		var_92_2:setInnerContainerSize(cc.size(500, var_92_4))

		for iter_92_0, iter_92_1 in ipairs(arg_92_1) do
			self.serverlist[iter_92_1.id] = self:update_server_btn(iter_92_1, self.serverlist[iter_92_1.id], var_92_2)

			self.serverlist[iter_92_1.id]:setPosition(cc.p(250, var_92_4 - var_92_3 - 70 * (iter_92_0 - 1)))
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			self._getting_serverlist = false
		end)))
	end)
end

function LoginScene:showErrMsg(arg_94_1)
	local var_94_0 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", config._DEBUG and 0 or 1)

	var_94_0:setPosition(320, GameDisplay.height / 2)
	self:addChild(var_94_0, 999)

	local var_94_1 = cc.Label:createWithTTF(arg_94_1 or "SDK LOGIN ERROR", "fonts/number.ttf", 27)

	var_94_1:setPosition(var_94_0:getContentSize().width / 2, var_94_0:getContentSize().height / 2)
	var_94_0:addChild(var_94_1)

	local var_94_2 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", config._DEBUG and 0 or 1)

	var_94_2:setPosition(var_94_0:getContentSize().width / 2, -var_94_2:getContentSize().height / 2 - 10)
	var_94_0:addChild(var_94_2)
	var_94_2:addTouchEventListener(function(arg_95_0, arg_95_1)
		if arg_95_1 ~= ccui.TouchEventType.ended then
			return false
		end

		var_94_0:runAction(cc.RemoveSelf:create())
	end)

	local var_94_3 = cc.Label:createWithTTF(L_BUTTON_TEXT.Item_Panel_Btn.Sure, "fonts/newkj.ttf", 28)

	var_94_3:setColor(cc.c3b(0, 0, 0))
	var_94_3:setPosition(var_94_2:getContentSize().width / 2 - 5, var_94_2:getContentSize().height / 2 - 5)
	var_94_2:addChild(var_94_3)
end

local function var_0_12(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4, arg_96_5, arg_96_6, arg_96_7, arg_96_8)
	local var_96_0 = cc.EditBox:create(arg_96_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_96_0:setName(arg_96_0)
	var_96_0:setPosition(arg_96_8)
	var_96_0:setAnchorPoint(cc.p(0, 0.5))
	var_96_0:setFontName(arg_96_3)
	var_96_0:setPlaceholderFont(arg_96_3, arg_96_2)
	var_96_0:setFontSize(arg_96_2)
	var_96_0:setFontColor(cc.c3b(255, 255, 255))
	var_96_0:setPlaceHolder(arg_96_4)
	var_96_0:setPlaceholderFontColor(cc.c3b(77, 79, 107))
	var_96_0:setMaxLength(arg_96_5)
	var_96_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_96_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_96_0:setInputFlag(arg_96_6)
	arg_96_1:addChild(var_96_0, 22)

	return var_96_0
end

function LoginScene:initPanelactivate()
	local var_97_0 = self.panelList.activate:getChildByName("fitpanel")
	local var_97_1 = var_97_0:getChildByName("input_name")

	var_97_1:getChildByName("input_describle"):setVisible(false)

	self.activatecode = self.activatecode or var_0_12("activatecode", var_97_1, 20, "fonts/W5.ttf", L_INPUT_ACTIVATION_CODE, 20, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(75, -2))

	var_97_0:getChildByName("button_return"):addTouchEventListener(function(arg_98_0, arg_98_1)
		if arg_98_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_98_0:isBright() then
			return
		end

		local var_98_0 = self.activatecode:getText()

		if string.len(var_98_0) <= 0 then
			return
		end

		arg_98_0:setBright(false)
		account_manager:activate_user(var_98_0, function(arg_99_0)
			if arg_99_0 == 1 then
				self:switchPanel("enter")
			else
				self.activatecode:setText("")

				if arg_99_0 == 2 then
					global_ShowBlockWords(L_ACTIVATION_CODE_ERROR[2])
				elseif arg_99_0 == 3 then
					global_ShowBlockWords(L_ACTIVATION_CODE_ERROR[3])
				elseif arg_99_0 == 4 then
					global_ShowBlockWords(L_ACTIVATION_CODE_ERROR[4])
				end
			end

			arg_98_0:setBright(true)
		end)
	end)
end

function LoginScene:registerCustomEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_101_0)
		self:onEnterForeground(arg_101_0.backtime)
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERBACKGROUND", function()
		self:onEnterBackground()
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("LOGOUT", function(arg_103_0)
		self:logout(arg_103_0.logouttype)
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ONREALNAME", function(arg_104_0)
		return
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("NEED_CLIENT_V3", function(arg_105_0)
		self:onNeedNewClient(arg_105_0.downloadurl)
	end), self)

	if config.packagechannel == "palmpi" then
		require("network.net_dispatcher"):registerListener(function(arg_106_0)
			hx_print("-----------------【服务器错误】-------------------")
			hx_print(dump(arg_106_0))
			hx_print("--------------------------------------------------")
		end, "service_error")
	end
end

function LoginScene:activityLock()
	self._activitylock = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self._activitylock = false
	end)))
end

function LoginScene:onEnterForeground()
	self._activitylock = false

	if not self._netconnected then
		return
	end

	network:checkconnection(function(arg_110_0)
		if arg_110_0 then
			return
		end

		self:endConnectionCheck()
		self:logout(4)
	end)
end

function LoginScene.onEnterBackground(arg_111_0)
	return
end

function LoginScene:logout(arg_112_1)
	if arg_112_1 == 6 then
		return
	end

	network:closeOnLogout()
	self:endConnectionCheck()
	self:stopConnectAni()

	self._netconnected = false

	if arg_112_1 == 5 then
		self:needRestartGame()
	else
		self:playerLogOut()
	end
end

function LoginScene:needRestartGame()
	require("view.Layer.DialogLayer")
	self:addChild(DialogLayer:create(L_LOGOUT_MSG[5].Title, L_LOGOUT_MSG[5].Info, 500, 250, function()
		global_restart_game()
	end), 10001)
end

function LoginScene:startConnectionCheck()
	self._checkscheduler = self._checkscheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		network:checkconnection(function(arg_117_0)
			if arg_117_0 then
				return
			end

			self:endConnectionCheck()
			self:logout(4)
		end)
	end, 30, false)
end

function LoginScene:endConnectionCheck()
	if self._checkscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._checkscheduler)

		self._checkscheduler = nil
	end
end

function LoginScene:playerLogin()
	self._netconnected = false

	self.panelList.choose:setVisible(false)
	self:connectToChannelServer()
end

function LoginScene.needCheckHuaweiPrivacy(arg_120_0)
	if config.packagechannel ~= "feiyu" then
		return false
	end

	if account_manager:getChannel() ~= "270054" then
		return false
	end

	return not cc.UserDefault:getInstance():getBoolForKey("agreehuaweiprivacy", false)
end

function LoginScene:showPrivacyInfo()
	self:addChild(require("view.Layer.PrivacyInfoLayer"):create(function()
		self:connectToChannelServer()
	end, function()
		self:switchPanel("choose")
	end), 5)
end

function LoginScene.canShowNewCheckPrivacy(arg_124_0)
	if config.packagechannel ~= "feiyu" then
		return false
	end

	if account_manager:getChannel() ~= "270054" then
		return false
	end

	if not FySDK.showPrivacyDialog then
		return false
	end

	return true
end

function LoginScene:checkPrivacy()
	self:addChild(require("view.Layer.CheckPrivacyLayer"):create(), 5)
end

function LoginScene:playerLogOut()
	self._netconnected = false

	self.panelList.choose:setVisible(false)
	self:showAccountPanel()
end

function LoginScene:connectToGameServer(arg_127_1, arg_127_2)
	self:playConnectAni()
	account_manager:verifyChannelPlayerid(arg_127_1, arg_127_2, function(arg_128_0, arg_128_1)
		if arg_128_0 == 1 then
			self:onConnectSuccess(account_manager:getUserID(), arg_127_2)
		else
			self:onConnectFail(arg_128_0, arg_128_1)
		end
	end)
end

function LoginScene:onConnectSuccess(arg_129_1, arg_129_2)
	self._netconnected = true

	self:startConnectionCheck()
	account_manager:getPlayerData(arg_129_1, function(arg_130_0)
		self:stopConnectAni()

		self._switchingserver = false

		if arg_130_0 == 1 then
			self:switchPanel("enter")
		elseif arg_130_0 == 3 then
			self:switchPanel("activate")
		else
			self:switchPanel("choose")
		end
	end)
end

function LoginScene:onConnectFail(arg_131_1, arg_131_2)
	print("onConnectFail: ", arg_131_1, arg_131_2)
	self:stopConnectAni()
	self:switchPanel("choose")

	if arg_131_1 == 0 then
		global_ShowBlockWords(L_CONNECT_FAIL)
	elseif arg_131_1 == 2 then
		if arg_131_2:find("^openweb:") then
			local var_131_0 = string.urldecode((arg_131_2:match("^openweb:(.+)")))

			if DeviceManager.platform == "windows" then
				DeviceManager.openURL(var_131_0)

				return
			end

			local var_131_1 = ccexp.WebView:create()

			var_131_1:setVisible(false)
			var_131_1:setScalesPageToFit(true)
			var_131_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
			var_131_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
			self:addChild(var_131_1, 999)
			var_131_1:loadURL(var_131_0)
			var_131_1:setName("webLayer")
			var_131_1:setOnDidFinishLoading(function(arg_132_0, arg_132_1)
				arg_132_0:setVisible(true)
			end)

			local var_131_2 = ccui.Layout:create()

			var_131_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
			var_131_2:setTouchEnabled(true)
			self:addChild(var_131_2, 998)
		else
			local var_131_3 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", config._DEBUG and 0 or 1)

			var_131_3:setPosition(320, GameDisplay.height / 2)
			self:addChild(var_131_3, 999)

			local var_131_4 = cc.Label:createWithTTF(arg_131_2 or "Connect Game Fail", "fonts/number.ttf", 27)

			var_131_4:setPosition(var_131_3:getContentSize().width / 2, var_131_3:getContentSize().height / 2)
			var_131_3:addChild(var_131_4)

			local var_131_5 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", config._DEBUG and 0 or 1)

			var_131_5:setPosition(var_131_3:getContentSize().width / 2, -var_131_5:getContentSize().height / 2 - 10)
			var_131_3:addChild(var_131_5)
			var_131_5:addTouchEventListener(function(arg_133_0, arg_133_1)
				if arg_133_1 ~= ccui.TouchEventType.ended then
					return false
				end

				var_131_3:runAction(cc.RemoveSelf:create())
			end)

			local var_131_6 = cc.Label:createWithTTF(L_BUTTON_TEXT.Item_Panel_Btn.Sure, "fonts/newkj.ttf", 28)

			var_131_6:setColor(cc.c3b(0, 0, 0))
			var_131_6:setPosition(var_131_5:getContentSize().width / 2 - 5, var_131_5:getContentSize().height / 2 - 5)
			var_131_5:addChild(var_131_6)
			self.panelList.choose:getChildByName("button_guest"):setVisible(false)
			self.panelList.choose:getChildByName("button_accout"):setVisible(false)
		end
	end
end

function LoginScene.connectToChannelServer(arg_134_0)
	account_manager:playerLogin(function(arg_135_0, arg_135_1, arg_135_2)
		if arg_135_0 == 1 then
			arg_134_0:connectToGameServer(arg_135_1, arg_135_2)
		else
			arg_134_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				arg_134_0:switchPanel("choose")
			end)))
		end
	end)
end

function LoginScene.showAccountPanel(arg_137_0)
	account_manager:switchaccount(function(arg_138_0, arg_138_1, arg_138_2)
		if arg_138_0 == 1 then
			arg_137_0:connectToGameServer(arg_138_1, arg_138_2)
		else
			arg_137_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				arg_137_0:switchPanel("choose")
			end)))
		end
	end)
end

function LoginScene.verifyChannelPlayerid(arg_140_0, arg_140_1, arg_140_2)
	return
end

function LoginScene.selectServer(arg_141_0, arg_141_1)
	arg_141_0._switchingserver = true

	account_manager:selectServer(arg_141_1, function(arg_142_0, arg_142_1)
		if arg_142_0 == 1 then
			arg_141_0:playConnectAni()
			arg_141_0:onConnectSuccess((account_manager:getUserID()))
		elseif arg_142_0 == 2 then
			arg_141_0._switchingserver = false

			arg_141_0:onConnectFail(arg_142_0, arg_142_1)
		elseif arg_142_0 == -1 then
			arg_141_0._switchingserver = false
		else
			arg_141_0._switchingserver = false

			arg_141_0:onConnectFail(0)
		end
	end)
end

function LoginScene:playConnectAni()
	if not self.loginlight then
		self.loginlight = cc.Sprite:create(self.loginlightpath)

		self.loginlight:setAnchorPoint(cc.p(0.5, 0))
		self.loginlight:setPosition(cc.p(320, 1136))
		self:addChild(self.loginlight, 5)
	end

	if not self.loginwait then
		self.loginwait = cc.Sprite:create(self.loginwaitpath)

		self.loginwait:setAnchorPoint(cc.p(1, 0))
		self.loginwait:setPosition(cc.p(620, 50))
		self:addChild(self.loginwait, 6)
	end

	self.loginlight:stopAllActions()
	self.loginlight:setPosition(cc.p(320, 1136))
	self.loginlight:setVisible(true)
	self.loginlight:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(2, cc.p(0, -1136)), cc.CallFunc:create(function()
		self.loginlight:setPosition(cc.p(320, 1136))
	end))))
	self.loginwait:stopAllActions()
	self.loginwait:setVisible(true)
	self.loginwait:setOpacity(255)
	self.loginwait:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 50), cc.FadeTo:create(1, 255))))
end

function LoginScene:stopConnectAni()
	if self.loginlight then
		self.loginlight:stopAllActions()
		self.loginlight:setVisible(false)
	end

	if self.loginwait then
		self.loginwait:stopAllActions()
		self.loginwait:setVisible(false)
	end
end

function LoginScene:showUserPlayerInfoLayer()
	require("view.Layer.SelectPlayerLayer")

	if self.statementPanel then
		self.statementPanel:runAction(cc.RemoveSelf:create())
	end

	self:addChild(SelectPlayerLayer:create(), 10)
end

function LoginScene:onSwitchPlayer()
	self:playConnectAni()

	if not network:connect(nil, nil, function(arg_148_0)
		self:stopConnectAni()

		if arg_148_0 == 1 then
			self:showUserPlayerInfoLayer()
		elseif arg_148_0 == -1 then
			self:switchPanel("choose")
		else
			self:switchPanel("selectserver")
		end
	end) then
		self:stopConnectAni()
		self:switchPanel("selectserver")
	end
end

function LoginScene:onSwitchAccount()
	if not network:connect(nil, nil, function(arg_150_0)
		if arg_150_0 == 1 then
			self:switchPanel("enter")
		elseif arg_150_0 == -1 then
			self:switchPanel("choose")
		else
			self:switchPanel("selectserver")
		end
	end) then
		self:switchPanel("selectserver")
	end

	local var_149_0 = account_manager:getToken()

	local function var_149_1(arg_151_0)
		self:stopConnectAni()

		if arg_151_0 == 1 then
			self:switchPanel("enter")
		elseif arg_151_0 == 3 then
			self:switchPanel("activate")
		else
			self:switchPanel("choose")
		end

		self._loginlock = false
	end

	self._loginlock = true

	self:playConnectAni()
	account_manager:verifyChannelPlayerid("", var_149_0, function(arg_152_0)
		if arg_152_0 == 1 then
			account_manager:getPlayerData(account_manager:getUserID(), var_149_1)
		else
			self._loginlock = false

			self:stopConnectAni()
		end
	end)
end

function LoginScene.initStatement(arg_153_0)
	return
end

function LoginScene.needShowStateMent(arg_154_0)
	return not cc.UserDefault:getInstance():getBoolForKey("agreeprivacy", false)
end

function LoginScene:showStateMent(arg_155_1)
	local var_155_0 = require("view.Layer.PrivacyLayer"):create()

	var_155_0:registerAgreeHandler(arg_155_1)
	self:addChild(var_155_0, 999)
end

function LoginScene.checkAntiAddiction(arg_156_0, arg_156_1)
	if account_manager.isAdult then
		if arg_156_1 then
			arg_156_1()
		end

		return
	end

	account_manager:checkAntiAddiction(arg_156_1)
end

function LoginScene:onAntiAddiction()
	local var_157_0 = ccui.Layout:create()

	var_157_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_157_0:setTouchEnabled(true)
	self:addChild(var_157_0, 999)

	local var_157_1 = ccui.ImageView:create("public/panelbg/bg_pop_login.png", config._DEBUG and 0 or 1)

	var_157_1:setScale9Enabled(true)
	var_157_0:addChild(var_157_1)

	local var_157_2 = cc.Label:createWithTTF("为了帮助孩子建立健康的游戏习惯, 针对全部未成年人:\n 仅在周五、周六、周日和法定节假日每日20:00-21:00提供游戏服务", "fonts/yanwenzi.ttf", 22)

	var_157_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_157_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_157_2:setMaxLineWidth(520)
	var_157_1:addChild(var_157_2)

	if var_157_2:getContentSize().height > 200 then
		var_157_1:setCapInsets(cc.rect(0, 50, 640, 80))
		var_157_1:setContentSize(cc.size(var_157_1:getContentSize().width, var_157_1:getContentSize().height + var_157_2:getContentSize().height - 200))
	end

	var_157_1:setPosition(320, GameDisplay.height / 2)
	var_157_2:setPosition(var_157_1:getContentSize().width / 2, var_157_1:getContentSize().height / 2)

	local var_157_3 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", config._DEBUG and 0 or 1)

	var_157_3:setPosition(var_157_1:getContentSize().width / 2, -var_157_3:getContentSize().height / 2 - 10)
	var_157_1:addChild(var_157_3)
	var_157_3:addTouchEventListener(function(arg_158_0, arg_158_1)
		if arg_158_1 ~= ccui.TouchEventType.ended then
			return false
		end

		var_157_0:runAction(cc.RemoveSelf:create())
		self:switchPanel("choose")
	end)
	var_157_0:addTouchEventListener(function(arg_159_0, arg_159_1)
		if arg_159_1 ~= ccui.TouchEventType.ended then
			return false
		end
	end)

	local var_157_4 = cc.Label:createWithTTF("确认", "fonts/newkj.ttf", 28)

	var_157_4:setColor(cc.c3b(0, 0, 0))
	var_157_4:setPosition(var_157_3:getContentSize().width / 2 - 5, var_157_3:getContentSize().height / 2 - 5)
	var_157_3:addChild(var_157_4)
end

function LoginScene:onNeedNewClient(arg_160_1)
	local var_160_0 = ccui.Layout:create()

	var_160_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_160_0:setTouchEnabled(true)
	self:addChild(var_160_0, 1001)

	local var_160_1 = ccui.ImageView:create("public/panelbg/bg_pop_login.png", config._DEBUG and 0 or 1)

	var_160_1:setScale9Enabled(true)
	var_160_0:addChild(var_160_1)

	local var_160_2 = cc.Label:createWithTTF("有新客户端可用，请前往下载", "fonts/yanwenzi.ttf", 24)

	var_160_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_160_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_160_2:setMaxLineWidth(520)
	var_160_1:addChild(var_160_2)

	if var_160_2:getContentSize().height > 200 then
		var_160_1:setCapInsets(cc.rect(0, 50, 640, 80))
		var_160_1:setContentSize(cc.size(var_160_1:getContentSize().width, var_160_1:getContentSize().height + var_160_2:getContentSize().height - 200))
	end

	var_160_1:setPosition(320, GameDisplay.height / 2)
	var_160_2:setPosition(var_160_1:getContentSize().width / 2, var_160_1:getContentSize().height / 2)

	local var_160_3 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", config._DEBUG and 0 or 1)

	var_160_3:setPosition(var_160_1:getContentSize().width / 2, -var_160_3:getContentSize().height / 2 - 10)
	var_160_1:addChild(var_160_3)
	var_160_3:addTouchEventListener(function(arg_161_0, arg_161_1)
		if arg_161_1 ~= ccui.TouchEventType.ended then
			return false
		end

		DeviceManager.openURL(arg_160_1)
	end)

	local var_160_4 = cc.Label:createWithTTF("确定", "fonts/newkj.ttf", 28)

	var_160_4:setColor(cc.c3b(0, 0, 0))
	var_160_4:setPosition(var_160_3:getContentSize().width / 2 - 5, var_160_3:getContentSize().height / 2 - 5)
	var_160_3:addChild(var_160_4)
end

function LoginScene:createNotice(arg_162_1)
	local var_162_0 = ccui.Layout:create()

	var_162_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_162_0:setTouchEnabled(true)
	var_162_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_162_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_162_0:setBackGroundColorOpacity(150)
	self:addChild(var_162_0, 999)

	local var_162_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

	var_162_1:setAnchorPoint(cc.p(0.5, 1))
	var_162_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
	var_162_0:addChild(var_162_1)
	var_162_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local var_163_0 = ccexp.WebView:create()

		var_163_0:setVisible(true)
		var_163_0:setScalesPageToFit(true)
		var_163_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
		var_163_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
		var_163_0:loadURL(arg_162_1)
		var_163_0:setOnDidFinishLoading(function(arg_164_0, arg_164_1)
			return
		end)
		var_162_0:addChild(var_163_0, 10)

		local var_163_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

		var_163_1:setScale(0.5)
		var_163_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
		var_162_0:addChild(var_163_1, 100)
		var_163_1:addTouchEventListener(function(arg_165_0, arg_165_1)
			if arg_165_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_162_0:runAction(cc.RemoveSelf:create())
		end)
	end)))
end
