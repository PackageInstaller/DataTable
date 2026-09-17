local ActivityMainLayer_156 = class("ActivityMainLayer_156", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityMainLayer_156:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_156.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_156:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_156:initOther()
	return
end

function ActivityMainLayer_156:playOutEffect(arg_5_1)
	self:stopAllActions()

	if self.effecticon then
		self.effecticon:setVisible(false)
	end

	local var_5_0 = 0.1

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(var_5_0 * 3 / 4, cc.p(50, 0)), cc.MoveBy:create(var_5_0 / 4, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_5_1 then
			arg_5_1()
		end
	end)))

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data"))) do
		if self[iter_5_0] then
			table.insert(var_5_1, {
				name = iter_5_0,
				posy = self[iter_5_0]:getPositionY()
			})
		end
	end

	table.sort(var_5_1, function(arg_7_0, arg_7_1)
		return arg_7_0.posy > arg_7_1.posy
	end)

	for iter_5_2, iter_5_3 in pairs(var_5_1) do
		self[iter_5_3.name]:setOpacity(255)
		self[iter_5_3.name]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_5_2 / #var_5_1 * (var_5_0 + 0.3) / 2), cc.FadeOut:create((var_5_0 + 0.3) / 2)))
	end
end

function ActivityMainLayer_156:playInEffect(arg_9_1)
	return
end

return ActivityMainLayer_156
