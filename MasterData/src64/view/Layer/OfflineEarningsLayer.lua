OfflineEarningsLayer = class("OfflineEarningsLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local armature_manager = require("controller.armature_manager")
local utf8 = require("controller.utf8")
local l2utils = require("controller.l2utils")
local activity_manager = require("controller.activity_manager")
local var_0_9 = "Offline_Return/"
local recharge_data = require("data.recharge_data")
local network = require("network.network")
local recharge_manager = require("controller.recharge_manager")
local drop_manager = require("controller.drop_manager")
local var_0_14 = require("data.item_data")
local activity_return_manager = require("controller.activity_return_manager")
local level_manager = require("controller.level_manager")
local var_0_17 = 174
local var_0_18 = 228

local function var_0_21()
	require("controller.texture_manager"):loadLayerTextures({
		"fightResultNew"
	})
end

local function var_0_22()
	require("controller.texture_manager"):removeLayerTextures({
		"fightResultNew"
	})
end

function OfflineEarningsLayer.create(arg_5_0, arg_5_1)
	var_0_21()

	local var_5_0 = OfflineEarningsLayer.new()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function OfflineEarningsLayer:init(arg_6_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "OfflineEarnings.json" or "OfflineEarnings.ExportJson")

	self:addChild(self.rootLayer, 2)

	self.offlineDay = activity_return_manager:getOfflineDay()
	self.msg = arg_6_1

	self:checkLimite()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			l2utils:performWithDelay(var_0_22, 0.5)
		end
	end)
end

function OfflineEarningsLayer:initUI(arg_8_1, arg_8_2)
	self:initBG(arg_8_1, arg_8_2)
	self:initTitle(arg_8_1, arg_8_2)
	self:initItems(arg_8_1, arg_8_2)
	self:registerBuygiftEventListener()
end

function OfflineEarningsLayer:initBG(arg_9_1, arg_9_2)
	self.bgPosX = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_2"):getPositionX()
	self.bgPosY = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_2"):getPositionY()
	self.scrSize = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_12"):getContentSize()

	self:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))

	local var_9_0 = cc.LayerColor:create(cc.c4b(10, 10, 10, 0), GameDisplay.width, GameDisplay.height + 10)

	var_9_0:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y - 70))
	self:addChild(var_9_0, 0)
	var_9_0:setTouchEnabled(true)

	local var_9_1 = ccui.Layout:create()

	var_9_1:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y - 70)
	var_9_1:setContentSize(GameDisplay.width, GameDisplay.height + 10)
	var_9_1:setTouchEnabled(true)
	self:addChild(var_9_1, 0)

	if activity_manager:getActivityObj(BACKFLOW_BP_ID) and self.offlineDay and (not arg_9_1 and self.offlineDay < 30 or not arg_9_2 and self.offlineDay >= 30) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_2"):setVisible(false)

		self.bg = ccui.ImageView:create(var_0_9 .. "bg.png", var_0_0)

		self.rootLayer:addChild(self.bg)
		self.bg:setAnchorPoint(0.5, 0.5)
		self.bg:setScaleY(0.8)
		self.bg:setPosition(self.bgPosX, self.bgPosY - 40)

		self.bg1 = ccui.ImageView:create(var_0_9 .. "bg1.png", var_0_0)

		self.bg1:setAnchorPoint(0.5, 0.5)
		self.bg1:setScale(1.2)
		self.bg1:setScaleX(1)
		self.bg:addChild(self.bg1)
		self.bg1:setPosition(self.bgPosX - 40, self.bgPosY - 385)

		local var_9_2 = ccui.ImageView:create(var_0_9 .. "money.png", var_0_0)
		local var_9_3 = ccui.ImageView:create(var_0_9 .. "sciencepoint.png", var_0_0)
		local var_9_4 = ccui.ImageView:create(var_0_9 .. "money.png", var_0_0)
		local var_9_5 = ccui.ImageView:create(var_0_9 .. "sciencepoint.png", var_0_0)
		local var_9_6 = cc.Label:createWithTTF(global_trans_number(drop_manager:getDropMsg("2024RETURBN01").gold), FONT_DES, 22)
		local var_9_7 = cc.Label:createWithTTF(global_trans_number(drop_manager:getDropMsg("2024RETURBN01").sp), FONT_DES, 22)
		local var_9_8 = cc.Label:createWithTTF(global_trans_number(drop_manager:getDropMsg("2024RETURBN02").gold), FONT_DES, 22)
		local var_9_9 = cc.Label:createWithTTF(global_trans_number(drop_manager:getDropMsg("2024RETURBN02").sp), FONT_DES, 22)

		var_9_6:setTextColor(cc.c4b(227, 243, 249, 255))
		var_9_7:setTextColor(cc.c4b(227, 243, 249, 255))
		var_9_8:setTextColor(cc.c4b(227, 243, 249, 255))
		var_9_9:setTextColor(cc.c4b(227, 243, 249, 255))
		var_9_2:setPosition(self.bgPosX - 150, self.bgPosY - 362)
		var_9_3:setPosition(self.bgPosX - 35, self.bgPosY - 362)
		var_9_4:setPosition(self.bgPosX - 150, self.bgPosY - 362)
		var_9_5:setPosition(self.bgPosX - 35, self.bgPosY - 362)
		var_9_6:setPosition(self.bgPosX - 100, self.bgPosY - 362)
		var_9_7:setPosition(self.bgPosX + 20, self.bgPosY - 362)
		var_9_8:setPosition(self.bgPosX - 100, self.bgPosY - 362)
		var_9_9:setPosition(self.bgPosX + 20, self.bgPosY - 362)
		self.rootLayer:addChild(var_9_2)
		self.rootLayer:addChild(var_9_3)
		self.rootLayer:addChild(var_9_4)
		self.rootLayer:addChild(var_9_5)
		self.rootLayer:addChild(var_9_6)
		self.rootLayer:addChild(var_9_7)
		self.rootLayer:addChild(var_9_8)
		self.rootLayer:addChild(var_9_9)
		var_9_2:setVisible(self.offlineDay < 30)
		var_9_3:setVisible(self.offlineDay < 30)
		var_9_6:setVisible(self.offlineDay < 30)
		var_9_7:setVisible(self.offlineDay < 30)
		var_9_4:setVisible(self.offlineDay >= 30)
		var_9_5:setVisible(self.offlineDay >= 30)
		var_9_8:setVisible(self.offlineDay >= 30)
		var_9_9:setVisible(self.offlineDay >= 30)

		local var_9_10 = cc.Label:createWithTTF("额外获得", FONT_DES, 16)
		local var_9_11 = cc.Label:createWithTTF("额外获得", FONT_DES, 16)

		var_9_10:setAnchorPoint(0, 0.5)
		var_9_11:setAnchorPoint(0, 0.5)
		var_9_10:setColor(cc.c4b(178, 200, 255, 255))
		var_9_11:setColor(cc.c4b(178, 200, 255, 255))
		var_9_10:setPosition(self.bgPosX - 240, self.bgPosY - 362)
		var_9_11:setPosition(self.bgPosX - 240, self.bgPosY - 362)
		self.rootLayer:addChild(var_9_10)
		self.rootLayer:addChild(var_9_11)
		var_9_10:setVisible(self.offlineDay < 30)
		var_9_11:setVisible(self.offlineDay >= 30)

		if self.offlineDay < 30 then
			for iter_9_0, iter_9_1 in ipairs(drop_manager:getDropMsg("2024RETURBN01").equips) do
				local var_9_12 = ccui.ImageView:create("public/box/new_item_bg5.png", var_0_0)

				var_9_12:setScale(0.4)
				var_9_12:setScaleY(0.3)
				var_9_12:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_12)

				local var_9_13 = ccui.ImageView:create("equipment/" .. var_0_14[iter_9_1.dropid].image_id .. ".png")

				var_9_13:setScale(0.4)
				var_9_13:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_13)

				local var_9_14 = cc.Label:createWithTTF("X" .. global_trans_number(iter_9_1.dropNum), FONT_DES, 14)

				var_9_14:setTextColor(cc.c4b(255, 255, 255, 255))
				var_9_14:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_14)
				var_9_12:setPosition(self.bgPosX - 210 + (iter_9_0 - 1) * 72, self.bgPosY - 305)
				var_9_14:setPositionX(var_9_12:getPositionX())
				var_9_14:setPositionY(var_9_12:getPositionY() - 25)
				var_9_13:setPosition(var_9_12:getPositionX(), var_9_12:getPositionY() + 9)
			end
		end

		if self.offlineDay >= 30 then
			for iter_9_2, iter_9_3 in ipairs(drop_manager:getDropMsg("2024RETURBN02").equips) do
				local var_9_15 = ccui.ImageView:create("public/box/new_item_bg5.png", var_0_0)

				var_9_15:setScale(0.4)
				var_9_15:setScaleY(0.3)
				var_9_15:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_15)

				local var_9_16 = ccui.ImageView:create("equipment/" .. var_0_14[iter_9_3.dropid].image_id .. ".png")

				var_9_16:setScale(0.4)
				var_9_16:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_16)

				local var_9_17 = cc.Label:createWithTTF("X" .. global_trans_number(iter_9_3.dropNum), FONT_DES, 14)

				var_9_17:setTextColor(cc.c4b(255, 255, 255, 255))
				var_9_17:setAnchorPoint(0.5, 0.5)
				self.rootLayer:addChild(var_9_17)
				var_9_15:setPosition(self.bgPosX - 210 + (iter_9_2 - 1) * 72, self.bgPosY - 305)
				var_9_17:setPositionX(var_9_15:getPositionX())
				var_9_17:setPositionY(var_9_15:getPositionY() - 25)
				var_9_16:setPosition(var_9_15:getPositionX(), var_9_15:getPositionY() + 7)
			end
		end

		self.button_6 = ccui.Button:create(var_0_9 .. "buy.png", nil, var_0_9 .. "buy.png", var_0_0)
		self.button_18 = ccui.Button:create(var_0_9 .. "buy.png", nil, var_0_9 .. "buy.png", var_0_0)

		self.rootLayer:addChild(self.button_6)
		self.rootLayer:addChild(self.button_18)
		self.button_6:setAnchorPoint(0.5, 0.5)
		self.button_18:setAnchorPoint(0.5, 0.5)
		self.button_6:setPosition(self.bgPosX + 152, self.bgPosY - 325)
		self.button_18:setPosition(self.bgPosX + 152, self.bgPosY - 325)

		self.mask1 = ccui.ImageView:create(var_0_9 .. "mask.png", var_0_0)

		self.mask1:setAnchorPoint(0.5, 0.5)
		self.mask1:setScale(1)
		self.rootLayer:addChild(self.mask1)
		self.mask1:setPosition(self.bgPosX, self.bgPosY - 323)
		self.mask1:setVisible(false)

		self.mask2 = ccui.ImageView:create(var_0_9 .. "mask.png", var_0_0)

		self.mask2:setAnchorPoint(0.5, 0.5)
		self.mask2:setScale(1)
		self.rootLayer:addChild(self.mask2)
		self.mask2:setPosition(self.bgPosX, self.bgPosY - 323)
		self.mask2:setVisible(false)
		self:UpdateUI(arg_9_1, arg_9_2)
	end

	local var_9_18 = ccui.Layout:create()

	var_9_18:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	var_9_18:setContentSize(GameDisplay.width, GameDisplay.height)
	var_9_18:setTouchEnabled(true)
	var_9_18:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:getActivityObj(BACKFLOW_BP_ID) or arg_9_1 and arg_9_2 then
			self:exit()
		end
	end)
	self:addChild(var_9_18, 0)
	var_9_0:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.EaseOut:create(cc.FadeTo:create(2, 200), 2)))
end

function OfflineEarningsLayer:UpdateBuyStates(arg_11_1)
	local var_11_0 = false
	local var_11_1 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.products) do
		if iter_11_1.id == 17601 and arg_11_1.products[iter_11_0].time >= arg_11_1.products[iter_11_0].buy_limit then
			var_11_0 = true
		elseif iter_11_1.id == 17602 and arg_11_1.products[iter_11_0].time >= arg_11_1.products[iter_11_0].buy_limit then
			var_11_1 = true
		end
	end

	self:initUI(var_11_0, var_11_1)
	self:UpdateUI(var_11_0, var_11_1)
end

function OfflineEarningsLayer:UpdateUI(arg_12_1, arg_12_2)
	if self.button_6 then
		self.button_6:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			activity_manager:getActivityObj(BACKFLOW_BP_ID):rechargeForShopItem(17601)
		end)

		if arg_12_1 then
			self.button_6:loadTextures(var_0_9 .. "buyoff.png", nil, var_0_9 .. "buyoff.png", var_0_0)
		end

		self.button_6:setVisible(self.offlineDay < 30)
		self.mask2:setVisible(arg_12_1 and self.offlineDay < 30)
	end

	if self.button_18 then
		self.button_18:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			activity_manager:getActivityObj(BACKFLOW_BP_ID):rechargeForShopItem(17602)
		end)

		if arg_12_2 then
			self.button_18:loadTextures(var_0_9 .. "buyoff.png", nil, var_0_9 .. "buyoff.png", var_0_0)
		end

		self.button_18:setVisible(self.offlineDay >= 30)
		self.mask1:setVisible(arg_12_2 and self.offlineDay >= 30)
	end
end

function OfflineEarningsLayer:registerBuygiftEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_16_0)
		self:checkLimite()
	end), self)
end

function OfflineEarningsLayer.checkLimite(arg_17_0)
	network:rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			4
		}
	}, function(arg_18_0)
		if tolua.isnull(arg_17_0) then
			return
		end

		arg_17_0:UpdateBuyStates(arg_18_0)
	end)
end

function OfflineEarningsLayer:initTitle(arg_19_1, arg_19_2)
	if activity_manager:getActivityObj(BACKFLOW_BP_ID) and self.offlineDay and (not arg_19_1 and self.offlineDay < 30 or not arg_19_2 and self.offlineDay >= 30) then
		self.title = ccui.ImageView:create("fightResultNew/title_outline.png", var_0_0)

		self.title:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.title)
		self.title:setPosition(self.bgPosX - 340 + 25, self.bgPosY + 440 - 20)

		self.titleTime = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleTime:setTextColor(cc.c4b(181, 196, 201, 255))
		self.titleTime:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleTime)
		self.titleTime:setPosition(self.bgPosX - 290 + 25, self.bgPosY + 380 - 20)
		self.titleTime:setString(string.format(L_OFFLINE_LEVEL, self.msg.time))

		self.titleLevel1 = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleLevel1:setTextColor(cc.c4b(181, 196, 201, 255))
		self.titleLevel1:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleLevel1)
		self.titleLevel1:setPosition(self.bgPosX - 290 + 25, self.bgPosY + 340 - 20)

		if playermodel.curMode < 401 then
			self.titleLevel1:setString(string.format(L_OFFLINE_TIME, self.msg.levelinfo .. "(" .. L_LEVEL_MODE_DIF[level_manager:getCurFightDifficulty()] .. ")"))
		else
			self.titleLevel1:setString(string.format(L_OFFLINE_TIME, self.msg.levelinfo))
		end

		self.titleLevel2 = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleLevel2:setTextColor(cc.c4b(181, 196, 201, 255))
		self.titleLevel2:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleLevel2)
		self.titleLevel2:setPosition(self.bgPosX - 290 + 25, self.bgPosY + 300 - 20)
		self.titleLevel2:setString(L_OFFLINE_TIME_DES1)

		self.img_sciencepointUp = ccui.ImageView:create("fightResultNew/img_sciencepoint.png", var_0_0)

		self.img_sciencepointUp:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.img_sciencepointUp)
		self.img_sciencepointUp:setPosition(self.bgPosX - 290 + 25, self.bgPosY + 240 - 20)

		self.img_moneyUp = ccui.ImageView:create("fightResultNew/img_money.png", var_0_0)

		self.img_moneyUp:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.img_moneyUp)
		self.img_moneyUp:setPosition(self.bgPosX - 160 + 45, self.bgPosY + 240 - 20)

		local var_19_0 = tostring(self:getShowRole())

		if var_19_0 then
			self.roleIcon = ccui.ImageView:create("role1/" .. model_data[var_19_0].cute_role .. ".png")

			self.roleIcon:setAnchorPoint(0.5, 0.5)
			self.rootLayer:addChild(self.roleIcon)
			self.roleIcon:setPosition(self.bgPosX + 220, self.bgPosY + 400 - 20)
			self.roleIcon:setScale(0.4)
		else
			self.roleIcon = ccui.ImageView:create("GUI/image.png", var_0_0)

			self.roleIcon:setVisible(false)
		end

		self.titleSp = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleSp:setTextColor(cc.c4b(227, 243, 249, 255))
		self.titleSp:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleSp)
		self.titleSp:setPosition(self.bgPosX - 210, self.bgPosY + 240 - 20)
		self.titleSp:setString(global_trans_bitmapnumber(self.msg.sp))

		self.titleGold = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleGold:setTextColor(cc.c4b(227, 243, 249, 255))
		self.titleGold:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleGold)
		self.titleGold:setPosition(self.bgPosX - 55, self.bgPosY + 240 - 20)
		self.titleGold:setString(global_trans_bitmapnumber(self.msg.gold))

		self.titleItem = cc.Label:createWithTTF("", "fonts/number.ttf", 26)

		self.titleItem:setAnchorPoint(0, 0.5)
		self.rootLayer:addChild(self.titleItem)
		self.titleItem:setPosition(self.bgPosX - 290 + 25, self.bgPosY + 200 - 20)
		self.titleItem:setString(L_FIGHTNEW_MSG.Cache_Title .. string.format("%d/%d", playermodel.dropcacheweight.weight, playermodel.dropcacheweight.limit))

		self.surebtn = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)

		self.surebtn:setAnchorPoint(0.5, 0.5)
		self.rootLayer:addChild(self.surebtn)
		self.surebtn:setPosition(self.bgPosX + 25, self.bgPosY - 520)
		self.surebtn:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)

		self.titleItem = cc.Label:createWithTTF("", "fonts/newkj.ttf", 28)

		self.titleItem:setTextColor(cc.c4b(0, 0, 0, 255))
		self.titleItem:setAnchorPoint(0.5, 0.5)
		self.rootLayer:addChild(self.titleItem)
		self.titleItem:setPosition(self.bgPosX + 25, self.bgPosY - 520)
		self.titleItem:setString(L_ADD_INSTANCE_TIMES.button)
	else
		self.titleTime = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_4")

		self.titleTime:setString(string.format(L_OFFLINE_LEVEL, self.msg.time))

		self.titleLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_5")

		if playermodel.curMode < 401 then
			self.titleLevel:setString(string.format(L_OFFLINE_TIME, self.msg.levelinfo .. "(" .. L_LEVEL_MODE_DIF[level_manager:getCurFightDifficulty()] .. ")"))
		else
			self.titleLevel:setString(string.format(L_OFFLINE_TIME, self.msg.levelinfo))
		end

		self.titleLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6")

		self.titleLevel:setString(L_OFFLINE_TIME_DES1)

		local var_19_1 = tostring(self:getShowRole())

		self.roleIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_15")

		self.roleIcon:setScale(0.4)

		if var_19_1 then
			self.roleIcon:loadTexture("role1/" .. model_data[var_19_1].cute_role .. ".png")
		else
			self.roleIcon:setVisible(false)
		end

		self.titleSp = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_8")

		self.titleSp:setString(global_trans_bitmapnumber(self.msg.sp))

		self.titleGold = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_10")

		self.titleGold:setString(global_trans_bitmapnumber(self.msg.gold))

		self.titleItem = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_11")

		self.titleItem:setString(L_FIGHTNEW_MSG.Cache_Title .. string.format("%d/%d", playermodel.dropcacheweight.weight, playermodel.dropcacheweight.limit))

		self.titleItem = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_21")

		self.titleItem:setString(L_ADD_INSTANCE_TIMES.button)

		self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_13")

		self.surebtn:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)
	end
end

function OfflineEarningsLayer:initItems(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_3 or playermodel.dropcache

	if activity_manager:getActivityObj(BACKFLOW_BP_ID) and self.offlineDay and (not arg_22_1 and self.offlineDay < 30 or not arg_22_2 and self.offlineDay >= 30) then
		self.scrollView = ccui.ScrollView:create()

		self.scrollView:setDirection(ccui.ScrollViewDir.vertical)
		self.scrollView:setAnchorPoint(0, 0)
		self.scrollView:setContentSize(self.scrSize)
		self.rootLayer:addChild(self.scrollView)
		self.scrollView:setTouchEnabled(true)
		self.scrollView:setBounceEnabled(true)
	else
		self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_12")
	end

	self.scrollView:removeAllChildren()

	local var_22_1 = 0

	self.allSp = {}
	self.itemNum = #var_22_0

	local var_22_2 = self.scrollView:getContentSize()
	local var_22_3 = (40 + math.ceil(self.itemNum / 5) * (20 + var_0_18)) * (var_22_2.width / (10 + (var_0_17 + 20) * 5))

	if var_22_3 < var_22_2.height then
		var_22_3 = var_22_2.height
	end

	self.scrollView:setInnerContainerSize(cc.size(var_22_2.width, var_22_3))

	if activity_manager:getActivityObj(BACKFLOW_BP_ID) and self.offlineDay and (not arg_22_1 and self.offlineDay < 30 or not arg_22_2 and self.offlineDay >= 30) then
		self.scrollView:setContentSize(self.scrollView:getContentSize().width, self.scrollView:getContentSize().height + 30)
		self.scrollView:setPosition(self.bgPosX - 255, self.bgPosY - 240)
	end

	self.initposY = self.initposY or self.scrollView:getInnerContainer():getPositionY()
	self.scrollheight = var_22_3

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_4 = ItemSprite:createNewWithItemId(iter_22_1.itemid, iter_22_1.itemcount)

		var_22_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_4:setScale(var_22_2.width / (10 + (var_0_17 + 20) * 5))
		var_22_4:setName("sp" .. "_" .. iter_22_0)
		self.scrollView:addChild(var_22_4)
		var_22_4:setPosition(cc.p((var_0_17 / 2 + (var_0_17 + 20) * var_22_1) * (var_22_2.width / (10 + (var_0_17 + 20) * 5)), var_22_3 - (20 + var_0_18 / 2 + (var_0_18 + 20) * 0) * (var_22_2.width / (10 + (var_0_17 + 20) * 5))))
		var_22_4:addSpriteTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[iter_22_1.itemid].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[iter_22_1.itemid].bag_item_type == kITEM_HERO then
				return
			end
		end)
		table.insert(self.allSp, var_22_4)

		var_22_1 = var_22_1 + 1

		if var_22_1 >= 5 then
			var_22_1 = 0
		end
	end
end

function OfflineEarningsLayer.getShowRole(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(playermodel.arrays) do
		for iter_24_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_24_1["pos_" .. iter_24_2].fight_girl then
				return iter_24_1["pos_" .. iter_24_2].fight_girl
			end
		end
	end

	return nil
end

function OfflineEarningsLayer:exit()
	if self.isExitting then
		return
	end

	self.isExitting = true

	require("controller.dropcache_manager"):harvestCache(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_1 and #arg_26_1 > 0 then
			self.cangetitems = arg_26_1

			self.scrollView:getInnerContainer():setPositionY(self.initposY)

			if arg_26_2 and #arg_26_2 > 0 then
				self:playGetItemActNew(1, arg_26_2)
			else
				self:playGetItemActNew(2)
			end
		else
			if arg_26_2 and #arg_26_2 > 0 then
				global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[1])
			end

			audio_manager:playeffectMusicTest("sound/invalid")
			LayerManager:removePopLayer(self.__queueindex)
		end

		if FightLayer and FightLayer.getInstance() then
			ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
		end
	end)
end

function OfflineEarningsLayer:playGetItemActNew(arg_27_1, arg_27_2)
	audio_manager:playeffectMusic2("sound/new_shouqu1", false, nil, function(arg_28_0)
		self.aud1 = arg_28_0
	end)
	LayerManager:removePopLayer(self.__queueindex)
end

function OfflineEarningsLayer:playSortAni(arg_29_1, arg_29_2)
	if self.aud1 and not self.aud1:isFinished() then
		self.aud1:resume()
	end

	self.row = self.itemNum % 5 == 0 and self.itemNum / 5 - 1 or math.floor(self.itemNum / 5)

	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3 = {}
	local var_29_4 = {}

	if not arg_29_2 then
		var_29_4 = self.cangetitems

		self:sortByQuality(self.cangetitems)
		self:sortByQuality(arg_29_1)

		local var_29_6 = global_deepCopy(var_29_4)

		for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
			table.insert(var_29_6, iter_29_1)
		end

		var_29_3.items = var_29_6
		var_29_1 = self.itemNum

		if self.itemNum > 15 then
			var_29_1 = 15
		end

		self.count = var_29_1
	else
		var_29_1 = #arg_29_1

		if #arg_29_1 > 15 then
			var_29_1 = 15
		end

		self.count = var_29_1
		var_29_3.items = arg_29_1
		var_29_2 = self.row * (var_0_18 / 2 + 40)
		self.isend = true
	end

	self.pos_y = 0
	self.pos_y = self.scrollheight == self.scrollView:getContentSize().height and self.scrollheight / 2 - var_29_2 or self.scrollheight - self.scrollView:getContentSize().height / 2 - var_29_2

	for iter_29_2 = 1, var_29_1 do
		self.allSp[iter_29_2]:runAction(cc.Sequence:create(cc.DelayTime:create((iter_29_2 - 1) * 0.04), cc.MoveTo:create(0.1, cc.p(self.scrollView:getContentSize().width / 2, self.pos_y)), cc.CallFunc:create(function()
			if iter_29_2 == var_29_1 then
				local var_30_0 = cc.Node:create()

				self:addChild(var_30_0)
				var_30_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					self:initItems(var_29_3.items)

					self.itemNum = not arg_29_2 and #var_29_4 or #arg_29_1
				end), cc.DelayTime:create(1), cc.CallFunc:create(function()
					if not arg_29_2 then
						global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[1])
						LayerManager:removePopLayer(self.__queueindex)
					end
				end)))
			end
		end)))
	end
end

function OfflineEarningsLayer:playItemsAni(arg_33_1)
	if arg_33_1 > self.itemNum then
		LayerManager:removePopLayer(self.__queueindex)

		return
	end

	local var_33_0 = self.allSp[arg_33_1]
	local var_33_1 = armature_manager:createAndPlayArmature("cachePackGetAwardNew", nil, nil, {
		start = function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
			if arg_33_1 > 5 and arg_33_1 % 5 == 1 then
				local var_34_0 = self.scrollView:getInnerContainer()

				var_34_0:setPositionY(var_34_0:getPositionY() + var_0_18 / 2 + 40)
			end

			var_33_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0)))
			self:playItemsAni(arg_33_1 + 1)
		end,
		["end"] = function(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
			var_33_0:removeFromParent()

			if arg_33_1 == self.itemNum then
				self:playCreatImageAniNew()
			end
		end
	}, 1)

	var_33_1:setPosition(self.allSp[arg_33_1]:getPosition())
	self.scrollView:addChild(var_33_1, 1000)
end

function OfflineEarningsLayer:playCreatImageAniNew()
	local var_36_1 = self.itemNum % 5 == 1 and 2 or self.itemNum % 5 == 2 and 3 or self.itemNum % 5 == 3 and 4 or self.itemNum % 5 == 4 and 5 or 6

	if self.aud1 and not self.aud1:isFinished() then
		self.aud1:pause()
	end

	audio_manager:playeffectMusic("sound/new_shouqu2", false, nil, nil)

	local var_36_2 = armature_manager:createAndPlayArmature("cachePackGetAwardNew", nil, nil, {
		["end"] = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
			local var_37_0 = cc.Node:create()

			self:addChild(var_37_0)
			var_37_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				if self.nofalg then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[1], nil, nil, 1)
				else
					self.titleItem:setString(L_FIGHTNEW_MSG.Cache_Title .. string.format("%d/%d", playermodel.dropcacheweight.weight, playermodel.dropcacheweight.limit))
				end
			end), cc.DelayTime:create(1), cc.CallFunc:create(function()
				if self.nofalg then
					self:playSortAni(self.nogetdata, 1)
				end
			end)))
		end
	}, var_36_1)

	var_36_2:setScaleY(-1)
	var_36_2:runAction(cc.MoveTo:create(1, cc.p(220, 868 - GameDisplay.fix_y)))
	self.rootLayer:addChild(var_36_2, 1000)

	local var_36_3 = {}

	for iter_36_0 = 1, #self.allSp - self.itemNum do
		var_36_3[iter_36_0] = self.allSp[self.itemNum + iter_36_0]
	end

	self.allSp = var_36_3
end

function OfflineEarningsLayer.sortByQuality(arg_40_0, arg_40_1)
	if arg_40_1 and #arg_40_1 > 1 then
		table.sort(arg_40_1, function(arg_41_0, arg_41_1)
			if item_data[arg_41_0.itemid].equip_quality == item_data[arg_41_1.itemid].equip_quality then
				return arg_41_0.itemid < arg_41_1.itemid
			else
				return item_data[arg_41_0.itemid].equip_quality > item_data[arg_41_1.itemid].equip_quality
			end
		end)
	end
end
