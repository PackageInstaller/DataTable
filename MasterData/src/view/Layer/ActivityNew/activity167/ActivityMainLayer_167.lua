local ActivityMainLayer_167 = class("ActivityMainLayer_167", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")

function ActivityMainLayer_167:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_167.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_167:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_167:initOther()
	self.btnGotoDorm:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_5_0 = ccui.Layout:create()

		var_5_0:setTouchEnabled(true)
		var_5_0:setContentSize(cc.Director:getInstance():getVisibleSize())
		var_5_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_0:setPosition(cc.p(320, 568))
		var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_5_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_5_0:setBackGroundColorOpacity(180)
		self.rootLayer:addChild(var_5_0, 1111111)
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_marrygift",
			activityid = self.id
		})
		var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_5_0:runAction(cc.RemoveSelf:create())
		end)

		local var_5_1 = ccui.ImageView:create(self:_getPath("goto_bg.png"))

		var_5_1:setPosition(cc.p(var_5_0:getContentSize().width / 2, var_5_0:getContentSize().height / 2 + GameDisplay.fix_y))
		var_5_0:addChild(var_5_1)

		local var_5_2 = ccui.Button:create(self:_getPath("goto_btn.png"), self:_getPath("goto_btn.png"), self:_getPath("goto_btn.png"))

		var_5_2:setPosition(cc.p(var_5_0:getContentSize().width / 2, 100 + GameDisplay.fix_y * 2))
		var_5_2:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:switchShowLayer("DormitoryLayer")
			AnalyticManager.ActivityMainLayer({
				event = "on_touch_gotodorm",
				activityid = self.id
			})
		end)
		var_5_0:addChild(var_5_2)
	end)
	self.btnPt:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 2400169
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_pt",
			activityid = self.id
		})
	end)
end

function ActivityMainLayer_167:playOutEffect(arg_9_1)
	if arg_9_1 then
		arg_9_1()
	end
end

function ActivityMainLayer_167:playInEffect(arg_10_1)
	if arg_10_1 then
		arg_10_1()
	end
end

return ActivityMainLayer_167
