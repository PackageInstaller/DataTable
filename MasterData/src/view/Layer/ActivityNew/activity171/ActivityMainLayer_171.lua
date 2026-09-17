local ActivityMainLayer_171 = class("ActivityMainLayer_171", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")

function ActivityMainLayer_171:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_171.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_171:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_171:initOther()
	self.btnXingDong = ccui.Button:create("activitiesRes/activity171/main/btn_xingdong.png", nil, "activitiesRes/activity171/main/btn_xingdong.png")

	self.btnXingDong:setPosition(cc.p(118, 328 - GameDisplay.fix_y))
	self.btnXingDong:setRotation(10)
	self.rootLayer:addChild(self.btnXingDong, 99)
	self.btnXingDong:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFoolActionLayter")
		AnalyticManager.activityJumpTo({
			module = "btn_xingdong",
			activityid = 171
		})
	end)
	self.btnTotalTask:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showHeadSend()
	end)

	self.btnHead = ccui.Button:create("activitiesRes/activity171/main/btn_head.png", nil, "activitiesRes/activity171/main/btn_head.png")

	self.btnHead:setPosition(cc.p(50, 720 + GameDisplay.fix_y * 0.3))
	self.rootLayer:addChild(self.btnHead, 99)
	self.btnHead:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFoolHeadCollectLayter")
		AnalyticManager.activityJumpTo({
			module = "btn_head",
			activityid = 171
		})
	end)
end

function ActivityMainLayer_171:playOutEffect(arg_8_1)
	if arg_8_1 then
		arg_8_1()
	end
end

function ActivityMainLayer_171:showHeadSend()
	local var_9_0 = ccui.Layout:create()

	var_9_0:setTouchEnabled(true)
	var_9_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_9_0:setBackGroundColorOpacity(180)
	self:addChild(var_9_0, 10)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_9_0:runAction(cc.RemoveSelf:create())
	end)

	local var_9_1 = ccui.ImageView:create("activitiesRes/activity171/main/head_bg.png")

	var_9_1:setPosition(cc.p(320, GameDisplay.height * 0.65 - GameDisplay.fix_y))
	var_9_1:setTouchEnabled(true)
	var_9_0:addChild(var_9_1, 9999)

	local var_9_2 = 108001059
	local var_9_3 = 17109008
	local var_9_4 = "activitiesRes/activity171/main/btn_get.png"

	if item_manager:haveItem(108001059) then
		var_9_4 = "activitiesRes/activity171/main/btn_got.png"
	end

	local var_9_5 = ccui.Button:create(var_9_4, nil, var_9_4)

	var_9_5:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:haveItem(var_9_2) then
			return
		end

		AnalyticManager.activityJumpTo({
			module = "rechargeewelfare",
			activityid = 171
		})
		activity_manager:getTaskReward(171, var_9_3, function(arg_12_0, arg_12_1)
			if arg_12_0 == 1 then
				global_gain(arg_12_1)
				var_9_0:runAction(cc.RemoveSelf:create())
				activity_manager:updateActivityAlert("total_recharge", 171, false)
			else
				local var_12_0 = {}

				function var_12_0.surecallback()
					AnalyticManager.activityJumpTo({
						module = "rechargeewelfare-torecharge",
						activityid = 171
					})
					LayerManager:pushInLayer("PopRechargePreviewLayer", {
						group = 401
					})
				end

				var_12_0.labels = {
					button = L_GO_BUY_DIAMOND.button,
					des = L_FOOL_RECHARGE
				}

				LayerManager:pushInLayer("PopDoLayer", var_12_0)
			end
		end)
	end)
	var_9_5:setPosition(cc.p(230, 86))
	var_9_1:addChild(var_9_5, 999)
end

return ActivityMainLayer_171
