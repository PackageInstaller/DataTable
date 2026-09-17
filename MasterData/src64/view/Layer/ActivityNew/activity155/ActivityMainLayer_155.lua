local ActivityMainLayer_155 = class("ActivityMainLayer_155", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityMainLayer_155:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_155.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_155:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_155:initOther()
	self.btnTwist:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			LayerManager:switchShowLayer("SkinTwisteggLayer")
		end
	end)
end

function ActivityMainLayer_155:playOutEffect(arg_6_1)
	self:stopAllActions()

	if self.effecticon then
		self.effecticon:setVisible(false)
	end

	local var_6_0 = 0.1

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(var_6_0 * 3 / 4, cc.p(50, 0)), cc.MoveBy:create(var_6_0 / 4, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_6_1 then
			arg_6_1()
		end
	end)))

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data"))) do
		if self[iter_6_0] then
			table.insert(var_6_1, {
				name = iter_6_0,
				posy = self[iter_6_0]:getPositionY()
			})
		end
	end

	table.sort(var_6_1, function(arg_8_0, arg_8_1)
		return arg_8_0.posy > arg_8_1.posy
	end)

	for iter_6_2, iter_6_3 in pairs(var_6_1) do
		self[iter_6_3.name]:setOpacity(255)
		self[iter_6_3.name]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_6_2 / #var_6_1 * (var_6_0 + 0.3) / 2), cc.FadeOut:create((var_6_0 + 0.3) / 2)))
	end
end

return ActivityMainLayer_155
