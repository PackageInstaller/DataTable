MainLayer = class("MainLayer", function()
	return cc.Layer:create()
end)

if config._DEBUGSHOWGIRL then
	require("view.Layer.MainLayerDebug")
end

require("view.Layer.ActivityMenuLayer")
require("view.Layer.Activity.ActivitySignLayer")
require("view.Layer.ActivityManageLayer")
require("view.Layer.SignLayer")
require("view.Layer.MailLayer")
require("view.Layer.BackGroundLayer")

local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local level_manager = require("controller.level_manager")
local invite_manager = require("controller.invite_manager")
local activity_manager = require("controller.activity_manager")
local sign_manager = require("controller.sign_manager")
local audio_manager = require("controller.audio_manager")
local alert_manager = require("controller.alert_manager")
local autopop_manager = require("controller.autopop_manager")
local time_check_manager = require("controller.time_check_manager")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local npc_data = require("data.npc_data")
local item_data = require("data.item_data")
local activity_conf_data = require("data.activity_conf_data")
local pop_layer_infos = require("controller.layerconfig.pop_layer_infos")
local var_0_15 = require("data.activity_conf_data")
local novice_award_data = require("data.novice_award_data")
local var_0_17 = require("data.item_data")
local activity_sign_conf = require("data.activity_modules.activity_sign_conf")
local var_0_20 = require("controller.layerconfig.pop_layer_infos")
local playermodel = require("model.playermodel")
local notice_manager = require("controller.notice_manager")
local var_0_23 = require("controller.main_city_bg_select_manager"):getInstance()
local activity_return_manager = require("controller.activity_return_manager")
local friend_system_manager = require("controller.friend_system_manager")
local community_system_manager = require("controller.community_system_manager")
local task_manager = require("controller.task_manager")
local network = require("network.network")
local var_0_29 = config._DEBUG and 0 or 1
local TempWidget = require("view.Sprite.TempWidget")
local var_0_31 = {
	InviteLayer = "button_invite",
	SettingLayer = "button_set"
}
local var_0_32 = {
	ActivityEntranceLayer = "button_activity",
	MarketLayer = "button_lab",
	AdventureLayer = "button_change",
	TwisteggLayer = "button_market",
	SupermarketLayer = "button_recharge"
}
local var_0_33 = {
	ActivityEntranceLayer = true,
	ScoreArenaLayer = true,
	MarketLayer = true,
	AdventureLayer = true,
	TwisteggLayer = true
}
local var_0_34 = {
	"button_battle_pass",
	"button_sign",
	"button_friend",
	"button_mail",
	"button_notice",
	"button_set",
	"button_invite",
	"Btn_return",
	"button_tap",
	"btn_calendar",
	"button_bindmobile"
}
local var_0_35 = {
	"MarketLayer",
	"TwisteggLayer",
	"AdventureLayer"
}
local var_0_36 = "MainLayer/yellow_point.png"
local var_0_37 = "MainLayer/white_point.png"
local var_0_39 = 1
local var_0_40 = 0
local var_0_41 = 2
local var_0_42 = 3
local var_0_43 = "MainLayerRolePosX"
local var_0_44 = "MainLayerRolePosY"
local var_0_45 = "MainLayerRoleScale"
local var_0_46 = 5
local var_0_47

function MainLayer.create(arg_2_0)
	local var_2_0 = MainLayer.new()

	var_2_0:init()

	return var_2_0
end

function MainLayer.getInstance()
	return var_0_47
end

local var_0_48 = {
	ScoreArenaLayer = {
		{
			x = 0,
			y = 75
		},
		{
			x = 75,
			y = 150
		},
		{
			x = 150,
			y = 75
		},
		{
			x = 75,
			y = 0
		}
	},
	ActivityEntranceLayer = {
		{
			x = 0,
			y = 79
		},
		{
			x = 79,
			y = 158
		},
		{
			x = 158,
			y = 75
		},
		{
			x = 79,
			y = 0
		}
	},
	MarketLayer = {
		{
			x = 0,
			y = 80
		},
		{
			x = 80,
			y = 160
		},
		{
			x = 160,
			y = 80
		},
		{
			x = 80,
			y = 0
		}
	},
	TwisteggLayer = {
		{
			x = 0,
			y = 100
		},
		{
			x = 100,
			y = 200
		},
		{
			x = 200,
			y = 100
		},
		{
			x = 100,
			y = 0
		}
	},
	AdventureLayer = {
		{
			x = 0,
			y = 80
		},
		{
			x = 80,
			y = 160
		},
		{
			x = 160,
			y = 80
		},
		{
			x = 80,
			y = 0
		}
	}
}

function MainLayer:init()
	var_0_47 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MainLayer.json" or "MainLayer.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice"):setLocalZOrder(-1)
	self:initUIButtons()
	self:showActivityGiftEntrance()
	self:initShowgirl()
	self:updateBackGround()
	self:initButtonShrink()
	self:initButtonGuide()
	self:addSpringElement()
	self:dealFriendStutus()
	friend_system_manager:get_friend_max_num()
	community_system_manager:get_family_data()
	self:drawMainLayerActivity()
	self:registerActivityEventListener()
	invite_manager:init()
	activity_manager:updateActivityEntranceList()
	activity_return_manager:get_returnback_info()
	self:fullScreen()
	self:autoPopActivity()
	self:checkNewNotice()
	self:check_show_appstar_and_debug()
	self:addAutoDownloader()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_47 = nil

			if self.actScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.actScheduler)

				self.actScheduler = nil
			end

			if self.invitescheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.invitescheduler)

				self.invitescheduler = nil
			end

			if self.activity_layout then
				self.activity_layout:runAction(cc.RemoveSelf:create())
			end

			activity_manager:releaseEventListenerByName("MainLayer")
		elseif arg_5_0 == "enter" then
			activity_manager:fireEvent(activity_manager.activityEventId.JOIN_IN_MAIN_LAYER)
		end
	end)
	self:initShowGirlTouchLayout()
end

local function var_0_49(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_2 == 2 then
		var_6_0 = ccui.ImageView:create("MainLayer/uolockentertiment.png", var_0_29)

		local var_6_2 = cc.Label:createWithBMFont("fonts/hongse.fnt", arg_6_1)

		var_6_2:setPosition(cc.p(var_6_0:getContentSize().width / 2 + 10, var_6_0:getContentSize().height / 2))
		var_6_0:addChild(var_6_2, 99)
	elseif arg_6_2 == 3 then
		print("word===", arg_6_1)

		var_6_0 = ccui.ImageView:create("MainLayer/new_changUnlock.png", var_0_29)

		local var_6_3 = cc.Label:createWithBMFont("fonts/lanse.fnt", arg_6_1)

		var_6_3:setPosition(cc.p(var_6_0:getContentSize().width / 2 + 10, var_6_0:getContentSize().height / 2))
		var_6_0:addChild(var_6_3, 99)
	else
		var_6_0 = ccui.ImageView:create("MainLayer/lockbg.png", var_0_29)

		local var_6_4 = cc.Label:createWithTTF(arg_6_1, "fonts/number.ttf", 18)

		var_6_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_6_4:setColor(cc.c3b(255, 255, 255))
		var_6_4:setPosition(cc.p(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2 - 20))
		var_6_0:addChild(var_6_4, 1)
	end

	var_6_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_0:setPosition(cc.p(arg_6_0:getContentSize().width / 2, arg_6_0:getContentSize().height / 2))
	arg_6_0:addChild(var_6_0)
end

local function var_0_50(arg_7_0, arg_7_1)
	if arg_7_1 ~= ccui.TouchEventType.ended then
		return
	end

	local var_7_0 = arg_7_0:getName()

	if not var_7_0 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(var_0_31) do
		if iter_7_1 == var_7_0 and var_7_0 == "button_invite" then
			LayerManager:pushInLayer("PopInviteResidentLayer")

			break
		elseif iter_7_1 == var_7_0 then
			LayerManager:switchShowLayer(iter_7_0)

			break
		end
	end
end

local function var_0_51(arg_8_0, arg_8_1)
	if arg_8_1 == ccui.TouchEventType.began then
		if var_0_33[arg_8_0.key] and not isContainPosOfConvexPolygon(var_0_48[arg_8_0.key], (arg_8_0:convertToNodeSpace((arg_8_0:getTouchBeganPosition())))) then
			return
		end

		arg_8_0:setScale(1.2)
	elseif arg_8_1 == ccui.TouchEventType.canceled then
		arg_8_0:setScale(1)
	elseif arg_8_1 == ccui.TouchEventType.ended then
		arg_8_0:setScale(1)
	end

	if arg_8_1 ~= ccui.TouchEventType.ended then
		return
	end

	if var_0_33[arg_8_0.key] and not isContainPosOfConvexPolygon(var_0_48[arg_8_0.key], (arg_8_0:convertToNodeSpace((arg_8_0:getTouchBeganPosition())))) then
		return
	end

	local var_8_0 = arg_8_0:getName()

	if not var_8_0 then
		return
	end

	for iter_8_0, iter_8_1 in pairs(var_0_32) do
		if iter_8_1 == var_8_0 then
			if iter_8_1 == "button_market" then
				require("controller.alert_manager"):unregister_alert(ALERT_ACTIVTIYNEWLOG_TWISTEGG, true)
				activity_manager:openNewActivity(7)
			end

			local var_8_1 = {
				TwisteggLayer = 180,
				SupermarketLayer = 170,
				MainLayer = 150
			}

			if var_8_1[iter_8_0] then
				AnalyticManager.clickActivityEntranceType({
					enterType = "MainLayer",
					jumpid = var_8_1[iter_8_0]
				})
			end

			LayerManager:switchShowLayer(iter_8_0)

			break
		end
	end
end

function MainLayer:fullScreen()
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist"):setPositionY(GameDisplay.top - 163 - GameDisplay.fix_y - GameDisplay.notch_height)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sencondlist"):setPositionY(611 - GameDisplay.fix_y)

	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice")
	local var_9_1 = GameDisplay.top - 1136 + var_9_0:getPositionY() - GameDisplay.notch_height

	var_9_0:setPositionY(var_9_1 - var_9_0:getContentSize().height / 2)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sencondlist"):getChildByName("btn_autodownload"):setPositionY(var_9_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_change_model"):setPositionY(174)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_allhide"):setPositionY(153)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_guidephone"):setPositionY(158)

	local var_9_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist")
end

function MainLayer:initUIButtons()
	for iter_10_0, iter_10_1 in pairs(var_0_32) do
		ccui.Helper:seekWidgetByName(self.rootLayer, iter_10_1):setSwallowTouches(true)

		ccui.Helper:seekWidgetByName(self.rootLayer, iter_10_1).key = iter_10_0

		ccui.Helper:seekWidgetByName(self.rootLayer, iter_10_1):addTouchEventListener(var_0_51)
	end

	for iter_10_2, iter_10_3 in pairs(var_0_31) do
		ccui.Helper:seekWidgetByName(self.rootLayer, iter_10_3):addTouchEventListener(var_0_50)
	end

	self:updateBtnInviteStatus()

	local var_10_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_mail")

	var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_MAIL) then
			global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_MAIL))))

			return
		end

		AnalyticManager.click_mail_enter()
		LayerManager:pushInLayer("MailLayer")
	end)

	local var_10_1 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_29)

	var_10_1:setPosition(cc.p(36, 33))
	var_10_1:setName("image")
	var_10_1:setScale(0.5)
	var_10_0:addChild(var_10_1)
	var_10_1:setVisible(not level_manager:isPlayerPassLevel(UNLOCK_MAIL))
	sign_manager:checkSignType(function(arg_12_0)
		if not var_0_47 then
			return
		end

		if not arg_12_0 then
			self:showNextSignTime()
		elseif self.signTimeLabel then
			self.signTimeLabel:setVisible(false)
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_sign"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		sign_manager:checkSignType(function(arg_14_0)
			if not var_0_47 then
				return
			end

			if not arg_14_0 then
				sign_manager:createSignLayer(nil)
			else
				if self.signTimeLabel then
					self.signTimeLabel:setVisible(false)
				end

				LayerManager:pushInLayer("SignLayerNew")
			end
		end)
	end)

	local hexie_manager = require("controller.hexie_manager")
	local var_10_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_battle_pass")

	var_10_3:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isCanPlayWarOrder(ACTIVITY_WARORDER_ID) then
			if time_check_manager:getCurTime() < global_get_time_by_date("2023-06-01 00:00:00") then
				LayerManager:switchShowLayer("ActivityWarOrderLayer")
			else
				LayerManager:switchShowLayer("ResidentActicityEntranceLayer")
			end
		else
			LayerManager:switchShowLayer("BattlePassLayer", {})
		end
	end)
	activity_manager:isCanShowWarOrder(ACTIVITY_WARORDER_ID, function(arg_16_0)
		if var_10_3 then
			var_10_3:setVisible(hexie_manager:canShowMainButton() and arg_16_0)
		end
	end)
	activity_manager:updateWarOrderEntranceAlert(ACTIVITY_WARORDER_ID)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_friend"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("FriendListLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_notice"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:openNotice()
	end)

	local var_10_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_calendar")

	var_10_4:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityCalendar", {
			callback = function()
				if not var_0_47 then
					return
				end

				self:updateBtnCalendarRedDot()
			end
		})
	end)
	var_10_4:setVisible(hexie_manager:canShowMainButton())
	self:updateBtnCalendarRedDot()
	self:updateButtonsUnlockStatus()

	if playermodel.bindmobilestatus == 0 then
		local var_10_5 = ccui.Button:create("MainLayer/thirdlist/btn_bindmobile.png", "MainLayer/thirdlist/btn_bindmobile.png", "MainLayer/thirdlist/btn_bindmobile.png", var_0_29)

		ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist"):addChild(var_10_5, 5)
		var_10_5:setName("button_bindmobile")
		var_10_5:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopBindMobileLayer")
		end)
		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("UPDATEBINDMOBILE", function()
			var_10_5:setVisible(playermodel.bindmobilestatus == 0)
		end), self)
	end

	self:updateThirdBtnListPos()
end

function MainLayer:updateThirdBtnListPos()
	local var_23_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist")
	local var_23_1 = var_23_0:getChildren()

	for iter_23_0 = 1, #var_0_34 do
		local var_23_2 = var_23_0:getChildByName(var_0_34[iter_23_0])

		if var_23_2 and var_23_2:isVisible() then
			var_23_2:setPosition(cc.p(-85, 9 - (1 - 1) * 55))
		end
	end
end

function MainLayer:showNextSignTime()
	if not var_0_47 then
		return
	end

	self.signTimeLabel = self.signTimeLabel or nil

	if self.signTimeLabel then
		self.signTimeLabel:stopAllActions()
	end

	local var_24_3 = time_check_manager:getCurTime()

	local function var_24_4(arg_25_0, arg_25_1)
		return arg_25_0 < 10 and (arg_25_1 < 10 and "0" .. arg_25_0 .. ":" .. "0" .. arg_25_1 or "0" .. arg_25_0 .. ":" .. arg_25_1) or arg_25_1 < 10 and arg_25_0 .. ":" .. "0" .. arg_25_1 or arg_25_0 .. ":" .. arg_25_1
	end

	local function var_24_5(arg_26_0)
		return (var_24_4((arg_26_0 - arg_26_0 % 60 - (arg_26_0 - arg_26_0 % 60) % 3600 / 60 * 60) / 3600, (arg_26_0 - arg_26_0 % 60) % 3600 / 60))
	end

	local function var_24_6(arg_27_0, arg_27_1)
		return arg_27_0 * 3600 - arg_27_1
	end

	local function var_24_7(arg_28_0)
		if arg_28_0 >= 60 then
			self.signTimeLabel:setString((var_24_5(arg_28_0)))
		else
			self.signTimeLabel:setString("< 1min")
		end

		arg_28_0 = arg_28_0 - 1

		return arg_28_0
	end

	local var_24_8 = tonumber((os.date("%H", var_24_3))) * 3600 + tonumber((os.date("%M", var_24_3))) * 60 + tonumber((os.date("%S", var_24_3)))

	if not self.signTimeLabel then
		self.signTimeLabel = cc.Label:createWithTTF("", FONT_DES, 18)

		self.signTimeLabel:setAnchorPoint(cc.p(0.5, 1))
		self.signTimeLabel:setPosition(cc.p(30, 10))
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_sign"):addChild(self.signTimeLabel, 9)
	else
		self.signTimeLabel:setVisible(true)
	end

	if AlertManager.alertsys[ALERT_SIGN] == true then
		self.signTimeLabel:setVisible(false)
	else
		self.signTimeLabel:setVisible(true)
	end

	sign_manager:getSignInfo(function()
		if not var_0_47 then
			return
		end

		local var_29_0 = sign_manager.SignLimit > 0 and sign_manager.SignLastTime + 10800 - sign_manager.server_time or var_24_6(24, var_24_8)

		self.signTimeLabel:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.CallFunc:create(function()
			if var_29_0 >= 0 then
				var_29_0 = var_24_7(var_29_0)
			else
				self.signTimeLabel:stopAction(seqre)
				self.signTimeLabel:setVisible(false)
				AlertManager:register_alert(ALERT_SIGN)
			end
		end), cc.DelayTime:create(1))))))
	end)
end

function MainLayer:createEffectAtRechargeGift()
	local var_31_0 = ccui.ImageView:create("mainScenebg/activity/common/effect.png")

	var_31_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_0:setPosition(cc.p(self.rechargeGift:getContentSize().width / 2, self.rechargeGift:getContentSize().height / 2))
	self.rechargeGift:addChild(var_31_0)
	var_31_0:setOpacity(40)
	var_31_0:setScale(0.5)
	var_31_0:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Spawn:create(cc.EaseOut:create(cc.ScaleTo:create(1, 3, 3), 2), cc.Sequence:create(cc.FadeTo:create(1 / 3, 255), cc.FadeTo:create(1 * 2 / 3, 40))), cc.CallFunc:create(function()
		var_31_0:setOpacity(40)
		var_31_0:setScale(0.5)

		if playermodel.haverechargeaward == true then
			var_31_0:stopAllActions()
		end
	end), cc.DelayTime:create(1 / 2))))))
end

function MainLayer:updateButtonsUnlockStatus()
	for iter_33_0, iter_33_1 in ipairs(var_0_35) do
		local var_33_0, var_33_1 = LayerManager:getLayerUnlockStat(iter_33_1)

		if not var_33_0 then
			var_0_49(ccui.Helper:seekWidgetByName(self.rootLayer, var_0_32[iter_33_1]), var_33_1, iter_33_0)
		end
	end
end

function MainLayer:initShowgirl()
	self.showgirlLayer = ShowGirlLayer:create(playermodel.showgirl, 3, nil, function(arg_35_0)
		self:onSettingLive2D(arg_35_0)
	end)

	self:addChild(self.showgirlLayer, -1)
	self:updateShowGirlBack()
	self.showgirlLayer:setTouchTalkCallback(function()
		if tolua.isnull(self.rootLayer) then
			return
		end

		if not self.imgCircle then
			local var_39_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_change_model")

			self.imgCircle = ccui.ImageView:create("MainLayer/circle.png", var_0_29)

			self.imgCircle:setPosition(var_39_0:getContentSize().width / 2 - 12, var_39_0:getContentSize().height / 2 + 5)
			var_39_0:addChild(self.imgCircle)
		end

		self.imgCircle:stopAllActions()
		self.imgCircle:setScale(0.8)
		self.imgCircle:setOpacity(255)
		self.imgCircle:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.8, 1.2), cc.FadeOut:create(0.8)), cc.CallFunc:create(function()
			self.imgCircle:setScale(0.8)
			self.imgCircle:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.8, 1.2), cc.FadeOut:create(0.8))))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_change_model"):addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("GirlSelectLayer", {
			selectType = 2,
			cursoul = playermodel.showgirl,
			sureCallBack = function(arg_37_0)
				self.showgirlLayer:update(playermodel.showgirl, nil, true)
				self:resetShowGirlPos()
				self:updateShowGirlBack()
				self:updateBackGround()
			end,
			resetMainLayerLive2dCallback = function()
				self.showgirlLayer:resetShowGirlLayer()
				self:updateBackGround()
			end
		})
		AnalyticManager.click_change_show_girl_btn()
	end)

	if config._DEBUGSHOWGIRL then
		self:initDebugShowGrilPos()
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "button_change_model"):setVisible(require("controller.hexie_manager"):canSwitchMainLayerShowGirl())
end

function MainLayer:onSettingLive2D(arg_41_1)
	if arg_41_1 == EVENT_SETTING_SHOWGIRL.LIVE2D_START then
		self:hideUI()
	elseif arg_41_1 == EVENT_SETTING_SHOWGIRL.LIVE2D_FINISH then
		self:showUI()
	end
end

function MainLayer:updateShowUIStatus(arg_42_1, arg_42_2)
	local var_42_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_allhide")
	local var_42_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist")
	local var_42_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sencondlist")
	local var_42_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_guidephone")

	if arg_42_1 == var_0_39 then
		var_42_0:runAction(cc.ScaleTo:create(0.3, 1, 1))
		var_42_3:getChildByName("guidePhoneFnt"):setVisible(true)
		var_42_3:runAction(cc.FadeIn:create(0.1))
		var_42_1:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.5, cc.p(122, GameDisplay.top - 163 - GameDisplay.fix_y - GameDisplay.notch_height))))
		var_42_2:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.5, cc.p(210, 611 - GameDisplay.fix_y))))
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + 0.1), cc.CallFunc:create(arg_42_2)))
		LayerManager:showTopBottomLayer({
			ListButtonLayer = true,
			TopcostLayer = true
		})
		self.showgirlLayer:switchPos(0)
	elseif arg_42_1 == var_0_40 then
		var_42_0:runAction(cc.ScaleTo:create(0.3, 1, 1))
		var_42_3:getChildByName("guidePhoneFnt"):setVisible(false)
		var_42_3:runAction(cc.FadeOut:create(0.1))
		var_42_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-378, GameDisplay.top - 163 - GameDisplay.fix_y - GameDisplay.notch_height)), cc.Hide:create()))
		var_42_2:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(1010, 611 - GameDisplay.fix_y)), cc.Hide:create()))
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + 0.1), cc.CallFunc:create(arg_42_2)))
		LayerManager:showTopBottomLayer({
			ListButtonLayer = false,
			TopcostLayer = false
		})
		self.showgirlLayer:switchPos(0)
	end
end

function MainLayer:showUI()
	if self._uiStatus == var_0_39 then
		return
	end

	self._uiStatus = var_0_39

	self:updateShowUIStatus(self._uiStatus, function()
		return
	end)
end

function MainLayer:hideUI()
	if self._uiStatus == var_0_40 then
		return
	end

	self._uiStatus = var_0_40

	self:updateShowUIStatus(self._uiStatus, function()
		return
	end)
end

function MainLayer:initButtonShrink()
	local var_47_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_allhideTouchPanel")

	self._uiStatus = var_0_39

	ccui.Helper:seekWidgetByName(self.rootLayer, "button_allhide"):addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_48_0:isBright() then
			return
		end

		self._uiStatus = 1 - self._uiStatus

		arg_48_0:setBright(false)
		self:updateShowUIStatus(self._uiStatus, function()
			arg_48_0:setBright(true)
		end)

		if self._uiStatus == 0 then
			AnalyticManager.main_layer_show_girl({
				modelid = playermodel.showgirl
			})
		end
	end)
end

function MainLayer.checkNewNotice(arg_50_0)
	return
end

function MainLayer:openNotice()
	local var_51_0 = notice_manager:get_notice_url()

	if not var_51_0 then
		return
	end

	if DeviceManager.platform == "windows" then
		DeviceManager.openURL(var_51_0)
	else
		self:openNoticeWithWebView(var_51_0)
	end

	notice_manager:update_notice_version()
	alert_manager:unregister_alert(ALERT_NEW_NOTICE, true)
end

function MainLayer.openNoticeWithWebView(arg_52_0, arg_52_1)
	local var_52_0 = ccui.Layout:create()

	var_52_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_52_0:setTouchEnabled(true)
	var_52_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_52_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_52_0:setBackGroundColorOpacity(150)
	global_basic_scene:addChild(var_52_0, 999)

	local var_52_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

	var_52_1:setAnchorPoint(cc.p(0.5, 1))
	var_52_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
	var_52_0:addChild(var_52_1)
	var_52_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		if not ccexp.WebView then
			return
		end

		local var_53_0 = ccexp.WebView:create()

		var_53_0:setVisible(true)
		var_53_0:setScalesPageToFit(true)
		var_53_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
		var_53_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
		var_53_0:loadURL(arg_52_1)
		var_53_0:setOnDidFinishLoading(function(arg_54_0, arg_54_1)
			return
		end)
		var_52_0:addChild(var_53_0, 10)

		local var_53_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

		var_53_1:setScale(0.5)
		var_53_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
		var_52_0:addChild(var_53_1, 100)
		var_53_1:addTouchEventListener(function(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_52_0:runAction(cc.RemoveSelf:create())
		end)
	end)))
end

function MainLayer:updateBackGround()
	local var_56_0 = 1

	if model_data[playermodel.showgirl].is_own_full_screen_background == 1 then
		var_56_0 = 2
	end

	local var_56_1 = var_0_23:getBackGroundId()

	if self.backGroundLayer ~= nil then
		self.backGroundLayer:update(var_56_1, var_56_0)
	else
		self.backGroundLayer = BackGroundLayer:create(var_56_1, var_56_0)

		self:addChild(self.backGroundLayer, -10)
	end
end

function MainLayer.registerActivityEventListener(arg_57_0)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.UPDATE_NEW_ACTIVITY_LIST, function(arg_58_0)
		arg_57_0:redrawActivityAlert()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_59_0)
		arg_57_0:redrawActivityAlert()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.ACTIVITY_STATE_CHANGED, function(arg_60_0)
		arg_57_0:updateActivityDoor()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.ACTIVITY_ENTRANCE_LIST_UPDATE, function(arg_61_0)
		arg_57_0:updateActivityDoor()
		arg_57_0:drawEctranceActivity()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.SIGN_IN_MAIN_LAYER, function(arg_62_0)
		arg_57_0:showNextSignTime()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.POP_LAYER_OPEMED, function(arg_63_0)
		for iter_63_0, iter_63_1 in pairs(arg_57_0.activityIcon) do
			iter_63_1:setBright(true)
		end
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_64_0)
		arg_57_0:redrawActivityAlert()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE, function(arg_65_0)
		arg_57_0:checkTest()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.FRIEND_NEW_APPLY_NOTICE, function(arg_66_0)
		arg_57_0:dealFriendStutus()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.FRIEND_NEW_Gift_NOTICE, function(arg_67_0)
		arg_57_0:dealFriendStutus()
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.INVITE_IS_MAIN_REDDOT, function(arg_68_0)
		arg_57_0:updateBtnInviteRedDot(arg_68_0)
	end)
	activity_manager:registerEventListener("MainLayer", activity_manager.activityEventId.COMMUNITY_WISH_NEW_AWARD, function(arg_69_0)
		if arg_69_0.tp then
			alert_manager:updataCommnityBtnAlert()
		end
	end)
end

function MainLayer:createActivityEntrance(arg_70_1, arg_70_2)
	if self.activity_layout then
		self.activity_layout:removeFromParent()
	end

	self.activity_layout = ccui.Layout:create()

	self.activity_layout:setContentSize(GameDisplay.getScreenSize())
	self.activity_layout:setPosition(cc.p(0, -GameDisplay.fix_x))
	self.activity_layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.activity_layout:setBackGroundColor(cc.c3b(0, 0, 0))
	self.activity_layout:setOpacity(180)
	self.activity_layout:setCascadeOpacityEnabled(false)
	global_basic_scene:addChild(self.activity_layout, 100)
	self.activity_layout:setVisible(false)
	self.activity_layout:setTouchEnabled(true)

	if self.imageActivityBottom then
		-- block empty
	else
		self.imageActivityBottom = nil
	end

	self.imageActivityBottom = arg_70_2 > 4 and ccui.ImageView:create("public/panelbg/activity_bottom2.png", var_0_29) or ccui.ImageView:create("public/panelbg/activity_bottom1.png", var_0_29)

	local var_70_0 = ccui.ImageView:create("public/panelbg/right.png", var_0_29)

	var_70_0:setPosition(cc.p(self.imageActivityBottom:getContentSize().width - var_70_0:getContentSize().width, self.imageActivityBottom:getContentSize().height / 2))
	self.imageActivityBottom:addChild(var_70_0, 99)
	self.activity_layout:addChild(self.imageActivityBottom, 99)

	local var_70_1 = arg_70_1:convertToWorldSpace(arg_70_1:getAnchorPointInPoints())

	self.activity_layout:addTouchEventListener(function(arg_71_0, arg_71_1)
		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.imageActivityBottom:setPosition(var_70_1)
		self.activity_layout:setVisible(false)
	end)
end

function MainLayer:drawMainLayerActivity()
	self.activityDoorSprit = require("view.Sprite.ActivityDoorNewSprite"):create()

	local var_72_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice")

	self.activityDoorSprit:setPosition(var_72_0:getContentSize().width - 45, 0)
	var_72_0:addChild(self.activityDoorSprit)

	self.activityLeftDoorSprite = require("view.Sprite.activityLeftDoorSprite"):create()

	self.activityLeftDoorSprite:setPosition(-80, -710 - GameDisplay.fix_y)
	self.activityLeftDoorSprite:setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist"):addChild(self.activityLeftDoorSprite, 100)

	self.activityTopDoorSprite = require("view.Sprite.activityTopDoorSprite"):create()

	self.activityTopDoorSprite:setPosition(cc.p(200, 380 + GameDisplay.fix_y * 2))
	self.activityTopDoorSprite:setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sencondlist"):addChild(self.activityTopDoorSprite, 100)
end

function MainLayer:updateActivityDoor()
	if self.activityDoorSprit then
		self.activityDoorSprit:resetActivityList()
	end

	if self.activityLeftDoorSprite then
		self.activityLeftDoorSprite:resetActivityList()
	end

	if self.activityTopDoorSprite then
		self.activityTopDoorSprite:resetActivityList()
	end

	self:updateOtherActivity()
end

function MainLayer:drawOtherActivity()
	self.activityIcon = self.activityIcon or {}

	for iter_74_0, iter_74_1 in pairs((activity_manager:getMainlayerList())) do
		local var_74_0 = iter_74_1:getMainlayerParentName()

		if var_74_0 == "panel_thirdlist" then
			local var_74_1 = iter_74_1:getMainLayerImage()
			local var_74_2 = iter_74_1:getMainLayerPoint()

			self.activityIcon[iter_74_0] = ccui.Button:create(var_74_1[1], nil, var_74_1[2] or var_74_1[1])

			if iter_74_0 == 8 and self.activityIcon[iter_74_0] then
				self.activityIcon[iter_74_0]:setScale(0.85)
			end

			if iter_74_0 == 2 then
				self.activityIcon[iter_74_0]:setVisible(false)
			end

			self.activityIcon[iter_74_0]:setPosition(cc.p(var_74_2.x, var_74_2.y + GameDisplay.notch_height))
			ccui.Helper:seekWidgetByName(self.rootLayer, var_74_0):addChild(self.activityIcon[iter_74_0])
			self.activityIcon[iter_74_0]:addTouchEventListener(function(arg_75_0, arg_75_1)
				if arg_75_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self.activityIcon[iter_74_0]:isBright() then
					return
				end

				self.activityIcon[iter_74_0]:setBright(false)

				if self.activity_layout then
					self.activity_layout:setVisible(false)
				end

				local var_75_0 = iter_74_1:getJumpToConfig()

				var_75_0.activityID = iter_74_0

				if iter_74_0 == 4 then
					AnalyticManager.main_layer_into_liuli_activity()
				end

				if var_75_0.jumpToLayer and var_0_20[var_75_0.jumpToLayer] then
					self.activityIcon[iter_74_0]:setBright(true)
				end

				if iter_74_0 == 110 then
					self.activityIcon[iter_74_0]:setBright(true)
				end

				ActivityManageLayer:create(var_75_0)
			end)
		end
	end

	self:redrawOtherActivityAlert()
end

function MainLayer.updateOtherActivity(arg_76_0)
	return
end

function MainLayer:checkKeepOutRechargeBtn(arg_77_1)
	if not self.rechargeGift then
		return
	end

	if arg_77_1 and arg_77_1:getParent() ~= self.rechargeGift:getParent() then
		return
	end

	self.keepOutRechargeNum = self.keepOutRechargeNum + 1

	self.rechargeGift:setPositionY(-60 + self.keepOutRechargeNum * 128)
end

function MainLayer.initShowImgPanelPath(arg_78_0)
	local var_78_0 = {}

	for iter_78_0, iter_78_1 in pairs((activity_manager:getActivityEntranceList())) do
		if iter_78_1.isinflashwindow ~= nil and (not iter_78_1.unlocklevel or level_manager:isPlayerPassLevel(iter_78_1.unlocklevel) or DeviceManager:getChannelID() == "270048") then
			var_78_0[1] = iter_78_1
		end
	end

	table.sort(var_78_0, function(arg_79_0, arg_79_1)
		if arg_79_0.image == 3000001 then
			return false
		elseif arg_79_1.image == 3000001 then
			return true
		else
			return arg_79_0.order < arg_79_1.order
		end
	end)

	if #var_78_0 > 8 then
		for iter_78_2 = 9, #var_78_0 do
			var_78_0[iter_78_2] = nil
		end
	end

	if ({})[DeviceManager.getChannelID()] then
		table.insert(var_78_0, {
			id = "weibo",
			image = "weibo",
			init_type = "weibo"
		})
	end

	return var_78_0
end

function MainLayer:drawEctranceActivity()
	self.ispanelgo = true

	local var_80_0 = self:initShowImgPanelPath()
	local var_80_1 = #var_80_0

	if not #var_80_0 or var_80_1 < 1 then
		return
	end

	local var_80_2 = 0

	self.activityPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice")
	self.activityBnt = ccui.Helper:seekWidgetByName(self.activityPanel, "button")

	self.activityBnt:setSwallowTouches(false)

	self.activityRay = ccui.Helper:seekWidgetByName(self.activityPanel, "ray")

	local var_80_3 = self.activityRay:getPositionY()
	local var_80_4 = self.activityRay:getPositionX() + 29

	self.activityRay:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0, cc.p(var_80_4, var_80_3)), cc.MoveTo:create(3, cc.p(var_80_4, var_80_3 - self.activityBnt:getContentSize().height - 18)))))

	if self.activityPoint and next(self.activityPoint) then
		for iter_80_0, iter_80_1 in pairs(self.activityPoint) do
			iter_80_1:removeFromParent()
		end
	end

	self.activityPoint = {}

	if var_80_1 > 1 then
		for iter_80_2 = 1, var_80_1 do
			self.activityPoint[iter_80_2] = iter_80_2 == 1 and ccui.ImageView:create(var_0_36, var_0_29) or ccui.ImageView:create(var_0_37, var_0_29)

			self.activityPoint[iter_80_2]:setPosition(cc.p(83 - (math.floor(var_80_1 / 2) + 1 - iter_80_2) * 20, -10))
			self.activityBnt:addChild(self.activityPoint[iter_80_2])
		end
	end

	local function var_80_5(arg_81_0)
		self.activityBnt:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			self.activityBnt:loadTextures("mainScenebg/flashwindow/" .. var_80_0[arg_81_0].image .. ".png", nil, nil)

			if var_80_0[arg_81_0].image == 8380001 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2025-10-09 23:59:59") then
				self.activityBnt:loadTextures("mainScenebg/flashwindow/" .. var_80_0[arg_81_0].image .. "_replace.png", nil, nil)
			end

			if self.activityPoint[arg_81_0] then
				self.activityPoint[arg_81_0]:loadTexture(var_0_36, var_0_29)
			end

			self:redrawActivityEntranceAlert(var_80_0[arg_81_0].id, var_80_0[arg_81_0].image)

			for iter_82_0 = 1, #var_80_0 do
				if iter_82_0 ~= arg_81_0 and self.activityPoint[iter_82_0] ~= nil then
					self.activityPoint[iter_82_0]:loadTexture(var_0_37, var_0_29)
				end
			end
		end), cc.FadeIn:create(0.5)))
	end

	local var_80_6
	local var_80_7

	local function var_80_8(arg_83_0)
		var_80_2 = arg_83_0 and var_80_2 + 1 or var_80_2 - 1

		if var_80_2 + 1 == var_80_1 then
			var_80_1 = #var_80_0
		end

		var_80_5(var_80_2 % var_80_1 + 1)

		if self.actScheduler then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.actScheduler)

			self.actScheduler = nil
		end

		self.actScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			var_80_2 = var_80_2 + 1

			if var_80_2 + 1 == var_80_1 then
				var_80_1 = #var_80_0
			end

			var_80_5(var_80_2 % var_80_1 + 1)
		end, 4, false)
	end

	local function var_80_9()
		require("controller.goto_system_manager")

		if var_80_0[var_80_2 % var_80_1 + 1].init_type == WEB_ACTIVITY then
			self:showWebActivity(var_80_0[var_80_2 % var_80_1 + 1].id)
		elseif var_80_0[var_80_2 % var_80_1 + 1].init_type == "weibo" then
			DeviceManager.openURL(DeviceManager.platform == "windows" and "http://www.sina.com.cn" or "sinaweibo://sendweibo?content=%23%e9%ad%82%e5%99%a8%e5%ad%a6%e9%99%a2%23+%e5%85%bb%e8%82%9d%e6%8a%a4%e8%82%be%ef%bc%8c%e6%94%be%e7%bd%ae%e6%8c%82%e6%9c%ba%e3%80%82%e4%b8%80%e8%b5%b7%e6%88%90%e4%b8%ba%e7%8f%ad%e9%95%bf%ef%bc%8c%e5%ae%88%e6%8a%a4%e5%8f%af%e7%88%b1%e7%9a%84%e5%b0%91%e5%a5%b3%e5%ad%a6%e5%91%98%e4%bb%ac%e5%90%a7%ef%bc%81&lfid=OP_1972298725&launchid=10000360-OP_1972298725&wm=90069_90001")
		else
			if var_80_0[var_80_2 % var_80_1 + 1].jump_talk then
				global_basic_scene:addChild(TalkLayer:create(var_80_0[var_80_2 % var_80_1 + 1].jump_talk, nil, 1, ""))

				return
			end

			if SYSTEMID[var_80_0[var_80_2 % var_80_1 + 1].jump] == "SignLayer" then
				LayerManager:pushInLayer("SignLayerNew")
			elseif SYSTEMID[var_80_0[var_80_2 % var_80_1 + 1].jump] == "HandOfMidasLayer" then
				require("controller.sign_manager"):createMidasLayer()
			else
				local var_85_1 = {
					jump_to_system = var_80_0[var_80_2 % var_80_1 + 1].jump
				}

				var_85_1.config = system_jump_config[SYSTEMID[var_80_0[var_80_2 % var_80_1 + 1].jump]] and system_jump_config[SYSTEMID[var_80_0[var_80_2 % var_80_1 + 1].jump]].config

				goto_complete_system(var_85_1)
			end
		end
	end

	local function var_80_10(arg_86_0)
		if not arg_86_0 then
			return true
		end

		local var_86_0 = arg_86_0:getParent()

		if var_86_0 and not var_86_0:isVisible() then
			return false
		end

		return var_80_10(var_86_0)
	end

	local var_80_11 = cc.EventListenerTouchOneByOne:create()

	var_80_11:setSwallowTouches(false)
	var_80_11:registerScriptHandler(function(arg_87_0, arg_87_1)
		if not var_80_10(self) then
			return false
		end

		local var_87_0 = self.activityBnt:convertToNodeSpace((arg_87_0:getLocation()))
		local var_87_1, var_87_2 = self.activityBnt:getPosition()
		local var_87_3 = self.activityBnt:getContentSize()

		if cc.rectContainsPoint(cc.rect(0, 0, var_87_3.width, var_87_3.height), var_87_0) then
			var_80_6 = false
			var_80_7 = true

			return true
		else
			var_80_6 = true
			var_80_7 = false

			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_80_11:registerScriptHandler(function(arg_88_0, arg_88_1)
		local var_88_0 = self.activityBnt:convertToNodeSpace((arg_88_0:getLocation()))
		local var_88_1 = self.activityBnt:convertToNodeSpace((arg_88_0:getStartLocation()))
		local var_88_2, var_88_3 = self.activityBnt:getPosition()
		local var_88_4 = self.activityBnt:getContentSize()

		if cc.rectContainsPoint(cc.rect(0, 0, var_88_4.width, var_88_4.height), var_88_0) then
			if var_80_7 then
				if math.abs(var_88_0.x - var_88_1.x) > 50 then
					var_80_8(var_88_0.x < var_88_1.x)
				else
					var_80_9()
				end
			else
				var_80_8(var_88_0.x < var_88_1.x)
			end
		elseif var_80_7 then
			var_80_8(var_88_0.x < var_88_1.x)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_80_11, self.activityBnt)
	self.activityBnt:loadTextures("mainScenebg/flashwindow/" .. var_80_0[1].image .. ".png", nil, nil)

	if var_80_0[1].image == 8380001 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2025-10-09 23:59:59") then
		self.activityBnt:loadTextures("mainScenebg/flashwindow/" .. var_80_0[1].image .. "_replace.png", nil, nil)
	end

	self.actScheduler = self.actScheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		var_80_2 = var_80_2 + 1

		var_80_5(var_80_2 % var_80_1 + 1)

		if var_80_2 + 1 == var_80_1 then
			var_80_1 = #var_80_0
		end
	end, 4, false)
end

function MainLayer.createAwardPanel(arg_90_0, arg_90_1)
	function arg_90_1.callback()
		SwitchManageLayer:switchAniUIElemen(SwitchManageLayer.activeLayerName, true)

		if not MainLayer.getInstance() then
			return
		end

		MainLayer.getInstance().ispanelgo = true

		arg_90_0:showActivityGiftEntrance()
	end

	LayerManager:pushInLayer("ActivityLayer", arg_90_1)
end

function MainLayer:showActivityGiftEntrance()
	if not self.rechargeGift then
		return
	end

	if playermodel.haverechargeaward == false then
		self.rechargeGift:setVisible(true)
		self.rechargeGift:setTouchEnabled(true)
	else
		self.rechargeGift:runAction(cc.RemoveSelf:create())
	end
end

function MainLayer:redrawOtherActivityAlert()
	if not self.activityIcon or not next(self.activityIcon) then
		return
	end

	for iter_93_0, iter_93_1 in pairs(self.activityIcon) do
		local var_93_0 = activity_manager:getActivityObj(iter_93_0)
		local var_93_1 = var_93_0:getMainlayerParentName()
		local var_93_2 = var_93_0:getMainLayerAlertPos()

		if (var_93_0._status == var_0_41 or var_93_0._status == var_0_42) and var_93_2 then
			if activity_manager:getAlertAllStatus(iter_93_0) then
				global_add_alert_tag(self.activityIcon[iter_93_0], var_93_2)

				if var_93_1 == "panel_sencondlist" then
					global_add_alert_tag(self.activityEntrance, {
						x = 100,
						y = 120
					})
				end

				if self.activityNew and self.activityNew.id == iter_93_0 then
					global_add_alert_tag(self.activityNew, var_93_2)
				end
			else
				global_remove_alert_tag(self.activityIcon[iter_93_0])

				if self.activityNew and self.activityNew.id == iter_93_0 then
					global_remove_alert_tag(self.activityNew)
				end
			end
		end
	end

	for iter_93_2, iter_93_3 in pairs(self.activityIcon) do
		local var_93_4 = activity_manager:getActivityObj(iter_93_2)
		local var_93_5 = var_93_4:getMainLayerAlertPos()
		local var_93_6 = var_93_4:getMainLayerNewAlertPos()

		if var_93_4:getMainlayerParentName() == "panel_sencondlist" then
			if activity_manager:checkMainNewActivity(iter_93_2) == true then
				alert_manager:add_alert_by_config(self.activityIcon[iter_93_2], true, {
					ALERT_SHOW_NEW,
					"",
					var_93_6
				})

				self.newActivityNum = self.newActivityNum + 1
			else
				alert_manager:add_alert_by_config(self.activityIcon[iter_93_2], false, {
					ALERT_SHOW_NEW
				})
			end
		end
	end
end

function MainLayer:redrawActivityAlert()
	if self.activityDoorSprit then
		self.activityDoorSprit:redrawActivityAlert()
	end

	if self.activityLeftDoorSprite then
		self.activityLeftDoorSprite:redrawActivityAlert()
	end

	if self.activityTopDoorSprite then
		self.activityTopDoorSprite:redrawActivityAlert()
	end

	self:redrawOtherActivityAlert()
end

function MainLayer:redrawActivityEntranceAlert(arg_95_1, arg_95_2)
	if not arg_95_1 then
		return
	end

	local var_95_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice")
	local var_95_1 = {
		x = 175,
		y = 90
	}

	alert_manager:add_new_mark(var_95_0, false)
	global_remove_alert_tag(var_95_0)

	if arg_95_2 == 3000001 and activity_manager:isActivityEntranceNeedAlert() then
		global_add_alert_tag(var_95_0, var_95_1)

		return
	end

	if activity_manager:isActivityInEntranceNeedAlert(arg_95_1) then
		alert_manager:register_alert(ALERT_RED_ACTIVITY)
		global_add_alert_tag(var_95_0, var_95_1)
	end

	if activity_manager:isNewActivity(arg_95_2) then
		activity_manager:checkRedNode(var_95_0)
		alert_manager:add_new_mark(var_95_0, true, {
			x = 135,
			y = 90
		})
		var_95_0:getChildByName("alert_new"):setScale(0.8)
	end
end

local var_0_52 = {}

function MainLayer:autoPopActivity()
	self:registerCustomEvent("AUTO_POP_EVENT", function(arg_97_0)
		self.autopop_count = 0

		if var_0_52[playermodel.playerid] then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		else
			var_0_52[playermodel.playerid] = true

			autopop_manager:check_autopop_event()
		end
	end)
	self:registerCustomEvent("INITIAL_POP_SIGN_LIST", function(arg_98_0)
		if not arg_98_0 then
			return
		end

		if not arg_98_0.list then
			return
		end

		autopop_manager:init_autopop_list_by_layername("MainLayer", arg_98_0.list)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
	end)

	local function var_96_0()
		if autopop_manager:getOhterStatus() ~= 1 then
			return
		end

		if autopop_manager:is_empty_with_popsignlist("MainLayer") then
			return
		end

		local var_99_0 = autopop_manager:remove_popsignlist("MainLayer", 1)

		if not var_99_0 then
			return
		end

		local var_99_1 = autopop_manager:get_autopop_func("MainLayer", var_99_0)

		if not var_99_1 then
			var_96_0()

			return
		end

		var_99_1()
	end

	self:registerCustomEvent("AUTO_POP_SIGN", function(arg_100_0)
		self.autopop_count = self.autopop_count + 1

		if self.autopop_count > var_0_46 then
			return
		end

		var_96_0()
	end)
end

function MainLayer:registerCustomEvent(arg_101_1, arg_101_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_101_1, arg_101_2), self)
end

function MainLayer:addSpringElement()
	local var_102_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_notice")
	local var_102_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_leftBottom")

	if var_102_0:getChildByName("denglong") then
		var_102_0:getChildByName("denglong"):removeFromParent()
	end

	if var_102_1:getChildByName("linespring") then
		var_102_0:getChildByName("linespring"):removeFromParent()
	end

	local var_102_2

	if not var_0_15[100] or not var_0_15[100].starttime or not var_0_15[100].finishtime then
		do return end

		var_102_2 = time_check_manager:getCurTime()
	end

	if global_get_time_by_date(var_0_15[100].starttime) <= var_102_2 and var_102_2 < global_get_time_by_date(var_0_15[100].finishtime) then
		local var_102_3 = ccui.ImageView:create("MainLayer/denglong.png", var_0_29)

		var_102_3:setPosition(cc.p(0, 0))
		var_102_3:setName("denglong")
		var_102_0:addChild(var_102_3, 10)

		local var_102_4 = ccui.ImageView:create("MainLayer/linespring.png", var_0_29)

		var_102_4:setPosition(cc.p(var_102_1:getContentSize().width / 2 + 74, var_102_1:getPositionY() + var_102_1:getContentSize().height + 140))
		var_102_4:setName("linespring")
		var_102_1:addChild(var_102_4)
	end
end

function MainLayer:checkTest()
	local var_103_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist")

	if var_103_0:getChildByName("Btn_return") then
		var_103_0:getChildByName("Btn_return"):removeFromParent()
	end

	if activity_return_manager:isShowReturnBp() then
		local var_103_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_thirdlist")
		local var_103_2 = ccui.Button:create("activity_return/activity_entrance.png", nil, "activity_return/activity_entrance.png", var_0_29)
		local var_103_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_invite")

		if var_103_3 and var_103_3:isVisible() == true then
			var_103_2:setPosition(cc.p(-85, -400))
		else
			var_103_2:setPosition(cc.p(-85, -350))
		end

		var_103_2:setName("Btn_return")
		var_103_2:addTouchEventListener(function(arg_104_0, arg_104_1)
			if arg_104_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:switchShowLayer("ActivityGameBackGuideLayer")
		end)
		var_103_1:addChild(var_103_2)

		if activity_return_manager:isShowReturnBpRedDot() then
			global_add_alert_tag(var_103_2, cc.p(64, 64))
			var_103_2:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.ScaleTo:create(1, 1.2), (cc.ScaleBy:create(1, 0.8)))))))
			var_103_2:setVisible(false)
		else
			global_remove_alert_tag(var_103_2)
		end
	end

	self:updateThirdBtnListPos()
end

function MainLayer:dealFriendStutus()
	local var_105_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_friend")

	if (RoleDefault:getInstance():getBoolForKey("NewFriendApplyHave", false) or RoleDefault:getInstance():getBoolForKey("NewFriendGiftHave", false)) and var_105_0 then
		global_add_alert_tag(var_105_0, (cc.p(64, 64)))
	elseif var_105_0 then
		global_remove_alert_tag(var_105_0)
	end
end

function MainLayer:updateBtnInviteRedDot(arg_106_1)
	local var_106_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_invite")

	if arg_106_1 and var_106_0 then
		global_add_alert_tag(var_106_0, (cc.p(64, 110)))
	elseif var_106_0 then
		global_remove_alert_tag(var_106_0)
	end
end

function MainLayer:updateBtnCalendarRedDot()
	local var_107_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_calendar")

	if not level_manager:isPlayerPassLevel("3-10") then
		var_107_0:setVisible(false)

		return
	end

	local var_107_1 = false
	local var_107_2 = os.date("*t", (time_check_manager:getCurTime()))
	local var_107_3 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_107_2.year,
		month = var_107_2.month,
		day = var_107_2.day
	})

	for iter_107_0, iter_107_1 in pairs((require("data.activity_calendar_data"))) do
		if var_107_3 + 604800 >= global_get_time_by_date(iter_107_1.starttime) and global_get_time_by_date(iter_107_1.finishtime) >= var_107_3 then
			if RoleDefault:getInstance():getBoolForKey("new_act_" .. iter_107_1.id, true) then
				var_107_1 = true

				break
			end
		end
	end

	if var_107_1 then
		global_add_alert_tag(var_107_0, cc.p(75, 48), 99, 2)
	else
		global_remove_alert_tag(var_107_0)
	end
end

function MainLayer:updateBtnInviteStatus()
	local function var_108_0()
		local var_109_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Btn_return")

		ccui.Helper:seekWidgetByName(self.rootLayer, "button_invite"):setVisible(true)
		self:updateThirdBtnListPos()
	end

	var_108_0()

	if self.invitescheduler ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.invitescheduler)

		self.invitescheduler = nil
	end

	self.invitescheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		var_108_0()
	end, 1, false)

	local var_108_1 = ccui.ImageView:create("public/reddot/limit_time.png", var_0_29)

	var_108_1:setPosition(cc.p(60, 45))
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_invite"):addChild(var_108_1)
end

local var_0_53 = false

function MainLayer.showWebActivity(arg_111_0, arg_111_1)
	activity_manager:get_activity_memory_session(arg_111_1, function(arg_112_0)
		if var_0_53 then
			return
		end

		var_0_53 = true

		local var_112_0 = ccui.Layout:create()

		var_112_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_112_0:setTouchEnabled(true)
		var_112_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_112_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_112_0:setBackGroundColorOpacity(150)
		global_basic_scene:addChild(var_112_0, 999)

		local var_112_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

		var_112_1:setAnchorPoint(cc.p(0.5, 1))
		var_112_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_112_0:addChild(var_112_1)
		var_112_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			if not ccexp.WebView then
				return
			end

			local var_113_0 = ccexp.WebView:create()

			var_113_0:setVisible(true)
			var_113_0:setScalesPageToFit(true)
			var_113_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
			var_113_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
			var_113_0:loadURL(arg_112_0)
			var_113_0:setOnDidFinishLoading(function(arg_114_0, arg_114_1)
				return
			end)
			var_112_0:addChild(var_113_0, 10)

			local var_113_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

			var_113_1:setScale(0.5)
			var_113_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
			var_112_0:addChild(var_113_1, 100)
			var_113_1:addTouchEventListener(function(arg_115_0, arg_115_1)
				if arg_115_1 ~= ccui.TouchEventType.ended then
					return
				end

				var_0_53 = false

				var_112_0:runAction(cc.RemoveSelf:create())
			end)
		end)))
	end)
end

function MainLayer:initButtonGuide()
	local var_116_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_guidephone")

	var_116_0:addTouchEventListener(function(arg_117_0, arg_117_1)
		if arg_117_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_117_0:isVisible() or arg_117_0:getOpacity() == 0 then
			return
		end

		LayerManager:switchShowLayer("GuidePhoneLayer")
	end)

	local var_116_1 = ccui.TextBMFont:create("", "fonts/guidephone_number.fnt")

	var_116_1:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_116_1:setRotation(-11)
	var_116_1:setPosition(cc.p(32, 72))
	var_116_1:setName("guidePhoneFnt")
	var_116_0:addChild(var_116_1)
	var_116_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function(...)
		local var_118_0 = os.date("*t")

		var_116_1:setString((string.format("%02d:%02d", var_118_0.hour, var_118_0.min)))
	end), cc.DelayTime:create(0.016666666666666666))))
end

function MainLayer:initShowGirlTouchLayout()
	if not self.showGirlTouchLayout then
		local var_119_0 = cc.UserDefault:getInstance():getBoolForKey("moveShowGirl", true)
		local var_119_1 = RoleDefault:getInstance()

		self.min_scale = 0.3
		self.max_scale = 2
		self.lastdis = 0
		self.scalerate = tonumber(var_119_1:getStringForKey(var_0_45, "1"))
		self.showGirlTouchLayout = TempWidget:CreateTempLayout()

		self.showGirlTouchLayout:setContentSize(GameDisplay.size)
		self.showGirlTouchLayout:align(cc.p(0.5, 0), GameDisplay.cx, -GameDisplay.fix_y)
		self:addChild(self.showGirlTouchLayout)

		local var_119_2 = self.showgirlLayer

		self.showgirlLayer:setPosition(cc.p(tonumber(var_119_1:getStringForKey(var_0_43, "0")), (tonumber(var_119_1:getStringForKey(var_0_44, "0")))))
		self.showgirlLayer:setScale(self.scalerate)

		local var_119_3 = self.showgirlLayer:getContentSize()
		local var_119_4 = cc.EventListenerTouchAllAtOnce:create()

		var_119_4:registerScriptHandler(function(arg_120_0, arg_120_1)
			return true
		end, cc.Handler.EVENT_TOUCHES_BEGAN)
		var_119_4:registerScriptHandler(function(arg_121_0, arg_121_1)
			if not (model_data[playermodel.showgirl].is_own_full_screen_background == 1 or model_data[playermodel.showgirl].is_big_role_image == 1) and not var_119_0 and LayerManager:getCurrentLayerName() == "MainLayer" then
				if #arg_121_0 == 1 then
					local var_121_1 = arg_121_0[1]:getLocation()
					local var_121_2 = arg_121_0[1]:getPreviousLocation()
					local var_121_3 = arg_121_0[1]:getStartLocation()

					if var_121_3.y < GameDisplay.getUiScreenSize().height - 100 and var_121_3.y > 100 then
						if math.abs(var_121_3.x - var_121_1.x) <= 15 and math.abs(var_121_3.y - var_121_1.y) <= 15 then
							return
						end

						local var_121_4 = var_119_2:getPositionX() - (var_121_2.x - var_121_1.x)
						local var_121_5 = var_119_2:getPositionY() - (var_121_2.y - var_121_1.y)

						if var_121_4 < -var_119_3.width / 2 then
							var_121_4 = -var_119_3.width / 2
						end

						if var_121_4 > var_119_3.width / 2 then
							var_121_4 = var_119_3.width / 2
						end

						if var_121_5 < -var_119_3.height / 2 + GameDisplay.fix_y then
							var_121_5 = -var_119_3.height / 2 + GameDisplay.fix_y
						end

						if var_121_5 > var_119_3.height / 2 + GameDisplay.fix_y then
							var_121_5 = var_119_3.height / 2 + GameDisplay.fix_y
						end

						var_119_2:setPosition(var_121_4, var_121_5)

						self.lastdis = 0

						if ((var_121_3.x - var_121_1.x)^2 + (var_121_3.y - var_121_1.y)^2)^0.5 > 12 then
							self.is_more_touch = true
						end
					end
				elseif #arg_121_0 == 2 then
					local var_121_6 = arg_121_0[1]:getLocation()
					local var_121_7 = arg_121_0[2]:getLocation()
					local var_121_8 = arg_121_0[1]:getStartLocation()
					local var_121_9 = arg_121_0[2]:getStartLocation()

					self.scalerate = (((var_121_6.x - var_121_7.x)^2 + (var_121_6.y - var_121_7.y)^2)^0.5 - ((var_121_8.x - var_121_9.x)^2 + (var_121_8.y - var_121_9.y)^2)^0.5 - self.lastdis) / 550 + self.scalerate
					self.lastdis = ((var_121_6.x - var_121_7.x)^2 + (var_121_6.y - var_121_7.y)^2)^0.5 - ((var_121_8.x - var_121_9.x)^2 + (var_121_8.y - var_121_9.y)^2)^0.5

					if self.scalerate < self.min_scale then
						self.scalerate = self.min_scale
					end

					if self.scalerate > self.max_scale then
						self.scalerate = self.max_scale
					end

					var_119_2:setScale(self.scalerate)

					self.is_more_touch = true
				end
			end
		end, cc.Handler.EVENT_TOUCHES_MOVED)
		var_119_4:registerScriptHandler(function(arg_122_0, arg_122_1)
			local var_122_0 = cc.p(var_119_2:getPosition())

			var_119_1:setStringForKey(var_0_45, tostring(self.scalerate))
			var_119_1:setStringForKey(var_0_43, tostring(var_122_0.x))
			var_119_1:setStringForKey(var_0_44, tostring(var_122_0.y))
		end, cc.Handler.EVENT_TOUCHES_ENDED)
		var_119_4:registerScriptHandler(function(arg_123_0, arg_123_1)
			local var_123_0 = cc.p(var_119_2:getPosition())

			var_119_1:setStringForKey(var_0_45, tostring(self.scalerate))
			var_119_1:setStringForKey(var_0_43, tostring(var_123_0.x))
			var_119_1:setStringForKey(var_0_44, tostring(var_123_0.y))
		end, cc.Handler.EVENT_TOUCH_CANCELLED)
		self.showGirlTouchLayout:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_119_4, self.showGirlTouchLayout)
	end
end

function MainLayer:resetShowGirlPos()
	local var_124_0 = RoleDefault:getInstance()

	self.scalerate = 1

	var_124_0:setStringForKey(var_0_45, tostring(self.scalerate))
	var_124_0:setStringForKey(var_0_43, tostring(0))
	var_124_0:setStringForKey(var_0_44, tostring(0))
	self.showgirlLayer:setPosition(cc.p(0, 0))
	self.showgirlLayer:setScale(self.scalerate)
end

function MainLayer:updateShowGirlBack()
	if self.showGirlBack then
		self.showGirlBack:setVisible(false)
	end

	local var_125_0 = model_data[playermodel.showgirl].backgroundid_main

	if model_data[playermodel.showgirl].backgroundid_main then
		local var_125_1 = 1

		if model_data[playermodel.showgirl].is_own_full_screen_background == 1 then
			var_125_1 = 2
		end

		if not self.showGirlBack then
			self.showGirlBack = BackGroundLayer:create(var_125_0, var_125_1)

			self.showGirlBack:setPosition(cc.p(0, 0))
			self:addChild(self.showGirlBack, -2)
		else
			self.showGirlBack:setVisible(true)
			self.showGirlBack:update(var_125_0, var_125_1)
		end
	end
end

function MainLayer:addAutoDownloader()
	self._btnAutoDownload = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sencondlist"):getChildByName("btn_autodownload")

	self._btnAutoDownload:setVisible(false)
end

function MainLayer.check_show_appstar_and_debug(arg_127_0)
	network:rpc("check_guide_stat", {
		id = GUIDE_APPSTAR_AND_DEBUG
	}, function(arg_128_0)
		if arg_128_0.result > 0 then
			global_show_appstar_and_debug()
		else
			hx_print(L_GUIDE_MAIN_DEBUG[arg_128_0.result])
		end
	end)
end
