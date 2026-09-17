PopFlopBuyLayer_137 = class("PopFlopBuyLayer_137", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_6 = config._DEBUG and 0 or 1

function PopFlopBuyLayer_137.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFlopBuyLayer_137.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopFlopBuyLayer_137:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_flop_buy_137.json" or "Pop_flop_buy_137.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 100 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		if arg_3_1.cancelCallback then
			arg_3_1.cancelCallback()
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end
		end
	end)
end

setmetatable({
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "equipment/1000000.png",
	[CURRENCY_DIAMOND_PAID] = "equipment/" .. item_data[CURRENCY_DIAMOND_PAID].image_id .. ".png"
}, {
	__index = function(arg_7_0, arg_7_1)
		return cc.FileUtils:getInstance():isFileExist("public/currency/" .. item_data[arg_7_1].image_id .. ".png") and "public/currency/" .. item_data[arg_7_1].image_id .. ".png" or "equipment/" .. item_data[arg_7_1].image_id .. ".png"
	end
})

function PopFlopBuyLayer_137:initUI(arg_8_1)
	self.currencyData = arg_8_1.currencyData
	self.limitData = arg_8_1.limitData
	self.id = arg_8_1.activityid
	self.initNum = arg_8_1.initNum or 1
	self.isCanBuy = true
	self.sureCallback = arg_8_1.sureCallback
	self.packageCallback = arg_8_1.packageCallback

	local var_8_0 = 1

	while ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. var_8_0) do
		local var_8_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. var_8_0)
		local var_8_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. var_8_0)
		local var_8_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. var_8_0)
		local var_8_4 = var_8_1:getChildByName("img_num")

		var_8_2.index = var_8_0
		var_8_2.limitNum = self.limitData[var_8_0].limitNum
		var_8_2.boughtNum = self.limitData[var_8_0].boughtNum
		var_8_1.index = var_8_0
		var_8_1.limitNum = self.limitData[var_8_0].limitNum
		var_8_1.boughtNum = self.limitData[var_8_0].boughtNum

		var_8_3:setString(self.limitData[var_8_0].boughtNum .. "/" .. self.limitData[var_8_0].limitNum)

		if self.limitData[var_8_0].limitNum == self.limitData[var_8_0].boughtNum then
			if self.currencyData[var_8_0].currency == SHOP_CURRENCY_DIAMOND then
				if L_TWIST_UNLOCK_BUY_LIMIT[self.limitData[var_8_0].addStep + 1] then
					var_8_2:loadTextures("PopUmaruTwist/btn_unlock_limit.png", "PopUmaruTwist/btn_unlock_limit.png", "PopUmaruTwist/btn_unlock_limit.png", var_0_6)
				else
					var_8_2:loadTextures("PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", var_0_6)
				end
			else
				var_8_2:loadTextures("PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", var_0_6)
			end

			var_8_4:setVisible(false)
		else
			local var_8_5 = ccui.TextBMFont:create("", "fonts/summer_package_number.fnt")

			var_8_5:setAnchorPoint(cc.p(0, 0.5))
			var_8_5:setPosition(cc.p(85, var_8_2:getContentSize().height / 2))
			var_8_5:setName("label_price")
			var_8_2:addChild(var_8_5)

			local var_8_6 = math.min(self.initNum, self.limitData[var_8_0].limitNum - self.limitData[var_8_0].boughtNum)

			var_8_5:setString(self.currencyData[var_8_0].price * var_8_6)
			var_8_4:loadTexture("PopUmaruTwist/" .. var_8_6 .. ".png", var_0_6)
		end

		var_8_2:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.isCanBuy then
				return
			end

			if arg_9_0.limitNum == arg_9_0.boughtNum then
				if arg_9_0.index == 1 and L_TWIST_UNLOCK_BUY_LIMIT[self.limitData[arg_9_0.index].addStep + 1] then
					self:gotoUnlockLimit(self.limitData[arg_9_0.index].addStep + 1)

					return
				else
					return
				end
			end

			self.isCanBuy = false

			self:buyKeyItemDirectly(arg_9_0.index, (math.min(self.initNum, self.limitData[arg_9_0.index].limitNum - self.limitData[arg_9_0.index].boughtNum)))
		end)
		var_8_1:setTouchEnabled(true)
		var_8_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.isCanBuy then
				return
			end

			if arg_10_0.limitNum == arg_10_0.boughtNum then
				if arg_10_0.index == 1 and L_TWIST_UNLOCK_BUY_LIMIT[self.limitData[arg_10_0.index].addStep + 1] then
					self:gotoUnlockLimit(self.limitData[arg_10_0.index].addStep + 1)

					return
				else
					return
				end
			end

			self.isCanBuy = false

			self:buyKeyItemDirectly(arg_10_0.index, (math.min(self.initNum, self.limitData[arg_10_0.index].limitNum - self.limitData[arg_10_0.index].boughtNum)))
		end)

		var_8_0 = var_8_0 + 1
	end

	self:initBuyPackage()
	self:initBuyFree()
	self:initTips()

	if self.limitData[2].limitNum <= self.limitData[2].boughtNum then
		ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "buy_package"):setVisible(true)
	end
end

function PopFlopBuyLayer_137:buyKeyItemDirectly(arg_11_1, arg_11_2)
	local var_11_0 = self.currencyData[arg_11_1].currency == 8888888
	local var_11_1 = 0
	local var_11_3 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if var_11_0 then
				return item_manager:getItemNumber(CURRENCY_DIAMOND_PAID)
			else
				return playermodel.diamond
			end
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_11_3, {
		__index = function(arg_17_0, arg_17_1)
			return function()
				return item_manager:getItemNumber(arg_17_1)
			end
		end
	})

	local var_11_4 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[var_11_1] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[6800601] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end,
		[8888888] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end
	}

	setmetatable(var_11_4, {
		__index = function(arg_25_0, arg_25_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_25_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	if self.currencyData[arg_11_1].price * arg_11_2 > var_11_3[self.currencyData[arg_11_1].currency]() then
		var_11_4[self.currencyData[arg_11_1].currency]()

		self.isCanBuy = true

		return
	end

	activity_manager:buyFlopLimitBag(self.id, arg_11_1, arg_11_2, nil, function(arg_27_0)
		if arg_27_0.result == 1 then
			if arg_11_2 < self.initNum then
				global_gain({
					items = arg_27_0.items
				})

				self.initNum = self.initNum - arg_11_2

				self:updateBtn(arg_27_0, arg_11_1)
			else
				global_get({
					items = arg_27_0.items
				})
				LayerManager:removePopLayer(self._index)

				if self.sureCallback then
					self.sureCallback()
				end
			end
		elseif arg_27_0.result == 2 then
			global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_27_0.result == 3 then
			LayerManager:removePopLayer(self._index)
			var_11_4[msgtable.shopitem.currency]()
		end

		self.isCanBuy = true
	end)
end

function PopFlopBuyLayer_137.updateUI(arg_28_0)
	return
end

function PopFlopBuyLayer_137:updateBtn(arg_29_1, arg_29_2)
	while ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1) do
		local var_29_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type" .. 1)
		local var_29_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy" .. 1)
		local var_29_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "limit_" .. 1)
		local var_29_3 = var_29_1:getChildByName("label_price")
		local var_29_4 = var_29_0:getChildByName("img_num")

		if 1 == arg_29_2 then
			self.limitData[1].boughtNum = arg_29_1.boughtNum
			var_29_1.boughtNum = arg_29_1.boughtNum
			var_29_0.boughtNum = arg_29_1.boughtNum
		end

		var_29_2:setString(self.limitData[1].boughtNum .. "/" .. self.limitData[1].limitNum)

		if self.limitData[1].limitNum == self.limitData[1].boughtNum then
			if self.currencyData[arg_29_2].currency == SHOP_CURRENCY_DIAMOND then
				if L_TWIST_UNLOCK_BUY_LIMIT[self.limitData[1].addStep + 1] then
					var_29_1:loadTextures("PopUmaruTwist/btn_unlock_limit.png", "PopUmaruTwist/btn_unlock_limit.png", "PopUmaruTwist/btn_unlock_limit.png", var_0_6)
				else
					var_29_1:loadTextures("PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", var_0_6)
				end

				var_29_4:setVisible(false)

				if var_29_3 then
					var_29_3:setVisible(false)
				end

				if var_29_1:getChildByName("currency_icon") then
					var_29_1:getChildByName("currency_icon"):setVisible(false)
				end
			else
				var_29_1:loadTextures("PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", "PopUmaruTwist/btn_buy_out.png", var_0_6)
				var_29_4:setVisible(false)

				if var_29_3 then
					var_29_3:setVisible(false)
				end

				if var_29_1:getChildByName("currency_icon") then
					var_29_1:getChildByName("currency_icon"):setVisible(false)
				end
			end
		end

		if var_29_3 then
			var_29_3:setString(self.currencyData[1].price * self.initNum)
		end

		var_29_4:loadTexture("PopUmaruTwist/" .. self.initNum .. ".png", var_0_6)
	end

	if self.limitData[2].limitNum <= self.limitData[2].boughtNum then
		ccui.Helper:seekWidgetByName(self.rootLayer, "buy_type2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "buy_package"):setVisible(true)
	end
end

function PopFlopBuyLayer_137:initBuyPackage()
	local var_30_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_package")

	var_30_0:setPositionY(0)

	local function var_30_1()
		require("controller.goto_system_manager")

		local var_31_0 = {
			jump_to_system = 1713721,
			config = {}
		}

		if var_31_0.config then
			var_31_0.config.callback = self.packageCallback
		end

		goto_complete_system(var_31_0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_package"):addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
		var_30_1()
	end)
	var_30_0:setTouchEnabled(true)
	var_30_0:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
		var_30_1()
	end)
end

function PopFlopBuyLayer_137:initBuyFree(...)
	local var_34_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buy_free")

	local function var_34_1()
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = 3037,
			config = {}
		})
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_buy3"):addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
		var_34_1()
	end)
	var_34_0:setTouchEnabled(true)
	var_34_0:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
		var_34_1()
	end)
end

function PopFlopBuyLayer_137:initTips()
	ccui.Helper:seekWidgetByName(self.rootLayer, "tips"):addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "umaru_twist"
		})
	end)
end

function PopFlopBuyLayer_137.gotoUnlockLimit(arg_40_0, arg_40_1)
	LayerManager:pushInLayer("PopDoLayer", {
		surecallback = function()
			LayerManager:removePopLayer(arg_40_0.__queueindex)
			LayerManager:pushInLayer("PopSupermarketLayer", {
				initSelectPage = 2
			})
		end,
		labels = {
			titleNewImage = "public/title/title_twist_unlock_limit.png",
			des = L_TWIST_UNLOCK_BUY_LIMIT[arg_40_1],
			button = L_GO_BUY_DIAMOND.button
		}
	})
end
