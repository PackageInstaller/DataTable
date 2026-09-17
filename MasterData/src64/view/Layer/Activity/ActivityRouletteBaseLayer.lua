ActivityRouletteBaseLayer = class("ActivityRouletteBaseLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.SlotMachineSprite")
require("view.Layer.CommonRouletteLayer")

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")

function ActivityRouletteBaseLayer.create(arg_2_0, arg_2_1)
	if activity_manager:isCommonRoulette(arg_2_1.activityId) then
		return CommonRouletteLayer:create(arg_2_1)
	end

	local var_2_0 = ActivityRouletteBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityRouletteBaseLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId

	TextureManager:loadLayerTextures({
		"ActivityRoulette_" .. self.activityId
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/routtle_bg.jpg")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and ("ActivityRoulette_" .. self.activityId .. ".json" or "ActivityRoulette_" .. self.activityId .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getRouletteInfo(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			activity_manager:releaseEventListenerByName(self._imagePath)
			TextureManager:removeLayerTextures({
				"ActivityRoulette_" .. self.activityId
			})
		end
	end)
end

function ActivityRouletteBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_INFO_UPDATE, function(arg_6_0)
		self:updateTimeTitle()
		self:updateCurrencyNum()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_LIMIT_BUY, function(arg_7_0)
		self:updateCurrencyNum()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, function(arg_8_0)
		self:updateCurrencyNum()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_9_0)
		self:updateCurrencyNum()
	end), self)
end

function ActivityRouletteBaseLayer:initUI()
	self:initBottomList()
	self:initTitle()
	self:initSlotMachine()
	self:playJoinEffect()
end

function ActivityRouletteBaseLayer:initBottomList()
	local var_11_0 = self.rootLayer:getChildByName("return_bg")

	self.btnReturn = var_11_0:getChildByName("btn_return")

	self.btnReturn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.slotMachineSprite.isplay then
			return
		end

		self:playOutEffect(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	self.btnCost = var_11_0:getChildByName("btn_cost")
	self.btnadd = ccui.Helper:seekWidgetByName(var_11_0, "+")

	self.btnCost:setTouchEnabled(true)

	local function var_11_1(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_14_0 = activity_manager:canBuyRouletteCurrency(self.activityId)

		if var_14_0 and var_14_0 < 0 then
			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				activityId = self.activityId
			})

			return
		elseif var_14_0 then
			goto_complete_system({
				jump_to_system = var_14_0
			})

			return
		end

		LayerManager:pushInLayer("PopRouletteBuyLayer", {
			activityId = self.activityId
		})
	end

	self.btnadd:addTouchEventListener(var_11_1)
	self.btnCost:addTouchEventListener(var_11_1)

	self.lblHasNum = self.btnCost:getChildByName("lblHasNum")

	var_11_0:setPositionY(-GameDisplay.fix_y)

	self.btnTask = ccui.Helper:seekWidgetByName(self.rootLayer, "task")

	if self.btnTask then
		self.btnTask:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopRouletteTaskLayer", {
				activityId = self.activityId
			})
		end)
	end
end

local function var_0_4(arg_16_0)
	if arg_16_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_16_0 / 86400), math.floor(arg_16_0 % 86400 / 3600))
	elseif arg_16_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_16_0 / 3600), math.floor(arg_16_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_16_0 / 60), math.floor(arg_16_0 % 60))
	end
end

function ActivityRouletteBaseLayer:initTitle()
	local var_17_0 = self.rootLayer:getChildByName("img_title")

	var_17_0:setTouchEnabled(true)
	var_17_0:setPositionY(var_17_0:getPositionY() + GameDisplay.fix_y)
	var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityRouletteLayer_" .. self.activityId
		})
	end)

	self.timeLbl = self.rootLayer:getChildByName("timeLbl")

	self.timeLbl:retain()
	self.timeLbl:setPositionY(self.timeLbl:getPositionY() + GameDisplay.fix_y)
end

function ActivityRouletteBaseLayer:updateTimeTitle()
	if self.activityScheduler then
		time_check_manager:removeUpdatePool(self.activityScheduler)

		self.activityScheduler = nil
	end

	local var_19_0 = activity_manager:getCurphase(self.activityId)
	local var_19_1 = activity_manager:getRouletteEndTime(self.activityId)

	if not var_19_1 then
		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_19_1, function(arg_20_0)
		self.timeLbl:setString(L_ROULETTE_PHASE .. L_LEFT_TIME_SPACE .. var_0_4(arg_20_0))

		if arg_20_0 <= 0 and self.activityScheduler then
			self.timeLbl:setVisible(false)
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityRouletteBaseLayer:updateCurrencyNum()
	self.lblHasNum:setString(item_manager:getItemNumber((activity_manager:getRouletteNeedItem(self.activityId))))
end

function ActivityRouletteBaseLayer:initSlotMachine()
	local var_22_0, var_22_1 = activity_manager:getRouletteSize(self.activityId)

	self.slotMachineSprite = SlotMachineSprite:create(var_22_0, var_22_1, self.activityId, self.rootLayer:getChildByName("slotMachineSprite"))

	self.slotMachineSprite:setPosition(320, 600 + (GameDisplay.height - 1136) * 0.5)
	self.rootLayer:addChild(self.slotMachineSprite)
end

function ActivityRouletteBaseLayer:playJoinEffect()
	self.btnReturn:setPositionX(self.btnReturn:getPositionX() + 600)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.4, cc.p(-610, 0)), cc.MoveBy:create(0.05, cc.p(10, 0))))
	self.btnCost:setPositionX(self.btnCost:getPositionX() + 200)
	self.btnCost:runAction(cc.Sequence:create(cc.EaseExponentialIn:create(cc.MoveBy:create(0.3, cc.p(-200, 0)))))
end

function ActivityRouletteBaseLayer:playOutEffect(arg_24_1)
	self.isShowEffect = true

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_24_1 then
			arg_24_1()
		end

		self.isShowEffect = nil
	end)))
	self.btnCost:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, -200))))
end
