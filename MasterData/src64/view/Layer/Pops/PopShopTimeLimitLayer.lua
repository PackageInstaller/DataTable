PopShopTimeLimitLayer = class("PopShopTimeLimitLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local recharge_manager = require("controller.recharge_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")

function PopShopTimeLimitLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShopTimeLimitLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopShopTimeLimitLayer:init(arg_3_1)
	self.initParam = arg_3_1.shopinfo
	self.exitcallback = arg_3_1.callback
	self.initParam.have_bought = activity_manager:getShopTimeLimitHaveBought(self.initParam.id) or self.initParam.have_bought
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "pop_shop_timelimitlayer.json" or "pop_shop_timelimitlayer.ExportJson")

	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, 0))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:loadTexture("mainScenebg/activity/shoptimelimit/bg_" .. self.initParam.id .. ".png")
	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))

	local var_3_0 = ccui.ImageView:create("mainScenebg/activity/shoptimelimit/bg_" .. self.initParam.id .. ".png")

	var_3_0:setPositionX(self.rootpanel:getContentSize().width / 2 - 20)
	var_3_0:setPositionY(self.rootpanel:getContentSize().height / 2)
	var_3_0:setVisible(false)
	self.rootpanel:addChild(var_3_0)
	self.rootpanel:setContentSize(var_3_0:getContentSize())
	self.rootpanel:setScaleY(0)
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
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, ccui.LayoutBackGroundColorType.none)
	self:initData(function(...)
		self:updateUI()
	end)
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" and self.initParam and self.initParam.callback then
			self.initParam.callback()
		end
	end)
	self:initPurchaseEventListener()
end

function PopShopTimeLimitLayer:initData(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.initParam.dropids) do
		if item_data[iter_8_1.dropid].bag_item_type == 13 then
			self.roleItemId = iter_8_1.dropid
		end
	end

	self.have_bought = self.initParam.have_bought
	self.price = self.rechargeid and recharge_manager.getProductDisplayPrice and recharge_manager:getProductDisplayPrice(info.rechargeid) or self.initParam.price
	self.currency = self.initParam.currency
	self.id = self.initParam.id
	self.rechargeid = self.initParam.rechargeid

	local var_8_0 = {
		{
			button = "public/button/button_gain.png"
		}
	}

	setmetatable(var_8_0, {
		__index = function(arg_9_0, arg_9_1)
			return {
				button = "public/button/button_gain.png"
			}
		end
	})

	self.buttonpath = var_8_0[self.id].button
	self.titlePos = {
		[3] = cc.p(320, 312)
	}

	setmetatable(self.titlePos, {
		__index = function(arg_10_0, arg_10_1)
			return cc.p(320, 312)
		end
	})

	if self.initParam.rechargeid then
		(function(...)
			recharge_manager:getRechargeInfo(function(arg_13_0, arg_13_1)
				if not PopShopTimeLimitNewLayerInstance then
					return
				end

				if arg_13_0 == 1 then
					for iter_13_0, iter_13_1 in pairs(arg_13_1) do
						if iter_13_1.rechargeid == self.rechargeid then
							self.have_bought = iter_13_1.have_bought
						end
					end

					if arg_8_1 then
						arg_8_1()
					end
				end
			end)

			if arg_8_1 then
				arg_8_1()
			end
		end)()
	else
		(function(...)
			if arg_8_1 then
				arg_8_1()
			end
		end)()
	end
end

function PopShopTimeLimitLayer:initUI()
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")

	var_14_0:addTouchEventListener(self:getSureBtnHangel())

	var_14_0.have_bought = self.have_bought

	if cc.FileUtils:getInstance():isFileExist("pop_shop_timelimit_layer/magnifier_" .. self.id .. ".png") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_magnifier"):loadTextures("pop_shop_timelimit_layer/magnifier_" .. self.id .. ".png", nil, "pop_shop_timelimit_layer/magnifier_" .. self.id .. ".png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_magnifier"):loadTextures("pop_shop_timelimit_layer/magnifier.png", nil, "pop_shop_timelimit_layer/magnifier.png", var_0_0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_magnifier"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.roleItemId then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[self.roleItemId].servant
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString((function(arg_16_0)
		local var_16_5 = global_get_time_by_date(self.initParam.finish_time) - time_check_manager:getCurTime()
		local var_16_6 = math.floor(var_16_5 / 24 / 3600)
		local var_16_7 = math.floor((var_16_5 - var_16_6 * 24 * 3600) / 3600)
		local var_16_8 = math.floor((var_16_5 - var_16_6 * 24 * 3600 - var_16_7 * 3600) / 60)

		return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_16_6, var_16_7) or var_16_7 ~= 0 and string.format(L_TIME_TEXT[2], var_16_7, var_16_8) or string.format(L_TIME_TEXT[3], var_16_8)
	end)(self.initParam.finish_time))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures(self.buttonpath, self.buttonpath, self.buttonpath, var_0_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_shoptime"):setAnchorPoint(cc.p(0.5, 0.5))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_shoptime"):setPositionX(self.titlePos[self.id].x + 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setPositionX(self.titlePos[self.id].x - 94 + 0)

	if cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/shoptimelimit/title_" .. self.id .. ".png") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_shoptime"):loadTexture("mainScenebg/activity/shoptimelimit/title_" .. self.id .. ".png")
	end
end

function PopShopTimeLimitLayer:getSureBtnHangel()
	return self.rechargeid and function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.have_bought > 0 then
			global_ShowBlockWords("已购买")

			return
		end

		self:buy(v)
	end or function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		if self.have_bought == 1 then
			global_ShowBlockWords("購入済み")
		end

		arg_19_0:setBright(false)
		activity_manager:buy_shop_timelimit(self.id, function(arg_20_0)
			if arg_20_0.result == 1 then
				self.have_bought = self.have_bought + 1

				activity_manager:setShopTimeLimitHaveBought(self.id)
				self:updateUI()
			elseif arg_20_0.result == 2 then
				print("表里没填")
			elseif arg_20_0.result == 3 then
				global_ShowBlockWords("購入済み")
			elseif arg_20_0.result == 4 then
				print("还没开始卖")
			elseif arg_20_0.result == 5 then
				global_ShowBlockWords("timeout")
			elseif arg_20_0.result == 6 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})
			end

			arg_19_0:setBright(true)
		end)
	end
end

function PopShopTimeLimitLayer.sortData(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		print(item_data[iter_21_1.itemid].name, iter_21_1.itemid)
	end

	local var_21_0 = {
		[1500010] = 2,
		[1306520] = 1,
		[6800601] = 3
	}

	setmetatable(var_21_0, {
		__index = function(arg_22_0, arg_22_1)
			return item_data[arg_22_1].equip_quality or 0
		end
	})
	table.sort(arg_21_1, function(arg_23_0, arg_23_1)
		return (var_21_0[arg_23_0.itemid] or 0) < (var_21_0[arg_23_1.itemid] or 0)
	end)
end

function PopShopTimeLimitLayer:updateUI()
	local var_24_9000

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_magnifier"):setVisible(self.roleItemId ~= nil)

	if self.have_bought == 0 then
		if self.currency then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency"):loadTexture("public/currency/" .. item_data[self.currency].image_id .. ".png", var_0_0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency"):loadTexture("public/currency/rmb_white.png", var_0_0)
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_price"):setString("X" .. self.price)

		local var_24_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency")

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency").setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_price").getContentSize(var_24_0).width, -(var_24_0:getContentSize().width / 2 + var_24_9000) / 2 + ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):getContentSize().width / 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_price"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency"):getPositionX() + ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency"):getContentSize().width / 2)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_price"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("PopNoviceAwardLayer/btn_got.png", "PopNoviceAwardLayer/btn_got.png", "PopNoviceAwardLayer/btn_got.png", var_0_0)
	end

	local var_24_1 = {}

	;(function()
		while ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. 1) do
			local var_25_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. 1)

			var_25_0:setVisible(false)
			var_25_0:removeAllChildren()
		end
	end)()
	;(function()
		local var_26_0 = {
			gold = self.initParam.gold,
			diamond = self.initParam.diamond,
			equips = self.initParam.dropids
		}

		if var_26_0.diamond > 0 then
			table.insert(var_24_1, {
				itemid = "diamond",
				num = var_26_0.diamond,
				name = L_DIAMOND
			})
		end

		if var_26_0.gold > 0 then
			table.insert(var_24_1, {
				itemid = "gold",
				num = var_26_0.gold,
				name = L_GOLD
			})
		end

		local var_26_1 = {}

		for iter_26_0, iter_26_1 in pairs(var_26_0.equips) do
			table.insert(var_26_1, {
				itemid = iter_26_1.dropid,
				num = iter_26_1.dropNum,
				name = item_data[iter_26_1.dropid].name,
				order = iter_26_0
			})
		end

		table.sort(var_26_1, function(arg_27_0, arg_27_1)
			return arg_27_0.order < arg_27_1.order
		end)
		self:sortData(var_26_1)

		for iter_26_2, iter_26_3 in pairs(var_26_1) do
			table.insert(var_24_1, iter_26_3)
		end

		for iter_26_4, iter_26_5 in pairs(var_24_1) do
			if iter_26_4 > 3 then
				var_24_1[iter_26_4] = nil
			end
		end

		for iter_26_6, iter_26_7 in pairs(var_24_1) do
			local var_26_2

			if ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):getContentSize().width == 174 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):setPositionY(158)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):setScale(1)

				var_26_2 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

				local var_26_4 = ItemSprite:createNewWithItemId(iter_26_7.itemid, nil, nil, iter_26_7.name .. ((iter_26_7.num > 1 or nil) and "X" .. iter_26_7.num))

				var_26_4:setName("itemSp")
				var_26_4:setAnchorPoint(cc.p(0, 0))
				var_26_2:addChild(var_26_4)
			else
				local var_26_5
				local var_26_6
				local var_26_7 = 1
				local var_26_8

				if itemid == "gold" then
					var_26_5 = "equipment/1000001.png"
					var_26_6 = 1
					var_26_7 = 1
				elseif itemid == "diamond" then
					var_26_5 = "equipment/1000000.png"
					var_26_6 = 1
					var_26_7 = 5
				elseif item_data[iter_26_7.itemid].bag_item_type == kITEM_COMPONENT then
					var_26_8 = component_manager:create_component_icon(iter_26_7.itemid)
					var_26_7 = item_data[iter_26_7.itemid].equip_quality
				elseif item_data[iter_26_7.itemid].image_id then
					var_26_5 = "equipment/" .. item_data[iter_26_7.itemid].image_id .. ".png"
					var_26_7 = item_data[iter_26_7.itemid].equip_quality
				end

				var_26_2 = ccui.Button:create("public/box/" .. var_26_7 .. ".png", "public/box/" .. var_26_7 .. ".png", "public/box/" .. var_26_7 .. ".png", var_0_0)
				var_26_8 = var_26_8 or ccui.ImageView:create(var_26_5)

				var_26_8:setName("itemSp")

				var_26_6 = var_26_6 or global_get_item_scale(var_26_8, item_data[iter_26_7.itemid].bag_item_type)

				var_26_8:setScale(var_26_6 * 0.5)
				var_26_8:setAnchorPoint(cc.p(0.5, 0.5))
				var_26_8:setPositionX(var_26_2:getContentSize().width / 2)
				var_26_8:setPositionY(var_26_2:getContentSize().height / 2)
				var_26_2:addChild(var_26_8)

				local var_26_9 = ccui.ImageView:create("PopNoviceAwardLayer/num_bg.png", var_0_0)

				var_26_9:setAnchorPoint(cc.p(1, 0))
				var_26_9:setPositionX(var_26_2:getContentSize().width)
				var_26_2:addChild(var_26_9)

				local var_26_10 = cc.Label:createWithTTF("x" .. iter_26_7.num, FONT_DES, 16)

				var_26_10:setAnchorPoint(cc.p(1, 0.5))
				var_26_10:setPositionX(var_26_9:getContentSize().width - 4)
				var_26_10:setPositionY(var_26_9:getContentSize().height / 2)
				var_26_9:addChild(var_26_10)
			end

			var_26_2.itemid = iter_26_7.itemid

			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):addChild(var_26_2)
			var_26_2:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):getContentSize().width / 2)
			var_26_2:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_26_6):getContentSize().height / 2)

			if type(iter_26_7.itemid) == "number" then
				var_26_2:addTouchEventListener(function(arg_28_0, arg_28_1)
					if arg_28_1 ~= ccui.TouchEventType.ended then
						return
					end

					if arg_28_0.itemid == self.roleItemId then
						if arg_28_1 ~= ccui.TouchEventType.ended then
							return
						end

						LayerManager:pushInLayer("SoulsLayer", {
							showtype = 6,
							defaultDisplayType = "preview",
							layertype = "DropDetailsLayer",
							cursoul = item_data[self.roleItemId].servant
						})
					else
						PopLayer:Item({
							hideGainButton = true,
							itemid = arg_28_0.itemid
						})
					end
				end)
			end
		end
	end)()

	for iter_24_0 = 1, #var_24_1 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_24_0):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_item" .. iter_24_0):setPositionX((iter_24_0 * 2 - 1) / (#var_24_1 * 2) * 540 + 50)
	end
end

function PopShopTimeLimitLayer:buy(arg_29_1)
	if self.recharging then
		return
	end

	AnalyticManager.clickPurchaseItem({
		product = self.rechargeid,
		rolenum = playermodel:getOwnedServantNum(),
		grade = playermodel.grade,
		class = playermodel.class
	})
	recharge_manager:confirmPayment(self.rechargeid)
end

function PopShopTimeLimitLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_31_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_32_0)
		if not arg_32_0 or not arg_32_0.id then
			return
		end

		self.have_bought = self.have_bought + 1
		self.recharging = false

		self:updateUI()
		activity_manager:setShopTimeLimitHaveBought(self.id)
	end), self)
end

function PopShopTimeLimitLayer:initBg(arg_33_1)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_0:setOpacity(0)
	self:addChild(var_33_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_34_0)
		self:addChild(arg_34_0, -2)
		arg_34_0:setPositionY(arg_34_0:getPositionY() - GameDisplay.fix_y)

		local var_34_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_34_0:setAnchorPoint(cc.p(0, 0))
		var_34_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_34_0, -1)
		self:init(arg_33_1)
		var_33_0:setOpacity(102)
		var_33_0:setTouchEnabled(false)
	end)
end

function PopShopTimeLimitLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(self.have_bought)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
