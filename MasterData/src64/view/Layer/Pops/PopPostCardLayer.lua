PopPostCardLayer = class("PopPostCardLayer", function()
	return PopBaseLayer:create()
end)

local item_data = require("data.item_data")
local time_check_manager = require("controller.time_check_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_6 = 8000900

function PopPostCardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPostCardLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPostCardLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopPostCardLayer.initData(arg_4_0, arg_4_1)
	arg_4_0.curCardId = 0
	arg_4_0.cards = {}
	arg_4_0.selectCard = nil
	arg_4_0.curPanelCard = nil
end

function PopPostCardLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopPostCardLayer.json" or "PopPostCardLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self.panelMain:setPositionY(self.panelMain:getPositionY() + 60)

	self.btnConfirm = self.panelMain:getChildByName("btnConfirm")
	self.listViewCards = self.panelMain:getChildByName("listViewCards")

	self.listViewCards:setItemModel(self.listViewCards:getChildByName("panelCard"))
end

function PopPostCardLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addClickEventListener(self.btnConfirm, handler(self, self.onBtnConfirm))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_VISIT_CARD_INFO, handler(self, self.handleGetVisitcardInfo))
	EventManager:subscribe(self, EventManager.EVENT_IDS.SET_VISITCARD, handler(self, self.handleSetVisitcard))
end

function PopPostCardLayer:updateLayout()
	self.listViewCards:removeAllChildren()

	for iter_7_0, iter_7_1 in ipairs(self.cards) do
		self.listViewCards:pushBackDefaultItem()

		local var_7_0 = self.listViewCards:getItem(iter_7_0 - 1)
		local var_7_1 = var_7_0:getChildByName("imgSelect")
		local var_7_2 = var_7_0:getChildByName("imgCard")
		local var_7_3 = var_7_0:getChildByName("labelName")
		local var_7_4 = var_7_0:getChildByName("labelTime")

		var_7_1:setVisible(self.curCardId == iter_7_1.id or self.curCardId % var_0_6 == iter_7_1.id % var_0_6)

		if self.curCardId == iter_7_1.id or self.curCardId % var_0_6 == iter_7_1.id % var_0_6 then
			self.curPanelCard = var_7_0
			self.selectCard = iter_7_1
		end

		if not item_data[iter_7_1.id] then
			print("error: postcard id isn`t itemid, ", iter_7_1.id)
		else
			var_7_3:setString(item_data[iter_7_1.id].name)
		end

		if iter_7_1.id == 0 then
			iter_7_1.id = nil
		end

		local var_7_5

		if iter_7_1.id then
			var_7_5 = iter_7_1.id % var_0_6 or 0
		end

		var_7_2:loadTexture("mainScenebg/hagaki/card_" .. var_7_5 .. ".png")

		local var_7_6 = math.max(0, iter_7_1.time - time_check_manager:getCurTime())

		var_7_4:setString("剩余时间：" .. Utility:formatTimeStr(var_7_6))

		if var_7_5 == 0 then
			var_7_4:setString("")
		end

		if var_7_5 ~= 0 then
			var_7_3:runAction((Utility:createClockTimerAction(var_7_4, 1, var_7_6, function(arg_8_0)
				if arg_8_0 == 0 then
					var_7_4:setString("已过期")
				else
					var_7_4:setString("剩余时间：" .. Utility:formatTimeStr(arg_8_0))
				end
			end)))
		end

		Utility:addClickEventListener(var_7_0, handler(self, self.onPanelCard), iter_7_1)
	end
end

function PopPostCardLayer:onPanelCard(arg_9_1, arg_9_2)
	if arg_9_1 == self.curPanelCard then
		return
	end

	if self.curPanelCard then
		self.curPanelCard:getChildByName("imgSelect"):setVisible(false)
	end

	self.curPanelCard = arg_9_1
	self.selectCard = arg_9_2

	self.curPanelCard:getChildByName("imgSelect"):setVisible(true)
end

function PopPostCardLayer:onBtnConfirm()
	if not next(self.cards) or self.curCardId % var_0_6 == self.selectCard.id % var_0_6 then
		self:hide()

		return
	end

	if self.isRequesting then
		return
	end

	if self.selectCard then
		self.isRequesting = true

		EventManager:requestSetVisitCard((self.selectCard.id % var_0_6 == 0 or nil) and nil)
	else
		LayerManager:pushInLayer("PopFriendIntroduceLayer", {})
	end
end

function PopPostCardLayer.onEnter(arg_11_0)
	EventManager:requestGetVisitcardInfo()
end

function PopPostCardLayer.onExit(arg_12_0)
	EventManager:unsubscribe(arg_12_0)
end

function PopPostCardLayer:show()
	self.showActions.extendVertical(self)
end

function PopPostCardLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopPostCardLayer:handleGetVisitcardInfo(arg_16_1)
	if not arg_16_1 then
		return
	end

	if arg_16_1 and arg_16_1.result == 1 then
		self.curCardId = arg_16_1.inuse or 0
		self.cards = arg_16_1.list or {}

		local var_16_0 = false

		for iter_16_0, iter_16_1 in ipairs(self.cards) do
			if iter_16_1.id % var_0_6 == 0 then
				var_16_0 = true
			end
		end

		if not var_16_0 then
			table.insert(self.cards, 1, {
				time = 0,
				id = var_0_6
			})
		end

		Utility:sortByProps(self.cards, {
			"id"
		})
		self:updateLayout()
	elseif arg_16_1 and arg_16_1.result == 2 then
		-- block empty
	end
end

function PopPostCardLayer.handleSetVisitcard(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_0.isRequesting = false

	if arg_17_1 and arg_17_1.result == 1 then
		EventManager:requestGetVisitcardInfo()
		LayerManager:pushInLayer("PopFriendIntroduceLayer", {})
	elseif arg_17_1 and arg_17_1.result == 2 then
		global_ShowBlockWords("名片框已过期")
	end
end
