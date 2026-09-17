ActivityUmaruMainLayer = class("ActivityUmaruMainLayer", function()
	return cc.Layer:create()
end)

require("controller.goto_system_manager")

local activity_manager = require("controller.activity_manager")
local activity_umaru_manager = require("controller.activity_umaru_manager")
local time_check_manager = require("controller.time_check_manager")
local share_manager = require("controller.share_manager")
local explore_manager = require("controller.explore_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local l2utils = require("controller.l2utils")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9

function ActivityUmaruMainLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityUmaruMainLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityUmaruMainLayer.getInstance()
	return var_0_9
end

function ActivityUmaruMainLayer:init()
	var_0_9 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityUmaruMain.json" or "ActivityUmaruMain.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setVisible(false)
	self:initData()

	local var_4_0 = activity_conf_data[self.id].Start_conversation or 3102002

	if not RoleDefault:getInstance():getBoolForKey("isFistEnterUmaruLayer") and var_4_0 then
		global_basic_scene:addChild(TalkLayer:create(var_4_0, nil, TALK_TYPE_TRAVEL, "", function()
			RoleDefault:getInstance():setBoolForKey("isFistEnterUmaruLayer", true)
			self.rootLayer:setVisible(true)
		end), ZORDER_TALKLAYER)
	else
		self.rootLayer:setVisible(true)
	end

	self:registerActivityEventListener()
	self:initUI()
	self:updateUI()
	self:fullScreen()
	self:showStartAni()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_9 = nil

			activity_manager:releaseEventListenerByName("ActivityUmaruMainLayer")

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function ActivityUmaruMainLayer.initData(arg_7_0)
	arg_7_0.id = 137

	activity_umaru_manager:getActivityInfo(function(arg_8_0)
		arg_7_0:initActivityExplore(arg_8_0)
	end)
end

function ActivityUmaruMainLayer:initUI()
	self.panelLeft = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_left")
	self.panelRight = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_right")
	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom")
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "img_main")

	self.bg:loadTexture("mainScenebg/activity/branch" .. self.id .. "/main_bg.png")
	self.bg:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX))
	self:initSurplusTime()
	self:initAllBtn()
	self:initRedDotNode()
	self:createShareButton()
end

local function var_0_10(arg_10_0)
	local var_10_5 = math.floor(arg_10_0 / 24 / 3600)

	arg_10_0 = arg_10_0 - var_10_5 * 24 * 3600

	local var_10_6 = math.floor(arg_10_0 / 3600)

	arg_10_0 = arg_10_0 - var_10_6 * 3600

	local var_10_7 = math.floor(arg_10_0 / 60)

	return 0 ~= 0 and string.format(L_TIME_REST2 .. L_TIME .. L_TIME_TEXT[1], var_10_5, var_10_6) or var_10_6 ~= 0 and string.format(L_TIME_REST2 .. L_TIME .. L_TIME_TEXT[2], var_10_6, var_10_7) or string.format(L_TIME_REST2 .. L_TIME .. L_TIME_TEXT[3], var_10_7)
end

function ActivityUmaruMainLayer:initSurplusTime()
	local var_11_0 = cc.Label:createWithTTF("", FONT_NAME, 40)

	var_11_0:setAnchorPoint(cc.p(0.5, 1))
	var_11_0:setName("time")
	var_11_0:setColor(cc.c3b(255, 255, 255))
	var_11_0:setPosition(cc.p(400, self.bg:getContentSize().height - 260))
	self.bg:addChild(var_11_0)
	self:createSurplusTime(var_11_0, activity_conf_data[self.id].finishtime)
end

function ActivityUmaruMainLayer.createSurplusTime(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = global_get_time_by_date(arg_12_2) - time_check_manager:getCurTime()

	if not var_12_0 then
		return
	end

	arg_12_0.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_12_0, function(arg_13_0)
		if arg_12_1 then
			arg_12_1:setString((var_0_10(arg_13_0)))

			if arg_13_0 <= 0 and arg_12_1 then
				time_check_manager:removeUpdatePool(arg_12_0.activityScheduler)
				arg_12_1:setVisible(false)
			end
		end
	end)))
end

function ActivityUmaruMainLayer:initActivityExplore(arg_14_1)
	local var_14_0 = self.panelBottom:getChildByName("btn_bottom_4")

	self.total_daily_times = arg_14_1.total_daily_times or 0
	self.surplus_times = arg_14_1.surplus_times or 0
	self.buy_times = arg_14_1.buy_times or 0
	self.next_step = arg_14_1.next_step or 1

	if self.surplus_times == 0 then
		self.panelBottom:getChildByName("btn_bottom_4"):loadTextures("ActivityUmaruMain/btn_adventure_off.png", "ActivityUmaruMain/btn_adventure_off.png", "ActivityUmaruMain/btn_adventure_off.png", var_0_8)
	end
end

function ActivityUmaruMainLayer:initAllBtn()
	self:initLeftBtn()
	self:initRightBtn()
	self:initBottomBtn()
	self:initOtherBtn()
end

function ActivityUmaruMainLayer:initLeftBtn()
	local var_16_0 = {
		function()
			LayerManager:switchShowLayer("ActivityBattlePassLayer_137")
		end,
		function()
			self:showrechargeIcon()
		end,
		function()
			LayerManager:switchShowLayer("AdventurerUmaruInfiniteLayer")
		end
	}

	while self.panelLeft:getChildByName("btn_left_" .. 1) do
		local var_16_1 = self.panelLeft:getChildByName("btn_left_" .. 1)

		var_16_1.index = 1

		var_16_1:setOpacity(0)
		var_16_1:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				do return end

				local var_20_0 = arg_20_0:getTouchEndPosition()
			end

			if not self:checkTouch(arg_20_0:getTouchBeganPosition(), arg_20_0.index, "left") then
				return
			end

			var_16_0[arg_20_0.index]()
		end)
	end

	self.panelLeft:getChildByName("lines"):setOpacity(0)
end

function ActivityUmaruMainLayer:initRightBtn()
	local var_21_0 = {
		function()
			LayerManager:pushInLayer("PopActivityShareLayer", {
				activityid = self.id
			})
		end,
		function()
			LayerManager:pushInLayer("ActivitySignBaseLayer", {
				activityUIObjName = "ActivitySignTemplateLayer",
				activityid = self.id
			})
		end,
		function()
			LayerManager:switchShowLayer("ActivityUmaruTaskLayer")
		end
	}

	while self.panelRight:getChildByName("btn_right_" .. 1) do
		local var_21_1 = self.panelRight:getChildByName("btn_right_" .. 1)

		var_21_1.index = 1

		var_21_1:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				do return end

				local var_25_0 = arg_25_0:getTouchEndPosition()
			end

			if not self:checkTouch(arg_25_0:getTouchBeganPosition(), arg_25_0.index, "right") then
				return
			end

			var_21_0[arg_25_0.index]()
		end)
	end

	self.panelRight:setPositionX(self.panelRight:getPositionX() - 100)
	self.panelRight:getChildByName("btn_right_3"):setVisible(true)
	self.panelRight:getChildByName("btn_right_3"):loadTextures("ActivityUmaruMain/btn_task.png", "ActivityUmaruMain/btn_task.png", "ActivityUmaruMain/btn_task.png", var_0_8)
end

function ActivityUmaruMainLayer:initBottomBtn()
	local var_26_0 = {
		function()
			print("返回")
			KeyCodeManager:onKeyReleasedCallFunc()
		end,
		function()
			require("controller.goto_system_manager")

			local var_28_0 = {
				jump_to_system = 1800121
			}

			var_28_0.config = system_jump_config[SYSTEMID[1800121]] and system_jump_config[SYSTEMID[1800121]].config

			if var_28_0.config and var_28_0.config.exitCallbackType == "function" then
				var_28_0.config.exitCallback = createExitCallback({
					jump_to_system = 30128
				}, self.initconfig)
			end

			goto_complete_system(var_28_0)
		end,
		function()
			LayerManager:switchShowLayer("ActivityUmaruLevelLayer")
		end,
		function()
			self:gotoExplore()
		end
	}

	while self.panelBottom:getChildByName("btn_bottom_" .. 1) do
		local var_26_1 = self.panelBottom:getChildByName("btn_bottom_" .. 1)

		var_26_1:setSwallowTouches(true)

		var_26_1.index = 1

		var_26_1:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				do return end

				local var_31_0 = arg_31_0:getTouchEndPosition()
			end

			if not self:checkTouch(arg_31_0:getTouchBeganPosition(), arg_31_0.index, "bottom") then
				return
			end

			var_26_0[arg_31_0.index]()
		end)
	end

	self.panelBottom:getChildByName("btn_bottom_4"):setSwallowTouches(false)
end

function ActivityUmaruMainLayer:initOtherBtn()
	self.btnDetail = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_detail")

	self.btnDetail:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_umaru_main"
		})
	end)
end

function ActivityUmaruMainLayer:initRedDotNode()
	self.needReddotNode = {
		sign = self.panelRight:getChildByName("btn_right_2"),
		bp = self.panelLeft:getChildByName("btn_left_1"),
		map = self.panelBottom:getChildByName("btn_bottom_3"),
		task = self.panelRight:getChildByName("btn_right_3")
	}
end

function ActivityUmaruMainLayer.checkTouch(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {
		bottom = function()
			return arg_35_0:checkBottomTouch(arg_35_1, arg_35_2)
		end
	}

	local function var_35_1()
		return true
	end

	setmetatable(var_35_0, {
		__index = function(arg_38_0, arg_38_1)
			return var_35_1
		end
	})

	return var_35_0[arg_35_3](arg_35_1, arg_35_2)
end

function ActivityUmaruMainLayer:checkBottomTouch(arg_39_1, arg_39_2)
	local var_39_0 = {
		[2] = {
			{
				x = 128,
				y = 0
			},
			{
				x = 0,
				y = 128
			},
			{
				x = 236,
				y = 364
			},
			{
				x = 236,
				y = 108
			}
		},
		[3] = {
			{
				x = 0,
				y = 0
			},
			{
				x = 272,
				y = 257
			},
			{
				x = 399,
				y = 130
			},
			{
				x = 269,
				y = 0
			}
		},
		[4] = {
			{
				x = 0,
				y = 0
			},
			{
				x = 186,
				y = 189
			},
			{
				x = 186,
				y = 0
			}
		}
	}

	if not var_39_0[arg_39_2] then
		return true
	else
		return isContainPosOfConvexPolygon(var_39_0[arg_39_2], (self.panelBottom:getChildByName("btn_bottom_" .. arg_39_2):convertToNodeSpace(arg_39_1)))
	end
end

function ActivityUmaruMainLayer:showStartAni()
	self.panelLeft:getChildByName("lines"):runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.FadeIn:create(0.2)))

	while self.panelLeft:getChildByName("btn_left_" .. 1) do
		local var_40_0 = self.panelLeft:getChildByName("btn_left_" .. 1)

		var_40_0:setPositionY(var_40_0:getPositionY() + 20)
		var_40_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * (1 - 1)), cc.Spawn:create(cc.FadeIn:create(0.2), cc.EaseIn:create(cc.MoveBy:create(0.2, cc.p(0, -20)), 0.5))))
	end

	self.panelRight:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.EaseIn:create(cc.MoveBy:create(0.4, cc.p(110, 0)), 0.2)))

	local var_40_2 = self.panelBottom:getChildByName("btn_bottom_3")
	local var_40_3 = self.panelBottom:getChildByName("btn_bottom_2")
	local var_40_4 = self.panelBottom:getChildByName("btn_bottom_4")

	var_40_2:setPosition(cc.p(var_40_2:getPositionX() - 240, var_40_2:getPositionY() - 240))
	var_40_3:setPosition(cc.p(var_40_3:getPositionX() + 240, var_40_3:getPositionY() + 240))
	var_40_4:setPositionY(var_40_4:getPositionY() + GameDisplay.height)
	var_40_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.EaseExponentialIn:create((cc.MoveBy:create(0.3, cc.p(240, 240))))))
	var_40_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.EaseExponentialIn:create((cc.MoveBy:create(0.3, cc.p(-240, -240))))))
	var_40_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.EaseExponentialIn:create((cc.MoveBy:create(0.4, cc.p(0, -GameDisplay.height)))), cc.EaseSineOut:create((cc.RotateTo:create(0.4, -30))), cc.EaseExponentialInOut:create((cc.RotateTo:create(0.4, 0)))))
end

function ActivityUmaruMainLayer:updateUI()
	self:redrawAllRedDot()
end

function ActivityUmaruMainLayer:redrawAllRedDot()
	for iter_42_0, iter_42_1 in pairs(self.needReddotNode) do
		self:redrawRedDotByNode(iter_42_0, iter_42_1)
	end

	activity_umaru_manager:getAlertExtraTask(function(arg_43_0)
		self:redrawRedDotByNode("task", self.panelRight:getChildByName("btn_right_3"), arg_43_0)
	end)
end

function ActivityUmaruMainLayer:redrawRedDotByNode(arg_44_1, arg_44_2, arg_44_3)
	if arg_44_3 or activity_umaru_manager:getRedDotStatus({
		name = arg_44_1
	}) then
		self:add_alert_tag(arg_44_2, ({
			sign = {
				x = 20,
				y = 69
			},
			bp = {
				x = 110,
				y = 110
			},
			flop = {
				x = 110,
				y = 110
			},
			adventure = {
				x = 110,
				y = 110
			},
			map = {
				x = 220,
				y = 62
			},
			swim = {
				x = 190,
				y = 70
			},
			task = {
				x = 20,
				y = 69
			}
		})[arg_44_1])
	else
		self:remove_alert_tag(arg_44_2)
	end
end

function ActivityUmaruMainLayer.registerActivityEventListener(arg_45_0)
	activity_manager:registerEventListener("ActivityUmaruMainLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function()
		arg_45_0:redrawAllRedDot()
	end)
end

function ActivityUmaruMainLayer:fullScreen()
	self.panelLeft:setPositionY(self.panelLeft:getPositionY() - GameDisplay.fix_y)
	self.panelBottom:setPositionY(self.panelBottom:getPositionY() - GameDisplay.fix_y)
	self.panelRight:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 500, TRANSFORM_UNIT.PX))
	self.btnDetail:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 20, TRANSFORM_UNIT.PX))
end

function ActivityUmaruMainLayer.add_alert_tag(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if not arg_48_1 then
		return
	end

	if arg_48_1:getChildByName("reddot") then
		arg_48_1:getChildByName("reddot"):setVisible(true)

		return
	end

	local var_48_0 = arg_48_3 or 999
	local var_48_1 = arg_48_2 or {
		x = arg_48_1:getContentSize().width,
		y = arg_48_1:getContentSize().height
	}
	local var_48_2 = ccui.ImageView:create("ActivityUmaruMain/redDot.png", var_0_8)

	var_48_2:setName("reddot")
	var_48_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_2:setPosition(cc.p(var_48_1.x, var_48_1.y))
	arg_48_1:addChild(var_48_2, var_48_0)
end

function ActivityUmaruMainLayer.remove_alert_tag(arg_49_0, arg_49_1)
	if not arg_49_1:getChildByName("reddot") then
		return
	end

	arg_49_1:getChildByName("reddot"):removeFromParent()
end

function ActivityUmaruMainLayer:createShareButton()
	self.btn_share = self.panelRight:getChildByName("btn_right_1")

	self.btn_share:setVisible(false)

	if not share_manager:can_share() then
		return
	end

	local function var_50_0()
		local var_51_0 = RoleDefault:getInstance():getIntegerForKey("shareReddotTime", 0)

		if var_51_0 and time_check_manager:getCurTime() < var_51_0 then
			return
		end

		self:add_alert_tag(self.btn_share, {
			x = 20,
			y = 69
		})
	end

	local function var_50_1()
		var_50_0()
		self.btn_share:setVisible(true)
		self.btn_share:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityShareLayer", {
				activityid = self.id
			})

			local var_53_0 = arg_53_0:getChildByName("reddot")

			if var_53_0 then
				var_53_0:setVisible(false)
			end

			local var_53_1 = os.date("*t", (time_check_manager:getCurTime()))
			local var_53_2 = RoleDefault:getInstance():setIntegerForKey("shareReddotTime", (os.time({
				hour = 23,
				min = 59,
				sec = 59,
				year = var_53_1.year,
				month = var_53_1.month,
				day = var_53_1.day
			})))
		end)
	end

	print("createShareButton!!!!!!")
	share_manager:get_activity_share_data(self.id, function(arg_54_0, arg_54_1)
		if arg_54_0 == 1 then
			if config.packagechannel == "xdtw" then
				if share_manager:can_share() then
					var_50_1()
				end
			else
				var_50_1()
			end
		end
	end)
end

function ActivityUmaruMainLayer:gotoExplore()
	if self.surplus_times and self.surplus_times == 0 then
		global_ShowBlockWords(L_ADVENTURE_WARNING[4])

		return
	end

	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityUmaruMainLayer",
		activity_explore_id = self.next_step,
		activityid = self.id,
		cancelCallback = function(arg_56_0)
			if arg_56_0 == 2 then
				global_ShowBlockWords(L_ACTIVITY_CLOSE)
			elseif arg_56_0 == 3 then
				global_ShowBlockWords(L_ACTIVITY_ALL_FINISHED)
			elseif arg_56_0 == 4 then
				global_ShowBlockWords(L_ACTIVITY_DATA_ERROR)
			elseif arg_56_0 == 5 then
				global_ShowBlockWords(L_ACTIVITY_DATA_ERROR)
			elseif arg_56_0 == 0 then
				global_ShowBlockWords(L_ACTIVITY_EXPLORE_END)
			end
		end
	})
end

function ActivityUmaruMainLayer.showrechargeIcon(arg_57_0)
	LayerManager:pushInLayer("PopRechargeIconLayer", {
		big_group = 3100002
	})
end
