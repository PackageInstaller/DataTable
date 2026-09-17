require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_176 = class("ActivityMainLayer_176", function(...)
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
local Utility = require("common.Utility")
local activity_return_manager = require("controller.activity_return_manager")

LayerManager = require("controller.layer_manager")

local ShowGirlLayer = require("view.Layer.ShowGirlLayer")

function ActivityMainLayer_176:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_176.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_176:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_176:playInEffect()
	return
end

function ActivityMainLayer_176:initOther(arg_5_1)
	self.btnRecharge:setPositionY(self.btnRecharge:getPositionY() + 40)
	self.btnBp:setPositionY(self.btnBp:getPositionY() + 70)
	self.btnTask:setPositionY(self.btnTask:getPositionY() + 80)

	self.btnPacks = ccui.Button:create("activitiesRes/activity176/main/btn_Packs.png", nil, "activitiesRes/activity176/main/btn_Packs.png")

	self.btnPacks:setPositionX(self.btnTask:getPositionX())
	self.btnPacks:setPositionY(self.btnTask:getPositionY() - 110)
	self.rootLayer:addChild(self.btnPacks)

	local playermodel = require("model.playermodel")

	self.btnCompensation:setVisible(playermodel.lastreturnbacktime and playermodel.lastreturnbacktime == 0)

	local var_5_1 = playermodel.lastreturnbacktime == 0 and 0 or 60

	self.btnTips:setPositionY(self.btnTips:getPositionY() + (playermodel.lastreturnbacktime == 0 and 0 or 60))
	self.btnAssistance:setPositionY(self.btnAssistance:getPositionY() + var_5_1)
	Utility:addClickEventListener(self.btnTips, function()
		LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
			index = 3
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_tips",
			activityid = self.id
		})
	end)
	Utility:addClickEventListener(self.btnAssistance, function()
		LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
			index = 9
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_fundation",
			activityid = self.id
		})
	end)
	Utility:addClickEventListener(self.btnCompensation, function()
		LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
			index = 8
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_supplement",
			activityid = self.id
		})
	end)
	Utility:addClickEventListener(self.btnTask, function()
		LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
			index = 5
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_returntask",
			activityid = self.id
		})
	end)
	Utility:addClickEventListener(self.btnSign, function()
		LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
			index = 1
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_sign",
			activityid = self.id
		})
	end)
	Utility:addClickEventListener(self.btnPacks, function()
		LayerManager:pushInLayer("PopReturnBackPacksLayer")
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_returnPacks",
			activityid = self.id
		})
	end)
end

return ActivityMainLayer_176
