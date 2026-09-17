ActivityNinifaLayer = class("ActivityNinifaLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = 0.25
local time_check_manager = require("controller.time_check_manager")
local activity_ninifa_manager = require("controller.activity_ninifa_manager")

function ActivityNinifaLayer.create(arg_2_0)
	local var_2_0 = ActivityNinifaLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityNinifaLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNinifaLayer.json" or "ActivityNinifaLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBG()
	self:initBottomList()
	self:initBtnTouchEventListener()
	self:createActivityCountDown()
	self:playJoinInEffect()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.activityScheduler then
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)
end

function ActivityNinifaLayer:initBG()
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg"):setBackGroundImage("mainScenebg/activity/branch11/bg.jpg")
end

function ActivityNinifaLayer:initBtnTouchEventListener()
	self.rootLayer:getChildByName("activity_gift_btn"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = {
					"1-17",
					"1-19",
					"1-20"
				}
			})
		end)
	end)
	self.rootLayer:getChildByName("activity_twist_btn"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			LayerManager:switchShowLayer("TwisteggLayer")
		end)
	end)
	self.rootLayer:getChildByName("manual_btn"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			LayerManager:switchShowLayer("ActivityNinifaExchangeLayer")
		end)
	end)
	self.rootLayer:getChildByName("material_collection_btn"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			LayerManager:switchShowLayer("ActivityNinifaExploreLayer")
		end)
	end)
	self.rootLayer:getChildByName("bload_maker_btn"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			LayerManager:switchShowLayer("ActivityNinifaCompositeLayer")
		end)
	end)
end

function ActivityNinifaLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playGetOutEffect(function()
			KeyCodeManager:onKeyReleasedCallFunc(global_basic_scene)
		end)
	end, {
		{
			texture = "ActivityNinifaLayer/activity_detail.png",
			name = "go_detail",
			word = "",
			handler = function(arg_20_0, arg_20_1)
				if arg_20_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopActivityDetail", {
					key = "activity_11"
				})
			end
		}
	})

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList, 2)
end

function ActivityNinifaLayer:playJoinInEffect()
	local var_21_0 = self.rootLayer:getChildByName("activity_gift_btn")

	var_21_0:setPositionX(var_21_0:getPositionX() - 200)
	var_21_0:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(200, 0))))

	local var_21_1 = self.rootLayer:getChildByName("activity_twist_btn")

	var_21_1:setPositionX(var_21_1:getPositionX() - 200)
	var_21_1:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(200, 0))))

	local var_21_2 = self.rootLayer:getChildByName("manual_btn")

	var_21_2:setPositionX(var_21_2:getPositionX() + 200)
	var_21_2:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-200, 0))))

	local var_21_3 = self.rootLayer:getChildByName("material_collection_btn")

	var_21_3:setPositionX(var_21_3:getPositionX() + 200)
	var_21_3:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-200, 0))))

	local var_21_4 = self.rootLayer:getChildByName("bload_maker_btn")

	var_21_4:setPositionX(var_21_4:getPositionX() + 200)
	var_21_4:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-200, 0))))
end

function ActivityNinifaLayer:playGetOutEffect(arg_22_1)
	self.rootLayer:getChildByName("activity_gift_btn"):runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-200, 0))))
	self.rootLayer:getChildByName("activity_twist_btn"):runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(-200, 0))))
	self.rootLayer:getChildByName("manual_btn"):runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(200, 0))))
	self.rootLayer:getChildByName("material_collection_btn"):runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(200, 0))))
	self.rootLayer:getChildByName("bload_maker_btn"):runAction(cc.Sequence:create(cc.MoveBy:create(var_0_0, cc.p(200, 0))))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_0), cc.CallFunc:create(function()
		if type(arg_22_1) == "function" then
			arg_22_1()
		end
	end)))
end

local function var_0_4(arg_24_0)
	if arg_24_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_24_0 / 86400), math.floor(arg_24_0 % 86400 / 3600))
	elseif arg_24_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_24_0 / 3600), math.floor(arg_24_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_24_0 / 60), math.floor(arg_24_0 % 60))
	end
end

function ActivityNinifaLayer:createActivityCountDown()
	local var_25_0 = self.rootLayer:getChildByName("activity_time_bg"):getChildByName("time_lbl")
	local var_25_1 = activity_ninifa_manager:getActivityEndTime()

	if not var_25_1 then
		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_25_1, function(arg_26_0)
		var_25_0:setString(L_LEFT_TIME_SPACE .. var_0_4(arg_26_0))

		if arg_26_0 <= 0 and self.activityScheduler then
			LayerManager:switchShowLayer("MainLayer")
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end
