PopDecomposeItemLayer = class("PopDecomposeItemLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local drop_mode_data = require("data.drop_mode_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local LocalEvent = require("common.LocalEvent")
local lab_manager = require("controller.lab_manager")
local var_0_7 = {
	GOLD_NOT_ENOUGH = "图灵新钞不足",
	ITEM_MAX = "没有更多该物品可分解",
	LACK_ITEM = "合成材料不足"
}
local var_0_8 = {
	DECOMPOSE = 1,
	COMPOSE = 2
}

function PopDecomposeItemLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDecomposeItemLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopDecomposeItemLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopDecomposeItemLayer:initData(arg_4_1)
	if arg_4_1 then
		self.itemId = arg_4_1.itemId or nil
	end

	if arg_4_1 then
		self.entityId = arg_4_1.entityId or nil
	end

	if arg_4_1 then
		self.type = arg_4_1.type or nil
	end

	self.operatorInfo = lab_manager:getOperatorInfoById(self.itemId)

	if self.type == var_0_8.DECOMPOSE then
		self.createId = self.operatorInfo.decompose.target
		self.costPer = self.operatorInfo.decompose.cost
		self.createCount = self.operatorInfo.decompose.createCount
		self.curCount = 1
		self.perDiff = 1
		self.min = 1
	elseif self.type == var_0_8.COMPOSE then
		self.createId = self.operatorInfo.compose.target
		self.costPer = self.operatorInfo.compose.cost
		self.needCount = self.operatorInfo.compose.needCount
		self.curCount = self.needCount
		self.perDiff = self.needCount
		self.min = self.needCount
	end

	self.ownCount = Utility:getItemById(self.itemId).count
	self.canDecomposeCount = math.floor(playermodel.gold / self.costPer) * self.perDiff
	self.isRequesting = false
end

function PopDecomposeItemLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopDecomposeItemLayer.json" or "PopDecomposeItemLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.btnMax = Utility:seekChildByName(self.panelMain, "btnMax")
	self.btnMin = Utility:seekChildByName(self.panelMain, "btnMin")
	self.btnAdd = Utility:seekChildByName(self.panelMain, "btnAdd")
	self.btnDec = Utility:seekChildByName(self.panelMain, "btnDec")
	self.btnDecompose = self.panelMain:getChildByName("btnDecompose")
	self.imgCost = self.btnDecompose:getChildByName("imgCost")
	self.labelCost = self.btnDecompose:getChildByName("labelCost")
	self.labelNum = cc.Label:createWithTTF("" .. self.curCount, "fonts/newkj.ttf", 36)

	Utility:replaceNodeByNode(self.panelMain, "labelNum", self.labelNum)

	local var_5_0 = Utility:seekChildByName(self.panelMain, "imgBg")

	if self.type == var_0_8.COMPOSE and var_5_0 then
		var_5_0:loadTexture("decompose/bg_compose.png", config._DEBUG and 0 or 1)
		self.btnDecompose:loadTextures("decompose/btn_confirm_compose.png", "decompose/btn_confirm_compose.png", "decompose/btn_confirm_compose.png", config._DEBUG and 0 or 1)
	end

	self.itemPre = ItemSprite:createNewWithItemId(self.itemId)
	self.itemNext = ItemSprite:createNewWithItemId(self.createId)

	Utility:replaceNodeByNode(self.panelMain, "imgPre", self.itemPre)
	Utility:replaceNodeByNode(self.panelMain, "imgNext", self.itemNext)

	self.btnPre = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, config._DEBUG and 0 or 1)

	self.btnPre:setContentSize(self.itemPre:getContentSize())
	self.btnPre:setAnchorPoint(cc.p(0, 0))
	self.itemPre:addChild(self.btnPre)

	self.btnNext = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, config._DEBUG and 0 or 1)

	self.btnNext:setContentSize(self.itemNext:getContentSize())
	self.btnNext:setAnchorPoint(cc.p(0, 0))
	self.itemNext:addChild(self.btnNext)

	local var_5_1 = ccui.ImageView:create("decompose/arrow.png", config._DEBUG and 0 or 1)

	var_5_1:setPosition(cc.p(self.panelMain:getContentSize().width / 2, self.itemPre:getPositionY()))
	self.panelMain:addChild(var_5_1)
	self:updateLayout()
end

function PopDecomposeItemLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addLastTouchEventListener(self.btnAdd, 0.2, 0.1, function()
		self:onBtnChangeNum(self.btnAdd, self.perDiff)
	end, {
		ended = function()
			self:onBtnChangeNum(self.btnAdd, self.perDiff)
		end
	})
	Utility:addLastTouchEventListener(self.btnDec, 0.2, 0.1, function()
		self:onBtnChangeNum(self.btnDec, -self.perDiff)
	end, {
		ended = function()
			self:onBtnChangeNum(self.btnDec, -self.perDiff)
		end
	})
	Utility:addClickEventListener(self.btnMax, handler(self, self.onBtnSetCount), 1)
	Utility:addClickEventListener(self.btnMin, handler(self, self.onBtnSetCount), -1)
	Utility:addClickEventListener(self.btnDecompose, handler(self, self.onBtnDecompose))
	Utility:addClickEventListener(self.btnPre, function()
		LayerManager:pushInLayer("PopItemLayer", {
			itemid = self.itemId
		})
	end)
	Utility:addClickEventListener(self.btnNext, function()
		LayerManager:pushInLayer("PopItemLayer", {
			itemid = self.createId
		})
	end)
	EventManager:subscribe(self, EventManager.EVENT_IDS.DECOMPOSE_ITEMS, handler(self, self.handleDecomposeItems))
end

function PopDecomposeItemLayer.onEnter(arg_13_0)
	return
end

function PopDecomposeItemLayer.onExit(arg_14_0)
	EventManager:unsubscribe(arg_14_0)
end

function PopDecomposeItemLayer:show()
	self.showActions.extendVertical(self)
end

function PopDecomposeItemLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopDecomposeItemLayer:onBtnChangeNum(arg_18_1, arg_18_2)
	if self.curCount + arg_18_2 > self.ownCount then
		self:showLackItem()
		arg_18_1:stopAllActions()
	elseif self.curCount + arg_18_2 > self.canDecomposeCount then
		self:showHandOfMidasLayer()
		arg_18_1:stopAllActions()
	end

	if self.curCount + arg_18_2 <= self.min then
		arg_18_1:stopAllActions()
	end

	self.curCount = Utility:clamp(self.curCount + arg_18_2, self.min, math.max(self.min, math.min(self.canDecomposeCount, self.ownCount)))

	if self.type == var_0_8.COMPOSE then
		self.curCount = math.floor(self.curCount / self.needCount) * self.needCount
	end

	self:updateLayout()
end

function PopDecomposeItemLayer:onBtnSetCount(arg_19_1, arg_19_2)
	if arg_19_2 == 1 then
		self.curCount = math.max(self.min, math.min(self.canDecomposeCount, self.ownCount))

		if self.type == var_0_8.COMPOSE then
			self.curCount = math.floor(self.curCount / self.needCount) * self.needCount
		end
	elseif arg_19_2 == -1 then
		self.curCount = self.min
	end

	self:updateLayout()
end

function PopDecomposeItemLayer:updateLayout()
	self.labelNum:setString(self.curCount .. "")

	local var_20_0 = false

	if self.type == var_0_8.COMPOSE then
		if self.curCount > self.ownCount then
			self.labelNum:setString("0")
			self.labelNum:setColor(cc.c3b(255, 0, 0))

			var_20_0 = true
		else
			self.labelNum:setString(math.floor(self.curCount / self.needCount) .. "")
			self.labelNum:setColor(cc.c3b(255, 255, 255))
		end
	end

	if var_20_0 then
		self.itemPre:setItemCount(self.ownCount, cc.c3b(255, 0, 0))
	else
		self.itemPre:setItemCount(self.curCount)
	end

	local var_20_1 = 0

	if self.type == var_0_8.DECOMPOSE then
		self.itemNext:setItemCount(self.curCount * self.createCount)

		var_20_1 = self.curCount * self.costPer
	elseif self.type == var_0_8.COMPOSE then
		if var_20_0 then
			self.itemNext:setItemCount(0, cc.c3b(255, 0, 0))
		else
			self.itemNext:setItemCount(math.floor(self.curCount / self.needCount))
		end

		var_20_1 = math.floor(self.curCount / self.needCount) * self.costPer
	end

	self.labelCost:setString(global_trans_number(var_20_1))

	if var_20_1 > playermodel.gold then
		self.labelCost:setColor(cc.c3b(255, 0, 0))
	else
		self.labelCost:setColor(cc.c3b(255, 255, 255))
	end
end

function PopDecomposeItemLayer:onBtnDecompose(arg_21_1)
	if self.isRequesting then
		return
	end

	if self.curCount > self.ownCount then
		self:showLackItem()

		return
	end

	local var_21_0 = 0
	local var_21_1 = 0

	if self.type == var_0_8.DECOMPOSE then
		var_21_0 = self.curCount * self.costPer
		var_21_1 = self.operatorInfo.decompose.operateId
	elseif self.type == var_0_8.COMPOSE then
		var_21_0 = math.floor(self.curCount / self.needCount) * self.costPer
		var_21_1 = self.operatorInfo.compose.operateId
	end

	if var_21_0 > playermodel.gold then
		self:showHandOfMidasLayer()

		return
	end

	self.isRequesting = true

	EventManager:requestDecomposeItems(var_21_1, (self.type == var_0_8.DECOMPOSE or nil) and (self.curCount or math.floor(self.curCount / self.needCount)))
end

function PopDecomposeItemLayer:handleDecomposeItems(arg_22_1)
	self.isRequesting = false

	if not arg_22_1 then
		return
	end

	if arg_22_1.result == 1 then
		global_gain({
			items = arg_22_1.items
		})

		for iter_22_0, iter_22_1 in ipairs(arg_22_1.cost_items) do
			item_manager:deleteItem(iter_22_1.entityid, iter_22_1.num)
		end

		LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.DECOMPOSE_ITEMS)
		self:updateData(arg_22_1.cost_gold)
		self:hide()
	elseif arg_22_1.result == 3 then
		self:showLackItem()
	elseif arg_22_1.result == 5 then
		self:showHandOfMidasLayer()
	end
end

function PopDecomposeItemLayer.showHandOfMidasLayer(arg_23_0)
	LayerManager:pushInLayer("HandOfMidasLayer", {
		showEnd = function()
			global_ShowBlockWords(var_0_7.GOLD_NOT_ENOUGH)
		end,
		callback = function()
			arg_23_0.canDecomposeCount = math.floor(playermodel.gold / arg_23_0.costPer) * arg_23_0.perDiff
		end
	})
end

function PopDecomposeItemLayer:showLackItem()
	if self.type == var_0_8.DECOMPOSE then
		global_ShowBlockWords(var_0_7.ITEM_MAX)
	else
		global_ShowBlockWords(var_0_7.LACK_ITEM)
	end
end

function PopDecomposeItemLayer:updateData(arg_27_1)
	self.ownCount = Utility:getItemById(self.itemId).count
	playermodel.gold = playermodel.gold - arg_27_1

	global_update_gold_stone_diamond(-arg_27_1, nil, nil)

	self.canDecomposeCount = math.floor(playermodel.gold / self.costPer) * self.perDiff
end
