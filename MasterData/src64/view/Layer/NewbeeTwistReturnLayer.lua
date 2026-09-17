NewbeeTwistReturnLayer = class("NewbeeTwistReturnLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_5 = config._DEBUG and 0 or 1

function NewbeeTwistReturnLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = NewbeeTwistReturnLayer.new()

	if arg_2_1 and arg_2_1.ispop then
		var_2_0:initBg(arg_2_1)
	else
		var_2_0:init(arg_2_1)
	end

	return var_2_0
end

function NewbeeTwistReturnLayer:init(arg_3_1)
	local var_3_0 = config._DEBUG and "NewbeeTwistReturnLayer.json" or "NewbeeTwistReturnLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(true)
	self:addChild(self.rootLayer)

	self.ispop = arg_3_1 and arg_3_1.ispop
	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_3_0)

	self.rootLayer:addChild(self.rootpanel, 10)
	self.showActions.moveFadeIn(self)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_newbee_twist_return_info(TWIST_RETURN_ACTIVITYID)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			if arg_3_1 and arg_3_1.exitcallback then
				arg_3_1.exitcallback()
			end

			activity_manager:releaseEventListenerByName("NewbeeTwistReturnLayer")
		end
	end)
end

function NewbeeTwistReturnLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("NewbeeTwistReturnLayer", activity_manager.activityEventId.ACTIVITY_TWIST_RETURN_DATA_UPDATE, function(arg_6_0)
		arg_5_0.data = arg_6_0

		arg_5_0:updateUI()
	end)
end

function NewbeeTwistReturnLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootpanel, "bg")
	self.lblTomGetNum = ccui.Helper:seekWidgetByName(self.rootpanel, "lbl_tom_get_num")
	self.lblTodayGetNum = self.bg:getChildByName("lbl_today_get_num")
	self.lblTodayTwistNum = self.bg:getChildByName("lbl_today_tiwst_num")
	self.btnGet = self.bg:getChildByName("btn_get")

	local var_7_0 = self.bg:getChildByName("title")

	var_7_0:setTouchEnabled(true)
	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "NewbeeTwistReturnLayer_" .. TWIST_RETURN_ACTIVITYID
		})
	end)

	if self.ispop then
		self.rootpanel:setTouchEnabled(true)
		self.rootpanel:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end
end

function NewbeeTwistReturnLayer:updateUI()
	self.lblTomGetNum:setString("X" .. self.data.reward_tomorrow)
	self.lblTodayGetNum:setString((self.data.reward_today > 0 or nil) and ("X" .. self.data.reward_today or "X0"))
	self.lblTodayTwistNum:setString(self.data.twist_num .. "/100")

	if self.data.reward_today < 0 then
		self.btnGet:loadTextures("NewbeeTwistReturnLayer/btn_got.png", nil, "NewbeeTwistReturnLayer/btn_got.png", var_0_5)
	elseif self.data.reward_today == 0 then
		self.btnGet:loadTextures("NewbeeTwistReturnLayer/btn_goto.png", nil, "NewbeeTwistReturnLayer/btn_goto.png", var_0_5)
	end

	self.btnGet:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.data.reward_today > 0 then
			activity_manager:get_activity_newbee_twist_return_reward(TWIST_RETURN_ACTIVITYID)
		else
			LayerManager:switchShowLayer("TwisteggLayer")
		end
	end)
end

function NewbeeTwistReturnLayer:updateTimeLabel()
	self.timeLabel = self.bg:getChildByName("title"):getChildByName("time_label")

	self.timeLabel:setVisible(true)

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(activity_manager:getManageMoneyEndTime(MANAGE_MONEY_ACTIVITYID), function(arg_13_0)
		if arg_13_0 <= 0 and self.activityScheduler or not self.timeLabel then
			if self.timeLabel then
				self.timeLabel:setString(L_ACTIVITY_END)
			end

			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end

		self.timeLabel:setString(L_LEFT_TIME_SPACE .. Global_format_time_str(arg_13_0))
	end)))
end

function NewbeeTwistReturnLayer:initBg(arg_14_1)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_14_0:setOpacity(0)
	self:addChild(var_14_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_15_0)
		self:addChild(arg_15_0, -2)
		arg_15_0:setPositionY(arg_15_0:getPositionY() - GameDisplay.fix_y)

		local var_15_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_15_0:setAnchorPoint(cc.p(0, 0))
		var_15_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_15_0, -1)
		self:init(arg_14_1)
		var_14_0:setOpacity(102)
		var_14_0:setTouchEnabled(false)
	end)
end
