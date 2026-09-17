require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_304 = class("ActivityMainLayer_304", function(...)
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

function ActivityMainLayer_304:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_304.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_304:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_304:initOther(arg_4_1)
	return
end

function ActivityMainLayer_304:playInEffect()
	local var_5_0 = L2Skeleton:create("spine/ui/xiahuo/wave.json", "spine/ui/xiahuo/wave.atlas")

	var_5_0:refreshSkeleton()
	var_5_0:setPosition(cc.p(320, 640 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_5_0, 1)
	var_5_0:play("animation", true)
end

return ActivityMainLayer_304
