BagSellItemPopLayer = class("BagSellItemPopLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local dorm_rooms_data = require("data.dorm_rooms_data")

function BagSellItemPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BagSellItemPopLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BagSellItemPopLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.sureCallback = arg_3_1.sureCallback
	self.titlePath = "public/title/title_sell.png"
	self.gold = arg_3_1.gold

	self:initUI()
	self:updateUI()
end

function BagSellItemPopLayer:initUI()
	local var_6_0 = ccui.ImageView:create(self.titlePath, var_0_0)

	var_6_0:setPositionX(var_6_0:getContentSize().width / 2)
	var_6_0:setPositionY(self.rootpanel:getContentSize().height + var_6_0:getContentSize().height / 2)
	self.rootpanel:addChild(var_6_0)

	local var_6_1 = cc.Label:createWithTTF(L_SELL_RESULT_LABEL, FONT_NAME, 30)

	var_6_1:setColor(cc.c3b(216, 230, 246))
	var_6_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_6_1:setPositionY(self.rootpanel:getContentSize().height - var_6_1:getContentSize().height)
	self.rootpanel:addChild(var_6_1)

	self.unlockBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.unlockBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.unlockBtn:setPositionY(-self.unlockBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.unlockBtn)

	local var_6_2 = cc.Label:createWithTTF(L_BUTTON_TEXT.Materil_Sold, FONT_BUTTON, 32)

	var_6_2:setColor(cc.c3b(12, 12, 12))
	var_6_2:setPositionX(self.unlockBtn:getContentSize().width / 2)
	var_6_2:setPositionY(self.unlockBtn:getContentSize().height / 2 - 4)
	self.unlockBtn:addChild(var_6_2)
	self.unlockBtn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)

		if self.sureCallback then
			self.sureCallback()
			self.hideActions.shrinkVertical(self, function(...)
				LayerManager:removePopLayer(self.__queueindex)
			end)
		end
	end)
end

function BagSellItemPopLayer:updateUI()
	local var_9_0 = {}

	table.insert(var_9_0, {
		itemid = "gold",
		ownNum = self.gold
	})

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_1 = ItemSmallSprite:createSmallItem(iter_9_1.itemid, iter_9_1.ownNum, iter_9_1.needNum, self.goto_back_system_id)

		var_9_1:setScale(0.7)
		var_9_1:setInfoTouchEvent(true)
		var_9_1:setPositionX(self.rootpanel:getContentSize().width / 2 - (iter_9_0 - (#var_9_0 + 1) / 2) * (var_9_1:getContentSize().width + 5))
		var_9_1:setPositionY(self.rootpanel:getContentSize().height / 2 - 16)
		self.rootpanel:addChild(var_9_1)
	end
end
