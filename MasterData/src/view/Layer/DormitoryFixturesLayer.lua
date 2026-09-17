local DormitoryFixturesLayer = class("DormitoryFixturesLayer", (require("view.Layer.BaseUILayer")))
local dormitory_manager = require("controller.dormitory_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local discount_manager = require("controller.discount_manager")
local shop_manager = require("controller.shop_manager")
local filter_config_manager = require("controller.filter_config_manager")
local bag_manager = require("controller.bag_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local furnituresuit_data = require("data.furnituresuit_data")
local major_factor_data = require("data.major_factor_data")
local furniture_data = require("data.furniture_data")
local servant_data = require("data.servant_data")
local utf8 = require("controller.utf8")
local TempWidget = require("view.Sprite.TempWidget")
local QuickCell = require("view.Sprite.QuickCell")

require("view.Sprite.FilterListSprite")
require("view.Sprite.ItemSprite")
require("view.Sprite.ItemSpriteSign")
require("view.Sprite.ItemSpriteFlop")

local var_0_20 = ItemSpriteFlop

require("view.Sprite.FilterSprite")

local var_0_21 = config._DEBUG and 0 or 1
local var_0_22 = "DormitoryFixturesLayer/"
local var_0_24 = {
	DECORATION_BED = 3,
	DECORATION_BOX = 2,
	DECORATION_BG = 1,
	DECORATION_BOX_BACK = 4,
	DECORATION_WINDOWS = 5
}
local var_0_25 = 285
local var_0_26 = 250
local var_0_27 = GameDisplay.height - 360
local var_0_28 = 0
local var_0_29 = cc.size(135, 180)
local var_0_30 = var_0_29.height + 20
local var_0_31 = 4
local var_0_32 = 75
local var_0_33 = 68
local var_0_34 = {
	SPORADIC = 0,
	SUIT = 1
}

local function var_0_35(arg_1_0)
	local var_1_0 = require("controller.dormitory_manager"):getUsedFurniture()

	if var_1_0[arg_1_0] then
		return playermodel.items[arg_1_0].number - var_1_0[arg_1_0]
	else
		return playermodel.items[arg_1_0].number
	end
end

local var_0_37 = 100
local var_0_38 = {
	function()
		return playermodel.gold
	end,
	[0] = function()
		return playermodel.diamond
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

setmetatable(var_0_38, {
	__index = function(arg_7_0, arg_7_1)
		return function()
			return item_manager:getItemNumber(arg_7_1)
		end
	end
})

local var_0_39 = {
	"public/currency/UI_battleEnd_gold.png",
	[0] = "public/currency/UI_battleEnd_diamond.png",
	"public/currency/arenascene_dot_1.png",
	"public/currency/explorecoin.png",
	[6800202] = "public/currency/6800202.png",
	[100] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png"
}

setmetatable(var_0_39, {
	__index = function(arg_9_0, arg_9_1)
		return "public/currency/" .. item_data[arg_9_1].image_id .. ".png"
	end
})

local var_0_40 = {
	function()
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "HandOfMidasLayer",
			labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
		})
	end,
	[0] = function()
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
	end
}

setmetatable(var_0_40, {
	__index = function(arg_14_0, arg_14_1)
		return function()
			global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_14_1].name))
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end
})

local function var_0_41(arg_16_0)
	if not arg_16_0 then
		return "-1"
	end

	local var_16_5 = global_get_time_by_date(arg_16_0) - playermodel.onlineTime
	local var_16_6 = math.floor(var_16_5 / 24 / 3600)
	local var_16_7 = math.floor((var_16_5 - var_16_6 * 24 * 3600) / 3600)
	local var_16_8 = math.floor((var_16_5 - var_16_6 * 24 * 3600 - var_16_7 * 3600) / 60)

	return var_16_6 ~= 0 and string.format(L_TIME_TEXT[1], var_16_6, var_16_7) or var_16_7 ~= 0 and string.format(L_TIME_TEXT[2], var_16_7, var_16_8) or string.format(L_TIME_TEXT[3], var_16_8)
end

local function var_0_42(arg_17_0)
	if not arg_17_0.currency2 or discount_manager:getLastPriceByItem(arg_17_0.itemid, arg_17_0.currency2, arg_17_0.discount2) < arg_17_0.discount2 then
		return true
	end

	return false
end

local function var_0_43(arg_18_0)
	local var_18_0 = {
		name = item_data[arg_18_0.itemtype].name,
		itemid = arg_18_0.itemtype,
		shopid = arg_18_0.shopid,
		costIcon = var_0_39[arg_18_0.currency],
		currency = arg_18_0.currency,
		isnewitem = arg_18_0.isnewitem,
		discountfinish = arg_18_0.discountfinish
	}

	var_18_0.cost = arg_18_0.discount or arg_18_0.price

	if arg_18_0.currency2 then
		var_18_0.costIcon2 = var_0_39[arg_18_0.currency2]
		var_18_0.currency2 = arg_18_0.currency2
		var_18_0.discount2 = arg_18_0.discount2 or arg_18_0.price2
		var_18_0.cost_old2 = arg_18_0.price2
	end

	var_18_0.quality = item_data[arg_18_0.itemtype].equip_quality or 1
	var_18_0.cost_old = arg_18_0.price
	var_18_0.bag_item_type = item_data[arg_18_0.itemtype].bag_item_type
	var_18_0.item_attr = arg_18_0.item_attr
	var_18_0.finish_time = arg_18_0.finish_time
	var_18_0.discount = arg_18_0.discount
	var_18_0.buy_limit = arg_18_0.buy_limit or 1000000
	var_18_0.have_bought = arg_18_0.have_bought or 0
	var_18_0.sell_out = arg_18_0.buy_limit and arg_18_0.buy_limit <= arg_18_0.have_bought
	var_18_0.tag = arg_18_0.tag or 0
	var_18_0.pos = arg_18_0.pos
	var_18_0.purchaseid = arg_18_0.productid

	return var_18_0
end

function DormitoryFixturesLayer:ctor()
	DormitoryFixturesLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function DormitoryFixturesLayer:create(arg_20_1)
	local var_20_0 = DormitoryFixturesLayer.new()

	if var_20_0 and var_20_0:init(arg_20_1) then
		return var_20_0
	end

	return nil
end

function DormitoryFixturesLayer:onEnter()
	DormitoryFixturesLayer.super.onEnter(self)
end

function DormitoryFixturesLayer:onExit()
	DormitoryFixturesLayer.super.onExit(self)
end

function DormitoryFixturesLayer:init(arg_23_1)
	self.oldShow = true
	self.isShowAttrs = false
	self.bagManager = bag_manager.create()
	self.data = arg_23_1 or {}
	self.panelType = self.data.paneltype
	self.usedItem = self.data.usedItem or {}
	self.showItem = clone(self.usedItem)
	self.itemConditions = self.data.itemConditions
	self.servantid = self.itemConditions.servantid
	self.weaponsoulid = self.itemConditions.soulid
	self.servantid = self.servantid or self.weaponsoulid
	self.callbacklist = self.data.callbacklist or {}
	self.surecallback = self.callbacklist.sure
	self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid, self.itemConditions.soulid)
	self.selectSuitId = nil
	self.selectSuitImg = nil
	self.selectSuitIndex = nil
	self.selectType = 0

	self:initLayer()
	self:initListener()

	return true
end

function DormitoryFixturesLayer:initLayer()
	self._root = TempWidget:CreateTempLayout(self)

	self._root:setContentSize(GameDisplay.size)

	local var_24_0 = TempWidget:CreateTempImg("mainScenebg/dormitory_fixtures_bg.png", self._root, 0)

	var_24_0:align(cc.p(0.5, 0), self._root:property().top_bottom)
	var_24_0:setScale9Enabled(true)
	var_24_0:setCapInsets(cc.rect(0, 0, var_24_0:size().w, var_24_0:size().h))
	var_24_0:setContentSize(GameDisplay.size)

	self.bg = var_24_0

	local var_24_1 = TempWidget:CreateTempImg(var_0_22 .. "mask.png", self._root)

	var_24_1:setScale9Enabled(true)
	var_24_1:setCapInsets(cc.rect(var_24_1:getContentSize().width / 2 - 1, var_24_1:getContentSize().height / 2 - 1, 2, 2))
	var_24_1:setContentSize(cc.size(self._root:size().w, 365))
	var_24_1:align(cc.p(0.5, 1), self._root:size().w / 2, GameDisplay.height)
	var_24_1:_addEvent(function()
		return
	end)

	local var_24_2 = TempWidget:CreateTempImg(var_0_22 .. "title.png", self._root)

	var_24_2:align(cc.p(0.5, 1), var_24_0:size().w / 2, GameDisplay.height - 25)

	local var_24_3 = TempWidget:CreateTempBtn(var_0_22 .. "btn_attr.png", var_24_2)

	var_24_3:align(cc.p(1, 0.5), var_24_2:property().right_center.x, var_24_2:property().right_center.y + 5)

	self.propertyBtn = var_24_3

	local var_24_4 = TempWidget:CreateTempBtn(var_0_22 .. "btn_filter.png", var_24_2)

	var_24_4:align(cc.p(1, 0.5), var_24_3:pos().x - var_24_3:size().w + 5, var_24_3:pos().y)

	self.filterBtn = var_24_4

	local var_24_5 = TempWidget:CreateTempLayout(self._root)

	var_24_5:setContentSize(cc.size(GameDisplay.width, var_0_25))
	var_24_5:align(cc.p(0.5, 1), GameDisplay.width / 2, var_24_2:pos().y - var_24_2:size().h - 5)
	TempWidget:CreateTempImg(var_0_22 .. "preview.png", var_24_5):align(cc.p(0, 1), 20, var_24_5:property().top_center.y)

	local var_24_6 = TempWidget:CreateTempImg(var_0_22 .. "favour_bg.png", var_24_5)

	var_24_6:align(cc.p(0.5, 0), var_24_5:property().top_bottom)

	local var_24_7 = TempWidget:CreateTempLabel("", FONT_NAME, 26, var_24_6)

	var_24_7:setColor(cc.c3b(255, 151, 32))
	var_24_7:center()

	self.addText = var_24_7

	local var_24_8 = TempWidget:CreateTempLayout(var_24_5)

	var_24_8:setContentSize(cc.size(GameDisplay.width - 35, 260))
	var_24_8:align(cc.p(0, 0), var_24_5:property().left_bottom.x, var_24_5:property().left_bottom.y + 20)
	var_24_8:setScaleY(0.93)
	var_24_8:setScaleX(0.98)

	self.fixturesLayout = var_24_8

	local var_24_9 = TempWidget:CreateTempBtn(var_0_22 .. "look_more_btn.png", var_24_5)

	var_24_9:setScale9Enabled(true)
	var_24_9:setCapInsets(cc.rect(0, 0, var_24_9:size().w, var_24_9:size().h))
	var_24_9:setContentSize(cc.size(var_24_9:size().w, 210))
	var_24_9:align(cc.p(1, 0.5), var_24_5:property().right_center.x, var_24_5:property().right_center.y + 10)

	self.lookMoreImg = var_24_9

	local var_24_10 = TempWidget:CreateTempListView(var_24_0)

	var_24_10:setContentSize(cc.size(GameDisplay.width, var_0_27))
	var_24_10:move(0, var_0_28)

	self.listView = var_24_10

	self:initBackLayout()
	self:initFilterList()
	self:updateItemListData()
	self:updatePreviewLayout()
	self:updateListView()
	self:updateAddText()
	self:updateBtnVisible()
end

function DormitoryFixturesLayer:initListener()
	self.propertyBtn:_addEvent(function()
		if self.selectType == var_0_34.SPORADIC then
			self.isShowAttrs = not self.isShowAttrs

			self:updateAllItemCell()
		end
	end)
	self.filterBtn:_addEvent(function()
		if not self.filterAniFlag then
			return
		end

		self.filterAniFlag = false

		self._root:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.filterAniFlag = true
			self.filterAniFlag1 = true
		end)))
		self:showFilterPop()
	end)
	self.lookMoreImg:_addEvent(function(arg_30_0)
		arg_30_0:setTouchEnabled(false)

		local var_30_0 = {
			jump_to_system = 153
		}

		var_30_0.config = system_jump_config[SYSTEMID[153]] and system_jump_config[SYSTEMID[153]].config

		require("controller.goto_system_manager")

		var_30_0.config.exitCallback = createExitCallback({
			jump_to_system = 700
		})

		goto_complete_system(var_30_0)
	end)
	self.sureBtn:_addEvent(function()
		local var_31_0 = false

		self.usedItem = clone(self.showItem)

		for iter_31_0, iter_31_1 in pairs(self.usedItem) do
			if iter_31_1 ~= playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures[iter_31_0] then
				var_31_0 = true

				break
			end
		end

		if self.surecallback then
			self.surecallback(self.usedItem, var_31_0)
		end

		local var_31_1 = self.listView:getChildren()
		local var_31_2

		for iter_31_2 = 1, #var_31_1 - 1 do
			if var_31_1[iter_31_2]:IsEnter() then
				var_31_2 = var_31_2 or iter_31_2

				var_31_1[iter_31_2]:stopAllActions()
				var_31_1[iter_31_2]:runAction(cc.FadeOut:create(0.03 * (iter_31_2 - var_31_2 + 1)))
			end
		end

		self._root:stopAllActions()
		self._root:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
	self.restoreBtn:_addEvent(function()
		self.selectSuitImg = nil
		self.selectSuitId = nil
		self.selectSuitIndex = nil
		self.showItem = clone(self.usedItem)

		self:updatePreviewLayout()
		self:updateListView()
		self:updateAddText()
		self:updateBtnVisible()
	end)
	self.backBtn:_addEvent(function()
		local var_34_0 = self.listView:getChildren()
		local var_34_1

		for iter_34_0 = 1, #var_34_0 - 1 do
			if var_34_0[iter_34_0]:IsEnter() then
				var_34_1 = var_34_1 or iter_34_0

				var_34_0[iter_34_0]:stopAllActions()
				var_34_0[iter_34_0]:runAction(cc.FadeOut:create(0.03 * (iter_34_0 - var_34_1 + 1)))
			end
		end

		self._root:stopAllActions()
		self._root:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
end

function DormitoryFixturesLayer:initBackLayout()
	local var_36_0 = TempWidget:CreateTempLayout(self.bg)

	var_36_0:setContentSize(cc.size(GameDisplay.width, var_0_32))
	var_36_0:_addEvent(function()
		return
	end)
	var_36_0:align(cc.p(0, 0), 0, 0)

	self.backLayout = var_36_0

	TempWidget:CreateTempImg(var_0_22 .. "bottom_bg.png", var_36_0):align(cc.p(0, 0), 0, 0)

	local var_36_1 = TempWidget:CreateTempBtn(var_0_22 .. "general _return_btn.png", var_36_0)

	var_36_1:align(cc.p(0, 0.5), 10, var_36_0:size().h / 2)

	self.backBtn = var_36_1

	local var_36_2 = TempWidget:CreateTempBtn(var_0_22 .. "sure_btn.png", var_36_0)

	var_36_2:align(cc.p(1, 0.5), var_36_0:property().right_center)

	self.sureBtn = var_36_2

	local var_36_3 = TempWidget:CreateTempBtn(var_0_22 .. "restore_btn.png", var_36_0)

	var_36_3:align(cc.p(1, 0.5), var_36_2:pos().x - var_36_2:size().w, var_36_2:pos().y)

	self.restoreBtn = var_36_3
end

function DormitoryFixturesLayer:updatePreviewLayout()
	self.fixturesLayout:removeAllChildren()

	local var_38_0 = TempWidget:CreateTempImg(var_0_22 .. "preview_mask.png", self.fixturesLayout)

	var_38_0:setScale9Enabled(true)
	var_38_0:setCapInsets(cc.rect(var_38_0:getContentSize().width / 2 - 1, var_38_0:getContentSize().height / 2 - 1, 2, 2))
	var_38_0:setContentSize(cc.size(var_38_0:size().w + 20, var_38_0:size().h + 32))
	var_38_0:align(cc.p(0.5, 0.5), self.fixturesLayout:size().w / 2 + 32, self.fixturesLayout:size().h / 2 + 10)

	local var_38_1 = TempWidget:CreateTempImg(nil, self.fixturesLayout)

	var_38_1:setName("smallDoor")
	var_38_1:align(cc.p(0, 0.5), 15, self.fixturesLayout:size().h / 2)

	local var_38_2 = {
		[var_0_24.DECORATION_BG] = cc.p(self.fixturesLayout:size().w / 2, self.fixturesLayout:size().h / 2),
		[var_0_24.DECORATION_BOX] = 0,
		[var_0_24.DECORATION_BED] = 0,
		[var_0_24.DECORATION_BOX_BACK] = 0,
		[var_0_24.DECORATION_WINDOWS] = 0,
		[2] = FURNITURE_POS[2],
		[3] = FURNITURE_POS[3],
		[4] = FURNITURE_POS[4],
		[5] = FURNITURE_POS[5]
	}
	local var_38_3 = {
		[var_0_24.DECORATION_BG] = cc.p(0.5, 0.5),
		[var_0_24.DECORATION_BOX] = cc.p(0, 0),
		[var_0_24.DECORATION_BED] = cc.p(0, 0),
		[var_0_24.DECORATION_BOX_BACK] = cc.p(0, 0),
		[var_0_24.DECORATION_WINDOWS] = cc.p(0, 0)
	}
	local var_38_4 = self.fixturesLayout:getChildByName("smallDoorSpine")

	if var_38_4 then
		var_38_4:removeSelf()
	end

	for iter_38_0 = 1, 5 do
		local var_38_6 = self.fixturesLayout:getChildByName("furniture" .. iter_38_0)

		if not var_38_6 then
			var_38_6 = TempWidget:CreateTempImg(nil, self.fixturesLayout)

			var_38_6:setAnchorPoint(var_38_3[iter_38_0])
		end

		var_38_6:setLocalZOrder(FURNITURE_ZORDER[iter_38_0])

		local var_38_7 = self.fixturesLayout:getChildByName("furnitureSpine" .. iter_38_0)

		if var_38_7 then
			var_38_7:removeSelf()
		end

		if self.showItem[iter_38_0] and self.showItem[iter_38_0] > 0 then
			var_38_6:show()

			if not item_data[self.showItem[iter_38_0]].spine_dorm then
				if iter_38_0 == 1 then
					var_38_6:loadTexture("mainScenebg/dorm_room_bg/" .. item_data[self.showItem[iter_38_0]].image_dorm .. ".png", 0)

					local var_38_9 = self.fixturesLayout:getChildByName("smallDoor")

					var_38_9:setVisible(true)
					var_38_9:loadTexture("mainScenebg/furnitures/" .. item_data[self.showItem[iter_38_0]].image_door .. ".png", 0)
				else
					var_38_6:loadTexture("mainScenebg/furnitures/" .. item_data[self.showItem[iter_38_0]].image_dorm .. ".png", 0)
				end

				local var_38_10 = item_data[self.showItem[iter_38_0]].init_x or var_38_2[iter_38_0].x
				local var_38_11 = item_data[self.showItem[iter_38_0]].init_y or var_38_2[iter_38_0].y

				var_38_6:setPosition(var_38_10, var_38_11)

				if item_data[self.showItem[iter_38_0]].offset then
					local var_38_12, var_38_13 = item_data[self.showItem[iter_38_0]].offset:match("([^,]+),(.+)")

					var_38_6:setPosition(var_38_10 + (tonumber(var_38_12) or 0), var_38_11 + (tonumber(var_38_13) or 0))
				end
			else
				local var_38_15 = item_data[self.showItem[iter_38_0]].spine_init_x or FURNITURE_POS[1].x
				local var_38_16 = item_data[self.showItem[iter_38_0]].spine_init_y or FURNITURE_POS[1].y

				if iter_38_0 == 1 then
					self.fixturesLayout:getChildByName("smallDoor"):setVisible(false)

					local var_38_17 = L2Skeleton:create("spine/furniture/" .. item_data[self.showItem[iter_38_0]].spine_dorm .. "_men.json", "spine/furniture/" .. item_data[self.showItem[iter_38_0]].spine_dorm .. "_men.atlas", nil, true)

					var_38_17:setName("smallDoorSpine")
					var_38_17:refreshSkeleton()
					var_38_17:play("animate", true)
					var_38_17:setPosition(var_38_15, var_38_16)
					self.fixturesLayout:addChild(var_38_17, FURNITURE_ZORDER[iter_38_0] + 1)
				end

				var_38_6:setVisible(false)

				local var_38_18 = L2Skeleton:create("spine/furniture/" .. item_data[self.showItem[iter_38_0]].spine_dorm .. ".json", "spine/furniture/" .. item_data[self.showItem[iter_38_0]].spine_dorm .. ".atlas", nil, true)

				var_38_18:setName("furnitureSpine" .. iter_38_0)
				var_38_18:refreshSkeleton()
				var_38_18:play("animate", true)
				var_38_18:setPosition(var_38_15, var_38_16)
				self.fixturesLayout:addChild(var_38_18, FURNITURE_ZORDER[iter_38_0])
			end
		else
			var_38_6:hide()
		end
	end
end

function DormitoryFixturesLayer:initFilterList()
	self.filterAniFlag = true
	self.filterAniFlag1 = false
	self.filterPopModel = false
	self.filterType = filter_config_manager.DORMROOM_FURNITURE_ITEMPANEL
	self.curSortOrders = 1
	self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)
	self.curSort = self.filterTbl.sortType

	local var_39_0 = {
		defaultSelected = 1,
		bagLayerType = self.filterType,
		filterCallback = function(self)
			self.selectTblAni = true

			if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
				if self.furniture_suit then
					self.selectType = 1
					self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid, self.itemConditions.soulid)

					self:updatePreviewLayout()
					self:updateListView()
					self:updateAddText()
					self:updateBtnVisible()
				else
					self.selectType = 0
					self.filterTbl.filterConfig[self.filterKey] = {
						self.filterValue
					}
					self.filterListData = self

					self:updateItemListData()
					self:updatePreviewLayout()
					self:updateListView()
					self:updateAddText()
					self:updateBtnVisible()
				end
			end

			self.selectTblAni = false
		end
	}

	if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		var_39_0.style = "style_furniture"
	end

	self.filterList = FilterListSprite:create(var_39_0)

	self.filterList:setPosition(cc.p(0, self.backLayout:size().h))
	self._root:addChild(self.filterList, 45)

	self.filterListData = self.filterList:getFilterData()
end

function DormitoryFixturesLayer:createSuitLayout(arg_41_1)
	local var_41_0 = TempWidget:CreateTempLayout()

	var_41_0:setContentSize(cc.size(GameDisplay.width, var_0_26))

	local var_41_1

	if arg_41_1 > #self.shopList then
		var_41_1 = self.suitList[arg_41_1 - #self.shopList] or self.shopList[arg_41_1].suitid
	end

	local var_41_2 = furnituresuit_data[var_41_1]
	local var_41_3 = TempWidget:CreateTempBtn("itempanel/furniture_bg.png", var_41_0)

	var_41_3:loadTexturePressed("itempanel/furniture_bg.png", var_0_21)
	var_41_3:loadTextureDisabled("itempanel/furniture_bg.png", var_0_21)
	var_41_3:setSwallowTouches(false)
	var_41_3:ignoreContentAdaptWithSize(false)
	var_41_3:setContentSize(cc.size(var_41_3:size().w - 8, var_41_3:size().h + 25))
	var_41_3:setName("bg")

	var_41_3.suitId = var_41_1

	var_41_3:align(cc.p(0, 0.5), 10, var_41_0:size().h / 2)
	var_41_3:_addEvent(function(arg_42_0)
		self:selectSuit(arg_42_0, arg_41_1)
	end)

	local var_41_4 = TempWidget:CreateTempImg("mainScenebg/market/" .. item_data[furnituresuit_data[var_41_1].furniture_gift_id].image_id .. ".jpg", var_41_3, 0)

	var_41_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_4:setPosition(var_41_3:getContentSize().width / 2 - 32, var_41_3:getContentSize().height / 2)
	var_41_4:setLocalZOrder(-1)
	var_41_4:setScale9Enabled(true)
	var_41_4:setCapInsets(cc.rect(0, 0, var_41_4:size().w, var_41_4:size().h))
	var_41_4:setContentSize(cc.size(var_41_4:size().w, var_41_3:size().h))

	local var_41_5 = TempWidget:CreateTempLabel(item_data[furnituresuit_data[var_41_1].furniture_gift_id].name, FONT_DES, 30, var_41_0)

	var_41_5:align(cc.p(1, 1), var_41_0:property().right_top.x - 70, var_41_0:property().right_top.y - 23)

	local var_41_6 = TempWidget:CreateTempImg(var_0_22 .. "normal_select.png", var_41_0)

	var_41_6:setName("stateBg")
	var_41_6:setScale9Enabled(true)
	var_41_6:setCapInsets(cc.rect(0, 0, var_41_6:size().w, var_41_6:size().h))
	var_41_6:setContentSize(cc.size(var_41_6:size().w, var_41_6:size().h + 30))
	var_41_6:align(cc.p(1, 0.5), var_41_0:property().right_bottom.x + 13, var_41_0:size().h / 2)

	if self.selectSuitId == var_41_1 then
		var_41_6:loadTextureEx(var_0_22 .. "equipment_select.png")
	end

	var_41_6:ignoreContentAdaptWithSize(true)

	if arg_41_1 <= #self.shopList then
		var_41_5:hide()

		var_41_3.shopconfig = self.shopList[arg_41_1]

		var_41_4:setOpacity(120)
		var_41_6:loadTextureEx(var_0_22 .. "buy_select.png")
		self:initCostLayout(var_41_3.shopconfig.shopinfo, var_41_6)
		var_41_6:_addEvent(function()
			self:selectSuit(var_41_3, arg_41_1)
		end)
	end

	self:initMiniHead(var_41_3, var_41_2)

	return var_41_0
end

function DormitoryFixturesLayer:initCostLayout(arg_44_1, arg_44_2)
	local var_44_0 = var_0_43(arg_44_1)
	local var_44_1 = {
		itemid = var_44_0.itemid,
		item_attr = var_44_0.item_attr
	}

	var_44_1.limitNum = var_44_0.buy_limit and var_44_0.buy_limit - var_44_0.have_bought or 100

	local var_44_2 = math.floor(var_0_38[var_44_0.currency]() / var_44_0.cost)

	if var_44_2 > var_44_1.limitNum then
		var_44_1.limitNum = var_44_1.limitNum or var_44_2
	end

	local var_44_3 = var_0_41(var_44_0.finish_time)

	if var_44_3 ~= "-1" then
		var_44_1.limit_time = L_MARKET_MSG.Rest_Time .. var_44_3
	end

	var_44_1.slidecost = {
		nowHave = var_0_38[var_44_0.currency]()
	}

	if var_0_42(var_44_0) then
		var_44_1.slidecost.costtype = var_44_0.costIcon
		var_44_1.slidecost.costnum = var_44_0.discount or var_44_0.cost
		var_44_1.slidecost.cost_old = var_44_0.cost_old or var_44_1.slidecost.costnum
		var_44_1.slidecost.nowHave = var_0_38[var_44_0.currency]()
		var_44_1.currency = var_44_0.currency
	else
		var_44_1.slidecost.costtype = var_44_0.costIcon2
		var_44_1.slidecost.costnum = var_44_0.discount2 or var_44_0.cost2
		var_44_1.slidecost.cost_old = var_44_0.cost_old2 or var_44_1.slidecost.costnum
		var_44_1.slidecost.nowHave = var_0_38[var_44_0.currency2]()
		var_44_1.currency = var_44_0.currency2
	end

	local var_44_4 = TempWidget:CreateTempLayout()

	var_44_4:setContentSize(cc.size(80, 200))

	local var_44_5 = TempWidget:CreateTempImg(var_44_1.slidecost.costtype)

	var_44_5:setPositionX(var_44_4:getContentSize().width / 2)
	var_44_5:setPositionY(150)
	var_44_4:addChild(var_44_5)

	local var_44_6 = TempWidget:CreateTempLabel(var_44_1.slidecost.costnum, FONT_DES, 23)

	var_44_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_44_6:setPositionX(var_44_5:getPositionX())
	var_44_6:setPositionY(var_44_5:getPositionY() - var_44_5:size().h / 2 - 10)
	var_44_4:addChild(var_44_6)
	arg_44_2:addChild(var_44_4)
	var_44_4:align(cc.p(0.5, 0.5), arg_44_2:property().center)
end

function DormitoryFixturesLayer:updateListView()
	self.listView:removeAllItems()
	self.listView:jumpToTop()

	local var_45_0 = self.listView

	if self.selectType == var_0_34.SPORADIC then
		var_45_0:setClippingEnabled(true)

		for iter_45_0 = 1, math.ceil(#self.itemList / var_0_31) do
			local var_45_1 = QuickCell:Create({
				wid = GameDisplay.width,
				hei = var_0_30,
				createCell = function()
					return self:createCell(iter_45_0)
				end
			})

			if var_45_1:IsActive() then
				local var_45_2 = cc.Node:create()

				var_45_1:addChild(var_45_2)
				var_45_1:setVisible(false)
				var_45_1:setOpacity(0)
				var_45_2:runAction(cc.Sequence:create(cc.DelayTime:create(iter_45_0 * 0.05), cc.CallFunc:create(function()
					var_45_1:setVisible(true)
					var_45_1:runAction(cc.FadeIn:create(0.05))
				end)))
			end

			var_45_0:pushBackCustomItem(var_45_1)
		end
	elseif self.selectType == var_0_34.SUIT then
		var_45_0:setClippingEnabled(false)

		for iter_45_1 = 1, #self.shopList + #self.suitList do
			local var_45_3 = QuickCell:Create({
				wid = GameDisplay.width,
				hei = var_0_26,
				createCell = function()
					return self:createSuitLayout(iter_45_1)
				end
			})

			if var_45_3:IsActive() then
				local var_45_4 = cc.Node:create()

				var_45_3:addChild(var_45_4)
				var_45_3:setVisible(false)
				var_45_3:setOpacity(0)
				var_45_4:runAction(cc.Sequence:create(cc.DelayTime:create(iter_45_1 * 0.05), cc.CallFunc:create(function()
					var_45_3:setVisible(true)
					var_45_3:runAction(cc.FadeIn:create(0.05))
				end)))
			end

			var_45_0:pushBackCustomItem(var_45_3)
		end
	end

	local var_45_5 = TempWidget:CreateTempLayout()

	var_45_5:setContentSize(cc.size(GameDisplay.width, 120))
	var_45_0:pushBackCustomItem(var_45_5)
end

function DormitoryFixturesLayer:selectSuit(arg_50_1, arg_50_2)
	if self.selectSuitId == arg_50_1.suitId then
		return
	end

	if arg_50_1.shopconfig then
		self:goBuyFurniture(arg_50_1.shopconfig.shopinfo, arg_50_1.shopconfig.shoptype)
	else
		self.selectSuitImg = arg_50_1
		self.selectSuitId = arg_50_1.suitId

		if self.selectSuitIndex then
			self:updateSuitCell(self.selectSuitIndex)
		end

		self.selectSuitIndex = arg_50_2

		self:updateSuitCell(self.selectSuitIndex)

		for iter_50_0 = 1, 5 do
			self.showItem[iter_50_0] = furnituresuit_data[arg_50_1.suitId]["furniture" .. iter_50_0]
		end

		self:updatePreviewLayout()
		self:updateAddText()
		self:updateBtnVisible()
	end
end

function DormitoryFixturesLayer:goBuyFurniture(arg_51_1, arg_51_2)
	if arg_51_1.currency == var_0_37 then
		(function(arg_56_0)
			local var_56_0 = {
				itemid = arg_56_0.itemid,
				item_attr = arg_56_0.item_attr
			}
			local var_56_1 = {
				costtype = arg_56_0.costIcon
			}

			var_56_1.costnum = arg_56_0.discount or arg_56_0.cost
			var_56_0.slidecost = var_56_1

			function var_56_0:ShopSliderCallback(arg_57_1, arg_57_2)
				if arg_57_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_56_0.have_bought >= arg_56_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_56_0.shopid, arg_56_0.purchaseid, function(arg_58_0)
					if arg_58_0 == 1 then
						arg_51_1.have_bought = arg_51_1.have_bought + curbuyTime
						arg_51_1.sell_out = arg_51_1.buy_limit and arg_51_1.buy_limit <= arg_51_1.have_bought
						self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid)

						self:updateListView()

						if self:getChildByName("popBuyLayer") then
							self:getChildByName("popBuyLayer"):removeFromParent()
						end

						if item_data[var_56_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_56_0.itemid), 1000)
						end

						if arg_51_2 == 6 then
							for iter_58_0, iter_58_1 in pairs({
								{
									entityid = var_56_0.itemid
								}
							}) do
								net:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_58_1.entityid
								}, function(arg_59_0)
									if arg_59_0.result == 1 then
										global_gain(arg_59_0)
										item_manager:deleteItem(iter_58_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							cc.Director:getInstance():getRunningScene():addChild(PopLayer:Gain({
								items = {
									{
										dropNum = 1,
										dropid = var_56_0.itemid,
										entityid = var_56_0.itemid
									}
								}
							}), 999)
						end
					elseif arg_58_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_57_2 then
						arg_57_2(arg_58_0)
					end
				end)
			end

			if arg_51_2 == 4 or arg_51_2 == 6 then
				self:buyFurniturePop(var_56_0)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_56_0.isnewitem = false
		end)(var_0_43(arg_51_1))
	else
		(function(arg_52_0)
			local var_52_0 = {
				itemid = arg_52_0.itemid,
				item_attr = arg_52_0.item_attr
			}

			var_52_0.limitNum = arg_52_0.buy_limit and arg_52_0.buy_limit - arg_52_0.have_bought or 100

			local var_52_1 = math.floor(var_0_38[arg_52_0.currency]() / arg_52_0.cost)

			if var_52_1 > var_52_0.limitNum then
				var_52_0.limitNum = var_52_0.limitNum or var_52_1
			end

			local var_52_2 = var_0_41(arg_52_0.finish_time)

			if var_52_2 ~= "-1" then
				var_52_0.limit_time = L_MARKET_MSG.Rest_Time .. var_52_2
			end

			var_52_0.slidecost = {
				nowHave = var_0_38[arg_52_0.currency]()
			}

			if var_0_42(arg_52_0) then
				var_52_0.slidecost.costtype = arg_52_0.costIcon
				var_52_0.slidecost.costnum = arg_52_0.discount or arg_52_0.cost
				var_52_0.slidecost.cost_old = arg_52_0.cost_old or var_52_0.slidecost.costnum
				var_52_0.slidecost.nowHave = var_0_38[arg_52_0.currency]()
				var_52_0.currency = arg_52_0.currency
			else
				var_52_0.slidecost.costtype = arg_52_0.costIcon2
				var_52_0.slidecost.costnum = arg_52_0.discount2 or arg_52_0.cost2
				var_52_0.slidecost.cost_old = arg_52_0.cost_old2 or var_52_0.slidecost.costnum
				var_52_0.slidecost.nowHave = var_0_38[arg_52_0.currency2]()
				var_52_0.currency = arg_52_0.currency2
			end

			function var_52_0:ShopSliderCallback(arg_53_1, arg_53_2, arg_53_3)
				if arg_53_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_53_0
				local var_53_1

				if var_0_42(arg_52_0) then
					var_53_0 = arg_52_0.currency
					var_53_1 = arg_52_0.discount
				else
					var_53_0 = arg_52_0.currency2
					var_53_1 = arg_52_0.discount2
				end

				if var_53_1 > var_0_38[var_53_0]() + discount_manager:getCouponsDiscount(arg_53_3) then
					var_0_40[var_53_0]()

					if self:getChildByName("popBuyLayer") then
						self:getChildByName("popBuyLayer"):runAction(cc.RemoveSelf:create())
					end

					return
				end

				self:setTouchEnabled(false)

				local var_53_2 = self.nowNum or 1

				if not arg_53_3 then
					shop_manager:shop_buy(arg_51_2, arg_52_0.shopid, function(arg_54_0)
						if arg_54_0 == 1 then
							arg_51_1.have_bought = arg_51_1.have_bought + var_53_2
							arg_51_1.sell_out = arg_51_1.buy_limit and arg_51_1.buy_limit <= arg_51_1.have_bought
							self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid)

							if self.selectSuitIndex then
								local var_54_0 = false

								for iter_54_0 = 1, #self.shopList do
									if self.shopList[iter_54_0] == self.selectSuitId then
										self.selectSuitIndex = iter_54_0
										var_54_0 = true

										break
									end
								end

								if not var_54_0 then
									for iter_54_1 = 1, #self.suitList do
										if self.suitList[iter_54_1] == self.selectSuitId then
											self.selectSuitIndex = iter_54_1 + #self.shopList

											break
										end
									end
								end
							end

							self:updatePreviewLayout()
							self:updateListView()
							self:updateBtnVisible()

							if item_data[var_52_0.itemid].bag_item_type == kITEM_SKIN then
								require("view.Layer.GetRoleAnimationLayer")
								cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_52_0.itemid), 1000)
							end

							if arg_53_2 then
								arg_53_2()
							end
						elseif arg_54_0 == 2 then
							global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_54_0 == 3 then
							var_0_40[arg_52_0.currency]()
						end

						if arg_53_2 then
							arg_53_2(arg_54_0)
						end
					end, var_53_2)
				else
					shop_manager:shop_buy_with_ticket(arg_51_2, arg_52_0.shopid, function(arg_55_0)
						if arg_55_0 == 1 then
							arg_51_1.have_bought = arg_51_1.have_bought + var_53_2
							arg_51_1.sell_out = arg_51_1.buy_limit and arg_51_1.buy_limit <= arg_51_1.have_bought
							self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid)

							self:updatePreviewLayout()
							self:updateListView()
							self:updateBtnVisible()

							if item_data[var_52_0.itemid].bag_item_type == kITEM_SKIN then
								require("view.Layer.GetRoleAnimationLayer")
								cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_52_0.itemid), 1000)
							end

							if arg_53_2 then
								arg_53_2()
							end
						elseif arg_55_0 == 2 then
							global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_55_0 == 3 then
							var_0_40[arg_52_0.currency]()
						end

						if arg_53_2 then
							arg_53_2(arg_55_0)
						end
					end, var_53_2, nil, arg_53_3, 1)
				end
			end

			var_52_0.hideGainButton = true

			if arg_52_0.have_bought and arg_52_0.buy_limit then
				var_52_0.limit_buy_num = arg_52_0.buy_limit - arg_52_0.have_bought
				var_52_0.have_bought_num = arg_52_0.have_bought
			end

			local var_52_3 = discount_manager:getCanUseCoupin(var_52_0.itemid, var_52_0.currency, var_52_0.costnum or var_52_0.slidecost.costnum, arg_51_2)

			if var_52_3 and next(var_52_3) then
				var_52_0.couponList = var_52_3

				self:showBachelorFurniturePop(var_52_0)

				arg_52_0.isnewitem = false

				return
			end

			self:buyFurniturePop(var_52_0)

			arg_52_0.isnewitem = false
		end)(var_0_43(arg_51_1))
	end
end

function DormitoryFixturesLayer:buyFurniturePop(arg_60_1)
	local var_60_0 = ccui.Layout:create()

	var_60_0:setTouchEnabled(true)
	var_60_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_60_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_60_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_60_0:setBackGroundColorOpacity(180)
	var_60_0:setName("popBuyLayer")
	self:addChild(var_60_0, 10)

	local var_60_1 = ccui.ImageView:create("mainScenebg/market/" .. arg_60_1.itemid .. ".jpg", 0)

	var_60_1:setPosition(cc.p(var_60_0:getContentSize().width / 2, var_60_0:getContentSize().height / 2))
	var_60_0:addChild(var_60_1)

	local var_60_2 = ccui.ImageView:create("itempanel/furniture_bg.png", var_0_21)

	var_60_2:setPosition(cc.p(var_60_1:getContentSize().width / 2, var_60_1:getContentSize().height / 2 - 18))
	var_60_1:addChild(var_60_2)

	local var_60_3 = cc.Label:createWithTTF(item_data[arg_60_1.itemid].name, FONT_DES, 22)

	var_60_3:setPosition(cc.p(470, 235))
	var_60_2:addChild(var_60_3)

	local var_60_4 = -130

	if arg_60_1.slidecost.cost_old and arg_60_1.slidecost.costnum < arg_60_1.slidecost.cost_old then
		local var_60_5 = ccui.ImageView:create(arg_60_1.slidecost.costtype, var_0_21)

		var_60_5:setPositionX(var_60_2:getContentSize().width / 2 - 30)
		var_60_5:setPositionY(var_60_4)
		var_60_2:addChild(var_60_5)

		local var_60_6 = cc.Label:createWithTTF(arg_60_1.slidecost.cost_old, FONT_DES, 23)

		var_60_6:setAnchorPoint(cc.p(0, 0.5))
		var_60_6:setPositionX(var_60_5:getPositionX() + var_60_5:getContentSize().width / 2 + 5)
		var_60_6:setPositionY(var_60_5:getPositionY())
		var_60_2:addChild(var_60_6)

		local var_60_7 = ccui.ImageView:create("public/currency/discount_line.png", var_0_21)

		var_60_7:setPositionX((var_60_5:getPositionX() + var_60_6:getPositionX() + var_60_6:getContentSize().width / 2) / 2)
		var_60_7:setPositionY(var_60_5:getPositionY())
		var_60_2:addChild(var_60_7, 2)

		var_60_4 = var_60_4 - 45
	end

	local var_60_8 = ccui.ImageView:create(arg_60_1.slidecost.costtype, var_0_21)

	var_60_8:setPositionX(var_60_2:getContentSize().width / 2 - 30)
	var_60_8:setPositionY(var_60_4)
	var_60_2:addChild(var_60_8)

	local var_60_9 = cc.Label:createWithTTF(arg_60_1.slidecost.costnum, FONT_DES, 23)

	var_60_9:setAnchorPoint(cc.p(0, 0.5))
	var_60_9:setPositionX(var_60_8:getPositionX() + var_60_8:getContentSize().width / 2 + 5)
	var_60_9:setPositionY(var_60_8:getPositionY())
	var_60_2:addChild(var_60_9)

	local var_60_10
	local var_60_11

	if arg_60_1.slidecost.costnum > arg_60_1.slidecost.nowHave then
		var_60_10 = ccui.Button:create("public/button/public_button_off.png", nil, "public/button/public_button_off.png", var_0_21)
		var_60_11 = cc.Label:createWithTTF(L_BUTTON_TEXT.Not_Enough, FONT_BUTTON, 26)
	else
		var_60_10 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y.png", var_0_21)
		var_60_11 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_60_11:setColor(cc.c3b(12, 12, 12))
	var_60_10:setScale9Enabled(true)
	var_60_10:setCapInsets(cc.rect(90, 30, 20, 20))
	var_60_10:setContentSize(cc.size(500, var_60_10:getContentSize().height))
	var_60_10:setPosition(cc.p(var_60_2:getContentSize().width / 2, -80))
	var_60_11:setPosition(cc.p(var_60_10:getContentSize().width / 2, var_60_10:getContentSize().height / 2))
	var_60_10:addChild(var_60_11)
	var_60_2:addChild(var_60_10)
	var_60_10:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_60_1.ShopSliderCallback then
			arg_60_1.ShopSliderCallback(arg_61_0, arg_61_1, function()
				var_60_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_60_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_60_1:setScaleY(0)
	var_60_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_60_0:addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_60_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_60_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	self:initMiniHead(var_60_2, furnituresuit_data[furniture_data[arg_60_1.itemid].suit_id])
end

function DormitoryFixturesLayer:initMiniHead(arg_66_1, arg_66_2)
	if (arg_66_2 and arg_66_2.servantid and major_factor_data[arg_66_2.servantid] and major_factor_data[arg_66_2.servantid].model) == nil then
		return
	end

	if arg_66_1:getChildByName("isShowHaveServant") then
		arg_66_1:getChildByName("isShowHaveServant"):removeFromParent()
	end

	if arg_66_1:getChildByName("mask") then
		arg_66_1:getChildByName("mask"):removeFromParent()
	end

	if arg_66_1:getChildByName("di") then
		arg_66_1:getChildByName("di"):removeFromParent()
	end

	local var_66_2 = cc.p(66, 153)
	local var_66_3 = "roleimage/role1/" .. model_data[var_66_0].cute_role .. ".png"
	local var_66_4

	if config._DEBUG then
		var_66_4 = cc.Sprite:create("public/rolebg/q_avatar_furniture_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_avatar_furniture_mask.png")
	end

	local var_66_5 = cc.Sprite:create(var_66_3)

	var_66_5:setScale(0.28)

	local var_66_6 = cc.ClippingNode:create()

	var_66_6:setInverted(false)
	var_66_6:setAlphaThreshold(0.5)
	var_66_6:setContentSize(cc.size(120, 112))
	var_66_6:setAnchorPoint(cc.p(0, 0))
	var_66_6:setPosition(var_66_2)
	var_66_6:setStencil(var_66_4)
	var_66_6:addChild(var_66_5)
	var_66_5:setPosition(cc.p(-10, 30))

	self.miniHeadNode = var_66_6

	self.miniHeadNode:setName("isShowHaveServant")
	arg_66_1:addChild(var_66_6, 99)

	local var_66_7 = ccui.ImageView:create("public/rolebg/q_avatar_furniture_di.png", var_0_21)

	var_66_7:setName("di")
	var_66_7:setPosition(var_66_2)
	arg_66_1:addChild(var_66_7, 98)
end

function DormitoryFixturesLayer:isShowHaveServant(arg_67_1)
	local var_67_0 = false
	local var_67_1 = {}

	if item_data[arg_67_1] and item_data[arg_67_1].bag_item_type == kITEM_WEAPON then
		table.insert(var_67_1, item_data[arg_67_1].servant)
	elseif item_data[arg_67_1] and item_data[arg_67_1].bag_item_type == kITEM_GIFT_FOR_FRIEND then
		for iter_67_0, iter_67_1 in pairs(servant_data) do
			if iter_67_1.major == item_data[arg_67_1].exclusive then
				table.insert(var_67_1, iter_67_1.id)
			end
		end
	elseif item_data[arg_67_1] and item_data[arg_67_1].bag_item_type == kITEM_FURNITURE_GIFT and furnituresuit_data[item_data[arg_67_1].suit_id] then
		for iter_67_2, iter_67_3 in pairs(servant_data) do
			if iter_67_3.major == furnituresuit_data[item_data[arg_67_1].suit_id].servantid then
				table.insert(var_67_1, iter_67_3.id)
			end
		end
	end

	for iter_67_4, iter_67_5 in pairs(var_67_1) do
		if playermodel.haveServant[iter_67_5] then
			var_67_0 = true

			break
		end
	end

	return var_67_0
end

function DormitoryFixturesLayer:updateItemListData()
	self.itemList = ({
		[ITEMPANEL_TYPE_DORM_FURNITURE] = function()
			local var_69_0 = {}

			for iter_69_0, iter_69_1 in pairs(self.usedItem) do
				if iter_69_1 > 0 then
					table.insert(var_69_0, 1, iter_69_1)
				end
			end

			self.filterTbl.outSide = var_69_0
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			return self.resultList
		end
	})[self.panelType]()

	if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		local var_68_2 = {}

		for iter_68_0, iter_68_1 in pairs(self.filterTbl.filterConfig.type) do
			var_68_2[iter_68_1] = true
		end

		if next(var_68_2) == nil then
			var_68_2[1] = true
			var_68_2[2] = true
			var_68_2[3] = true
			var_68_2[4] = true
			var_68_2[5] = true
		end

		for iter_68_2, iter_68_3 in pairs(playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures) do
			if iter_68_3 > 0 and var_68_2[item_data[iter_68_3].furniture_type] then
				table.insert(self.itemList, 1, iter_68_3)
			end
		end

		local var_68_3 = {}

		for iter_68_4 = 1, 5 do
			if playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures[iter_68_4] ~= self.usedItem[iter_68_4] and self.usedItem[iter_68_4] > 0 then
				table.insert(var_68_3, iter_68_4)
			end
		end

		if next(var_68_3) ~= nil then
			for iter_68_5, iter_68_6 in pairs(var_68_3) do
				if var_68_2[item_data[self.usedItem[iter_68_6]].furniture_type] then
					table.insert(self.itemList, 1, self.usedItem[iter_68_6])
				end
			end
		end
	end

	self.highestQuality = self:getHighestQuality()
end

function DormitoryFixturesLayer:getHighestQuality()
	local var_70_0

	for iter_70_0, iter_70_1 in pairs(self.itemList) do
		local var_70_1 = false

		if playermodel.items[iter_70_1].itemtype == kITEM_COMPONENT then
			if playermodel.items[iter_70_1].component_attr.use then
				var_70_1 = true
			end
		elseif playermodel.items[iter_70_1].itemtype == kITEM_WEAPON and playermodel.items[iter_70_1].weapon_attr.use then
			var_70_1 = true
		end

		if not var_70_1 then
			var_70_0 = math.max(var_70_0 or 1, item_data[playermodel.items[iter_70_1].itemid].equip_quality)
		end
	end

	return var_70_0
end

function DormitoryFixturesLayer:createCell(arg_71_1)
	local var_71_0 = TempWidget:CreateTempLayout()

	var_71_0:setContentSize(cc.size(self.listView:size().w, var_0_29.height))

	local var_71_1 = (var_71_0:size().w - 10 * 2 - var_0_31 * var_0_29.width) / (var_0_31 - 1)

	for iter_71_0 = 1, var_0_31 do
		if self.itemList[(arg_71_1 - 1) * var_0_31 + iter_71_0] then
			local var_71_2 = self:createItem((arg_71_1 - 1) * var_0_31 + iter_71_0, iter_71_0)

			var_71_0:addChild(var_71_2)
			var_71_2:align(cc.p(0, 0.5), 10 + (iter_71_0 - 1) * (var_71_2:size().w + var_71_1), var_71_0:size().h / 2)
		end
	end

	return var_71_0
end

function DormitoryFixturesLayer:createItem(arg_72_1, arg_72_2)
	local var_72_0 = TempWidget:CreateTempLayout()

	var_72_0:setContentSize(var_0_29)

	local var_72_1 = self.itemList[arg_72_1]
	local var_72_3 = playermodel.items[self.itemList[arg_72_1]]
	local var_72_5

	if var_72_3 then
		var_72_5 = item_data[var_72_3.itemid] or item_data[var_72_1]
	end

	local var_72_6 = var_72_5.bag_item_type == kITEM_FURNITURE and var_0_35(var_72_1) or nil
	local var_72_7 = var_72_5.equip_quality or 2
	local var_72_8 = var_0_22 .. string.format("item_bg_off%d.png", var_72_7)
	local var_72_9 = false

	for iter_72_0, iter_72_1 in pairs(self.showItem) do
		if iter_72_1 == var_72_1 then
			var_72_9 = true

			break
		end
	end

	local var_72_10 = TempWidget:CreateTempImg(var_72_8, var_72_0)

	var_72_10:center()

	var_72_10.entityid = var_72_1
	var_72_10.quality = var_72_7

	var_72_10:setName("bg" .. arg_72_2)
	TempWidget:CreateTempLabel("x" .. var_72_6, FONT_W5, 20, var_72_10):align(cc.p(0.5, 0), var_72_10:property().top_bottom)

	local var_72_11 = TempWidget:CreateTempImg(var_0_22 .. "item_select_light.png", var_72_10)

	var_72_11:align(cc.p(0.5, 0), var_72_10:property().top_bottom.x, var_72_10:property().top_bottom.y + 15)
	var_72_11:setVisible(var_72_9)
	var_72_11:setName("lightImg" .. arg_72_2)

	local var_72_13 = TempWidget:CreateTempImg(var_72_9 and var_0_22 .. string.format("item_select_on%d.png", var_72_7) or var_0_22 .. string.format("item_select_off%d.png", var_72_7), var_72_10)

	var_72_13:setName("selectStateImg" .. arg_72_2)

	function var_72_13.pathFormatOn()
		return var_0_22 .. string.format("item_select_on%d.png", var_72_7)
	end

	function var_72_13.pathFormatOff()
		return var_0_22 .. string.format("item_select_off%d.png", var_72_7)
	end

	var_72_13:align(cc.p(0.5, 1), var_72_10:property().top_center)
	performWithDelay(var_72_0, function()
		local var_75_0 = var_0_20:createPurchaseItemByItemid(var_72_1, var_72_6)

		var_75_0:setPosition(var_72_0:property().center.x, var_72_0:property().center.y + 5)
		var_72_0:addChild(var_75_0)
		ui_delegate(var_75_0).numLabel:setVisible(false)

		local var_75_1 = TempWidget:CreateTempImg("public/box/new_item_attr_bg.png")

		var_75_1:setAnchorPoint(cc.p(0, 1))
		var_75_1:setPosition(0, var_75_0:getContentSize().height)
		var_75_1:setName("attr" .. arg_72_2)
		var_75_1:setVisible(self.isShowAttrs)
		var_75_1:setScale9Enabled(true)
		var_75_1:setCapInsets(cc.rect(0, 0, var_75_1:size().w, var_75_1:size().h))
		var_75_1:setContentSize(var_75_0:getContentSize())
		var_75_0:addChild(var_75_1, 99)

		local var_75_2 = var_72_5.intro or "这里没填intro 找振辉！"
		local var_75_3 = math.min(string.utf8len(var_75_2), var_0_33)
		local var_75_4 = utf8.sub(var_75_2, 1, var_75_3)

		if var_75_3 == var_0_33 then
			var_75_4 = var_75_4 .. "..."
		end

		local var_75_5 = TempWidget:CreateTempLabel(var_75_4, FONT_DES, 20)

		var_75_5:setMaxLineWidth(var_75_1:getContentSize().width)
		var_75_5:setLineBreakWithoutSpace(true)
		var_75_5:setColor(cc.c3b(170, 196, 229))
		var_75_5:setAnchorPoint(cc.p(0, 1))
		var_75_5:setPosition(0, var_75_1:getContentSize().height - 5)
		var_75_1:addChild(var_75_5)

		local var_75_6 = TempWidget:CreateTempBtn()

		var_75_6:ignoreContentAdaptWithSize(false)
		var_75_6:setContentSize(var_72_0:size())
		var_75_6:_addEvent(function()
			local var_76_0 = false

			for iter_76_0, iter_76_1 in pairs(self.showItem) do
				if iter_76_1 > 0 and var_72_1 == iter_76_1 then
					if iter_76_0 == 1 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[3])
					else
						var_76_0 = true
						self.showItem[iter_76_0] = -1

						break
					end
				end
			end

			if not var_76_0 then
				self.showItem[item_data[playermodel.items[var_72_1].itemid].furniture_type] = var_72_1
			end

			self:updateAllItemCell()
			self:updatePreviewLayout()
			self:updateBtnVisible()
			self:updateAddText()
		end, {
			touchDelay = 0.1
		})
		var_72_0:addChild(var_75_6)
		var_75_6:align(cc.p(0, 0), 0, 0)
		var_75_6:setSwallowTouches(true)
	end, 0.016666666666666666 * arg_72_2)

	return var_72_0
end

function DormitoryFixturesLayer:updateLayer()
	return
end

function DormitoryFixturesLayer:updateAddText()
	self.addText:setString(string.format(L_ADD_FAVOR_COIN_HOUR, (dormitory_manager:get_furniture_add_favor(self.showItem, self.itemConditions.soulid))))
end

function DormitoryFixturesLayer:updateSuitCell(arg_79_1)
	local var_79_0 = self.listView:getChildren()

	if var_79_0[self.selectSuitIndex] and var_79_0[self.selectSuitIndex]:IsEnter() then
		local var_79_1 = ui_delegate(var_79_0[self.selectSuitIndex])
		local var_79_2 = var_79_1.bg
		local var_79_3 = furnituresuit_data[var_79_1.bg.suitId]

		if self.selectSuitId == var_79_1.bg.suitId then
			var_79_1.stateBg:loadTextureEx(var_0_22 .. "equipment_select.png")
		else
			var_79_1.stateBg:loadTextureEx(var_0_22 .. "normal_select.png")
		end

		self:initMiniHead(var_79_2, var_79_3)
	end
end

function DormitoryFixturesLayer:updateAllSuitCell()
	for iter_80_0 = 1, #self.listView:getChildren() do
		self:updateSuitCell(iter_80_0)
	end
end

function DormitoryFixturesLayer:updateAllItemCell()
	local var_81_0 = self.listView:getChildren()
	local var_81_1 = {}

	for iter_81_0, iter_81_1 in pairs(self.showItem) do
		if iter_81_1 ~= -1 then
			var_81_1[iter_81_1] = 1
		end
	end

	for iter_81_2 = 1, #var_81_0 - 1 do
		if var_81_0[iter_81_2]:IsEnter() then
			local var_81_2 = ui_delegate(var_81_0[iter_81_2])

			for iter_81_3 = 1, var_0_31 do
				if var_81_2["bg" .. iter_81_3] then
					if var_81_1[var_81_2["bg" .. iter_81_3].entityid] then
						var_81_2["selectStateImg" .. iter_81_3]:loadTextureEx(var_81_2["selectStateImg" .. iter_81_3].pathFormatOn())
						var_81_2["lightImg" .. iter_81_3]:show()
					else
						var_81_2["selectStateImg" .. iter_81_3]:loadTextureEx(var_81_2["selectStateImg" .. iter_81_3].pathFormatOff())
						var_81_2["lightImg" .. iter_81_3]:hide()
					end

					var_81_2["attr" .. iter_81_3]:setVisible(self.isShowAttrs)
				end
			end
		end
	end
end

function DormitoryFixturesLayer:updateBtnVisible()
	local var_82_0 = false

	for iter_82_0, iter_82_1 in pairs(self.usedItem) do
		local var_82_1 = false

		for iter_82_2, iter_82_3 in pairs(self.showItem) do
			if iter_82_3 == iter_82_1 then
				var_82_1 = true

				break
			end
		end

		if not var_82_1 then
			var_82_0 = true

			break
		end
	end

	if not var_82_0 then
		self.sureBtn:hide()
		self.restoreBtn:hide()
	else
		self.sureBtn:show()
		self.restoreBtn:show()
	end

	self.filterBtn:setVisible(self.selectType ~= 1)
end

function DormitoryFixturesLayer:isShowRedDot(arg_83_1)
	return false
end

function DormitoryFixturesLayer:showFilterPop()
	local var_84_0 = self.filterListData.col
	local var_84_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_84_0, iter_84_1 in pairs(self.filterListData.btnState) do
				var_84_1[iter_84_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_84_2, iter_84_3 in pairs(self.filterListData.btnState) do
			var_84_1[iter_84_2] = iter_84_3 == 1 and -2 or -1
		end
	end

	if self.filterSpritePop then
		self.filterSpritePop:setFilterBtnState(var_84_0, var_84_1)
		self.filterSpritePop:setSortOrderState(1, self.curSortOrders == 0 and {
			0,
			1
		} or {
			1,
			0
		})
		self.filterSpritePop:updateAllFilterBtn()
		self.filterSpritePop:playPopAni()
	else
		self.filterSpritePop = self:createFilterPop()

		self._root:addChild(self.filterSpritePop, 1000)
	end
end

function DormitoryFixturesLayer:createFilterPop()
	local function var_85_0(arg_87_0)
		if self.filterAniFlag1 then
			self.filterAniFlag1 = false

			self._root:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.filterAniFlag1 = true
				self.filterAniFlag = true
			end)))
			arg_87_0()
		end
	end

	local function var_85_1(arg_89_0)
		self:sortCallback(arg_89_0)
	end

	local var_85_2 = self.filterListData.col or {}
	local var_85_3 = self.filterListData.btnState or {}
	local var_85_4 = {}
	local var_85_5 = false

	for iter_85_0, iter_85_1 in pairs(var_85_3) do
		if iter_85_1 == 1 then
			var_85_5 = true
		end
	end

	for iter_85_2, iter_85_3 in pairs(var_85_3) do
		var_85_4[iter_85_2] = var_85_5 and (iter_85_3 == 1 and -2 or -1) or iter_85_3
	end

	local var_85_7 = FilterSprite:create({
		filterType = self.filterType,
		filterCallback = function(arg_86_0)
			self:filterCallback(arg_86_0)
		end,
		maskTouchCallback = var_85_0,
		sortOrderChangeCallback = var_85_1,
		initButtonConfig = {
			[var_85_2] = var_85_4
		},
		defaultSortOrder = self.curSortOrders == 1 and 0 or 1
	})

	var_85_7:setPositionX(320)
	var_85_7:setPositionY(568)
	var_85_7:moveToTop()

	return var_85_7
end

function DormitoryFixturesLayer:filterCallback(arg_90_1)
	self.filterTbl.sortType = arg_90_1.sortType or self.filterTbl

	for iter_90_0, iter_90_1 in pairs(arg_90_1.filterConfig) do
		self.filterTbl.filterConfig[iter_90_0] = global_deepCopy(iter_90_1)
	end

	self.curSort = self.filterTbl.sortType

	self:updateItemListData()
	self:updateListView()
end

function DormitoryFixturesLayer:sortCallback(arg_91_1)
	self.orderType = arg_91_1
	self.curSortOrders = arg_91_1

	self.bagManager:reverseOrder(self.resultList)
	self:updateShowingCells()
end

function DormitoryFixturesLayer:updateShowingCells(arg_92_1)
	self:updateListView()
end

function DormitoryFixturesLayer:showBachelorFurniturePop(arg_93_1)
	local var_93_0 = ccui.Layout:create()

	var_93_0:setTouchEnabled(true)
	var_93_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_93_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_93_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_93_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_93_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_93_0:setBackGroundColorOpacity(180)
	self:addChild(var_93_0, 10)

	local var_93_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_21)

	var_93_1:setPosition(cc.p(var_93_0:getContentSize().width / 2, var_93_0:getContentSize().height / 2))
	var_93_1:setScaleY(0)
	var_93_1:setScaleY(0)
	var_93_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_93_0:addChild(var_93_1)

	local var_93_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_93_1.itemid .. ".jpg")

	var_93_2:setPosition(cc.p(var_93_0:getContentSize().width / 2, var_93_0:getContentSize().height / 2))
	var_93_0:addChild(var_93_2)

	local var_93_3 = ccui.ImageView:create("MarketLayer/furniture_bg.png", var_0_21)

	var_93_3:setPosition(cc.p(var_93_2:getContentSize().width / 2, var_93_2:getContentSize().height / 2))
	var_93_2:addChild(var_93_3)

	local var_93_4 = string_split(item_data[arg_93_1.itemid].name, "】")

	if #var_93_4 == 2 then
		local var_93_5 = cc.Label:createWithTTF(var_93_4[2], FONT_DES, 26)

		var_93_5:setPosition(cc.p(470, 188))
		var_93_5:setColor(cc.c3b(187, 62, 198))
		var_93_3:addChild(var_93_5)

		local var_93_6 = cc.Label:createWithTTF(var_93_4[2], FONT_DES, 26)

		var_93_6:setPosition(cc.p(472, 188))
		var_93_6:setColor(cc.c3b(0, 168, 255))
		var_93_3:addChild(var_93_6)
	else
		local var_93_7 = cc.Label:createWithTTF(item_data[arg_93_1.itemid].name, FONT_DES, 26)

		var_93_7:setPosition(cc.p(470, 188))
		var_93_7:setColor(cc.c3b(187, 62, 198))
		var_93_3:addChild(var_93_7)

		local var_93_8 = cc.Label:createWithTTF(item_data[arg_93_1.itemid].name, FONT_DES, 26)

		var_93_8:setPosition(cc.p(472, 188))
		var_93_8:setColor(cc.c3b(0, 168, 255))
		var_93_3:addChild(var_93_8)
	end

	local var_93_9 = ccui.ImageView:create(arg_93_1.slidecost.costtype, var_0_21)

	var_93_9:setPositionX(var_93_3:getContentSize().width / 2 - 30)
	var_93_9:setPositionY(-130)
	var_93_3:addChild(var_93_9)

	local var_93_10 = cc.Label:createWithTTF(arg_93_1.slidecost.costnum, FONT_DES, 23)

	var_93_10:setAnchorPoint(cc.p(0, 0.5))
	var_93_10:setPositionX(var_93_9:getPositionX() + var_93_9:getContentSize().width / 2 + 5)
	var_93_10:setPositionY(var_93_9:getPositionY())
	var_93_3:addChild(var_93_10)

	local var_93_11
	local var_93_12

	if arg_93_1.limit_buy_num == 0 then
		var_93_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_21)
		var_93_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_93_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_21)
		var_93_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_93_12:setColor(cc.c3b(12, 12, 12))
	var_93_11:setPosition(cc.p(var_93_3:getContentSize().width / 2, -60))
	var_93_12:setPosition(cc.p(var_93_11:getContentSize().width / 2, var_93_11:getContentSize().height / 2 - 5))
	var_93_11:addChild(var_93_12)
	var_93_3:addChild(var_93_11)
	var_93_2:setScaleY(0)
	var_93_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_93_0:addTouchEventListener(function(arg_94_0, arg_94_1)
		var_93_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_93_0:runAction(cc.RemoveSelf:create())
		end)))
		var_93_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_93_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_93_13 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_21)

	var_93_13:setScale9Enabled(true)
	var_93_13:setCapInsets(cc.rect(0, 0, 10, 10))
	var_93_13:setContentSize(cc.size(640, 45 * (#arg_93_1.couponList + 1) + (#arg_93_1.couponList + 1 - 2) * 12))
	var_93_11:setPositionY(var_93_11:getPositionY() - var_93_13:getContentSize().height + 18)
	var_93_13:setAnchorPoint(cc.p(0.5, 0))
	var_93_13:setPosition(cc.p(282, var_93_11:getPositionY() + 30))
	var_93_3:addChild(var_93_13, 1)
	var_93_9:setPositionY(var_93_9:getPositionY() - var_93_13:getContentSize().height + 18)
	var_93_10:setPositionY(var_93_9:getPositionY())

	self.selectBtnList = {}

	local var_93_14

	for iter_93_0, iter_93_1 in pairs(arg_93_1.couponList) do
		local var_93_15 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_21)

		var_93_15:setPosition(cc.p(var_93_13:getContentSize().width / 2, var_93_13:getContentSize().height - 45 - (var_93_15:getContentSize().height + 12) * (iter_93_0 - 1)))
		var_93_13:addChild(var_93_15)

		local var_93_16 = ccui.ImageView:create("equipment/" .. iter_93_1.id .. ".png")

		var_93_16:setPosition(cc.p(40, 23))
		var_93_16:setScale(0.3)
		var_93_15:addChild(var_93_16)

		local var_93_17 = cc.Label:createWithTTF(iter_93_1.name .. " X" .. item_manager:getItemNumber(iter_93_1.id), FONT_NAME, 20)

		var_93_17:setColor(cc.c3b(188, 206, 226))
		var_93_17:setAnchorPoint(cc.p(0, 0.5))
		var_93_17:setPosition(cc.p(80, 23))
		var_93_15:addChild(var_93_17)

		local var_93_18 = ccui.ImageView:create(arg_93_1.slidecost.costtype, var_0_21)

		var_93_18:setPosition(cc.p(355, 23))
		var_93_15:addChild(var_93_18)

		local var_93_19 = "-" .. iter_93_1.discount1

		if iter_93_1.discount1 == -1 then
			var_93_19 = L_FREE_BUY

			var_93_18:setVisible(false)
		end

		local var_93_20 = cc.Label:createWithTTF(var_93_19, FONT_NAME, 24)

		var_93_20:setColor(cc.c3b(188, 206, 226))
		var_93_20:setPosition(cc.p(400, 23))
		var_93_15:addChild(var_93_20)

		local var_93_21 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_21)

		self.selectBtnList[iter_93_0] = var_93_21

		var_93_21:setPosition(cc.p(444, 22))
		var_93_15:addChild(var_93_21)
		var_93_21:addTouchEventListener(function(arg_97_0, arg_97_1)
			if arg_97_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_93_0)

			var_93_14 = iter_93_1.id

			var_93_10:setString((iter_93_1.discount1 == -1 or nil) and "0")
		end)
	end

	if arg_93_1.couponList[1] then
		self:updateSelectBtn(1)

		var_93_14 = arg_93_1.couponList[1].id

		var_93_10:setString((arg_93_1.couponList[1].discount1 == -1 or nil) and "0")
	end

	var_93_11:addTouchEventListener(function(arg_98_0, arg_98_1)
		if arg_98_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_93_1.ShopSliderCallback then
			arg_93_1.ShopSliderCallback(arg_98_0, arg_98_1, function()
				var_93_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_93_0:runAction(cc.RemoveSelf:create())
				end)))
				var_93_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_93_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_93_14)
		end
	end)
end

function DormitoryFixturesLayer:updateSelectBtn(arg_102_1)
	for iter_102_0, iter_102_1 in pairs(self.selectBtnList) do
		if iter_102_0 == arg_102_1 then
			iter_102_1:loadTextures("public/button/coupon_select.png", "public/button/coupon_select.png", "public/button/coupon_select.png", var_0_21)
		else
			iter_102_1:loadTextures("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_21)
		end
	end
end

return DormitoryFixturesLayer
