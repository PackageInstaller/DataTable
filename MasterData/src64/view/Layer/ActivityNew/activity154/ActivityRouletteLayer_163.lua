ActivityRouletteLayer_163 = class("ActivityRouletteLayer_163", function()
	return ActivityRouletteBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")

function ActivityRouletteLayer_163.create(arg_2_0)
	local var_2_0 = ActivityRouletteLayer_163.new()

	var_2_0:init({
		id = 163
	})

	return var_2_0
end

function ActivityRouletteLayer_163:initBottomList()
	self.btnReturn = ccui.Button:create(self._imagePath .. "/btn_return.png", nil, self._imagePath .. "/btn_return.png", var_0_0)

	self.btnReturn:setPosition(cc.p(95, 20 + (GameDisplay.height - 1136) * 0.07))
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
