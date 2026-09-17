ActivityWakefundVipBuyPopLayer = class("ActivityWakefundVipBuyPopLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 0

require("view.Sprite.ItemSprite")

local drop_manager = require("controller.drop_manager")
local task_data = require("data.task_data")
local activity_wake_fund_conf = require("data.activity_modules.activity_wake_fund_conf")
local playermodel = require("model.playermodel")
local var_0_6 = require("controller.drop_manager")
local recharge_manager = require("controller.recharge_manager")
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local recharge_data = require("data.recharge_data")

function ActivityWakefundVipBuyPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityWakefundVipBuyPopLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityWakefundVipBuyPopLayer:init(arg_3_1)
	self.initParam = arg_3_1
	self.updatecallback = arg_3_1.updatecallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, 0))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("activitiesRes/activitytemplate/wake_fund/img_pop_buy_bg.png", var_0_1)

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.updatecallback then
				self.updatecallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	self:initData()
	self:initUI()
	self:updateUI()
	self:initPurchaseEventListener()
	self:test()
end

function ActivityWakefundVipBuyPopLayer:initData(...)
	self.id = self.initParam.id
	self.tasklist = self.initParam.tasklist
	self.freelist = {}
	self.paidlist = {}

	for iter_6_0, iter_6_1 in pairs(self.tasklist) do
		local var_6_0 = var_0_6:getDropMsg(task_data[iter_6_1.taskid].drop)

		if var_6_0.diamond > 0 then
			self.freelist.diamond = self.freelist.diamond or 0
			self.freelist.diamond = self.freelist.diamond + var_6_0.diamond
		end

		if var_6_0.gold > 0 then
			self.freelist.gold = self.freelist.gold or 0
			self.freelist.gold = self.freelist.gold + var_6_0.gold
		end

		if next(var_6_0.equips) then
			self.freelist[var_6_0.equips[1].dropid] = self.freelist[var_6_0.equips[1].dropid] or 0
			self.freelist[var_6_0.equips[1].dropid] = self.freelist[var_6_0.equips[1].dropid] + var_6_0.equips[1].dropNum
		end

		if task_data[iter_6_1.taskid].free_extra_drop then
			local var_6_1 = var_0_6:getDropMsg(task_data[iter_6_1.taskid].free_extra_drop)

			if var_6_1.diamond > 0 then
				self.freelist.diamond = self.freelist.diamond or 0
				self.freelist.diamond = self.freelist.diamond + var_6_1.diamond
			end

			if var_6_1.gold > 0 then
				self.freelist.gold = self.freelist.gold or 0
				self.freelist.gold = self.freelist.gold + var_6_1.gold
			end

			if next(var_6_1.equips) then
				self.freelist[var_6_1.equips[1].dropid] = self.freelist[var_6_1.equips[1].dropid] or 0
				self.freelist[var_6_1.equips[1].dropid] = self.freelist[var_6_1.equips[1].dropid] + var_6_1.equips[1].dropNum
			end
		end

		if task_data[iter_6_1.taskid].extra_drop then
			local var_6_2 = var_0_6:getDropMsg(task_data[iter_6_1.taskid].extra_drop)

			if var_6_2.diamond > 0 then
				self.paidlist.diamond = self.paidlist.diamond or 0
				self.paidlist.diamond = self.paidlist.diamond + var_6_2.diamond
			end

			if var_6_2.gold > 0 then
				self.paidlist.gold = self.paidlist.gold or 0
				self.paidlist.gold = self.paidlist.gold + var_6_2.gold
			end

			if next(var_6_2.equips) then
				self.paidlist[var_6_2.equips[1].dropid] = self.paidlist[var_6_2.equips[1].dropid] or 0
				self.paidlist[var_6_2.equips[1].dropid] = self.paidlist[var_6_2.equips[1].dropid] + var_6_2.equips[1].dropNum
			end
		end
	end
end

function ActivityWakefundVipBuyPopLayer:initUI(...)
	local var_7_0 = ccui.ImageView:create("activitiesRes/activitytemplate/wake_fund/img_free.png", var_0_1)

	var_7_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, 480))
	self.rootpanel:addChild(var_7_0)

	local var_7_1 = ccui.ImageView:create("activitiesRes/activitytemplate/wake_fund/img_paid.png", var_0_1)

	var_7_1:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, 260))
	self.rootpanel:addChild(var_7_1)

	local var_7_2 = cc.Label:createWithTTF("通过指定关卡，可获得大量扭蛋券奖励", FONT_DES, 22)

	var_7_2:setColor(cc.c3b(161, 161, 161))
	var_7_2:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, 530))
	self.rootpanel:addChild(var_7_2)

	local var_7_3 = ccui.Button:create("public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", var_0_0)

	var_7_3:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -100))
	var_7_3:setName("btn")
	var_7_3:addTouchEventListener(self:getBuyHandel())
	self.rootpanel:addChild(var_7_3)

	local var_7_4 = cc.Label:createWithTTF("开启特殊补给", FONT_DES, 32)

	var_7_4:setColor(cc.c3b(12, 12, 12))
	var_7_4:setPosition(cc.p(var_7_3:getContentSize().width / 2, var_7_3:getContentSize().height / 2 - 5))
	var_7_4:setName("btnLabel")
	var_7_3:addChild(var_7_4)

	local var_7_5
	local var_7_6

	if activity_wake_fund_conf[self.id].rechargeid then
		var_7_5 = "public/currency/rmb_white.png"
		var_7_6 = recharge_data[activity_wake_fund_conf[self.id].rechargeid].rmb
	else
		var_7_5 = "public/currency/" .. item_data[activity_wake_fund_conf[self.id].currency].image_id .. ".png"
		var_7_6 = activity_wake_fund_conf[self.id].price
	end

	local var_7_7 = ccui.ImageView:create(var_7_5, var_0_0)

	var_7_7:setPositionY(-20)
	var_7_7:setName("currencyImg")
	var_7_3:addChild(var_7_7)

	local var_7_8 = cc.Label:createWithTTF(var_7_6, FONT_DES, 24)

	var_7_8:setPositionY(-20)
	var_7_8:setName("currencyLabel")
	var_7_3:addChild(var_7_8)
	var_7_7:setPositionX(var_7_3:getContentSize().width / 2 - var_7_8:getContentSize().width / 2 - 40)
	var_7_8:setPositionX(var_7_3:getContentSize().width / 2 + var_7_7:getContentSize().width / 2 - 40)

	local var_7_9 = ccui.ImageView:create(var_7_5, var_0_0)

	var_7_9:setPositionY(-20)
	var_7_9:setName("currencyImg2")
	var_7_3:addChild(var_7_9)

	local var_7_10 = cc.Label:createWithTTF(98, FONT_DES, 24)

	var_7_10:setPositionY(-20)
	var_7_10:setName("currencyLabel2")
	var_7_3:addChild(var_7_10)
	var_7_9:setPositionX(var_7_3:getContentSize().width / 2 - var_7_10:getContentSize().width / 2 + 40)
	var_7_10:setPositionX(var_7_3:getContentSize().width / 2 + var_7_9:getContentSize().width / 2 + 40)

	local var_7_11 = ccui.ImageView:create("activitiesRes/activitytemplate/wake_fund/line.png")

	var_7_11:setPositionY(-20)
	var_7_11:setName("line")
	var_7_3:addChild(var_7_11)
	var_7_11:setPositionX(var_7_3:getContentSize().width / 2 + var_7_10:getContentSize().width / 2 + 30)

	local var_7_12 = 0

	for iter_7_0, iter_7_1 in pairs(self.freelist) do
		var_7_12 = var_7_12 + 1
	end

	local var_7_13 = 0

	for iter_7_2, iter_7_3 in pairs(self.freelist) do
		var_7_13 = var_7_13 + 1

		local var_7_14 = ItemSmallSprite:createSmallItem()

		var_7_14:setInfoTouchEvent(true)
		var_7_14:updateSmallItemByItemid(iter_7_2, iter_7_3)
		var_7_14:setScale(0.7)
		var_7_14:setPosition(cc.p((var_7_13 * 2 - 1) / (var_7_12 * 2) * (self.rootpanel:getContentSize().width - 160) + 80, 360))
		self.rootpanel:addChild(var_7_14)
	end

	local var_7_15 = 0

	for iter_7_4, iter_7_5 in pairs(self.paidlist) do
		var_7_15 = var_7_15 + 1
	end

	local var_7_16 = 0

	for iter_7_6, iter_7_7 in pairs(self.paidlist) do
		var_7_16 = var_7_16 + 1

		local var_7_17 = ItemSmallSprite:createSmallItem()

		var_7_17:setScale(0.7)
		var_7_17:setInfoTouchEvent(true)
		var_7_17:updateSmallItemByItemid(iter_7_6, iter_7_7)
		var_7_17:setPosition(cc.p((var_7_16 * 2 - 1) / (var_7_15 * 2) * (self.rootpanel:getContentSize().width - 160) + 80, 130))
		self.rootpanel:addChild(var_7_17)
	end
end

function ActivityWakefundVipBuyPopLayer:updateUI()
	if item_manager:getItemNumber(activity_wake_fund_conf[self.id].extra_drop_vip) > 0 then
		local var_8_0 = self.rootpanel:getChildByName("btn")

		var_8_0:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
		var_8_0:getChildByName("btnLabel"):setString("已购买")
		var_8_0:getChildByName("currencyImg"):setVisible(false)
		var_8_0:getChildByName("currencyLabel"):setVisible(false)
	else
		local var_8_1 = self.rootpanel:getChildByName("btn")

		var_8_1:loadTextures("public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", var_0_0)
		var_8_1:getChildByName("btnLabel"):setString("开启特殊补给")
		var_8_1:getChildByName("currencyImg"):setVisible(true)
		var_8_1:getChildByName("currencyLabel"):setVisible(true)
	end
end

function ActivityWakefundVipBuyPopLayer.getBuyHandel(arg_9_0, ...)
	return function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_9_0.recharging then
			return
		end

		arg_9_0.recharging = true

		if item_manager:getItemNumber(activity_wake_fund_conf[arg_9_0.id].extra_drop_vip) > 0 then
			global_ShowBlockWords("无法重复购买！！！")

			arg_9_0.recharging = false

			return
		end

		if activity_wake_fund_conf[arg_9_0.id].rechargeid then
			arg_9_0.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function(...)
				arg_9_0.recharging = false
			end)))
			AnalyticManager.clickPurchaseItem({
				product = activity_wake_fund_conf[arg_9_0.id].rechargeid,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(activity_wake_fund_conf[arg_9_0.id].rechargeid)
		else
			activity_manager:buyWakeFundVip(arg_9_0.id, function(arg_12_0)
				arg_9_0:updateUI()

				arg_9_0.recharging = false

				if arg_9_0.updatecallback then
					arg_9_0.updatecallback()
				end

				arg_9_0.hideActions.shrinkVertical(arg_9_0, function()
					if arg_9_0.updatecallback then
						arg_9_0.updatecallback(0)
					end

					LayerManager:removePopLayer(arg_9_0.__queueindex)
				end)
			end)
		end
	end
end

function ActivityWakefundVipBuyPopLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_15_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_16_0)
		if not arg_16_0 or not arg_16_0.id then
			return
		end

		self.recharging = false

		self:updateUI()
		self.hideActions.shrinkVertical(self, function()
			if self.updatecallback then
				self.updatecallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)

		if self.updatecallback then
			self.updatecallback()
		end
	end), self)
end

function ActivityWakefundVipBuyPopLayer.test(arg_18_0)
	if not config._DEBUG then
		return
	end

	for iter_18_0, iter_18_1 in pairs(recharge_data) do
		if iter_18_1.iosid and iter_18_1.iosid ~= "jieri01" and iter_18_1.iosid ~= "jieri02" and (tonumber(string.match(iter_18_1.iosid, "[0-9]+")) < 14 or tonumber(string.match(iter_18_1.iosid, "[0-9]+")) > 23) then
			if string.find(iter_18_1.iosid, "[a-z]") then
				global_ShowBlockWords("充值表的iosid必须为纯数字字符串\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)
				print("充值表的iosid必须为数字请联系对应负责人赶快改掉")

				return
			end

			if iter_18_1.id ~= tonumber(string.match(iter_18_1.productid, "[0-9]+")) or iter_18_1.id ~= tonumber(iter_18_1.iosid) then
				print("充值表的id、iosid、productid数字必须要对应！请联系对应负责人赶快改掉")
				global_ShowBlockWords("充值表的" .. iter_18_1.id .. " id、iosid、productid数字必须要对应！\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)

				return
			end
		end
	end
end

return ActivityWakefundVipBuyPopLayer
