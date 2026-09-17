PopBuyRechargeLayer = class("PopBuyRechargeLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")
require("view.Sprite.RechargeSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local mail_data = require("data.mail_data")
local choosegift_data = require("data.choosegift_data")
local var_0_8 = 12000001
local var_0_9 = 12000003
local var_0_10 = 12000004
local var_0_11 = 12000005
local var_0_12 = {
	12000006,
	12000007,
	12000008
}
local var_0_13 = {
	diamond_month_card = 108,
	back_player = 106,
	newbee_card = 16,
	diamond_year_card = 110,
	returnback_card = 17,
	gold_card = 18,
	horcrux_card = 20,
	diamond_quarter_card = 109,
	gold_quarter_card = 19
}
local var_0_14 = {
	returnback_card = 20002,
	newbee_card = 20001,
	gold_quarter_card = 30004,
	quartercard = 90,
	month_card = 1,
	yearcard = 365,
	diamond_quarter_card = 88002,
	diamond_year_card = 88003,
	gold_card = 20003,
	horcrux_card = 20004,
	diamond_month_card = 88001,
	forevercard = 9
}

function PopBuyRechargeLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = PopBuyRechargeLayer.new()

	var_2_0:initBg(arg_2_1, arg_2_2)

	return var_2_0
end

function PopBuyRechargeLayer:init(arg_3_1, arg_3_2)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.dataList = {}
	self.initParam = arg_3_1
	self.id = self.initParam.id
	self.rechargeInfo = arg_3_2
	self.result = arg_3_1.result
	self.rootpanel = ccui.ImageView:create("mainScenebg/recharge/" .. self.id .. ".png")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 150 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)

	function self.rootpanel.afterLoadSuccess()
		self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2)
		self.tableviewBg:setPositionX(self.rootpanel:getContentSize().width / 2)

		if self.rechargeInfo.type == 1 then
			self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 20)
		elseif self.rechargeInfo.type == 9 then
			self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 54)
		end

		self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.tableviewBg:getPositionY() - self.tableviewBg:getContentSize().height / 2 - 50))
	end

	self.tableviewBg = ccui.ImageView:create("PopBuyRechargeLayer/bg.png", var_0_0)

	self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2)
	self.tableviewBg:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.rootpanel:addChild(self.tableviewBg)
	self.tableviewBg:setTouchEnabled(true)

	if self.rechargeInfo.type == 1 then
		self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 20)
	elseif self.rechargeInfo.type == 9 then
		self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 54)
	end

	if self.rechargeInfo.type == 21 then
		local var_3_0 = ccui.ImageView:create("SupermarketLayer/img_clock.png", var_0_0)

		var_3_0:setPosition(35, 162)
		self.rootpanel:addChild(var_3_0)

		local var_3_1 = ccui.Text:create("", "fonts/W5.ttf", 16)

		var_3_1:setName("labelRemainTime")
		var_3_1:setPosition(50, 162)
		var_3_1:setAnchorPoint(0, 0.5)
		var_3_1:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
		var_3_1:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		self.rootpanel:addChild(var_3_1)

		local Utility = require("common.Utility")
		local var_3_3 = math.max(0, global_get_time_by_date(self.rechargeInfo.finishtime) - require("controller.time_check_manager"):getCurTime())

		var_3_1:setString("剩余时间: " .. Utility:formatTimeStr(var_3_3))
		var_3_1:stopAllActions()
		var_3_1:runAction((Utility:createClockTimerAction(var_3_1, 1, var_3_3, function(arg_5_0)
			var_3_1:setString("剩余时间: " .. Utility:formatTimeStr(arg_5_0))
		end)))
	end

	if self.rechargeInfo.type == 9 then
		local var_3_4 = RechargeSprite:create(6)

		var_3_4:update(arg_3_2)
		var_3_4:setPositionX(self.rootpanel:getContentSize().width / 2)
		var_3_4:setPositionY(self.rootpanel:getContentSize().height / 2)
		ccui.Helper:seekWidgetByName(var_3_4, "Button_22"):setVisible(false)
		self.rootpanel:addChild(var_3_4)
	elseif self.rechargeInfo.id == 1 or self.rechargeInfo.id == 90 or self.rechargeInfo.id == 365 or self.rechargeInfo.id == var_0_14.newbee_card or self.rechargeInfo.id == var_0_14.returnback_card or self.rechargeInfo.id == var_0_14.gold_card or self.rechargeInfo.id == var_0_14.gold_quarter_card or self.rechargeInfo.id == var_0_14.horcrux_card then
		local var_3_5 = RechargeSprite:create(2)

		var_3_5:update(arg_3_2)
		var_3_5:setPositionX(self.rootpanel:getContentSize().width / 2)
		var_3_5:setPositionY(self.rootpanel:getContentSize().height / 2 - 20)

		if var_3_5.hideReddot then
			var_3_5:hideReddot()
		end

		self.rootpanel:addChild(var_3_5)
	elseif self.rechargeInfo.id == var_0_14.diamond_month_card or self.rechargeInfo.id == var_0_14.diamond_quarter_card or self.rechargeInfo.id == var_0_14.diamond_year_card then
		local var_3_6 = RechargeSprite:create(5)

		var_3_6:update(arg_3_2, true)
		var_3_6:setPositionX(self.rootpanel:getContentSize().width / 2)
		var_3_6:setPositionY(self.rootpanel:getContentSize().height / 2 - 20)

		if var_3_6.hideReddot then
			var_3_6:hideReddot()
		end

		self.rootpanel:addChild(var_3_6)
	end

	self.title = ccui.ImageView:create("PopBuyRechargeLayer/des.png", var_0_0)

	self.title:setPositionX(86)
	self.title:setPositionY(230)
	self.tableviewBg:addChild(self.title)
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		arg_6_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)

			if arg_3_1 and arg_3_1.exitcallback then
				arg_3_1.exitcallback()
			end
		end)
	end, 0)
	self:initData()
	self:initUI()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback(self.consume)
		end
	end)
end

function PopBuyRechargeLayer:initData()
	if self.initParam.dropitem and next(self.initParam.dropitem) then
		for iter_9_0, iter_9_1 in pairs(self.initParam.dropitem) do
			if iter_9_1.dropid == CURRENCY_DIAMOND_PAID then
				table.insert(self.dataList, {
					itemid = iter_9_1.dropid,
					num = iter_9_1.dropNum
				})
			end
		end
	end

	if self.initParam.gold and self.initParam.gold > 0 then
		table.insert(self.dataList, {
			itemid = "gold",
			num = self.initParam.gold
		})
	end

	if self.initParam.honor and self.initParam.honor > 0 then
		table.insert(self.dataList, {
			itemid = "honor",
			num = self.initParam.honor
		})
	end

	if self.initParam.strengthpoint and self.initParam.strengthpoint > 0 then
		table.insert(self.dataList, {
			itemid = "strengthpoint",
			num = self.initParam.strengthpoint
		})
	end

	if self.initParam.diamond and self.initParam.diamond > 0 then
		table.insert(self.dataList, {
			itemid = "diamond",
			num = self.initParam.diamond
		})
	end

	if self.initParam.dropitem and next(self.initParam.dropitem) then
		table.sort(self.initParam.dropitem, function(arg_10_0, arg_10_1)
			return item_data[arg_10_0.dropid].equip_quality > item_data[arg_10_1.dropid].equip_quality
		end)

		for iter_9_2, iter_9_3 in pairs(self.initParam.dropitem) do
			if iter_9_3.dropid ~= CURRENCY_DIAMOND_PAID then
				table.insert(self.dataList, {
					itemid = iter_9_3.dropid,
					num = iter_9_3.dropNum
				})
			end
		end
	end

	for iter_9_4, iter_9_5 in pairs(self.dataList) do
		if type(iter_9_5.itemid) == "number" and item_data[iter_9_5.itemid].bag_item_type == kITEM_SKIN and item_data[iter_9_5.itemid].model then
			self:createShowgirlBtn(iter_9_5.itemid)

			break
		end
	end
end

function PopBuyRechargeLayer:initUI()
	self.getAwardBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -50))
	self.rootpanel:addChild(self.getAwardBtn)
	self.getAwardBtn:addTouchEventListener(self:getSureHanel())

	local var_11_0 = ""

	var_11_0 = (self.rechargeInfo.type == 9 or self.rechargeInfo.type == 11 or self.rechargeInfo.type == 8) and L_BUTTON_TEXT.UnGet or L_BUTTON_TEXT.Buy

	if recharge_data[self.rechargeInfo.id].dropid_ext then
		if self.rechargeInfo.buy_limit and self.rechargeInfo.buy_limit == self.rechargeInfo.have_bought and self.rechargeInfo.buy_limit == self.rechargeInfo.have_bought_ext then
			var_11_0 = L_BUTTON_TEXT.Got

			self.getAwardBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
		end

		if self.rechargeInfo.buy_limit and self.rechargeInfo.buy_limit == self.rechargeInfo.have_bought and self.rechargeInfo.buy_limit > self.rechargeInfo.have_bought_ext then
			var_11_0 = L_BUTTON_TEXT.continue_got
		end
	elseif self.rechargeInfo.buy_limit and self.rechargeInfo.buy_limit == self.rechargeInfo.have_bought then
		if self.rechargeInfo.type == 9 or self.rechargeInfo.type == 11 or self.rechargeInfo.type == 8 then
			var_11_0 = L_BUTTON_TEXT.Got

			self.getAwardBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
		else
			var_11_0 = L_BUTTON_TEXT.Bought
		end
	end

	self.getAwardLabel = cc.Label:createWithTTF(var_11_0, FONT_BUTTON, 32)

	self.getAwardLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.getAwardLabel:setColor(cc.c3b(12, 12, 12))
	self.getAwardLabel:setPosition(cc.p(self.getAwardBtn:getContentSize().width / 2, self.getAwardBtn:getContentSize().height / 2 - 5))
	self.getAwardBtn:addChild(self.getAwardLabel)

	local var_11_1
	local var_11_2 = ""

	if self.rechargeInfo.rmb then
		var_11_1 = "public/currency/rmb_white.png"
		var_11_2 = self.rechargeInfo.rmb or var_11_2
	elseif self.rechargeInfo.price_diamond then
		var_11_1 = "public/currency/UI_battleEnd_diamond.png"
		var_11_2 = self.rechargeInfo.price_diamond or var_11_2
	else
		var_11_1 = "public/currency/6800601.png"
		var_11_2 = self.rechargeInfo.price_card or var_11_2
	end

	self.costIcon = ccui.ImageView:create(var_11_1, var_0_0)

	self.costIcon:setPositionX(self.getAwardBtn:getContentSize().width / 2 - 30)
	self.costIcon:setPositionY(-10)
	self.getAwardBtn:addChild(self.costIcon)

	self.costLabel = cc.Label:createWithTTF(var_11_2, FONT_BUTTON, 24)

	self.costLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costLabel:setColor(cc.c3b(239, 204, 255))
	self.costLabel:setPositionX(self.costIcon:getPositionX() + self.costIcon:getContentSize().width / 2 + 5)
	self.costLabel:setPositionY(self.costIcon:getPositionY())
	self.getAwardBtn:addChild(self.costLabel)
	self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.tableviewBg:getPositionY() - self.tableviewBg:getContentSize().height / 2 - 50))

	if self.rechargeInfo.type == 2 or self.rechargeInfo.type == 6 or self.rechargeInfo.type == 7 or self.rechargeInfo.type == 15 or self.rechargeInfo.type == var_0_13.diamond_month_card or self.rechargeInfo.type == var_0_13.diamond_quarter_card or self.rechargeInfo.type == var_0_13.diamond_year_card then
		self.cardCostLabel:setVisible(false)
		self:createCard()
	elseif self.rechargeInfo.type == var_0_13.newbee_card or self.rechargeInfo.type == var_0_13.returnback_card or self.rechargeInfo.type == var_0_13.gold_card or self.rechargeInfo.type == var_0_13.gold_quarter_card or self.rechargeInfo.type == var_0_13.horcrux_card then
		self:createDailyCard()
	else
		self:createTableView()
	end

	if self.rechargeInfo.type == 9 then
		self.costIcon:setVisible(false)
		self.costLabel:setVisible(false)
		self.costLabel:setString(L_BUTTON_TEXT.UnGet)
	end

	if self.rechargeInfo.type == 11 or self.rechargeInfo.type == 8 then
		self.costIcon:setVisible(false)
		self.costLabel:setVisible(false)
	end

	if self.isChoosegift then
		self.title:setVisible(false)

		local var_11_3 = cc.Label:createWithTTF(L_CHOOSE_RECHARGE_DES, FONT_DES, 22)

		var_11_3:setColor(cc.c3b(255, 158, 64))
		var_11_3:setAnchorPoint(cc.p(0, 0.5))
		var_11_3:setPosition(cc.p(20, 230))
		self.tableviewBg:addChild(var_11_3)
	end
end

function PopBuyRechargeLayer:createShowgirlBtn(arg_12_1)
	local var_12_0 = ccui.Button:create("PopBuyRechargeLayer/skin_btn.png", "PopBuyRechargeLayer/skin_btn.png", "PopBuyRechargeLayer/skin_btn.png", var_0_0)

	var_12_0:setPosition(cc.p(510, -86))
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
			itemid = arg_12_1
		})
	end)
	self.rootpanel:addChild(var_12_0)
end

function PopBuyRechargeLayer:createCard()
	self.tableviewBg:setScale9Enabled(true)
	self.tableviewBg:setCapInsets(cc.rect(100, 100, 100, 100))
	self.tableviewBg:setContentSize(cc.size(594, 363))
	self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 40)

	for iter_14_0, iter_14_1 in pairs(self.dataList) do
		local var_14_0 = self:createSp()

		var_14_0:setPositionX(84 + (iter_14_0 - 1) * 130)
		var_14_0:setPositionY(100)
		var_14_0:update(iter_14_1)
		var_14_0:setScale(0.65)
		self.tableviewBg:addChild(var_14_0)
	end

	local var_14_1 = var_0_8

	if self.rechargeInfo.type == 2 then
		var_14_1 = var_0_8
	elseif self.rechargeInfo.type == 6 then
		var_14_1 = var_0_9
	elseif self.rechargeInfo.type == 7 then
		var_14_1 = var_0_10
	elseif self.rechargeInfo.type == 15 then
		var_14_1 = var_0_11
	elseif self.rechargeInfo.type == 108 then
		var_14_1 = var_0_8
	elseif self.rechargeInfo.type == 109 then
		var_14_1 = var_0_9
	elseif self.rechargeInfo.type == 110 then
		var_14_1 = var_0_11
	elseif self.rechargeInfo.type == 106 then
		var_14_1 = var_0_12[require("controller.supermarket_limited_time_package_manager"):getInstance():getCurCanBuyIndex()]
	end

	local var_14_2 = cc.Label:createWithTTF("    " .. recharge_data[self.rechargeInfo.id].des, FONT_BUTTON, 24)

	var_14_2:setAnchorPoint(cc.p(0, 1))
	var_14_2:setMaxLineWidth(500)
	var_14_2:setLineBreakWithoutSpace(true)
	var_14_2:setPositionX(42)
	var_14_2:setPositionY(320)
	var_14_2:setColor(cc.c3b(239, 204, 255))
	self.tableviewBg:addChild(var_14_2)
	self.title:setPositionY(200)
	self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.tableviewBg:getPositionY() - self.tableviewBg:getContentSize().height / 2 - 70))
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 170 - GameDisplay.fix_y)

	local var_14_3 = ccui.ImageView:create("PopBuyRechargeLayer/des_daily.png", var_0_0)

	var_14_3:setAnchorPoint(cc.p(0, 0.5))
	var_14_3:setPositionX(280)
	var_14_3:setPositionY(self.title:getPositionY())
	self.tableviewBg:addChild(var_14_3)

	if #self.dataList >= 3 then
		var_14_3:setPositionX(410)
	end

	local var_14_4 = drop_manager:getNormalDrops(mail_data[var_14_1] and mail_data[var_14_1].dropid)
	local var_14_5 = {}

	if var_14_4.diamond and var_14_4.diamond > 0 then
		table.insert(var_14_5, {
			itemid = "diamond",
			num = var_14_4.diamond
		})
	end

	for iter_14_2, iter_14_3 in pairs(var_14_4.equips) do
		table.insert(var_14_5, {
			itemid = iter_14_3.dropid,
			num = iter_14_3.dropNum
		})
	end

	if var_14_4.gold and var_14_4.gold > 0 then
		table.insert(var_14_5, {
			itemid = "gold",
			num = var_14_4.gold
		})
	end

	for iter_14_4, iter_14_5 in pairs(var_14_5) do
		local var_14_6 = 340

		if #self.dataList >= 3 then
			var_14_6 = var_14_6 + 130
		end

		local var_14_7 = self:createSp()

		var_14_7:setPositionX(var_14_6 + (iter_14_4 - 1) * 130)
		var_14_7:setPositionY(100)
		var_14_7:update(iter_14_5)
		var_14_7:setScale(0.65)
		self.tableviewBg:addChild(var_14_7)
	end
end

function PopBuyRechargeLayer:createDailyCard()
	self.tableviewBg:setScale9Enabled(true)
	self.tableviewBg:setCapInsets(cc.rect(100, 100, 100, 100))
	self.tableviewBg:setContentSize(cc.size(594, 363))
	self.tableviewBg:setPositionY(-self.rootpanel:getContentSize().height / 2 - 40)

	local var_15_0 = ccui.ImageView:create("PopBuyRechargeLayer/des_daily.png", var_0_0)

	var_15_0:setAnchorPoint(cc.p(0, 0.5))
	var_15_0:setPositionX(280)
	var_15_0:setPositionY(200)
	self.tableviewBg:addChild(var_15_0)

	if self.rechargeInfo.type == var_0_13.newbee_card or self.rechargeInfo.type == var_0_13.returnback_card then
		self.title:setVisible(false)
		var_15_0:setPositionX(86)

		for iter_15_0, iter_15_1 in pairs(self.dataList) do
			local var_15_1 = self:createSp()

			var_15_1:setPositionX(140 + (iter_15_0 - 1) * 130)
			var_15_1:setPositionY(100)
			var_15_1:update(iter_15_1)
			var_15_1:setScale(0.65)
			self.tableviewBg:addChild(var_15_1)
		end
	elseif self.rechargeInfo.type == var_0_13.gold_card or self.rechargeInfo.type == var_0_13.gold_quarter_card or self.rechargeInfo.type == var_0_13.horcrux_card then
		for iter_15_2, iter_15_3 in pairs(self.dataList) do
			local var_15_2 = self:createSp()

			var_15_2:setPositionX(340 + (iter_15_2 - 1) * 130)
			var_15_2:setPositionY(100)
			var_15_2:update(iter_15_3)
			var_15_2:setScale(0.65)
			self.tableviewBg:addChild(var_15_2)
		end

		local var_15_3 = drop_manager:getNormalDrops(recharge_data[self.rechargeInfo.id].first_dropid)
		local var_15_4 = {}

		if var_15_3.diamond and var_15_3.diamond > 0 then
			table.insert(var_15_4, {
				itemid = "diamond",
				num = var_15_3.diamond
			})
		end

		for iter_15_4, iter_15_5 in pairs(var_15_3.equips) do
			table.insert(var_15_4, {
				itemid = iter_15_5.dropid,
				num = iter_15_5.dropNum
			})
		end

		if var_15_3.gold and var_15_3.gold > 0 then
			table.insert(var_15_4, {
				itemid = "gold",
				num = var_15_3.gold
			})
		end

		for iter_15_6, iter_15_7 in pairs(var_15_4) do
			local var_15_5 = self:createSp()

			var_15_5:setPositionX(84 + (iter_15_6 - 1) * 130)
			var_15_5:setPositionY(100)
			var_15_5:update(iter_15_7)
			var_15_5:setScale(0.65)
			self.tableviewBg:addChild(var_15_5)
		end

		self.title:setPositionX(86)
	end

	local var_15_6 = cc.Label:createWithTTF("    " .. recharge_data[self.rechargeInfo.id].des, FONT_BUTTON, 24)

	var_15_6:setAnchorPoint(cc.p(0, 1))
	var_15_6:setMaxLineWidth(500)
	var_15_6:setLineBreakWithoutSpace(true)
	var_15_6:setPositionX(42)
	var_15_6:setPositionY(320)
	var_15_6:setColor(cc.c3b(239, 204, 255))
	self.tableviewBg:addChild(var_15_6)
	self.title:setPositionY(200)
	self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.tableviewBg:getPositionY() - self.tableviewBg:getContentSize().height / 2 - 70))
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 170 - GameDisplay.fix_y)
end

local var_0_15 = 560
local var_0_16 = 186
local var_0_17 = 10
local var_0_18 = 20
local var_0_19 = 145
local var_0_20 = 160
local var_0_21 = {
	cc.p(80, 70),
	cc.p(217, 70),
	cc.p(354, 70),
	(cc.p(491, 70))
}
local var_0_22 = 4
local var_0_23 = 0.65

function PopBuyRechargeLayer:createTableView()
	self.listPanel = cc.TableView:create(cc.size(var_0_15, var_0_16))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_17, var_0_18))
	self.listPanel:setDelegate()
	self.tableviewBg:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_17_0, arg_17_1)
		return var_0_19, var_0_20
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.listPanel:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell()

		if not var_18_0 then
			var_18_0 = cc.TableViewCell:create()

			for iter_18_0 = 1, var_0_22 do
				local var_18_1 = self:createSp()

				var_18_1:setScale(var_0_23)
				var_18_1:setName("sp_" .. iter_18_0)
				var_18_1:setPosition(var_0_21[iter_18_0])
				var_18_0:addChild(var_18_1)
			end
		end

		for iter_18_1 = 1, var_0_22 do
			local var_18_2 = var_18_0:getChildByName("sp_" .. iter_18_1)

			if self.dataList[arg_18_1 * var_0_22 + iter_18_1] then
				var_18_2:setVisible(true)
				var_18_2:update(self.dataList[arg_18_1 * var_0_22 + iter_18_1])
			else
				var_18_2:setVisible(false)
			end
		end

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_19_0, arg_19_1)
		return math.ceil(#self.dataList / var_0_22)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
	self.listPanel:updateCellAtIndex(0)

	self.curIndex = 0
end

function PopBuyRechargeLayer.createSp(arg_20_0)
	local var_20_0 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

	var_20_0:setSwallowTouches(false)

	function var_20_0:update(arg_21_1)
		var_20_0.itemid = arg_21_1.itemid
		var_20_0.num = arg_21_1.num
		var_20_0.item_attr = arg_21_1.item_attr

		if self:getChildByName("itemSp") then
			self:getChildByName("itemSp"):removeFromParent()
		end

		local var_21_0 = ItemSprite:createNewWithItemId(var_20_0.itemid, var_20_0.num, nil, nil, var_20_0.item_attr)

		var_21_0:setName("itemSp")
		var_21_0:setAnchorPoint(cc.p(0, 0))
		self:addChild(var_21_0)
	end

	var_20_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_22_0.itemid == CURRENCY_DIAMOND_PAID or arg_22_0.itemid == "diamond" then
			return
		end

		PopLayer:Item({
			hideGainButton = true,
			itemid = arg_22_0.itemid,
			item_attr = arg_22_0.item_attr
		})
	end)

	return var_20_0
end

function PopBuyRechargeLayer.getSureHanel(arg_23_0)
	return function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if recharge_data[arg_23_0.rechargeInfo.id].dropid_ext then
			if arg_23_0.rechargeInfo.buy_limit and arg_23_0.rechargeInfo.buy_limit == arg_23_0.rechargeInfo.have_bought_ext then
				global_ShowBlockWords(L_BUTTON_TEXT.Got)

				return
			end
		elseif arg_23_0.rechargeInfo.buy_limit and arg_23_0.rechargeInfo.buy_limit == arg_23_0.rechargeInfo.have_bought then
			if arg_23_0.rechargeInfo.type == 9 then
				global_ShowBlockWords(L_BUTTON_TEXT.Got)
			else
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			end

			return
		end

		if recharge_data[arg_23_0.rechargeInfo.id].need_total_recharge and playermodel.rechargeamount < recharge_data[arg_23_0.rechargeInfo.id].need_total_recharge then
			global_ShowBlockWords("累计充值金额不足")

			return
		end

		if not arg_24_0:isBright() then
			return
		end

		arg_24_0:setBright(false)

		if arg_23_0.initParam.sureCallback then
			arg_23_0.initParam.sureCallback(function(arg_25_0)
				if arg_25_0.result == 1 then
					arg_23_0:exit()
				end

				arg_24_0:setBright(true)
			end)
		end
	end
end

function PopBuyRechargeLayer:initBg(arg_26_1, arg_26_2)
	local var_26_0 = ccui.Layout:create()

	var_26_0:setTouchEnabled(true)
	var_26_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_26_0:setAnchorPoint(cc.p(0, 0))
	var_26_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_26_0:setOpacity(0)
	self:addChild(var_26_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_27_0)
		self:addChild(arg_27_0, -2)
		arg_27_0:setPositionY(arg_27_0:getPositionY() - GameDisplay.fix_y)

		local var_27_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_27_0:setAnchorPoint(cc.p(0, 0))
		var_27_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_27_0, -1)
		self:init(arg_26_1, arg_26_2)
		var_26_0:setOpacity(102)
		var_26_0:setTouchEnabled(false)
	end)
end

function PopBuyRechargeLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
