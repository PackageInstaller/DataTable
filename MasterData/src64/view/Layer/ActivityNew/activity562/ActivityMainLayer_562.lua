require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_562 = class("ActivityMainLayer_562", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local var_0_14 = 1

function ActivityMainLayer_562:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_562.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_562:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_562:playInEffect()
	return
end

function ActivityMainLayer_562:initOther(arg_5_1)
	self:initTwistChosee()
	self.btnTwist:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectType = var_0_14

		self:updateTwistChosee()
	end)
end

function ActivityMainLayer_562:initTwistChosee()
	self.twistChoseeLayer = ccui.Layout:create()

	self.twistChoseeLayer:setTouchEnabled(true)
	self.twistChoseeLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.twistChoseeLayer:setAnchorPoint(cc.p(0, 0))
	self.twistChoseeLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.twistChoseeLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.twistChoseeLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.twistChoseeLayer:setBackGroundColorOpacity(180)
	self:addChild(self.twistChoseeLayer)
	self.twistChoseeLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			self.twistChoseeLayer:setVisible(false)
			self.twistChoseeLayer:setOpacity(255)
		end)))
	end)
	self.twistChoseeLayer:setVisible(false)

	self.bg = ccui.ImageView:create("activitiesRes/activity562/main/twistChoseeBg_1.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(320, 520 + GameDisplay.fix_y))
	self.twistChoseeLayer:addChild(self.bg)

	self.btn1 = ccui.Button:create("activitiesRes/activity562/main/twistChoseebtn1_1.png", nil, "activitiesRes/activity562/main/twistChoseebtn1_1.png")

	self.btn1:setPosition(cc.p(310, 420))
	self.bg:addChild(self.btn1)
	self.btn1:addTouchEventListener(function(arg_10_0, arg_10_1)
		local var_10_0
		local var_10_1

		if arg_10_1 ~= ccui.TouchEventType.ended then
			do return end

			var_10_0 = goto_complete_system
			var_10_1 = {}
		end

		var_10_1.jump_to_system = self.selectType == var_0_14 and 1800696 or 1800696

		var_10_0(var_10_1)
	end)

	self.btn2 = ccui.Button:create("activitiesRes/activity562/main/twistChoseebtn1_2.png", nil, "activitiesRes/activity562/main/twistChoseebtn1_2.png")

	self.btn2:setPosition(cc.p(310, 190))
	self.bg:addChild(self.btn2)
	self.btn2:addTouchEventListener(function(arg_11_0, arg_11_1)
		local var_11_0
		local var_11_1

		if arg_11_1 ~= ccui.TouchEventType.ended then
			do return end

			var_11_0 = goto_complete_system
			var_11_1 = {}
		end

		var_11_1.jump_to_system = self.selectType == var_0_14 and 1800697 or 1800697

		var_11_0(var_11_1)
	end)
end

function ActivityMainLayer_562:updateTwistChosee()
	self.bg:loadTexture("activitiesRes/activity562/main/twistChoseeBg_" .. self.selectType .. ".png")
	self.btn1:loadTextures("activitiesRes/activity562/main/twistChoseebtn" .. self.selectType .. "_1.png", nil, "activitiesRes/activity562/main/twistChoseebtn" .. self.selectType .. "_1.png")
	self.btn2:loadTextures("activitiesRes/activity562/main/twistChoseebtn" .. self.selectType .. "_2.png", nil, "activitiesRes/activity562/main/twistChoseebtn" .. self.selectType .. "_2.png")
	self.twistChoseeLayer:setOpacity(0)
	self.twistChoseeLayer:setVisible(true)
	self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.5)))
end

return ActivityMainLayer_562
