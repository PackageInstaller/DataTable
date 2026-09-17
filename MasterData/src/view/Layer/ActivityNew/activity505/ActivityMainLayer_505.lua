local ActivityMainLayer_505 = class("ActivityMainLayer_505", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local l2utils = require("controller.l2utils")
local activity_rogue_level_data_505 = require("data.activity_505.activity_rogue_level_data_505")

function ActivityMainLayer_505:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_505.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_505:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_505:initOther()
	self:initExploreBtns()
	self:initBuffBtn()
end

function ActivityMainLayer_505:initExploreBtns()
	self.btnExplore1:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:touchFunc(1)
	end)
	self.btnExplore2:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:touchFunc(2)
	end)
	self.btnExplore1:setVisible(false)
	self.btnExplore2:setVisible(false)
	network:rpc("get_rogue_explore_level_info", {
		is_reset = 0,
		activityid = self.id
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			self.levelInfo = {}

			for iter_8_0, iter_8_1 in pairs(arg_8_0.info) do
				self.levelInfo[iter_8_1.levelid] = iter_8_1
			end

			self.btnExplore1:setVisible(true)
			self.btnExplore2:setVisible(true)

			if self.levelInfo[1].is_finish == 0 then
				self:createLockedMask()
			end
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2])
		elseif arg_8_0.result == 3 then
			print("不存在肉鸽探险活动")
			global_ShowBlockWords(L_FLOP_BUY_KEY_WARNING[2] .. "msg:3")
		end
	end)
end

function ActivityMainLayer_505:touchFunc(arg_9_1)
	if arg_9_1 == 2 and self.levelInfo[1].is_finish == 0 then
		global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)

		return
	end

	local var_9_0 = activity_rogue_level_data_505[arg_9_1]

	local function var_9_1(arg_10_0)
		activity_manager:get_activity_rogue_explore_conf(self.id, arg_9_1, arg_10_0, var_9_0.aim)
	end

	if self.levelInfo[arg_9_1].is_running > 0 then
		var_9_1()
	else
		LayerManager:pushInLayer("PopExplorePreviewLayer", {
			aimid = var_9_0.aim,
			fighttype = FIGHTTYPE_ROGUEEXPLORE,
			sureCallback = var_9_1
		})
	end
end

function ActivityMainLayer_505:initBuffBtn()
	self.btnBuff:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("ActivityBuffLayer_505")
	end)
end

function ActivityMainLayer_505:createLockedMask()
	self.btnExplore2:setColor(cc.c3b(117, 117, 117))

	local var_13_0 = cc.p(self.btnExplore2:getPositionX() - 15, self.btnExplore2:getPositionY() - 8)
	local var_13_1 = ccui.Layout:create()

	var_13_1:setTouchEnabled(false)
	var_13_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_13_1:setBackGroundColorOpacity(180)
	var_13_1:setCascadeOpacityEnabled(false)
	var_13_1:setLocalZOrder(98)
	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setPosition(var_13_0)
	self:addChild(var_13_1)

	local var_13_2 = cc.Label:createWithTTF(L_MAP_CITY_CHAPTERS.Locking, FONT_NAME, 26)

	var_13_2:setColor(cc.c3b(255, 255, 255))
	var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_2:setPosition(var_13_0)
	var_13_2:setLocalZOrder(99)
	self:addChild(var_13_2)

	local var_13_3 = var_13_2:getContentSize()

	var_13_1:setContentSize((cc.size(var_13_3.width + 4, var_13_3.height + 4)))
end

return ActivityMainLayer_505
