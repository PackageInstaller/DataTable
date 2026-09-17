ActivityBachelorBaseLayer = class("ActivityBachelorBaseLayer", function()
	return cc.Layer:create()
end)

require("controller.goto_system_manager")

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local share_manager = require("controller.share_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local l2utils = require("controller.l2utils")
local item_manager = require("controller.item_manager")
local recharge_manager = require("controller.recharge_manager")
local recharge_data = require("data.recharge_data")
local item_data = require("data.item_data")

function ActivityBachelorBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityBachelorBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityBachelorBaseLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityBachelor_2020.json" or "ActivityBachelor_2020.ExportJson")

	self:addChild(self.rootLayer)

	self.activityid = arg_3_1.activityId
	self.texturePath = "ActivityBachelor_" .. self.activityid

	TextureManager:loadLayerTextures({
		self.texturePath
	})
	self:initUI()
	self:registerActivityEventListener()
	self:updateAlert()
	activity_manager:get_activity_shopitem(self.activityid)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self.texturePath
			})
			activity_manager:releaseEventListenerByName("ActivityBachelorBaseLayer")
		end
	end)
end

function ActivityBachelorBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener("ActivityBachelorBaseLayer", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_6_0)
		self:updateRoutleAlert()
	end)
	activity_manager:registerEventListener("ActivityBachelorBaseLayer", activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, function(arg_7_0)
		self:updateRoutleAlert()
		self:updateShopItem(arg_7_0)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_8_0)
		activity_manager:get_activity_shopitem(self.activityid)
	end), self)
end

function ActivityBachelorBaseLayer:initUI()
	self:initPanelUp()
	self:initBottomPanel()
	self:playJoinEffect()
	self:fullScreen()
end

function ActivityBachelorBaseLayer:initPanelUp()
	self.ipad = self.rootLayer:getChildByName("ipad")

	self.ipad:loadTexture(self.texturePath .. "/ipad.png", var_0_0)

	self.btnShop = self.rootLayer:getChildByName("btn_shop")

	self.btnShop:setLocalZOrder(100)
	self.btnShop:loadTextures(self.texturePath .. "/btn_shop.png", nil, self.texturePath .. "/btn_shop.png", var_0_0)
	self.btnShop:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			showType = "1-502",
			singleMarket = {
				"1-502"
			}
		})
	end)

	self.btnCoupons = self.btnShop:getChildByName("btn_coupons")

	self.btnCoupons:loadTextures(self.texturePath .. "/btn_coupons.png", nil, self.texturePath .. "/btn_coupons.png", var_0_0)
	self.btnCoupons:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		goto_complete_system({
			jump_to_system = 1799903
		})
	end)

	self.btnEnvelope = self.btnShop:getChildByName("btn_envelope")

	self.btnEnvelope:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		activity_manager:check_red_packet(self.activityid, function(arg_14_0, arg_14_1)
			if arg_14_0 == 1 and arg_14_1 ~= 3 then
				LayerManager:pushInLayer("PopBachelorWelfareLayer", {
					id = self.activityid,
					stat = arg_14_1
				})
			end
		end)
	end)

	local var_10_0 = ccui.ImageView:create(self.texturePath .. "/img1.png", var_0_0)

	var_10_0:setPosition(cc.p(480, 756))
	var_10_0:setLocalZOrder(1001)
	self.ipad:addChild(var_10_0)

	local var_10_1 = ccui.ImageView:create(self.texturePath .. "/img2.png", var_0_0)

	var_10_1:setPosition(cc.p(400, -30))
	var_10_1:setRotation(-10)
	var_10_1:setLocalZOrder(1001)
	self.ipad:addChild(var_10_1)
end

function ActivityBachelorBaseLayer:initBottomPanel()
	self.btnReturn = self.rootLayer:getChildByName("btn_return")

	self.btnReturn:setLocalZOrder(999)
	self.btnReturn:loadTextures(self.texturePath .. "/btn_return.png", nil, self.texturePath .. "/btn_return.png", var_0_0)
	self.btnReturn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		self:playOutEffect(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	self.btnTwist = self.rootLayer:getChildByName("btn_twist")

	self.btnTwist:loadTextures(self.texturePath .. "/btn_twist.png", nil, self.texturePath .. "/btn_twist.png", var_0_0)
	self.btnTwist:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		LayerManager:switchShowLayer("ActivityRouletteBaseLayer", {
			activityId = self.activityid
		})
	end)

	self.btnRoulette = self.rootLayer:getChildByName("btn_roulette")

	self.btnRoulette:loadTextures(self.texturePath .. "/btn_roulette.png", nil, self.texturePath .. "/btn_roulette.png", var_0_0)
	self.btnRoulette:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isShowEffect then
			return
		end

		goto_complete_system({
			jump_to_system = tonumber(2000 .. self.activityid)
		})
	end)
end

function ActivityBachelorBaseLayer:updateShopItem(arg_20_1)
	if not self.shopitemPanel then
		self:createShopitemPanel(arg_20_1)
	else
		self:updateShopitemPanel(arg_20_1)
	end
end

function ActivityBachelorBaseLayer:createShopitemPanel(arg_21_1)
	self.shopitemPanel = ccui.Layout:create()

	self.shopitemPanel:setContentSize(self.ipad:getContentSize())
	self.shopitemPanel:setAnchorPoint(cc.p(0, 0))
	self.shopitemPanel:setPosition(cc.p(0, 0))
	self.ipad:addChild(self.shopitemPanel)

	for iter_21_0, iter_21_1 in pairs(arg_21_1.shopitem) do
		local var_21_0 = cc.Label:createWithTTF(iter_21_1.value .. "%折扣", FONT_NAME, 18)

		var_21_0:setColor(cc.c3b(255, 249, 155))
		var_21_0:setName("lbl_value_" .. iter_21_0)
		var_21_0:setPosition(cc.p(536, 66 + 169 * iter_21_0))
		self.shopitemPanel:addChild(var_21_0)

		local var_21_1 = cc.Label:createWithTTF(string.format(L_PRICE[1], iter_21_1.original_price), FONT_NAME, 18)

		var_21_1:setColor(cc.c3b(149, 158, 192))
		var_21_1:setName("original_price_" .. iter_21_0)
		var_21_1:setPosition(cc.p(520, 30 + 169 * iter_21_0))
		self.shopitemPanel:addChild(var_21_1)

		local var_21_2 = ccui.ImageView:create(self.texturePath .. "/delete.png", var_0_0)

		var_21_2:setPosition(cc.p(520, 30 + 169 * iter_21_0))
		self.shopitemPanel:addChild(var_21_2)

		local var_21_3

		if not var_21_3 or var_21_3 == "nil" then
			var_21_3 = recharge_data[iter_21_1.rechargeid].rmb
		end

		local var_21_4 = cc.Label:createWithTTF(string.format(L_PRICE[2], var_21_3), FONT_NAME, 20)

		var_21_4:setColor(cc.c3b(255, 255, 255))
		var_21_4:setName("real_price_" .. iter_21_0)
		var_21_4:setPosition(cc.p(520, 10 + 169 * iter_21_0))
		self.shopitemPanel:addChild(var_21_4)

		local var_21_5 = ccui.Button:create(self.texturePath .. "/btn_buy.png", nil, self.texturePath .. "/btn_buy.png", var_0_0)

		if iter_21_1.have_bought > 0 then
			var_21_5:loadTextures(self.texturePath .. "/btn_bought.png", nil, self.texturePath .. "/btn_bought.png", var_0_0)
		end

		var_21_5:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_21_1.have_bought > 0 then
				return
			end

			if tonumber(iter_21_1.limit_sever_num) <= 0 then
				global_ShowBlockWords(L_ACTIVITY_SHOPITEM_NIL)

				return
			end

			activity_manager:rechargeForShopItem(self.activityid, iter_21_1.rechargeid)
		end)
		var_21_5:setName("btn_buy_" .. iter_21_0)
		var_21_5:setPosition(cc.p(520, -30 + 169 * iter_21_0))
		self.shopitemPanel:addChild(var_21_5)

		if iter_21_1.diamond and iter_21_1.diamond > 0 then
			table.insert(iter_21_1.items, {
				dropid = "diamond",
				dropNum = iter_21_1.diamond
			})
		end

		for iter_21_2, iter_21_3 in ipairs(iter_21_1.items) do
			local var_21_7 = ccui.ImageView:create("equipment/" .. ((iter_21_3.dropid == "diamond" or nil) and 1000000) .. ".png")

			var_21_7:setPosition(cc.p(85 + 145 * iter_21_2, 18 + 169 * iter_21_0))
			var_21_7:setName("item_" .. iter_21_0 .. "_" .. iter_21_2)

			if item_data[iter_21_3.dropid].bag_item_type == kITEM_HORCRUX then
				var_21_7:setScale(0.3)
			else
				var_21_7:setScale(0.75)
			end

			if item_data[iter_21_3.dropid].bag_item_type == kITEM_HORCRUX then
				var_21_7:setScale(0.3)
			else
				var_21_7:setScale(0.75)
			end

			self.shopitemPanel:addChild(var_21_7)
			var_21_7:setTouchEnabled(true)
			var_21_7:addTouchEventListener(function(arg_23_0, arg_23_1)
				if arg_23_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_21_3.dropid)
			end)

			local var_21_8 = ccui.ImageView:create(self.texturePath .. "/price_bg.png", var_0_0)

			var_21_8:setPosition(cc.p(85 + 145 * iter_21_2, -25 + 169 * iter_21_0))
			self.shopitemPanel:addChild(var_21_8)

			local var_21_9 = cc.Label:createWithTTF("X" .. iter_21_3.dropNum, FONT_NAME, 20)

			var_21_9:setColor(cc.c3b(255, 255, 255))
			var_21_9:setAnchorPoint(cc.p(1, 0.5))
			var_21_9:setName(string.format("lbl_num_%s_%s", iter_21_0, iter_21_2))
			var_21_9:setPosition(cc.p(132 + 145 * iter_21_2, -25 + 169 * iter_21_0))
			self.shopitemPanel:addChild(var_21_9)

			local var_21_11 = cc.Label:createWithTTF((iter_21_3.dropid == "diamond" or nil) and L_DIAMOND, FONT_NAME, 17)

			var_21_11:setColor(cc.c3b(255, 255, 255))
			var_21_11:setName(string.format("lbl_name_%s_%s", iter_21_0, iter_21_2))
			var_21_11:setPosition(cc.p(85 + 145 * iter_21_2, -50 + 169 * iter_21_0))
			self.shopitemPanel:addChild(var_21_11)

			local var_21_12 = ccui.Layout:create()

			var_21_12:setContentSize(cc.size(10, 10))
			var_21_12:setAnchorPoint(cc.p(0, 0))
			var_21_12:setPosition(cc.p(32 + 145 * iter_21_2, -34 + 169 * iter_21_0))
			var_21_12:setName(string.format("star_panel_%s_%s", iter_21_0, iter_21_2))
			self.shopitemPanel:addChild(var_21_12)

			for iter_21_4 = 1, 6 do
				local var_21_13 = ccui.ImageView:create("public/currency/equip_star.png", var_0_0)

				var_21_13:setPosition(cc.p(10, iter_21_4 * 13))
				var_21_12:addChild(var_21_13, 999)
			end

			var_21_12:setVisible(iter_21_3.item_attr == "star=6")
		end

		iter_21_1.limit_sever_num = tonumber(iter_21_1.limit_sever_num)
		iter_21_1.limit_sever_num = math.ceil(iter_21_1.limit_sever_num * 10) / 10

		local var_21_14 = ccui.Slider:create()

		var_21_14:setRotation(-90)
		var_21_14:loadBarTexture(self.texturePath .. "/progressBar_bg.png", var_0_0)

		if iter_21_1.limit_sever_num > 40 then
			var_21_14:loadProgressBarTexture(self.texturePath .. "/progressBar_full.png", var_0_0)
		else
			var_21_14:loadProgressBarTexture(self.texturePath .. "/progressBar_nil.png", var_0_0)
		end

		var_21_14:setPosition(cc.p(123, 6 + 169 * iter_21_0))
		var_21_14:setName("progressBar" .. iter_21_0)
		var_21_14:setPercent(iter_21_1.limit_sever_num)
		self.shopitemPanel:addChild(var_21_14)

		local var_21_15 = ccui.ImageView:create(self.texturePath .. "/progressBar_pg.png", var_0_0)

		var_21_15:setPosition(cc.p(123, 6 + 169 * iter_21_0))
		var_21_15:setRotation(-90)
		self.shopitemPanel:addChild(var_21_15)

		local var_21_16 = cc.Label:createWithTTF(iter_21_1.limit_sever_num .. "%", FONT_NAME, 24)

		var_21_16:setColor(cc.c3b(255, 255, 255))
		var_21_16:setPosition(cc.p(123, -50 + 169 * iter_21_0))
		var_21_16:setName("percent" .. iter_21_0)
		self.shopitemPanel:addChild(var_21_16)
	end
end

function ActivityBachelorBaseLayer:updateShopitemPanel(arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1.shopitem) do
		self.shopitemPanel:getChildByName("lbl_value_" .. iter_24_0):setString(iter_24_1.value .. L_SHOPSPRITE[2])
		self.shopitemPanel:getChildByName("original_price_" .. iter_24_0):setString(string.format(L_PRICE[1], iter_24_1.original_price))

		local var_24_0

		if not var_24_0 or var_24_0 == "nil" then
			var_24_0 = recharge_data[iter_24_1.rechargeid].rmb
		end

		self.shopitemPanel:getChildByName("real_price_" .. iter_24_0):setString(string.format(L_PRICE[2], var_24_0))

		local var_24_1 = self.shopitemPanel:getChildByName("btn_buy_" .. iter_24_0)

		if iter_24_1.have_bought > 0 then
			var_24_1:loadTextures(self.texturePath .. "/btn_bought.png", nil, self.texturePath .. "/btn_bought.png", var_0_0)
		end

		var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_24_1.have_bought > 0 then
				return
			end

			if tonumber(iter_24_1.limit_sever_num) <= 0 then
				global_ShowBlockWords(L_ACTIVITY_SHOPITEM_NIL)

				return
			end

			activity_manager:rechargeForShopItem(self.activityid, iter_24_1.rechargeid)
		end)

		if iter_24_1.diamond and iter_24_1.diamond > 0 then
			table.insert(iter_24_1.items, {
				dropid = "diamond",
				dropNum = iter_24_1.diamond
			})
		end

		for iter_24_2, iter_24_3 in ipairs(iter_24_1.items) do
			local var_24_2 = item_data[iter_24_3.dropid].image_id

			if iter_24_3.dropid == "diamond" then
				var_24_2 = 1000000
			end

			local var_24_3 = self.shopitemPanel:getChildByName("item_" .. iter_24_0 .. "_" .. iter_24_2)

			var_24_3:loadTexture("equipment/" .. var_24_2 .. ".png")

			if item_data[iter_24_3.dropid].bag_item_type == kITEM_HORCRUX then
				var_24_3:setScale(0.3)
			else
				var_24_3:setScale(0.75)
			end

			var_24_3:setTouchEnabled(true)
			var_24_3:addTouchEventListener(function(arg_26_0, arg_26_1)
				if arg_26_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_24_3.dropid)
			end)

			local var_24_4 = item_data[iter_24_3.dropid].name

			if iter_24_3.dropid == "diamond" then
				var_24_4 = L_DIAMOND
			end

			self.shopitemPanel:getChildByName(string.format("lbl_num_%s_%s", iter_24_0, iter_24_2)):setString("X" .. iter_24_3.dropNum)
			self.shopitemPanel:getChildByName(string.format("lbl_name_%s_%s", iter_24_0, iter_24_2)):setString(var_24_4)
			self.shopitemPanel:getChildByName("star_panel_" .. iter_24_0 .. "_" .. iter_24_2):setVisible(iter_24_3.item_attr == "star=6")
		end

		iter_24_1.limit_sever_num = tonumber(iter_24_1.limit_sever_num)
		iter_24_1.limit_sever_num = math.ceil(iter_24_1.limit_sever_num * 10) / 10

		local var_24_5 = self.shopitemPanel:getChildByName("progressBar" .. iter_24_0)

		var_24_5:setPercent(iter_24_1.limit_sever_num)

		if iter_24_1.limit_sever_num > 40 then
			var_24_5:loadProgressBarTexture(self.texturePath .. "/progressBar_full.png", var_0_0)
		else
			var_24_5:loadProgressBarTexture(self.texturePath .. "/progressBar_nil.png", var_0_0)
		end

		local var_24_6 = self.shopitemPanel:getChildByName("percent" .. iter_24_0):setString(iter_24_1.limit_sever_num .. "%")
	end
end

function ActivityBachelorBaseLayer:playJoinEffect()
	self.isShowEffect = true

	self.btnShop:setOpacity(0)
	self.btnRoulette:setOpacity(0)
	self.btnRoulette:runAction(cc.Sequence:create(cc.FadeIn:create(0.6)))
	self.btnShop:runAction(cc.Sequence:create(cc.FadeIn:create(0.6), cc.CallFunc:create(function()
		self.isShowEffect = nil
	end)))
end

function ActivityBachelorBaseLayer:playOutEffect(arg_29_1)
	self.isShowEffect = true

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_29_1 then
			arg_29_1()
		end

		self.isShowEffect = nil
	end)))
	self.btnRoulette:runAction(cc.FadeOut:create(0.2))
	self.btnShop:runAction(cc.FadeOut:create(0.2))
end

function ActivityBachelorBaseLayer:fullScreen()
	self.btnRoulette:setPositionY(143 - (GameDisplay.height - 1136) * 0.33)
	self.btnTwist:setPosition(504, 120 - (GameDisplay.height - 1136) * 0.33)
	self.btnTwist:setRotation(-30)
	self.btnShop:setPositionY(GameDisplay.height - 130 + -GameDisplay.fix_y - (GameDisplay.height - 1136) * 0.2)
	self.btnReturn:setPositionY(52 - GameDisplay.fix_y)
end

function ActivityBachelorBaseLayer:add_alert_tag(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if not arg_32_1 then
		return
	end

	if arg_32_1:getChildByName("reddot") then
		arg_32_1:getChildByName("reddot"):setVisible(arg_32_4)

		return
	end

	local var_32_0 = arg_32_3 or 999
	local var_32_1 = arg_32_2 or {
		x = arg_32_1:getContentSize().width,
		y = arg_32_1:getContentSize().height
	}
	local var_32_2 = ccui.ImageView:create(self.texturePath .. "/redDot.png", var_0_0)

	var_32_2:setName("reddot")
	var_32_2:setVisible(arg_32_4)
	var_32_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_32_2:setPosition(cc.p(var_32_1.x, var_32_1.y))
	arg_32_1:addChild(var_32_2, var_32_0)
end

function ActivityBachelorBaseLayer.updateAlert(arg_33_0)
	return
end

function ActivityBachelorBaseLayer.updateRoutleAlert(arg_34_0)
	return
end
