RechargeLayer = class("RechargeLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local network = require("network.network")
local recharge_manager = require("controller.recharge_manager")
local alert_manager = require("controller.alert_manager")
local item_manager = require("controller.item_manager")
local shop_manager = require("controller.shop_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local shop_data = require("data.shop_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.RechargeSprite")

local var_0_11 = config._DEBUG and 0 or 1
local var_0_12

local function var_0_13(arg_2_0, arg_2_1)
	network:rpc("check_recharge", {
		id = arg_2_0,
		client = config.clientmode
	}, function(arg_3_0)
		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

local function var_0_14(arg_4_0, arg_4_1)
	network:rpc("get_recharge_items_drop", {
		id = arg_4_0
	}, function(arg_5_0)
		if arg_4_1 then
			arg_4_1(arg_5_0)
		end
	end)
end

local function var_0_15(arg_6_0, arg_6_1)
	network:rpc("recharge_from_diamond", {
		id = arg_6_0
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			for iter_7_0, iter_7_1 in pairs(arg_7_0.cost_items) do
				item_manager:deleteItem(iter_7_1.entityid, iter_7_1.num)
			end

			if arg_7_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_7_0.cost_diamond
			end

			global_gain({
				items = arg_7_0.items,
				diamond = arg_7_0.diamond,
				gold = arg_7_0.gold,
				sp = arg_7_0.sp
			})
		elseif arg_7_0.result == 2 then
			print("recharge is not price_diamond")
		elseif arg_7_0.result == 3 then
			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		elseif arg_7_0.result == 4 then
			print(L_SUPERMARKET_TIME_LIMIT)
		elseif arg_7_0.result == 5 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_7_0.result == 6 then
			global_ShowBlockWords(L_DIAMOND_LACK)
		end

		if arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

local function var_0_16(arg_8_0, arg_8_1)
	network:rpc("get_totalrecharge_award", {
		id = arg_8_0
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			global_gain({
				items = arg_9_0.items,
				diamond = arg_9_0.diamond,
				gold = arg_9_0.gold,
				sp = arg_9_0.sp
			})
		elseif arg_9_0.result == 2 then
			print(L_LAB_RECIPE_WARNING[3])
		elseif arg_9_0.result == 3 then
			print(L_SUPERMARKET_TIME_LIMIT_3)
		elseif arg_9_0.result == 4 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_9_0.result == 5 then
			print(L_SUPERMARKET_TIME_LIMIT_2)
		end

		if arg_8_1 then
			arg_8_1(arg_9_0)
		end
	end)
end

local function var_0_17(arg_10_0, arg_10_1)
	network:rpc("get_free_award", {
		id = arg_10_0
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			global_gain({
				items = arg_11_0.items,
				diamond = arg_11_0.diamond,
				gold = arg_11_0.gold,
				sp = arg_11_0.sp
			})
		elseif arg_11_0.result == 2 then
			print(L_LAB_RECIPE_WARNING[3])
		elseif arg_11_0.result == 3 then
			print(L_SUPERMARKET_TIME_LIMIT_3)
		elseif arg_11_0.result == 4 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_11_0.result == 5 then
			print(L_SUPERMARKET_TIME_LIMIT_2)
		end

		if arg_10_1 then
			arg_10_1(arg_11_0)
		end
	end)
end

function RechargeLayer.recharge_from_card(arg_12_0, arg_12_1, arg_12_2)
	network:rpc("recharge_from_card", {
		id = arg_12_1
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			for iter_13_0, iter_13_1 in pairs(arg_13_0.cost_items) do
				item_manager:deleteItem(iter_13_1.entityid, iter_13_1.num)
			end

			global_gain({
				items = arg_13_0.items,
				diamond = arg_13_0.diamond,
				gold = arg_13_0.gold,
				sp = arg_13_0.sp
			})
		elseif arg_13_0.result == 2 then
			print("recharge is not price_card")
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords(L_RECHARGE_GRADE_LIMIT)
		elseif arg_13_0.result == 4 then
			print(L_SUPERMARKET_TIME_LIMIT)
		elseif arg_13_0.result == 5 then
			print(L_RECHARGE_BUY_LIMIT)
		elseif arg_13_0.result == 6 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[5])

			arg_12_0.curSelectType = 15

			LayerManager:removePopLayer()
			arg_12_0:filterBtnTouchEvent()
		end

		if arg_12_2 then
			arg_12_2(arg_13_0)
		end
	end)
end

local var_0_18 = {
	{
		order = 8
	},
	{
		order = 2
	},
	{
		order = 4
	},
	{
		order = 5
	},
	{
		order = 7
	},
	{
		order = 6
	},
	[11] = {
		order = 9
	},
	[14] = {
		order = 1
	},
	[15] = {
		order = 3
	},
	{
		order = 20
	}
}

setmetatable(var_0_18, {
	__index = function(arg_14_0, arg_14_1)
		return {
			order = 0
		}
	end
})

local var_0_19 = {
	[10] = 10
}
local var_0_20 = {
	[9] = 556
}
local var_0_21 = {
	[9] = 780
}

setmetatable(var_0_20, {
	__index = function(arg_15_0, arg_15_1)
		return 556
	end
})
setmetatable(var_0_21, {
	__index = function(arg_16_0, arg_16_1)
		return 980
	end
})

local var_0_22 = 0
local var_0_23 = 0
local var_0_24 = {
	556,
	556,
	556,
	556,
	nil,
	nil,
	nil,
	nil,
	nil,
	556
}
local var_0_25 = {
	238,
	340,
	340,
	172,
	nil,
	nil,
	nil,
	nil,
	nil,
	660
}
local var_0_26 = {}

setmetatable(var_0_26, {
	__index = function(arg_17_0, arg_17_1)
		return cc.p(var_0_24[arg_17_1] / 2, var_0_25[arg_17_1] / 2)
	end
})

local var_0_28 = 8
local var_0_29 = 9
local var_0_30 = 11
local var_0_31 = 12
local var_0_32 = 13
local var_0_33 = 14
local var_0_34 = {
	[12] = true,
	[102] = true
}

function RechargeLayer.create(arg_18_0, arg_18_1)
	local var_18_0 = RechargeLayer.new()

	var_18_0:init(arg_18_1)

	return var_18_0
end

function RechargeLayer.getInstance()
	return var_0_12
end

function RechargeLayer:init(arg_20_1)
	require("controller.supermarket_manager"):get_supermarket_list()

	var_0_12 = self

	self:setTouchEnabled(true)

	if arg_20_1 then
		self.returnLayer = arg_20_1.returnLayer or "FightLayer"
		self.jumpToGiftCard = arg_20_1.jumpToGiftCard
		self.jumpToGiftBox = arg_20_1.jumpToGiftBox
		self.initSelectPage = arg_20_1.initSelectPage
	else
		self.returnLayer = "FightLayer"
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "recharge.json" or "recharge.ExportJson")

	self:addChild(self.rootLayer)

	self.recharging = false

	self:initPurchaseEventListener()
	AnalyticManager.enterPurchaseLayer()
	self:registerScriptHandler(function(arg_21_0)
		if arg_21_0 == "exit" then
			var_0_12 = nil

			if arg_20_1 and arg_20_1.callback then
				arg_20_1.callback()
			end
		end
	end)
	self:initUI()
	self:initData(function(...)
		self.tableviewobj = {}

		self:createTableView(self.curSelectType)
		self:initFilterList()
		self:updateUI()
	end)
	alert_manager:unregister_alert(ALERT_REFRESH_RECHARGE)
	self:test()
end

function RechargeLayer:getCurLevelpackgage()
	local function var_23_1(arg_24_0)
		for iter_24_0, iter_24_1 in pairs(self.levelpackage) do
			if iter_24_1.id == arg_24_0 and iter_24_1.have_bought > 0 then
				return true
			end
		end

		return false
	end

	for iter_23_0, iter_23_1 in pairs(self.levelpackage) do
		if iter_23_1.have_bought < iter_23_1.buy_limit then
			if iter_23_1.pre_rechargeid and var_23_1(iter_23_1.pre_rechargeid) then
				return iter_23_1
			end

			return iter_23_1
		end
	end
end

function RechargeLayer:initData(arg_25_1)
	self.curSelectType = 14

	if self.jumpToGiftCard then
		self.curSelectType = 2
	elseif self.jumpToGiftBox then
		self.curSelectType = 1
	end

	if self.initSelectPage then
		self.curSelectType = self.initSelectPage
	end

	self.totalRechargeRank = {}

	for iter_25_0, iter_25_1 in pairs(recharge_data) do
		if iter_25_1.type == var_0_29 then
			table.insert(self.totalRechargeRank, {
				id = iter_25_1.id,
				need_total_recharge = iter_25_1.need_total_recharge
			})
		end
	end

	table.sort(self.totalRechargeRank, function(arg_26_0, arg_26_1)
		return arg_26_0.need_total_recharge < arg_26_1.need_total_recharge
	end)

	local var_25_0 = {}

	for iter_25_2, iter_25_3 in pairs(self.totalRechargeRank) do
		var_25_0[iter_25_3.id] = iter_25_2
	end

	self.rechargeList = {}
	self.levelpackage = {}
	self.filterList = {}
	self.lastrechargeid = nil

	recharge_manager:getRechargeInfo(function(arg_27_0, arg_27_1)
		if not var_0_12 then
			return
		end

		if arg_27_0 == 1 then
			for iter_27_0, iter_27_1 in pairs(arg_27_1) do
				if iter_27_1.type ~= var_0_31 and not var_0_34[iter_27_1.shop_type] then
					self.rechargeList[iter_27_1.shop_type] = self.rechargeList[iter_27_1.shop_type] or {}

					if iter_27_1.type == var_0_28 then
						table.insert(self.levelpackage, iter_27_1)
					else
						table.insert(self.rechargeList[iter_27_1.shop_type], iter_27_1)
					end

					if recharge_data[iter_27_1.id].dropid_ext then
						if iter_27_1.buy_limit and iter_27_1.have_bought_ext == iter_27_1.buy_limit and iter_27_1.have_bought == iter_27_1.buy_limit then
							iter_27_1.order = iter_27_1.order + 100
						end
					elseif iter_27_1.buy_limit and iter_27_1.have_bought == iter_27_1.buy_limit then
						iter_27_1.order = iter_27_1.order + 100
					end
				end
			end

			local var_27_0 = self:getCurLevelpackgage()

			if var_27_0 then
				table.insert(self.rechargeList[var_27_0.shop_type], var_27_0)
			end

			for iter_27_2, iter_27_3 in pairs(self.rechargeList) do
				table.sort(iter_27_3, function(arg_28_0, arg_28_1)
					return arg_28_0.order < arg_28_1.order
				end)
			end

			for iter_27_4, iter_27_5 in pairs(self.rechargeList) do
				if iter_27_4 ~= var_0_29 then
					table.insert(self.filterList, {
						id = iter_27_4,
						order = var_0_18[iter_27_4].order
					})
				end
			end

			table.sort(self.filterList, function(arg_29_0, arg_29_1)
				return arg_29_0.order < arg_29_1.order
			end)

			if self.rechargeList[var_0_29] then
				for iter_27_6, iter_27_7 in pairs(self.rechargeList[var_0_29]) do
					iter_27_7.no = var_25_0[iter_27_7.id]
				end
			end

			if arg_25_1 then
				arg_25_1()
			end
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
end

function RechargeLayer:resetData(arg_30_1)
	self.rechargeList = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if iter_30_1.type ~= var_0_31 and not var_0_34[iter_30_1.shop_type] then
			self.rechargeList[iter_30_1.shop_type] = self.rechargeList[iter_30_1.shop_type] or {}

			if iter_30_1.type ~= var_0_31 then
				if iter_30_1.type == var_0_28 then
					table.insert(self.levelpackage, iter_30_1)
				else
					table.insert(self.rechargeList[iter_30_1.shop_type], iter_30_1)
				end
			end
		end
	end

	local var_30_0 = self:getCurLevelpackgage()

	if var_30_0 then
		table.insert(self.rechargeList[var_30_0.shop_type], var_30_0)
	end

	for iter_30_2, iter_30_3 in pairs(self.rechargeList) do
		table.sort(iter_30_3, function(arg_31_0, arg_31_1)
			return arg_31_0.order < arg_31_1.order
		end)
	end
end

function RechargeLayer:initUI()
	self:initTopImg()
	self:initBottomList()
	self:fullScreen()
	self:initOther()
	self:initBottomLbl()
end

function RechargeLayer:initTopImg()
	self.topImg = ccui.ImageView:create("recharge/top.png", var_0_11)

	self.topImg:setPosition(cc.p(330, 960 + GameDisplay.fix_y))
	self.topImg:setVisible(false)
	self.rootLayer:addChild(self.topImg)

	self.totalRechargeImg = ccui.ImageView:create("recharge/big_no_1.png", var_0_11)

	self.totalRechargeImg:setPosition(cc.p(86, 164))
	self.topImg:addChild(self.totalRechargeImg)

	self.expLabel = cc.Label:createWithTTF("0/0", FONT_BUTTON, 36)

	self.expLabel:setAnchorPoint(cc.p(0, 0.5))
	self.expLabel:setPosition(cc.p(30, 64))
	self.expLabel:setColor(cc.c3b(170, 219, 255))
	self.topImg:addChild(self.expLabel)

	self.totalRechargeLabel1 = cc.Label:createWithTTF(L_NOVICE_AWARD_2[1], FONT_BUTTON, 26)

	self.totalRechargeLabel1:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel1:setPosition(cc.p(100, 122))
	self.topImg:addChild(self.totalRechargeLabel1)

	self.totalRechargeLabel2 = cc.Label:createWithTTF("", FONT_BUTTON, 28)

	self.totalRechargeLabel2:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel2:setColor(cc.c3b(248, 253, 132))
	self.totalRechargeLabel2:setPosition(cc.p(100, 122))
	self.topImg:addChild(self.totalRechargeLabel2)

	self.totalRechargeLabel3 = cc.Label:createWithTTF(L_SUPERMARKET_TIME_LIMIT_5, FONT_BUTTON, 26)

	self.totalRechargeLabel3:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeLabel3:setPosition(cc.p(100, 122))
	self.topImg:addChild(self.totalRechargeLabel3)

	self.totalRechargeImg2 = ccui.ImageView:create("recharge/small_no_1.png", var_0_11)

	self.totalRechargeImg2:setAnchorPoint(cc.p(0, 0.5))
	self.totalRechargeImg2:setPosition(cc.p(100, 122))
	self.topImg:addChild(self.totalRechargeImg2)

	self.expbg = ccui.ImageView:create("recharge/exp_blue.png", var_0_11)

	self.expbg:setScale9Enabled(true)
	self.expbg:setCapInsets(cc.rect(20, 5, 10, 2))
	self.expbg:setContentSize(cc.size(260, 14))
	self.expbg:setAnchorPoint(cc.p(0, 0.5))
	self.expbg:setPosition(cc.p(30, 96))
	self.topImg:addChild(self.expbg)

	self.expbar = ccui.ImageView:create("recharge/exp_red.png", var_0_11)

	self.expbar:setScale9Enabled(true)
	self.expbar:setCapInsets(cc.rect(20, 5, 10, 2))
	self.expbar:setContentSize(cc.size(260, 14))
	self.expbar:setAnchorPoint(cc.p(0, 0.5))
	self.expbar:setPositionX(self.expbg:getPositionX() - 2)
	self.expbar:setPositionY(self.expbg:getPositionY() + 2)
	self.topImg:addChild(self.expbar)
end

function RechargeLayer:updateTopImg()
	if not self.totalRechargeRank[1] then
		return
	end

	local var_34_0 = 0
	local var_34_1 = self.totalRechargeRank[1].need_total_recharge

	for iter_34_0, iter_34_1 in pairs(self.totalRechargeRank) do
		if playermodel.rechargeamount >= iter_34_1.need_total_recharge then
			var_34_0 = iter_34_0

			local var_34_2 = math.max(0, iter_34_1.need_total_recharge)
		end
	end

	if self.totalRechargeRank[var_34_0 + 1] then
		var_34_1 = recharge_data[self.totalRechargeRank[var_34_0 + 1].id] and recharge_data[self.totalRechargeRank[var_34_0 + 1].id].need_total_recharge
	end

	if self.totalRechargeRank[var_34_0 + 1] then
		self.totalRechargeLabel2:setString(var_34_1 - playermodel.rechargeamount .. "元")
		self.totalRechargeImg2:loadTexture("recharge/small_no_" .. var_34_0 + 1 .. ".png", var_0_11)
		self.expLabel:setString(playermodel.rechargeamount .. "/" .. var_34_1)
		self.expbar:setScaleX(playermodel.rechargeamount / var_34_1)
	else
		self.totalRechargeLabel1:setString(L_MAX_LEVLE)
		self.totalRechargeLabel2:setVisible(false)
		self.totalRechargeLabel3:setVisible(false)
		self.totalRechargeImg2:setVisible(false)
		self.totalRechargeImg2:loadTexture("recharge/small_no_" .. var_34_0 .. ".png", var_0_11)
		self.expLabel:setString("")
		self.expbar:setScaleX(1)
	end

	self.totalRechargeImg:loadTexture("recharge/big_no_" .. var_34_0 .. ".png", var_0_11)
	self.topImg:setVisible(self.curSelectType == var_0_29)

	local var_34_3 = 24

	for iter_34_2 = 1, 3 do
		self["totalRechargeLabel" .. iter_34_2]:setPositionX(var_34_3)

		var_34_3 = var_34_3 + self["totalRechargeLabel" .. iter_34_2]:getContentSize().width

		if iter_34_2 == 3 then
			self.totalRechargeImg2:setPositionX(var_34_3)

			var_34_3 = var_34_3 + self.totalRechargeImg2:getContentSize().width
		end
	end
end

function RechargeLayer:filterBtnTouchEvent()
	if not self.tableviewobj[self.curSelectType] then
		self:createTableView(self.curSelectType)
	end

	for iter_35_0, iter_35_1 in pairs(self.tableviewobj) do
		if self.curSelectType == iter_35_0 then
			self.tableviewobj[self.curSelectType]:setVisible(true)
		else
			self.tableviewobj[self.curSelectType]:setVisible(false)
		end
	end

	for iter_35_2, iter_35_3 in pairs(self.tableviewobj) do
		iter_35_3:setVisible(iter_35_2 == self.curSelectType)
	end

	self:updateUI()
end

function RechargeLayer:initFilterList()
	self.filterListBtn = {}

	local function var_36_0(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curSelectType == arg_37_0.curSelectType then
			return
		end

		if self.lastrechargeid then
			for iter_37_0, iter_37_1 in pairs(self.rechargeList) do
				for iter_37_2, iter_37_3 in pairs(iter_37_1) do
					if self.rechargeList[iter_37_0][iter_37_2].id == self.lastrechargeid and self.rechargeList[iter_37_0][iter_37_2].have_bought then
						self.rechargeList[iter_37_0][iter_37_2].have_bought = self.rechargeList[iter_37_0][iter_37_2].have_bought - 1
					end
				end
			end

			self.lastrechargeid = nil
		end

		self.curSelectType = arg_37_0.selectType

		if not self.rechargeList[self.curSelectType] and self.curSelectType == 10 then
			shop_manager:get_shop_data(10, function(arg_38_0)
				self.rechargeList[10] = arg_38_0

				local var_38_0 = {
					[3] = {
						weight = 3,
						func = function(self, arg_41_1)
							local var_41_0 = 0
							local var_41_1 = 0

							if self.buy_limit and self.have_bought >= self.buy_limit then
								var_41_0 = -1
							end

							if arg_41_1.buy_limit and arg_41_1.have_bought >= arg_41_1.buy_limit then
								var_41_1 = -1
							end

							if var_41_0 == var_41_1 then
								return "=="
							else
								return var_41_1 < var_41_0
							end
						end
					},
					[2] = {
						weight = 1,
						func = function(self, arg_40_1)
							return self.pos < arg_40_1.pos
						end
					},
					{
						weight = 2,
						func = function(self, arg_39_1)
							local var_39_0 = 0
							local var_39_1 = 0

							if item_data[self.itemtype].bag_item_type == KITEM_ROLE_GIFT and playermodel.haveServant[item_data[self.itemtype].servant] then
								var_39_0 = 1
							end

							if item_data[arg_39_1.itemtype].bag_item_type == KITEM_ROLE_GIFT and playermodel.haveServant[item_data[arg_39_1.itemtype].servant] then
								var_39_1 = 1
							end

							if var_39_0 == var_39_1 then
								return "=="
							else
								return var_39_1 < var_39_0
							end
						end
					}
				}

				table.sort(var_38_0, function(arg_42_0, arg_42_1)
					return arg_42_0.weight > arg_42_1.weight
				end)
				table.sort(self.rechargeList[10], function(arg_43_0, arg_43_1)
					for iter_43_0 = 1, #var_38_0 do
						if var_38_0[iter_43_0].func(arg_43_0, arg_43_1) ~= "==" then
							return var_38_0[iter_43_0].func(arg_43_0, arg_43_1)
						end
					end
				end)

				for iter_38_0, iter_38_1 in pairs(self.rechargeList[10]) do
					function iter_38_1.touchCallBack(arg_44_0)
						self:shopBuyGift(iter_38_1)
					end
				end

				self:filterBtnTouchEvent()
			end)
		else
			self:filterBtnTouchEvent()
		end

		if self.curSelectType == 2 then
			self.activityLbl:setVisible(true)
		else
			self.activityLbl:setVisible(false)
		end
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):getPositionY() - GameDisplay.fix_y * 2 + 24)
	ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):setContentSize(cc.size(ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):getContentSize().width, ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):getContentSize().height + GameDisplay.fix_y * 2))

	for iter_36_0, iter_36_1 in pairs(self.filterList) do
		local var_36_1 = ccui.Button:create()

		var_36_1:setSwallowTouches(false)
		var_36_1:setName("button_" .. iter_36_1.id)
		var_36_1:loadTextures("recharge/filter" .. iter_36_1.id .. "_normal.png", "recharge/filter" .. iter_36_1.id .. "_normal.png", "", var_0_11)
		var_36_1:setAnchorPoint(cc.p(0.5, 0.5))

		var_36_1.selectType = iter_36_1.id

		var_36_1:addTouchEventListener(var_36_0)

		local var_36_2 = ccui.ImageView:create("public/reddot/new.png", var_0_11)

		var_36_2:setPositionX(var_36_1:getContentSize().width / 2)
		var_36_2:setPositionY(var_36_1:getContentSize().height - 20)
		var_36_2:setName("newImage")
		var_36_1:addChild(var_36_2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):pushBackCustomItem(var_36_1)

		self.filterListBtn[iter_36_1.id] = var_36_1
	end

	local var_36_3 = ccui.Button:create()

	var_36_3:setSwallowTouches(false)
	var_36_3:setName("button_10")
	var_36_3:loadTextures("recharge/filter10_normal.png", "recharge/filter10_normal.png", "", var_0_11)
	var_36_3:setAnchorPoint(cc.p(0.5, 0.5))

	var_36_3.selectType = 10

	var_36_3:addTouchEventListener(var_36_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):pushBackCustomItem(var_36_3)

	self.filterListBtn[10] = var_36_3

	local var_36_4 = ccui.Button:create()

	var_36_4:setSwallowTouches(false)
	var_36_4:setVisible(false)
	var_36_4:setName("button_10")
	var_36_4:loadTextures("recharge/filter10_normal.png", "recharge/filter10_normal.png", "", var_0_11)
	var_36_4:setAnchorPoint(cc.p(0.5, 0.5))

	var_36_4.selectType = 10

	var_36_4:addTouchEventListener(var_36_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_filter"):pushBackCustomItem(var_36_4)
end

function RechargeLayer:updateFilterBtn()
	for iter_45_0, iter_45_1 in pairs(self.filterListBtn) do
		if iter_45_1.selectType == self.curSelectType then
			ccui.Helper:seekWidgetByName(self.rootLayer, "button_" .. iter_45_1.selectType):loadTextures("recharge/filter" .. iter_45_1.selectType .. "_on.png", "recharge/filter" .. iter_45_1.selectType .. "_on.png", "", var_0_11)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "button_" .. iter_45_1.selectType):loadTextures("recharge/filter" .. iter_45_1.selectType .. "_normal.png", "recharge/filter" .. iter_45_1.selectType .. "_normal.png", "", var_0_11)
		end
	end

	local var_45_0 = {}

	for iter_45_2, iter_45_3 in pairs(self.rechargeList) do
		for iter_45_4, iter_45_5 in pairs(iter_45_3) do
			if iter_45_5.new_tag then
				var_45_0[iter_45_2] = true
			end
		end
	end

	for iter_45_6, iter_45_7 in pairs(self.filterListBtn) do
		if iter_45_7:getChildByName("newImage") then
			iter_45_7:getChildByName("newImage"):setVisible(var_45_0[iter_45_6] == true)
		end
	end
end

function RechargeLayer:updateUI()
	self:updateShowingCells()
	self.cardinfoBtn:setVisible(false)
	self:updateFilterBtn()
	self:updateOtherUI()
	self:updateTopImg()
	self:updateBottomList()
end

function RechargeLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_48_0)
		self.recharging = false
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_49_0)
		if not arg_49_0 or not arg_49_0.id then
			return
		end

		for iter_49_0, iter_49_1 in pairs(self.rechargeList) do
			for iter_49_2, iter_49_3 in pairs(iter_49_1) do
				if self.rechargeList[iter_49_0][iter_49_2].id == arg_49_0.id then
					if self.rechargeList[iter_49_0][iter_49_2].time then
						self.rechargeList[iter_49_0][iter_49_2].time = self.rechargeList[iter_49_0][iter_49_2].time + 1
					end

					if self.rechargeList[iter_49_0][iter_49_2].remain then
						self.rechargeList[iter_49_0][iter_49_2].remain = arg_49_0.remain
					end
				end
			end
		end

		self.lastrechargeid = nil

		self:updateUI()
	end), self)
end

function RechargeLayer:fullScreen()
	local var_50_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom")

	var_50_0.full_posY = var_50_0:getPositionY() - GameDisplay.fix_y

	var_50_0:setPositionY(var_50_0.full_posY)

	local var_50_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_filterList")

	var_50_1:setPositionY(1244)

	var_50_1.full_posY = var_50_1:getPositionY() + GameDisplay.fix_y

	var_50_1:setPositionY(var_50_1.full_posY)
end

function RechargeLayer:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_return"):addTouchEventListener(function(arg_52_0, arg_52_1)
		if arg_52_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("???????????Image_return", self.__cname)

		if self.__cname == "PopRechargeLayer" then
			LayerManager:removePopLayer(self.__queueindex)
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	local var_51_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_64")

	self.diamondNumBtn = ccui.Button:create("recharge/diamond_num_btn.png", "recharge/diamond_num_btn.png", "recharge/diamond_num_btn.png", var_0_11)

	self.diamondNumBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.diamondNumBtn:setPosition(cc.p(200, var_51_0:getContentSize().height / 2))
	var_51_0:addChild(self.diamondNumBtn)

	local var_51_1 = ccui.ImageView:create("public/reddot/award.png", var_0_11)

	var_51_1:setName("reddot")
	var_51_1:setVisible(false)
	var_51_1:setAnchorPoint(cc.p(1, 0))
	var_51_1:setPosition(cc.p(self.diamondNumBtn:getContentSize().width, self.diamondNumBtn:getContentSize().height))
	self.diamondNumBtn:addChild(var_51_1)
	self.diamondNumBtn:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curSelectType = var_0_29

		self:filterBtnTouchEvent()
	end)

	self.cardinfoBtn = ccui.ImageView:create("recharge/cardinfo_btn.png", var_0_11)

	self.cardinfoBtn:setTouchEnabled(true)
	self.cardinfoBtn:setPosition(cc.p(520, 94))
	self.cardinfoBtn:addTouchEventListener(function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCardDesLayer")
	end)
	var_51_0:addChild(self.cardinfoBtn)
end

function RechargeLayer:createSp(arg_55_1)
	local var_55_1 = RechargeSprite:create(var_0_19[arg_55_1] or self.rechargeList[arg_55_1][1].ui_type or 1)

	var_55_1:setOpacity(255)

	var_55_1.selectType = arg_55_1

	if arg_55_1 ~= 10 then
		var_55_1:addTouchEventListener(self:getrechargeHanel())
	end

	return var_55_1
end

function RechargeLayer:createTableView(arg_56_1)
	local var_56_0 = var_0_19[arg_56_1] or self.rechargeList[arg_56_1][1].ui_type or 1
	local var_56_1 = var_0_21[arg_56_1] + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.tableviewobj[arg_56_1] = cc.TableView:create(cc.size(var_0_20[arg_56_1], var_56_1))
	self.tableviewobj[arg_56_1].displayheight = var_56_1

	self.tableviewobj[arg_56_1]:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableviewobj[arg_56_1]:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableviewobj[arg_56_1]:setPosition(cc.p(var_0_22, var_0_23 - GameDisplay.fix_y))
	self.tableviewobj[arg_56_1]:setDelegate()

	self.tableviewobj[arg_56_1].anchorPoint = cc.p(0, 0)

	self.tableviewobj[arg_56_1]:setName("tableview")

	self.tableviewobj[arg_56_1].selectType = arg_56_1

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableviewobj[arg_56_1])
	self.tableviewobj[arg_56_1]:registerScriptHandler(function(arg_57_0, arg_57_1)
		return var_0_24[var_56_0], var_0_25[var_56_0]
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewobj[arg_56_1]:registerScriptHandler(function(arg_58_0, arg_58_1)
		local var_58_0 = arg_58_0:dequeueCell()

		if self.lastrechargeid then
			for iter_58_0, iter_58_1 in pairs(self.rechargeList) do
				for iter_58_2, iter_58_3 in pairs(iter_58_1) do
					if iter_58_3.id == self.lastrechargeid and self.rechargeList[iter_58_0][iter_58_2].have_bought then
						self.rechargeList[iter_58_0][iter_58_2].have_bought = self.rechargeList[iter_58_0][iter_58_2].have_bought - 1
					end
				end
			end

			self.lastrechargeid = nil
		end

		if not var_58_0 then
			var_58_0 = cc.TableViewCell:create()

			local var_58_2 = self:createSp(arg_56_1)

			var_58_2:setSwallowTouches(false)
			var_58_2:setPosition(var_0_26[var_56_0])
			var_58_2:setName("sp")
			var_58_0:addChild(var_58_2)

			if self.rechargeList[arg_56_1][arg_58_1 + 1] then
				var_58_2:setVisible(true)
				var_58_2:update(self.rechargeList[arg_56_1][arg_58_1 + 1])

				var_58_2.info = self.rechargeList[arg_56_1][arg_58_1 + 1]
			else
				var_58_2:setVisible(false)
			end
		else
			local var_58_3 = var_58_0:getChildByName("sp")

			if self.rechargeList[arg_56_1][arg_58_1 + 1] then
				var_58_3:setVisible(true)
				var_58_3:update(self.rechargeList[arg_56_1][arg_58_1 + 1])

				var_58_3.info = self.rechargeList[arg_56_1][arg_58_1 + 1]
			else
				var_58_3:setVisible(false)
			end
		end

		return var_58_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewobj[arg_56_1]:registerScriptHandler(function(arg_59_0, arg_59_1)
		return self:getRechargeLen(arg_56_1)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewobj[arg_56_1]:reloadData()
end

function RechargeLayer:getRechargeLen(arg_60_1)
	return #self.rechargeList[arg_60_1]
end

function RechargeLayer:updateShowingCells()
	local var_61_0 = var_0_19[self.curSelectType] or self.rechargeList[self.curSelectType][1].ui_type or 1
	local var_61_1, var_61_2 = GetTableViewShowCellIdx(self.tableviewobj[self.curSelectType], {
		cellsize = cc.size(var_0_24[var_61_0], var_0_25[var_61_0]),
		maxcount = self:getRechargeLen(self.curSelectType)
	})

	for iter_61_0 = var_61_1, var_61_2 do
		self.tableviewobj[self.curSelectType]:updateCellAtIndex(iter_61_0)
	end
end

function RechargeLayer:updateBottomList()
	if not self.rechargeList[var_0_29] then
		self.diamondNumBtn:setVisible(false)

		return
	end

	local var_62_0 = false

	for iter_62_0, iter_62_1 in pairs(self.rechargeList[var_0_29]) do
		if iter_62_1.have_bought < iter_62_1.buy_limit and recharge_data[iter_62_1.id].need_total_recharge <= playermodel.rechargeamount then
			var_62_0 = true
		end

		if recharge_data[iter_62_1.id].dropid_ext and iter_62_1.have_bought_ext < iter_62_1.buy_limit and recharge_data[iter_62_1.id].need_total_recharge <= playermodel.rechargeamount then
			var_62_0 = true
		end
	end

	self.diamondNumBtn:getChildByName("reddot"):setVisible(var_62_0)
end

function RechargeLayer.getrechargeHanel(arg_63_0, ...)
	return function(arg_64_0, arg_64_1)
		if math.abs(arg_64_0:getTouchBeganPosition().y - arg_64_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_64_0:isBright() then
			return
		end

		if arg_63_0.lastrechargeid then
			for iter_64_0, iter_64_1 in pairs(arg_63_0.rechargeList) do
				for iter_64_2, iter_64_3 in pairs(iter_64_1) do
					if iter_64_3.id == arg_63_0.lastrechargeid and arg_63_0.rechargeList[iter_64_0][iter_64_2].have_bought then
						arg_63_0.rechargeList[iter_64_0][iter_64_2].have_bought = arg_63_0.rechargeList[iter_64_0][iter_64_2].have_bought - 1
						arg_64_0.info.have_bought = arg_63_0.rechargeList[iter_64_0][iter_64_2].have_bought
					end
				end
			end

			arg_63_0.lastrechargeid = nil
		end

		for iter_64_4, iter_64_5 in pairs(arg_63_0.rechargeList) do
			for iter_64_6, iter_64_7 in pairs(iter_64_5) do
				if iter_64_7.id == arg_64_0.info.id then
					arg_63_0.rechargeList[iter_64_4][iter_64_6].new_tag = nil
				end
			end
		end

		arg_64_0:setBright(false)
		arg_63_0:createDropDes(arg_64_0.selectType, arg_64_0.info, function(...)
			arg_64_0:setBright(true)
		end)

		if arg_64_0.updateNew then
			arg_64_0:updateNew()
		end
	end
end

local var_0_35 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_35, {
	__index = function(arg_66_0, arg_66_1)
		return "public/currency/" .. item_data[arg_66_1].image_id .. ".png"
	end
})

function RechargeLayer:shopBuyGift(arg_67_1)
	local var_67_0 = ccui.Layout:create()

	var_67_0:setTouchEnabled(true)
	var_67_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_67_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_67_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_67_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_67_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_67_0:setBackGroundColorOpacity(180)
	self:addChild(var_67_0, 10)

	local var_67_1 = ccui.ImageView:create("mainScenebg/market/" .. arg_67_1.itemtype .. ".png")

	var_67_1:setPosition(cc.p(var_67_0:getContentSize().width / 2, var_67_0:getContentSize().height / 2))
	var_67_0:addChild(var_67_1)

	local var_67_2 = ccui.ImageView:create(var_0_35[arg_67_1.currency], var_0_11)

	var_67_2:setPositionX(var_67_1:getContentSize().width / 2 - 20)
	var_67_2:setPositionY(-130)
	var_67_1:addChild(var_67_2)

	local var_67_3 = arg_67_1.discount * arg_67_1.item_number or arg_67_1.price * arg_67_1.item_number
	local var_67_4 = cc.Label:createWithTTF(var_67_3, FONT_DES, 23)

	var_67_4:setAnchorPoint(cc.p(0, 0.5))
	var_67_4:setPositionX(var_67_2:getPositionX() + var_67_2:getContentSize().width / 2 + 5)
	var_67_4:setPositionY(var_67_2:getPositionY())
	var_67_1:addChild(var_67_4)

	local var_67_5 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_11)
	local var_67_6 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_67_6:setColor(cc.c3b(12, 12, 12))
	var_67_5:setPosition(cc.p(var_67_1:getContentSize().width / 2, -70))
	var_67_6:setPosition(cc.p(var_67_5:getContentSize().width / 2, var_67_5:getContentSize().height / 2 - 5))
	var_67_5:addChild(var_67_6)
	var_67_1:addChild(var_67_5)
	var_67_5:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_67_3 > item_manager:getItemNumber(6800601) then
			global_ShowBlockWords("礼品卡不足")

			return
		end

		if not arg_68_0:isBright() then
			return
		end

		arg_68_0:setBright(false)
		shop_manager:shop_buy(10, arg_67_1.shopid, function(arg_69_0)
			if arg_69_0 == 1 then
				self:buySuccess(arg_67_1.shopid)
				var_67_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_67_0:runAction(cc.RemoveSelf:create())
				end)))
				self:updateUI()
			end

			arg_68_0:setBright(true)
		end, 1)
	end)
	var_67_1:setScaleY(0)
	var_67_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_67_0:addTouchEventListener(function(arg_71_0, arg_71_1)
		var_67_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_67_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	;(function(...)
		print(dump(arg_67_1))

		local var_73_0 = var_67_1

		while var_73_0:getChildByName("itemsprite_" .. 1) do
			var_73_0:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			var_73_0:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end

		if not shop_data[arg_67_1.shopid].shop_ui_type then
			return
		end

		local var_73_2 = drop_manager:getDropMsg(item_data[arg_67_1.itemtype].mode_id)

		table.sort(var_73_2.equips, function(arg_74_0, arg_74_1)
			return arg_74_0._index < arg_74_1._index
		end)

		local var_73_3 = {}

		if var_73_2.diamond > 0 then
			table.insert(var_73_3, {
				itemid = "diamond",
				num = var_73_2.diamond,
				name = L_DIAMOND
			})
		end

		if var_73_2.gold > 0 then
			table.insert(var_73_3, {
				itemid = "gold",
				num = var_73_2.gold,
				name = L_GOLD
			})
		end

		local var_73_4 = {}
		local var_73_5 = false
		local var_73_6 = false

		for iter_73_0, iter_73_1 in pairs(var_73_2.equips) do
			if item_data[iter_73_1.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_73_1.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_73_6 = true
			end

			if item_data[iter_73_1.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_73_4, {
				itemid = iter_73_1.dropid,
				num = iter_73_1.dropNum
			})
		end

		if var_73_6 and var_73_6 then
			var_73_5 = true
		end

		local var_73_9 = false

		while var_73_4[1] do
			local var_73_10 = false

			if item_data[var_73_4[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_73_9 then
					var_73_9 = true
					var_73_4[1].path = string.gsub(arg_67_1.icon, ".png", "_furniture.jpg")
				else
					var_73_10 = true
				end
			end

			local var_73_11

			if var_73_10 then
				table.remove(var_73_4, 1)
			else
				var_73_11 = 1 + 1
			end
		end

		for iter_73_2, iter_73_3 in pairs(var_73_4) do
			table.insert(var_73_3, iter_73_3)
		end

		local var_73_12 = {}

		var_73_12 = var_73_5 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_73_3 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_73_3 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_73_4, iter_73_5 in pairs(var_73_3) do
			local var_73_13 = ItemSpriteShop:createSignItem()

			var_73_13:updateSignItemByItemid(iter_73_5.itemid, iter_73_5.num, nil, nil, iter_73_5.path)
			var_73_13:setName("itemsprite_" .. iter_73_4)
			var_73_13:setPosition(var_73_12[iter_73_4])
			var_73_0:addChild(var_73_13)
			var_73_13:setInfoTouchEvent(true)
			var_73_13:setSwallowTouches(true)
		end
	end)()
end

function RechargeLayer:buySuccess(arg_75_1)
	for iter_75_0, iter_75_1 in pairs(self.rechargeList[10]) do
		if iter_75_1.shopid == arg_75_1 then
			iter_75_1.have_bought = iter_75_1.have_bought + 1
		end
	end
end

function RechargeLayer:buyRecharge(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
	if self.recharging then
		return
	end

	self.recharging = true

	var_0_13(arg_76_2, function(arg_77_0)
		if arg_77_0.result == 1 then
			if arg_76_3 == var_0_28 then
				var_0_15(arg_76_2, function(arg_78_0)
					if arg_78_0.result == 1 then
						for iter_78_0, iter_78_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_78_1.id == arg_76_2 then
								iter_78_1.have_bought = iter_78_1.have_bought + 1
							end

							if iter_78_1.id == arg_76_2 then
								local var_78_0 = self:getCurLevelpackgage()

								if var_78_0 then
									self.rechargeList[self.curSelectType][iter_78_0] = var_78_0

									break
								end

								table.remove(self.rechargeList[self.curSelectType][iter_78_0])

								break
							end
						end

						self:updateUI()

						if arg_76_4 then
							arg_76_4(arg_78_0)
						end
					end

					self.recharging = false
				end)
			elseif arg_76_3 == var_0_29 then
				var_0_16(arg_76_2, function(arg_79_0)
					if arg_79_0.result == 1 then
						for iter_79_0, iter_79_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_79_1.id == arg_76_2 then
								if iter_79_1.have_bought == 0 then
									iter_79_1.have_bought = iter_79_1.have_bought + 1
								end

								iter_79_1.have_bought_ext = iter_79_1.have_bought_ext + 1
							end
						end
					end

					self:updateUI()

					if arg_76_4 then
						arg_76_4(arg_79_0)
					end

					self.recharging = false
				end)
			elseif arg_76_3 == var_0_30 then
				var_0_17(arg_76_2, function(arg_80_0)
					if arg_80_0.result == 1 then
						for iter_80_0, iter_80_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_80_1.id == arg_76_2 then
								iter_80_1.have_bought = iter_80_1.have_bought + 1
							end
						end
					end

					self:updateUI()

					if arg_76_4 then
						arg_76_4(arg_80_0)
					end

					self.recharging = false
				end)
			elseif arg_76_3 == var_0_32 then
				var_0_15(arg_76_2, function(arg_81_0)
					if arg_81_0.result == 1 then
						for iter_81_0, iter_81_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_81_1.id == arg_76_2 then
								iter_81_1.have_bought = iter_81_1.have_bought + 1
							end
						end

						self:updateUI()

						if arg_76_4 then
							arg_76_4(arg_81_0)
						end
					end

					self.recharging = false
				end)
			elseif arg_76_3 == var_0_33 then
				self:recharge_from_card(arg_76_2, function(arg_82_0)
					if arg_82_0.result == 1 then
						for iter_82_0, iter_82_1 in pairs(self.rechargeList[self.curSelectType]) do
							if iter_82_1.id == arg_76_2 then
								iter_82_1.have_bought = iter_82_1.have_bought + 1
							end
						end

						self:updateUI()

						if arg_76_4 then
							arg_76_4(arg_82_0)
						end
					end

					self.recharging = false
				end)
			else
				for iter_77_0, iter_77_1 in pairs(self.rechargeList) do
					for iter_77_2, iter_77_3 in pairs(iter_77_1) do
						if iter_77_3.id == arg_76_2 and self.rechargeList[iter_77_0][iter_77_2].have_bought then
							self.rechargeList[iter_77_0][iter_77_2].have_bought = self.rechargeList[iter_77_0][iter_77_2].have_bought + 1
						end
					end
				end

				self.recharging = false
				self.lastrechargeid = arg_76_2

				AnalyticManager.clickPurchaseItem({
					product = arg_76_2,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(arg_76_2)

				if arg_76_4 then
					arg_76_4(arg_77_0)
				end
			end
		elseif arg_77_0.result == 2 then
			print("测试模式")
		elseif arg_77_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_77_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_77_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_77_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end

		if arg_77_0.products then
			self:resetData(arg_77_0.products)
			self.tableviewobj[arg_76_1]:reloadData()
			self:updateUI()
		end
	end)
end

function RechargeLayer.createDropDes(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	local var_83_0 = arg_83_2.id

	var_0_14(arg_83_2.id, function(arg_84_0)
		arg_84_0.id = arg_83_2.id

		function arg_84_0.sureCallback(arg_85_0)
			if arg_83_2.type == 7 and arg_83_2.remain ~= 0 then
				global_ShowBlockWords(L_SUPERMARKET_TIME_LIMIT_7)

				return
			end

			if recharge_data[var_83_0].dropid_ext then
				if arg_83_2.have_bought and arg_83_2.buy_limit and arg_83_2.have_bought >= arg_83_2.buy_limit and arg_83_2.have_bought_ext and arg_83_2.have_bought_ext >= arg_83_2.buy_limit then
					global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

					return
				end
			elseif arg_83_2.have_bought and arg_83_2.buy_limit and arg_83_2.have_bought >= arg_83_2.buy_limit then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

				return
			end

			arg_83_0:buyRecharge(arg_83_1, arg_83_2.id, arg_83_2.type, arg_85_0)

			if arg_83_3 then
				arg_83_3()
			end
		end

		function arg_84_0.exitcallback(...)
			if arg_83_3 then
				arg_83_3()
			end
		end

		LayerManager:pushInLayer("PopBuyRechargeLayer", arg_84_0, arg_83_2)
	end)
end

function RechargeLayer:initOther()
	local var_87_0 = TitleSprite:create("recharge/title_recharge.png", 2)

	var_87_0:setPosition(cc.p(0, GameDisplay.height - GameDisplay.fix_y - 56))
	self.rootLayer:addChild(var_87_0, 5)

	self.diamondbg1 = ccui.ImageView:create("recharge/coin_bg.png", var_0_11)

	self.diamondbg1:setPosition(cc.p(380, var_87_0:getContentSize().height / 2))
	self.diamondbg1:setTouchEnabled(true)
	var_87_0:addChild(self.diamondbg1)

	local var_87_1 = ccui.ImageView:create("public/currency/6800601.png", var_0_11)

	var_87_1:setPositionX(40)
	var_87_1:setPositionY(self.diamondbg1:getContentSize().height / 2)
	self.diamondbg1:addChild(var_87_1)

	local var_87_2 = cc.Label:createWithTTF(playermodel.diamond, FONT_DES, 24)

	var_87_2:setAnchorPoint(cc.p(1, 0.5))
	var_87_2:setPositionX(var_87_1:getPositionX() + 80)
	var_87_2:setPositionY(self.diamondbg1:getContentSize().height / 2)
	var_87_2:setName("diamondlabel1")
	self.diamondbg1:addChild(var_87_2)

	self.diamondbg2 = ccui.ImageView:create("recharge/coin_bg.png", var_0_11)

	self.diamondbg2:setPosition(cc.p(560, var_87_0:getContentSize().height / 2))
	self.diamondbg2:setTouchEnabled(true)
	var_87_0:addChild(self.diamondbg2)

	local var_87_3 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_11)

	var_87_3:setPositionX(20)
	var_87_3:setPositionY(self.diamondbg2:getContentSize().height / 2)
	self.diamondbg2:addChild(var_87_3)

	local var_87_4 = cc.Label:createWithTTF(playermodel.diamond, FONT_DES, 24)

	var_87_4:setAnchorPoint(cc.p(1, 0.5))
	var_87_4:setPositionX(var_87_3:getPositionX() + 100)
	var_87_4:setPositionY(self.diamondbg2:getContentSize().height / 2)
	var_87_4:setName("diamondlabel2")
	self.diamondbg2:addChild(var_87_4)
end

function RechargeLayer:updateOtherUI()
	self.diamondbg1:getChildByName("diamondlabel1"):setString(item_manager:getItemNumber(6800601))
	self.diamondbg2:getChildByName("diamondlabel2"):setString(playermodel.diamond)
end

function RechargeLayer.test(arg_89_0)
	if not config._DEBUG then
		return
	end

	for iter_89_0, iter_89_1 in pairs(recharge_data) do
		if iter_89_1.iosid and iter_89_1.iosid ~= "jieri01" and iter_89_1.iosid ~= "jieri02" and (tonumber(string.match(iter_89_1.iosid, "[0-9]+")) < 14 or tonumber(string.match(iter_89_1.iosid, "[0-9]+")) > 23) then
			if string.find(iter_89_1.iosid, "[a-z]") then
				global_ShowBlockWords("充值表的iosid必须为纯数字字符串\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)
				print("充值表的iosid必须为数字请联系对应负责人赶快改掉")

				return
			end

			if iter_89_1.id ~= 30104 and iter_89_1.id ~= 154001 and iter_89_1.id ~= 154002 and iter_89_1.id ~= 154003 and iter_89_1.id ~= 154004 and iter_89_1.id ~= 154005 and iter_89_1.id ~= 154006 and (iter_89_1.id ~= tonumber(string.match(iter_89_1.productid, "[0-9]+")) or iter_89_1.id ~= tonumber(iter_89_1.iosid)) then
				print("充值表的id、iosid、productid数字必须要对应！请联系对应负责人赶快改掉")
				global_ShowBlockWords("充值表的" .. iter_89_1.id .. " id、iosid、productid数字必须要对应！\n请联系对应负责人赶快改掉", cc.c3b(255, 0, 0), nil, 10000, 1, 22)

				return
			end
		end
	end
end

function RechargeLayer:initBottomLbl()
	self.activityLbl = cc.Label:createWithTTF(L_RECHARGE_DES_ABV, FONT_DES, 24)

	self.activityLbl:setPosition(cc.p(460, 28))
	self.activityLbl:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_64"):addChild(self.activityLbl)

	if self.curSelectType and self.curSelectType == 2 then
		self.activityLbl:setVisible(false)
	end
end

PopRechargeLayer = class("PopRechargeLayer", function(arg_91_0)
	return RechargeLayer:create(arg_91_0)
end)

function PopRechargeLayer.create(arg_92_0, arg_92_1)
	return (PopRechargeLayer.new(arg_92_1))
end
