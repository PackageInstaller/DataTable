SupermarketRouletteSprite = class("SupermarketRouletteSprite", function()
	require("view.Layer.Activity.ActivityRouletteBaseLayer")

	return ActivityRouletteBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local supermarket_manager = require("controller.supermarket_manager")

function SupermarketRouletteSprite.create(arg_2_0)
	local var_2_0 = SupermarketRouletteSprite.new()

	var_2_0:init({
		id = 174
	})

	return var_2_0
end

function SupermarketRouletteSprite:initBottomList()
	self.btnReturn = ccui.Button:create(self._imagePath .. "/btn_return.png", nil, self._imagePath .. "/btn_return.png", var_0_0)

	self.btnReturn:setPosition(cc.p(95, 20 + (GameDisplay.height - 1136) * 0.07))
	self.btnReturn:setVisible(false)
	self.rootLayer:addChild(self.btnReturn, 999)
	self.btnReturn:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.slotMachineSprite.isplay then
			return
		end

		self:playOutEffect(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	self.returnBG = ccui.ImageView:create(self._imagePath .. "/return_bg.png", var_0_0)

	self.returnBG:setAnchorPoint(cc.p(0, 0))
	self.returnBG:setPosition(cc.p(0, -10))
	self.returnBG:setVisible(false)
	self.rootLayer:addChild(self.returnBG)

	self.btnCost = ccui.Button:create(self._imagePath .. "/btn_cost.png", self._imagePath .. "/btn_cost.png", self._imagePath .. "/btn_cost.png", var_0_0)

	self.btnCost:setPosition(cc.p(550, 20 + (GameDisplay.height - 1136) * 0.08))
	self.rootLayer:addChild(self.btnCost, 999)
	self.btnCost:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = activity_manager:canBuyRouletteCurrency(self.activityId)

		if var_6_0 and var_6_0 < 0 then
			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				activityId = self.activityId
			})

			return
		elseif var_6_0 then
			goto_complete_system({
				jump_to_system = var_6_0
			})

			return
		end

		LayerManager:pushInLayer("PopRouletteBuyLayer", {
			activityId = self.activityId
		})
	end)

	local var_3_0 = ccui.ImageView:create(self._imagePath .. "/+.png", var_0_0)

	var_3_0:setPosition(cc.p(150, 28))
	self.btnCost:addChild(var_3_0, 999)

	self.lblHasNum = cc.Label:createWithTTF("X999", FONT_NAME, 24)

	self.lblHasNum:setPosition(cc.p(90, 28))
	self.btnCost:addChild(self.lblHasNum, 999)
end

function SupermarketRouletteSprite:initTitle()
	local var_7_0 = ccui.Button:create(self._imagePath .. "/img_title.png", self._imagePath .. "/img_title.png", self._imagePath .. "/img_title.png", var_0_0)

	var_7_0:setPosition(cc.p(320, GameDisplay.height - 200 - (GameDisplay.height - 1136) * 0.18))
	self.rootLayer:addChild(var_7_0, 99)
	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self._imagePath
		})
	end)

	self.timeLbl = cc.Label:createWithTTF("", FONT_NAME, 18)

	self.timeLbl:setPosition(cc.p(518, var_7_0:getPositionY() - 103))
	self.rootLayer:addChild(self.timeLbl, 99)
end

function SupermarketRouletteSprite:setUIPosition()
	self.btnCost:setPosition(cc.p(720, 800 + (GameDisplay.height - 1136) * 0.08))
	self.btnCost:setVisible(false)
	self.slotMachineSprite:setPosition(320, 540 + (GameDisplay.height - 1136) * 0.5)
	self.rootLayer:setPositionY(0)
end

function SupermarketRouletteSprite.updateBySupermarketLayer(arg_10_0, ...)
	return
end

function SupermarketRouletteSprite:registerActivityEventListener()
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_INFO_UPDATE, function(arg_12_0)
		self:updateTimeTitle()
		self:updateCurrencyNum()
		supermarket_manager:updateCurrencyList()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_LIMIT_BUY, function(arg_13_0)
		self:updateCurrencyNum()
		supermarket_manager:updateCurrencyList()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_14_0)
		self:updateCurrencyNum()
		supermarket_manager:updateCurrencyList()
	end), self)
end
