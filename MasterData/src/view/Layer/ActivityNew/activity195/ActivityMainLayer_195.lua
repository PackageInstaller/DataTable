local ActivityMainLayer_195 = class("ActivityMainLayer_195", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")

function ActivityMainLayer_195:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_195.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()

	return var_2_0
end

function ActivityMainLayer_195:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

return ActivityMainLayer_195
