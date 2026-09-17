require("view.Layer.Pops.PopBaseLayer")

PopMarketBuyOnekeyLayer = class("PopMarketBuyOnekeyLayer", function()
	return PopBaseLayer:create()
end)

local shop_manager = require("controller.shop_manager")
local playermodel = require("model.playermodel")
local bit = require("bit")

function PopMarketBuyOnekeyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopMarketBuyOnekeyLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopMarketBuyOnekeyLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopMarketBuyOnekeyLayer.json" or "PopMarketBuyOnekeyLayer.ExportJson")

	self.rootLayer:setTouchEnabled(true)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setTouchEnabled(true)
	self:initUI()
	self:fullScreen()
	self:registerEvent()
	self:loadData()
	self:onEnter()
end

function PopMarketBuyOnekeyLayer:onEnter()
	self.showActions.extendVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopMarketBuyOnekeyLayer:onExit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopMarketBuyOnekeyLayer:initUI()
	self.btnGold = self.rootpanel:getChildByName("btn_gold")

	self.btnGold:getChildByName("img_select"):setVisible(false)

	self.btnDiamond = self.rootpanel:getChildByName("btn_diamond")

	self.btnDiamond:getChildByName("img_select"):setVisible(false)

	self.goldNum = self.rootpanel:getChildByName("label_gold_num")

	self.goldNum:setString(global_trans_number(playermodel.gold))

	self.diamondNum = self.rootpanel:getChildByName("label_diamond_num")

	self.diamondNum:setString(global_trans_number(playermodel.diamond))

	self.btnSure = self.rootpanel:getChildByName("btn_sure")
	self.btnCancel = self.rootpanel:getChildByName("btn_cancel")

	self.btnSure:setVisible(false)
	self.btnCancel:setVisible(false)
	self.rootpanel:getChildByName("info"):setString(L_MARKET_BUY_ONEKEY_DES[1])
	self.btnGold:getChildByName("info"):setString(L_MARKET_BUY_ONEKEY_DES[2])
	self.btnDiamond:getChildByName("info"):setString(L_MARKET_BUY_ONEKEY_DES[3])
end

function PopMarketBuyOnekeyLayer:updateUI()
	self.btnSure:setVisible(true)
	self.btnCancel:setVisible(true)
	self:onSelectGold()
	self:onSelectDiamond()
end

function PopMarketBuyOnekeyLayer:fullScreen()
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self.rootpanel:setPositionY(GameDisplay.cy)
end

function PopMarketBuyOnekeyLayer:registerEvent()
	self.btnGold:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self._selectstatus = self:isSelectGold() and bit.band(self._selectstatus, 2) or bit.bor(self._selectstatus, 1)

		cc.UserDefault:getInstance():setIntegerForKey("buyonekey", self._selectstatus)
		self:onSelectGold()
	end)
	self.btnDiamond:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self._selectstatus = self:isSelectDiamond() and bit.band(self._selectstatus, 1) or bit.bor(self._selectstatus, 2)

		cc.UserDefault:getInstance():setIntegerForKey("buyonekey", self._selectstatus)
		self:onSelectDiamond()
	end)
	self.btnCancel:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		self:onExit()
	end)
	self.rootLayer:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onExit()
	end)
	self.btnSure:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		if not self:isSelectGold() and not self:isSelectDiamond() then
			global_ShowBlockWords("未选择任何物品")

			return
		end

		local var_16_0 = 0

		if self:isSelectGold() and self._needgold == 0 then
			var_16_0 = bit.bor(var_16_0, 1)
		end

		if self:isSelectDiamond() and self._needdiamond == 0 then
			var_16_0 = bit.bor(var_16_0, 2)
		end

		if var_16_0 > 0 then
			self:showEmptyWord(var_16_0)

			return
		end

		arg_16_0:setBright(false)
		self.btnCancel:setBright(false)
		shop_manager:buy_diamond_and_gold_items_onekey(self:isSelectGold(), self:isSelectDiamond())
	end)

	local var_11_0 = self:getEventDispatcher()

	var_11_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("BUY_ONEKEY_SUCCESS", function(arg_17_0)
		if arg_17_0.result == 1 then
			LayerManager:removePopLayer(self.__queueindex)
		else
			self.btnCancel:setBright(true)
			self.btnSure:setBright(true)
			self:showFailWord(arg_17_0.result - 1)
		end
	end), self)
	var_11_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("GET_BUY_ONEKEY_DATA", function(arg_18_0)
		self._needgold = arg_18_0.gold
		self._needdiamond = arg_18_0.diamond

		self:updateUI()
	end), self)
end

function PopMarketBuyOnekeyLayer:loadData()
	self._needgold = 0
	self._needdiamond = 0
	self._selectstatus = cc.UserDefault:getInstance():getIntegerForKey("buyonekey", 1)

	self:onSelectGold()
	self:onSelectDiamond()
	shop_manager:get_all_diamond_and_gold_items_price()
end

function PopMarketBuyOnekeyLayer:isSelectGold()
	return bit.band(self._selectstatus, 1) > 0
end

function PopMarketBuyOnekeyLayer:isSelectDiamond()
	return bit.band(self._selectstatus, 2) > 0
end

function PopMarketBuyOnekeyLayer:onSelectGold()
	self.btnGold:getChildByName("img_select"):setVisible(self:isSelectGold())

	if self:isSelectGold() then
		self.goldNum:setString(global_trans_number(self._needgold))

		if playermodel.gold >= self._needgold then
			self.goldNum:setColor(cc.c3b(97, 255, 224))
		else
			self.goldNum:setColor(cc.c3b(255, 97, 97))
		end
	else
		self.goldNum:setString(0)
		self.goldNum:setColor(cc.c3b(255, 255, 255))
	end
end

function PopMarketBuyOnekeyLayer:onSelectDiamond()
	self.btnDiamond:getChildByName("img_select"):setVisible(self:isSelectDiamond())

	if self:isSelectDiamond() then
		self.diamondNum:setString(global_trans_number(self._needdiamond))

		if playermodel.diamond >= self._needdiamond then
			self.diamondNum:setColor(cc.c3b(97, 255, 224))
		else
			self.diamondNum:setColor(cc.c3b(255, 97, 97))
		end
	else
		self.diamondNum:setString(0)
		self.diamondNum:setColor(cc.c3b(255, 255, 255))
	end
end

function PopMarketBuyOnekeyLayer.showFailWord(arg_24_0, arg_24_1)
	global_ShowBlockWords(({
		"图灵新钞不足",
		"魂晶不足",
		"图灵新钞和魂晶不足"
	})[arg_24_1])

	if arg_24_1 == 1 or arg_24_1 == 3 then
		LayerManager:pushInLayer("HandOfMidasLayer", {
			callback = function(...)
				arg_24_0:updateUI()
			end
		})
	end
end

function PopMarketBuyOnekeyLayer.showEmptyWord(arg_26_0, arg_26_1)
	global_ShowBlockWords(({
		"图灵新钞价格物品出售完毕",
		"魂晶价格物品已出售完毕",
		"所有物品均已出售"
	})[arg_26_1])
end
