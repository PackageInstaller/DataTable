local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local shop_manager = require("controller.shop_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local var_0_6
local var_0_7 = config._DEBUG and 0 or 1
local var_0_9 = 120
local var_0_10 = "mainScenebg/activity/common/dianji.png"
local var_0_11 = "mainScenebg/activity/common/activity_entrance.png"
local ActivityDoorSprite = class("ActivityDoorSprite", function()
	return cc.Node:create()
end)

function ActivityDoorSprite:create()
	local var_2_0 = ActivityDoorSprite.new()

	var_2_0:init()

	return var_2_0
end

function ActivityDoorSprite:init()
	var_0_6 = self
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	self.iconList = {}

	self:initUI()
	self:initActivityList()
	self:registerArrowTouchEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_6 = nil
		end
	end)
end

function ActivityDoorSprite:initUI()
	self.line = ccui.ImageView:create("MainLayer/secondlist/line.png", var_0_7)

	self.line:setAnchorPoint(0.5, 1)
	self.line:setPosition(0, 0)
	self.rootLayer:addChild(self.line)

	self.imageBottom = ccui.ImageView:create("MainLayer/secondlist/short_activity_bottom.png", var_0_7)

	self.imageBottom:setAnchorPoint(cc.p(0.5, 1))
	self.imageBottom:setPosition(0, -self.line:getContentSize().height + 5)
	self.imageBottom:setScale9Enabled(true)
	self.imageBottom:setCapInsets(cc.rect(0, 28, 97, 103))
	self.rootLayer:addChild(self.imageBottom)

	self.arrowPanel = ccui.Layout:create()

	self.arrowPanel:setAnchorPoint(cc.p(0.5, 1))
	self.arrowPanel:setContentSize(self.imageBottom:getContentSize().width, self.imageBottom:getContentSize().height)
	self.arrowPanel:setPosition(self.imageBottom:getPositionX(), self.imageBottom:getPositionY())
	self.rootLayer:addChild(self.arrowPanel, 9)

	self.mask = ccui.ImageView:create("MainLayer/secondlist/short_activity_mask.png", var_0_7)

	self.mask:setAnchorPoint(cc.p(0.5, 0))
	self.mask:setPosition(self.arrowPanel:getContentSize().width / 2, 0)
	self.arrowPanel:addChild(self.mask)

	self.arrowBtn = ccui.Button:create("MainLayer/secondlist/arrow.png", nil, "MainLayer/secondlist/arrow.png", var_0_7)

	self.arrowBtn:setScaleY(-1)
	self.arrowBtn:setPosition(self.arrowPanel:getContentSize().width / 2, 20)
	self.arrowPanel:addChild(self.arrowBtn)

	self.clipPanel = cc.ClippingNode:create()

	self.clipPanel:setInverted(false)
	self.clipPanel:setAlphaThreshold(0.5)
	self.clipPanel:setPosition(self.imageBottom:getPositionX(), self.imageBottom:getPositionY())
	self.rootLayer:addChild(self.clipPanel)

	var_0_9 = self.imageBottom:getContentSize().width

	if config._DEBUG then
		self.clipSprite = cc.Scale9Sprite:create("MainLayer/secondlist/short_activity_bottom.png") or cc.Scale9Sprite:createWithSpriteFrameName("MainLayer/secondlist/short_activity_bottom.png")
	end

	self.clipSprite:setAnchorPoint(cc.p(0.5, 1))
	self.clipSprite:setCapInsets(cc.rect(0, 28, 97, 103))
	self.clipSprite:setContentSize(cc.size(var_0_9, self.imageBottom:getContentSize().height))
	self.clipPanel:setStencil(self.clipSprite)

	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setAnchorPoint(cc.p(0.5, 1))
	self.scrollView:setClippingType(ccui.Layout.CLIPPING_SCISSOR)
	self.scrollView:setContentSize(cc.size(var_0_9, self.imageBottom:getContentSize().height))
	self.scrollView:setInnerContainerSize(cc.size(var_0_9, self.imageBottom:getContentSize().height))
	self.scrollView:setClippingEnabled(false)
	self.scrollView:setBounceEnabled(true)
	self.clipPanel:addChild(self.scrollView)
end

function ActivityDoorSprite:registerArrowTouchEvent()
	self.arrowBtn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchListPanel()
	end)
end

function ActivityDoorSprite:getListConfig()
	local var_8_0 = activity_manager:getMainlayerList()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs((self:getEntranceList())) do
		local var_8_3 = {
			type = "entrance",
			info = iter_8_1
		}

		var_8_3.order = iter_8_1.door_order or 0

		table.insert(var_8_1, var_8_3)
	end

	table.sort(var_8_1, function(arg_9_0, arg_9_1)
		return arg_9_0.order > arg_9_1.order
	end)

	if not activity_manager:is_module_stat_finished(2, "sign") then
		table.insert(var_8_1, 1, {
			type = "activity_2_sign"
		})
	end

	table.insert(var_8_1, {
		type = "menu"
	})

	if time_check_manager:getCurTime() > os.time(parse_time("2020-12-18 00:00:00")) and time_check_manager:getCurTime() - playermodel.create_time < 604800 then
		table.insert(var_8_1, 1, {
			type = "recharge_gift"
		})
	end

	return var_8_1
end

function ActivityDoorSprite:getEntranceList()
	local var_10_0 = {}

	local function var_10_1(arg_11_0)
		local var_11_0 = time_check_manager:getCurTime()

		if arg_11_0.door_starttime and var_11_0 < os.time(parse_time(arg_11_0.door_starttime)) then
			return false
		end

		if arg_11_0.door_finishtime and var_11_0 > os.time(parse_time(arg_11_0.door_finishtime)) then
			return false
		end

		return true
	end

	for iter_10_0, iter_10_1 in pairs(activity_manager:getActivityEntranceList() or {}) do
		if iter_10_1.isinactivitydoor and var_10_1(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	table.sort(var_10_0, function(arg_12_0, arg_12_1)
		return arg_12_0.order < arg_12_1.order
	end)

	return var_10_0
end

function ActivityDoorSprite:initActivityList()
	local var_13_0 = self:getListConfig()

	if #var_13_0 == 0 then
		self:setVisible(false)

		return
	else
		self:setVisible(true)
	end

	self.mask:setVisible(#var_13_0 >= 4)

	local var_13_1 = -65
	local var_13_2 = 125
	local var_13_3 = 161

	if #var_13_0 > 1 then
		local var_13_4 = #var_13_0 >= 4 and 440 or #var_13_0 * 125 + 30

		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, #var_13_0 >= 4 and 440 or #var_13_0 * 125 + 30))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, var_13_4))
		self.arrowPanel:setContentSize(cc.size(self.imageBottom:getContentSize().width, var_13_4))
		self.scrollView:setContentSize(cc.size(self.imageBottom:getContentSize().width, var_13_4))
		self.scrollView:setInnerContainerSize(cc.size(self.imageBottom:getContentSize().width, #var_13_0 * 125 + 30))

		self.imageBottom.limitheight = var_13_4
		self.imageBottom.minheight = var_13_3
		self.imageBottom.list_type = 1
	else
		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, var_13_3))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, var_13_3))

		self.imageBottom.limitheight = var_13_3
		self.imageBottom.minheight = var_13_3
		self.imageBottom.list_type = -1
	end

	self.imageBottom.activity_num = #var_13_0

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_5

		if iter_13_1.type == "recharge" then
			var_13_5 = self:createRechagreIcon()
		elseif iter_13_1.type == "menu" then
			var_13_5 = self:createMenuIcon()
		elseif iter_13_1.type == "entrance" then
			var_13_5 = self:createEntranceIcon(iter_13_1.info)

			var_13_5:setName("entrance" .. iter_13_0)
		elseif iter_13_1.type == "recharge_gift" then
			var_13_5 = self:createRechargeGiftIcon()
		elseif iter_13_1.type == "activity_2_sign" then
			var_13_5 = self:createActivity2SignIcon()
		elseif iter_13_1.type == "activity" then
			var_13_5 = self:createActivityIcon(iter_13_1.activityid, iter_13_1.activityObj)
		end

		var_13_5:setPosition(self.scrollView:getInnerContainerSize().width / 2, self.scrollView:getInnerContainerSize().height + var_13_1 - (iter_13_0 - 1) * var_13_2)
		self.scrollView:addChild(var_13_5)

		self.iconList[iter_13_0] = var_13_5
	end

	self:redrawActivityAlert()
end

function ActivityDoorSprite:checkIsShowRecharge()
	return not playermodel.haverechargeaward
end

function ActivityDoorSprite:checkIsRechargeFirst()
	local var_15_0 = os.date("*t", playermodel.create_time)
	local var_15_1 = os.date("*t", time_check_manager:getCurTime())

	if playermodel.haverecharge then
		return true
	end

	if math.abs(var_15_0.year - var_15_1.year) > 1 or math.abs(var_15_0.month - var_15_1.month) > 1 then
		return false
	else
		return true
	end
end

function ActivityDoorSprite:createRechagreIcon()
	local var_16_0 = ccui.Button:create(var_0_10, nil, var_0_10)

	var_16_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_16_0:setScale(0.78)
	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		self:createAwardPanel({
			paneltype = 1
		})
	end)

	if playermodel.haverecharge == true then
		local var_16_1 = ccui.ImageView:create("mainScenebg/activity/common/effect.png")

		var_16_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_16_1:setPosition(cc.p(var_16_0:getContentSize().width / 2, var_16_0:getContentSize().height / 2))
		var_16_0:addChild(var_16_1)
		var_16_1:setOpacity(40)
		var_16_1:setScale(0.5)
		var_16_1:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Spawn:create(cc.EaseOut:create(cc.ScaleTo:create(1, 3, 3), 2), cc.Sequence:create(cc.FadeTo:create(1 / 3, 255), cc.FadeTo:create(1 * 2 / 3, 40))), cc.CallFunc:create(function()
			var_16_1:setOpacity(40)
			var_16_1:setScale(0.5)

			if playermodel.haverechargeaward == true then
				var_16_1:stopAllActions()
			end
		end), cc.DelayTime:create(1 / 2))))))
	end

	var_16_0.type = "recharge"

	return var_16_0
end

function ActivityDoorSprite:createActivityIcon(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2:getMainLayerImage()
	local var_19_1 = ccui.Button:create(var_19_0[1], nil, var_19_0[2] or var_19_0[1])

	var_19_1:setScale(0.78)
	var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_20_0:isBright() then
			return
		end

		local var_20_0 = arg_19_2:getJumpToConfig()

		var_20_0.activityID = arg_19_1

		ActivityManageLayer:create(var_20_0)

		local var_20_1 = {
			enterType = "ActivityDoor",
			activityid = arg_19_1
		}

		var_20_1.jumpid = var_20_0.jumpToLayer or var_20_0.systemid

		AnalyticManager.clickActivityEntranceType(var_20_1)
	end)

	var_19_1.type = "activity"
	var_19_1.activityid = arg_19_1

	return var_19_1
end

function ActivityDoorSprite:createMenuIcon()
	local var_21_0 = ccui.Button:create(var_0_11, nil, var_0_11)

	var_21_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_0:setScale(0.78)
	var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_22_0:isBright() then
			return
		end

		LayerManager:switchShowLayer("ActivityEntranceLayer")
	end)

	var_21_0.type = "menu"

	return var_21_0
end

function ActivityDoorSprite:createEntranceIcon(arg_23_1)
	local var_23_0 = (function(arg_24_0)
		if not arg_24_0 then
			return
		end

		return string.gsub(arg_24_0, "@", "/")
	end)(arg_23_1.door_img_path) or var_0_11
	local var_23_1 = ccui.Button:create(var_23_0, nil, var_23_0)

	var_23_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_1:setScale(0.78)
	var_23_1:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")

		if arg_23_1.jump_talk then
			global_basic_scene:addChild(TalkLayer:create(arg_23_1.jump_talk, nil, 1, ""))
		else
			goto_complete_system({
				jump_to_system = arg_23_1.jump
			})
		end

		AnalyticManager.clickActivityEntranceType({
			enterType = "ActivityLeftDoor",
			activityid = arg_23_1.configId,
			jumpid = systemID
		})
	end)

	var_23_1.type = "entrance"
	var_23_1.activityid = arg_23_1.configId
	var_23_1.alert_activity_systemid = arg_23_1.alert_activity_systemid
	var_23_1.jump = arg_23_1.jump
	var_23_1.force_new_reddot = arg_23_1.force_new_reddot

	return var_23_1
end

function ActivityDoorSprite:createRechargeGiftIcon()
	local var_26_0 = ccui.Button:create("mainScenebg/activity/branch2/recharge_gift.png", nil, "mainScenebg/activity/branch2/recharge_gift.png")

	var_26_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_26_0:setScale(0.78)
	var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SupermarketLayer", {
			initSelectPage = 3
		})
		AnalyticManager.clickActivityEntranceType({
			jumpid = 103,
			enterType = "ActivityDoor"
		})
	end)

	return var_26_0
end

function ActivityDoorSprite:createActivity2SignIcon(...)
	local var_28_0 = ccui.Button:create("mainScenebg/activity/branch2/sign.png", nil, "mainScenebg/activity/branch2/sign.png")

	var_28_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_0:setScale(0.78)
	var_28_0:addTouchEventListener(function(arg_29_0, arg_29_1)
		local var_29_0

		if arg_29_1 ~= ccui.TouchEventType.ended then
			do return end

			var_29_0 = {
				activityid = 2,
				activityUIObjName = "ActivitySignFmlLayer"
			}
		end

		function var_29_0.exit_set_bright_callback()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end

		LayerManager:pushInLayer("ActivitySignBaseLayer", var_29_0)
		AnalyticManager.clickActivityEntranceType({
			activityid = 2,
			jumpid = 104,
			enterType = "ActivityDoor"
		})
	end)

	return var_28_0
end

function ActivityDoorSprite:switchListPanel()
	if self.imageBottom.activity_num <= 1 then
		return
	end

	local var_31_0

	if self.imageBottom.list_type == -1 then
		var_31_0 = 10
	elseif self.imageBottom.list_type == 1 then
		var_31_0 = -10
	end

	self.imageBottom:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_32_0 = self.imageBottom:getContentSize().width
		local var_32_1 = self.imageBottom:getContentSize().height + var_31_0

		self.imageBottom:setContentSize(cc.size(var_32_0, var_32_1))
		self.clipSprite:setContentSize(cc.size(var_32_0, var_32_1))
		self.arrowPanel:setContentSize(cc.size(var_32_0, var_32_1))

		if self.imageBottom:getContentSize().height >= self.imageBottom.limitheight or self.imageBottom:getContentSize().height <= self.imageBottom.minheight then
			self.imageBottom:stopAllActions()
			self.arrowBtn:setScaleY(-self.arrowBtn:getScaleY())

			self.imageBottom.list_type = -self.imageBottom.list_type

			self:updateActivityList()
			self:updateArrowAlert()
			self:updateArrowReddot(isReddot)
		end
	end))))
end

function ActivityDoorSprite:updateActivityList()
	if self.imageBottom.list_type == 1 then
		for iter_33_0, iter_33_1 in pairs(self.iconList) do
			if iter_33_0 ~= 1 then
				iter_33_1:setVisible(true)
			end
		end

		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, self.imageBottom.limitheight))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, self.imageBottom.limitheight))
		self.arrowPanel:setContentSize(cc.size(self.arrowPanel:getContentSize().width, self.imageBottom.limitheight))
	elseif self.imageBottom.list_type == -1 then
		for iter_33_2, iter_33_3 in pairs(self.iconList) do
			if iter_33_2 ~= 1 then
				iter_33_3:setVisible(false)
			end
		end

		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, self.imageBottom.minheight))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, self.imageBottom.minheight))
		self.arrowPanel:setContentSize(cc.size(self.arrowPanel:getContentSize().width, self.imageBottom.minheight))
		self.scrollView:jumpToTop()
	end
end

function ActivityDoorSprite:resetActivityList()
	self.scrollView:removeAllChildren()
	self:initActivityList()
end

function ActivityDoorSprite:redrawActivityAlert()
	local var_35_0 = false
	local var_35_1 = false

	local function var_35_2(arg_36_0, arg_36_1)
		local var_36_0 = activity_manager:getActivityObj(arg_36_0.activityid)
		local var_36_1 = var_36_0:getMainLayerAlertPos()

		if var_36_0._status == ACTIVITY_ACTIVING or var_36_0._status == ACTIVITY_ENDED then
			if arg_36_0.activityid ~= 15 then
				if activity_manager:getAlertAllStatus(arg_36_0.activityid, arg_36_0.alert_activity_systemid) then
					alert_manager:add_alert_by_config(arg_36_0, true, {
						ALERT_SHOW_REDDOT,
						"",
						(arg_36_1 == 1 or nil) and cc.p({
							x = arg_36_0:getContentSize().width - 40,
							y = arg_36_0:getContentSize().height / 2 + 30
						}) or {
							x = arg_36_0:getContentSize().width - 15,
							y = arg_36_0:getContentSize().height - 10
						}
					})

					var_35_1 = true
				else
					alert_manager:add_alert_by_config(arg_36_0, false, {
						ALERT_SHOW_REDDOT
					})
				end
			else
				alert_manager:add_alert_by_config(arg_36_0, false, {
					ALERT_SHOW_REDDOT
				})
			end
		end
	end

	local function var_35_3(arg_37_0)
		local var_37_0 = activity_manager:getActivityObj(arg_37_0.activityid)
		local var_37_1 = var_37_0:getMainLayerAlertPos()

		if activity_manager:checkMainNewActivity(arg_37_0.activityid) then
			alert_manager:add_alert_by_config(arg_37_0, true, {
				ALERT_SHOW_NEW,
				"",
				var_37_0:getMainLayerNewAlertPos() or {
					x = arg_37_0:getContentSize().width - 20,
					y = arg_37_0:getContentSize().height - 10
				}
			})

			var_35_0 = true
		end
	end

	for iter_35_0, iter_35_1 in pairs(self.iconList) do
		if iter_35_1.type == "activity" or iter_35_1.type == "entrance" and iter_35_1.activityid then
			var_35_2(iter_35_1, iter_35_0)
			var_35_3(iter_35_1)
		elseif iter_35_1.type == "entrance" then
			if iter_35_1.jump and iter_35_1.jump >= 1500000 and iter_35_1.jump <= 1599999 then
				shop_manager:get_config_data_single("1-" .. tostring(iter_35_1.jump % 1500000), function(arg_38_0, arg_38_1)
					self:updateShopAlert(arg_38_1, iter_35_0)
				end, iter_35_1.force_new_reddot and iter_35_1.force_new_reddot == 1)
			end
		end
	end

	self:updateArrowAlert(false)
	self:updateArrowReddot(false)
end

function ActivityDoorSprite:updateShopAlert(arg_39_1, arg_39_2)
	if not arg_39_2 then
		return
	end

	if not self.scrollView:getChildByName("entrance" .. arg_39_2) then
		return
	end

	local var_39_0 = self.scrollView:getChildByName("entrance" .. arg_39_2)

	if arg_39_1 and next(arg_39_1) and arg_39_1[1].havenewitem then
		local var_39_1 = {
			ALERT_SHOW_REDDOT,
			""
		}

		var_39_1[3] = pos or {
			x = var_39_0:getContentSize().width - 15,
			y = var_39_0:getContentSize().height - 50
		}

		alert_manager:add_alert_by_config(var_39_0, true, var_39_1)
	end
end

function ActivityDoorSprite:updateArrowAlert(arg_40_1)
	if arg_40_1 ~= nil then
		self.arrowBtn.flag = arg_40_1
	end

	alert_manager:add_alert_by_config(self.arrowBtn, self.arrowBtn.flag or false, {
		ALERT_SHOW_NEW,
		"",
		{
			x = 70,
			y = 30
		}
	})

	if self.arrowBtn:getScaleY() == -1 and self.arrowBtn:getChildByName("alert_new") then
		self.arrowBtn:getChildByName("alert_new"):setVisible(false)
	end
end

function ActivityDoorSprite:updateArrowReddot(arg_41_1)
	if arg_41_1 ~= nil then
		self.arrowBtn.reddot_flag = arg_41_1
	end

	alert_manager:add_alert_by_config(self.arrowBtn, self.arrowBtn.reddot_flag or false, {
		ALERT_SHOW_REDDOT,
		"",
		{
			x = 70,
			y = 30
		}
	})

	if self.arrowBtn:getScaleY() == -1 and self.arrowBtn:getChildByName("alert_reddot") then
		self.arrowBtn:getChildByName("alert_reddot"):setVisible(false)
	end
end

function ActivityDoorSprite:createAwardPanel(arg_42_1)
	function arg_42_1.callback()
		if var_0_6 then
			SwitchManageLayer:switchAniUIElemen(SwitchManageLayer.activeLayerName, true)

			if not var_0_6:checkIsShowRecharge() then
				var_0_6:resetActivityList()
			end
		end
	end

	LayerManager:pushInLayer("PopNoviceAwardLayer", arg_42_1)
end

return ActivityDoorSprite
