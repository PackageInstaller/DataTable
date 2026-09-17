PopGameCompoundLayer = class("PopGameCompoundLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.ItemSpriteActivityRecharge")

local lab_manager = require("controller.lab_manager")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_6 = {
	LABORATORY = 1,
	PLANT = 2,
	UNKNOWN = 0
}
local var_0_7 = config._DEBUG and 0 or 1

function PopGameCompoundLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGameCompoundLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGameCompoundLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopGameCompoundLayer:initData(arg_4_1)
	self.itemId = arg_4_1 and arg_4_1.itemId
	self.mainNeed = arg_4_1 and arg_4_1.mainNeed
	self.backSysId = arg_4_1.backSysId
	self.panelItems = {}
	self.nodeItems = {}
	self.lackItems = {}
	self.nodeLines = {}
	self.curPanelItem = nil
	self.curComposeInfo = nil
	self.isRequesting = false
	self.curNeed = 0
	self.isPlaying = false
	self.canCompose = false
	self.composeType = var_0_6.UNKNOWN

	print("current need itemid is", self.itemId)
end

function PopGameCompoundLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopGameCompoundLayer.json" or "PopGameCompoundLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self.panelMain:setPositionY(self.panelMain:getPositionY() + GameDisplay.fix_y - 40)

	self.imgBg = self.panelMain:getChildByName("imgBg")
	self.panelBottom = self.panelMain:getChildByName("panelBottom")
	self.btnCompose = self.panelBottom:getChildByName("btnCompose")
	self.labelGold = Utility:seekChildByName(self.panelBottom, "labelGold")
	self.labelEnergy = Utility:seekChildByName(self.panelBottom, "labelEnergy")
	self.panelMiddle = self.panelMain:getChildByName("panelMiddle")
	self.nodeMaterial = self.panelMiddle:getChildByName("nodeMainItem")

	self.nodeMaterial:setPositionY(self.nodeMaterial:getPositionY() + 25)
	self.nodeMaterial:retain()
	self.nodeMaterial:removeFromParent()

	self.listViewInfos = self.panelMain:getChildByName("listViewInfos")
	self.nodeGainInfos = self.listViewInfos:getChildByName("nodeGainInfo")

	self.nodeGainInfos:retain()
	self.nodeGainInfos:removeFromParent()
end

function PopGameCompoundLayer:initGainBtn()
	self.btnGain = ccui.Button:create("public/button/button_saying.png", nil, "public/button/button_saying.png", var_0_7)

	self.btnGain:setPosition(cc.p(320, 300))
	self.btnGain:setName("btnGain")
	self.panelMiddle:addChild(self.btnGain)
	self.btnGain:setVisible(true)
	self.btnGain:addTouchEventListener(function(arg_7_0, arg_7_1)
		local var_7_0

		if arg_7_1 ~= ccui.TouchEventType.ended then
			do return end

			var_7_0 = {
				item = self.curPanelItem.id,
				goto_back_system_id = self.backSysId
			}
		end

		var_7_0.layer = cc.Layer:create()

		LayerManager:pushInLayer("PopGoGainLayer", var_7_0)
	end)
end

function PopGameCompoundLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootpanel, handler(self, self.hide))
	Utility:addClickEventListener(self.btnCompose, handler(self, self.onBtnCompose))
	EventManager:subscribe(self, EventManager.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleCompoundItemOneKey))
end

function PopGameCompoundLayer:initListView()
	self.listViewLeft = self.panelMain:getChildByName("listViewLeft")

	self.listViewLeft:setBounceEnabled(false)

	self.panelItem = self.listViewLeft:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
	self:createOnePanelItem(self.itemId, self.mainNeed)
end

function PopGameCompoundLayer:createOnePanelItem(arg_10_1, arg_10_2)
	local var_10_0 = Utility:indexOf(self.panelItems, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)

	if var_10_0 > 0 then
		self.panelItems[var_10_0].needCount = arg_10_2

		return
	end

	local var_10_1 = self.panelItem:clone()
	local var_10_2 = var_10_1:getChildByName("imgBorder")
	local var_10_3 = var_10_1:getChildByName("imgItem")
	local var_10_4 = var_10_1:getChildByName("imgArrowRight")
	local var_10_5 = var_10_1:getChildByName("imgArrowDown")
	local var_10_6 = ItemSpriteActivityRecharge:createSignItem(arg_10_1)

	Utility:replaceNodeByNode(var_10_1, "imgItem", var_10_6)
	var_10_6:setNumBgVisible(false)
	var_10_1:setTouchEnabled(true)

	var_10_1.id = arg_10_1
	var_10_1.needCount = arg_10_2

	self.listViewLeft:pushBackCustomItem(var_10_1)
	Utility:addClickEventListener(var_10_1, handler(self, self.onPanelItem))

	self.panelItems[#self.panelItems + 1] = var_10_1

	self:updatePanelItem(var_10_1, true)
end

function PopGameCompoundLayer:onPanelItem(arg_12_1)
	if arg_12_1 == self.curPanelItem then
		return
	end

	self.curNeed = arg_12_1.needCount

	self:updatePanelItem(self.curPanelItem, false)

	self.curPanelItem = arg_12_1

	self:updatePanelItem(self.curPanelItem, true)
	self:updateComposeInfo()
	self:updateMiddlePanel()
	self:updateBottom()
end

function PopGameCompoundLayer:updatePanelItem(arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	local var_13_0 = Utility:indexOf(self.panelItems, arg_13_1)

	if var_13_0 < 0 then
		return
	end

	arg_13_1:getChildByName("imgArrowRight"):setVisible(arg_13_2)
	arg_13_1:getChildByName("imgArrowDown"):setVisible(var_13_0 ~= #self.panelItems)
	arg_13_1:getChildByName("imgBorder"):setVisible(arg_13_2)
end

function PopGameCompoundLayer:updateMiddlePanel()
	if not self.nodeMainItem then
		self.nodeMainItem = self:createMaterialItem(self.curPanelItem.id, true)

		local var_14_0 = self:createDecomposeSpine(true, self.nodeMainItem)
	else
		self:updateMaterialItem(self.nodeMainItem, self.curPanelItem.id, true)
	end

	local var_14_1 = self.curComposeInfo.materials or {}

	for iter_14_0 = #var_14_1, #self.nodeItems do
		if self.nodeItems[iter_14_0] then
			self.nodeItems[iter_14_0]:setVisible(false)
		end
	end

	self.nodeItems = {}
	self.lackItems = {}

	for iter_14_1, iter_14_2 in ipairs(var_14_1) do
		local var_14_2 = self.panelMiddle:getChildByName("nodeItem_" .. iter_14_1)

		if not var_14_2 then
			var_14_2 = self:createMaterialItem(iter_14_2.itemId, false, iter_14_1)

			local var_14_3 = self:createDecomposeSpine(false, var_14_2)
		else
			self:updateMaterialItem(var_14_2, iter_14_2.itemId, false)
		end

		var_14_2:setVisible(true)
		self:updateMaterialPositions(var_14_2, iter_14_1, #var_14_1)

		self.nodeItems[#self.nodeItems + 1] = var_14_2
	end

	self:updateComposePath()

	if #var_14_1 == 0 then
		self:showGainInfos()
		self.btnGain:setVisible(false)
	else
		self:hideGainInfos()
		self.btnGain:setVisible(true)
	end
end

function PopGameCompoundLayer:getMaterialCountById(arg_15_1)
	if not self.curComposeInfo.materials then
		return 0
	end

	for iter_15_0, iter_15_1 in ipairs(self.curComposeInfo.materials) do
		if iter_15_1.itemId == arg_15_1 then
			return iter_15_1.itemNum
		end
	end

	return 0
end

function PopGameCompoundLayer.getComposeInfoById(arg_16_0, arg_16_1)
	return lab_manager:getComposeDataById(arg_16_1)
end

function PopGameCompoundLayer:createMaterialItem(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self.nodeMaterial:clone()

	Utility:addClickEventListener(var_17_0, handler(self, self.onMaterialItem), arg_17_2)
	self:updateMaterialItem(var_17_0, arg_17_1, arg_17_2)
	self.panelMiddle:addChild(var_17_0)

	if arg_17_3 then
		var_17_0:setName("nodeItem_" .. arg_17_3)
	end

	return var_17_0
end

function PopGameCompoundLayer:updateMaterialPositions(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1:getContentSize()
	local var_18_1 = self.nodeMainItem:getPositionX()

	arg_18_1:setPositionX((self.panelMiddle:getContentSize().width - ((arg_18_3 - 1) * 50 + arg_18_3 * var_18_0.width)) / 2 + (arg_18_2 - 1) * (var_18_0.width + 50))
	arg_18_1:setPositionY(self.nodeMainItem:getPositionY() - 30 - 180)
end

function PopGameCompoundLayer:updateMaterialItem(arg_19_1, arg_19_2, arg_19_3)
	arg_19_1.id = arg_19_2

	local var_19_0 = ItemSpriteActivityRecharge:createSignItem(arg_19_2)

	Utility:replaceNodeByNode(arg_19_1, "imgItem", var_19_0)
	var_19_0:setName("imgItem")
	var_19_0:setScale(1.2)

	local var_19_1 = arg_19_1:getChildByName("labelNeed")
	local var_19_2 = arg_19_1:getChildByName("labelOwn")
	local var_19_3 = Utility:getItemById(arg_19_2).count
	local var_19_4 = self:getMaterialCountById(arg_19_2)

	if arg_19_3 and arg_19_2 == self.itemId then
		var_19_4 = self.mainNeed
	elseif arg_19_3 then
		var_19_4 = self.curNeed
	end

	arg_19_1.needCount = var_19_4

	var_19_2:setString("" .. var_19_3)
	var_19_1:setString("/" .. var_19_4)

	if var_19_3 < var_19_4 then
		var_19_2:setColor(cc.c3b(255, 223, 155))

		self.lackItems[#self.lackItems + 1] = {
			isLack = true,
			id = arg_19_2
		}
	else
		var_19_2:setColor(cc.c3b(255, 255, 255))

		self.lackItems[#self.lackItems + 1] = {
			isLack = false,
			id = arg_19_2
		}
	end

	var_19_0:setNumBgVisible(not arg_19_3)
	var_19_2:setVisible(arg_19_3)
	var_19_1:setVisible(arg_19_3)

	if arg_19_3 then
		local var_19_5 = var_19_2:getContentSize().width + (arg_19_1:getContentSize().width - (var_19_2:getContentSize().width + var_19_1:getContentSize().width)) / 2

		if not arg_19_3 then
			var_19_2:setLocalZOrder(3)
			var_19_1:setLocalZOrder(3)
			var_19_2:setPosition(var_19_5 + 18, 12)
			var_19_1:setPosition(var_19_5 + 18, 12)
		else
			var_19_2:setPositionX(var_19_5)
			var_19_1:setPositionX(var_19_5)
		end
	else
		var_19_0:setItemNum(var_19_3, var_19_4)
	end
end

function PopGameCompoundLayer:updateComposePath()
	local var_20_0 = self.panelMiddle:getContentSize()
	local var_20_1 = self.nodeMainItem:getPositionX()
	local var_20_2 = self.nodeMainItem:getPositionY() - 30
	local var_20_4 = 36
	local var_20_5 = 8
	local var_20_6 = (self.nodeMainItem:getContentSize().width - 8) / 2

	for iter_20_0, iter_20_1 in ipairs(self.nodeLines) do
		iter_20_1:removeFromParent()
	end

	self.nodeLines = {}

	if #self.nodeItems == 0 then
		return
	end

	local var_20_7 = #self.nodeItems

	if #self.nodeItems == 1 then
		local var_20_8 = self:createComposePath(true, var_20_4 * 2, self.lackItems[1].isLack, false)

		var_20_8:setPosition(var_20_1 + var_20_6, var_20_2)
		self.panelMiddle:addChild(var_20_8)

		self.nodeLines[#self.nodeLines + 1] = var_20_8

		return
	end

	local var_20_9 = self:createComposePath(true, var_20_4, not self:queryPathStatus(0, true))

	var_20_9:setPosition(var_20_1 + var_20_6, var_20_2)
	self.panelMiddle:addChild(var_20_9)
	var_20_9:setLocalZOrder(2)

	self.nodeLines[#self.nodeLines + 1] = var_20_9

	local function var_20_10(arg_21_0, arg_21_1)
		if arg_21_1 % 2 == 0 then
			return arg_21_0 == math.round(arg_21_1 / 2) or arg_21_0 == math.round(arg_21_1 / 2) + 1
		else
			return false
		end
	end

	local var_20_11 = self.nodeItems[2]:getPositionX() - self.nodeItems[1]:getPositionX() + 0
	local var_20_12 = self.nodeItems[1]:getPositionX() + var_20_6

	for iter_20_2, iter_20_3 in ipairs(self.nodeItems) do
		if var_20_7 % 2 == 1 and iter_20_2 == math.floor((var_20_7 + 1) / 2) then
			local var_20_13 = self:createComposePath(true, var_20_4, self.lackItems[iter_20_2].isLack)

			var_20_13:setPosition(var_20_1 + var_20_6, var_20_2 - var_20_4)
			self.panelMiddle:addChild(var_20_13)

			self.nodeLines[#self.nodeLines + 1] = var_20_13
		else
			local var_20_14 = iter_20_3:getPositionX()
			local var_20_15 = iter_20_3:getPositionY()
			local var_20_16 = iter_20_2 > var_20_7 / 2
			local var_20_17 = self:createComposePath(false, var_20_11 / (var_20_10(iter_20_2, var_20_7) and 2 or 1) + (iter_20_2 > var_20_7 / 2 and 7 or 8), self.lackItems[iter_20_2].isLack, iter_20_2 > var_20_7 / 2)

			var_20_17:setPosition(var_20_14 + var_20_6 + (iter_20_2 > var_20_7 / 2 and var_20_5 or 0), var_20_2 - var_20_4)
			self.panelMiddle:addChild(var_20_17)

			self.nodeLines[#self.nodeLines + 1] = var_20_17

			if not self.lackItems[iter_20_2].isLack then
				var_20_17:setZOrder(1)
			end

			local var_20_18 = self:createComposePath(true, var_20_4, self.lackItems[iter_20_2].isLack, var_20_16)

			self.panelMiddle:addChild(var_20_18)
			var_20_18:setPosition(var_20_14 + var_20_6, var_20_2 - var_20_4)

			self.nodeLines[#self.nodeLines + 1] = var_20_18
		end
	end
end

function PopGameCompoundLayer:queryPathStatus(arg_22_1, arg_22_2)
	if arg_22_2 then
		local var_22_0 = 0

		for iter_22_0, iter_22_1 in ipairs(self.lackItems) do
			if not iter_22_1.isLack then
				var_22_0 = var_22_0 + 1
			end
		end

		return var_22_0 > 0
	end
end

function PopGameCompoundLayer.createComposePath(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = ccui.ImageView:create(arg_23_3 and "gamecompound/bar_1.png" or "gamecompound/bar_2.png", var_0_7)

	var_23_0:ignoreContentAdaptWithSize(false)

	if not arg_23_1 and arg_23_4 then
		var_23_0:setAnchorPoint(1, 0)
	else
		var_23_0:setAnchorPoint(0, 0)
	end

	var_23_0:setContentSize(cc.size(arg_23_2, 8))

	if arg_23_1 then
		var_23_0:setRotation(90)
	end

	return var_23_0
end

function PopGameCompoundLayer:onMaterialItem(arg_24_1, arg_24_2)
	if arg_24_2 then
		if #self.nodeItems == 0 then
			return
		end

		;({
			item = arg_24_1.id,
			goto_back_system_id = self.backSysId
		}).layer = cc.Layer:create()

		return
	end

	self.curNeed = arg_24_1.needCount

	local var_24_0 = self:querySameLevel(arg_24_1.id)

	if var_24_0 > -1 then
		self.panelItems[var_24_0].id = arg_24_1.id

		Utility:replaceNodeByNode(self.panelItems[var_24_0], "imgItem", (ItemSpriteActivityRecharge:createSignItem(arg_24_1.id)))

		for iter_24_0 = #self.panelItems, var_24_0 + 1, -1 do
			self.panelItems[iter_24_0]:removeFromParent()
			table.remove(self.panelItems, iter_24_0)
		end
	else
		self:createOnePanelItem(arg_24_1.id, arg_24_1.needCount)
	end

	self:updatePanelItem(self.panelItems[#self.panelItems - 1], false)
	self:onPanelItem(self.panelItems[Utility:indexOf(self.panelItems, function(arg_25_0)
		return arg_25_0.id == arg_24_1.id
	end)])
end

function PopGameCompoundLayer:updateComposeInfo()
	local var_26_0 = self:getComposeInfoById(self.curPanelItem.id) or {}

	if var_26_0.research then
		self.curComposeInfo = var_26_0.research
		self.composeType = var_0_6.LABORATORY

		return
	end

	if var_26_0.recipe then
		self.curComposeInfo = var_26_0.recipe
		self.composeType = var_0_6.PLANT

		return
	end

	self.curComposeInfo = {}
	self.composeType = var_0_6.UNKNOWN
end

function PopGameCompoundLayer:updateBottom()
	if self.composeType == var_0_6.UNKNOWN then
		self.panelBottom:setVisible(false)

		return
	end

	local var_27_0 = self.curComposeInfo.gold
	local var_27_1 = self.curComposeInfo.power
	local var_27_2 = item_manager:getItemNumber(ELECTRIC)

	self:setLabel(self.labelGold, global_trans_number(self.curComposeInfo.gold), self.curComposeInfo.gold <= playermodel.gold)
	self:setLabel(self.labelEnergy, global_trans_number(var_27_1), var_27_1 <= var_27_2)

	if var_27_1 == 0 then
		self.labelGold:getParent():setPositionX(150)
	else
		self.labelGold:getParent():setPositionX(54)
	end

	if var_27_0 == 0 then
		self.labelEnergy:getParent():setPositionX(150)
	else
		self.labelEnergy:getParent():setPositionX(245)
	end

	self.labelGold:getParent():setVisible(var_27_0 > 0)
	self.labelEnergy:getParent():setVisible(var_27_1 > 0)

	if self.curComposeInfo and next(self.curComposeInfo) then
		if not self.labelUnlock then
			self.labelUnlock = cc.Label:create()

			self.labelUnlock:setTTFConfig({
				fontSize = 24,
				distanceFieldEnabled = false,
				outlineSize = 0,
				glyphs = 1,
				fontFilePath = "fonts/newkj.ttf",
				customGlyphs = ""
			})
			self.labelUnlock:setColor(cc.c3b(200, 0, 0))
			self.labelUnlock:setString("所需材料合成路径尚未解锁")
			self.labelUnlock:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			self.labelUnlock:setAnchorPoint(0.5, 0.5)
			self.labelUnlock:setPosition(self.panelBottom:getContentSize().width / 2, self.btnCompose:getPositionY() + 40)
			self.panelBottom:addChild(self.labelUnlock)
		end

		self.labelUnlock:setVisible(not self.curComposeInfo.unlock)

		self.canCompose = self.curComposeInfo.unlock
	end
end

function PopGameCompoundLayer.setLabel(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_1:setString(arg_28_2)

	if not arg_28_3 then
		arg_28_1:setColor(cc.c3b(255, 0, 0))
	else
		arg_28_1:setColor(cc.c3b(255, 255, 255))
	end
end

function PopGameCompoundLayer:updateLayout()
	self:initGainBtn()
	self:initListView()
	self:onPanelItem(self.panelItems[1])
end

function PopGameCompoundLayer:onBtnCompose(arg_30_1)
	if self.isRequesting then
		return
	end

	if not self.canCompose then
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				isHorizonalCenter = true,
				des = string.format("材料未解锁，是否前往%s", self.composeType == var_0_6.LABORATORY and "实验室" or "加工厂"),
				button = L_BATTLEPASS_BUY.button
			},
			surecallback = function()
				Utility:executeLayerJump({
					systemid = self.composeType == var_0_6.LABORATORY and 820 or 810
				}, self.backSysId, nil, nil)
			end
		})

		return
	end

	if playermodel.gold < self.curComposeInfo.gold then
		self:showHandOfMidasLayer()

		return
	end

	if item_manager:getItemNumber(ELECTRIC) < self.curComposeInfo.power then
		self:showAddEnergy()

		return
	end

	if Utility:indexOf(self.lackItems, function(arg_32_0)
		return arg_32_0.isLack
	end) > 0 then
		global_ShowBlockWords("所需材料不足")

		return
	end

	self.isRequesting = true

	EventManager:requestCompoundItemOneKey(self.composeType, self.curComposeInfo.operateId, 1)
end

function PopGameCompoundLayer:onEnter()
	print(self.rootpanel:getPositionY(), self.panelMain:getPositionY())
	lab_manager:queryComposeUnlock(handler(self, self.updateLayout))
end

function PopGameCompoundLayer:onExit()
	if self.panelItem then
		self.panelItem:release()
	end

	self.nodeMaterial:release()
	EventManager:unsubscribe(self)
end

function PopGameCompoundLayer:show()
	self.showActions.extendVertical(self)
end

function PopGameCompoundLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopGameCompoundLayer:handleCompoundItemOneKey(arg_38_1)
	self.isRequesting = false

	if not arg_38_1 then
		return
	end

	if arg_38_1.result == 1 then
		(function()
			({}).items = arg_38_1.items

			for iter_39_0, iter_39_1 in ipairs(arg_38_1.cost_items) do
				item_manager:deleteItem(iter_39_1.entityid, iter_39_1.num)
			end

			playermodel.gold = playermodel.gold - arg_38_1.cost_gold

			for iter_39_2, iter_39_3 in ipairs(arg_38_1.items) do
				item_manager:setItemByServerItem(iter_39_3)
			end

			global_update_gold_stone_diamond(arg_38_1.cost_gold)
			LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY)
			self:updateMiddlePanel()
		end)()
		self:playDecomposeAni()
	elseif arg_38_1.result == 3 then
		print("材料不足")
	elseif arg_38_1.result == 5 then
		print("金币不足")
	end
end

function PopGameCompoundLayer:showGainInfos()
	self.imgBg:loadTexture("gamecompound/bg_2.png", var_0_7)
	self.listViewInfos:setVisible(true)
	self.listViewInfos:removeAllChildren()
	self.listViewInfos:setItemsMargin(15)
	self.panelBottom:setVisible(false)

	for iter_40_0, iter_40_1 in ipairs((Utility:generateGoConfig(self.curPanelItem.id))) do
		local var_40_0 = self.nodeGainInfos:clone()

		var_40_0:getChildByName("labelInfo"):setString(iter_40_1.des)
		Utility:addClickEventListener(var_40_0, handler(self, self.onBtnJump), iter_40_1)
		self.listViewInfos:pushBackCustomItem(var_40_0)
	end
end

function PopGameCompoundLayer:hideGainInfos()
	self.listViewInfos:setVisible(false)
	self.panelBottom:setVisible(true)
	self.imgBg:loadTexture("gamecompound/bg_1.png", var_0_7)
end

function PopGameCompoundLayer:onBtnJump(arg_42_1, arg_42_2)
	print("jump", arg_42_2)
	Utility:executeLayerJump(arg_42_2, self.backSysId, nil, self.curPanelItem.id)
end

function PopGameCompoundLayer.createDecomposeSpine(arg_43_0, arg_43_1, arg_43_2)
	local spinecache_manager = require("controller.spinecache_manager")
	local var_43_1 = L2Skeleton:create(arg_43_1 and "spine/ui/uihechengshang.json" or "spine/ui/uihechengxia.json", arg_43_1 and "spine/ui/uihechengshang.atlas" or "spine/ui/uihechengxia.atlas")

	var_43_1:refreshSkeleton()
	var_43_1:setVisible(false)
	var_43_1:setPosition(arg_43_2:getContentSize().width / 2 + 2, arg_43_2:getContentSize().height / 2 - 6)
	var_43_1:setName("spine")
	var_43_1:setLocalZOrder(2)
	arg_43_2:addChild(var_43_1)

	return var_43_1
end

function PopGameCompoundLayer:playDecomposeAni(arg_44_1)
	self.isPlaying = true

	self:stopAllActions()

	for iter_44_0, iter_44_1 in ipairs(self.nodeItems) do
		iter_44_1:getChildByName("spine"):setVisible(false)
	end

	self.nodeMainItem:getChildByName("spine"):setVisible(false)
	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		for iter_45_0, iter_45_1 in ipairs(self.nodeItems) do
			local var_45_0 = iter_45_1:getChildByName("spine")

			var_45_0:setVisible(true)
			var_45_0:play("animation", false)
		end
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		for iter_46_0, iter_46_1 in ipairs(self.nodeItems) do
			iter_46_1:getChildByName("spine"):setVisible(false)
		end

		local var_46_0 = self.nodeMainItem:getChildByName("spine")

		var_46_0:setVisible(true)
		var_46_0:play("animation", false)
	end), cc.DelayTime:create(0.8), cc.CallFunc:create(function()
		self.isPlaying = false

		self.nodeMainItem:getChildByName("spine"):setVisible(false)

		if arg_44_1 then
			arg_44_1()
		end
	end)))
end

function PopGameCompoundLayer.showHandOfMidasLayer(arg_48_0)
	LayerManager:pushInLayer("HandOfMidasLayer", {
		callback = function()
			arg_48_0:updateBottom()
		end
	})
end

function PopGameCompoundLayer.showAddEnergy(arg_50_0)
	LayerManager:pushInLayer("PopElectricSupplyLayer", {
		callback = function()
			arg_50_0:updateBottom()
		end
	})
end

function PopGameCompoundLayer:querySameLevel(arg_52_1)
	local var_52_0 = self:getComposeInfoById(self.curPanelItem.id)

	if var_52_0.research then
		for iter_52_0, iter_52_1 in ipairs(var_52_0.research.materials) do
			for iter_52_2, iter_52_3 in ipairs(self.panelItems) do
				if iter_52_3.id == iter_52_1.itemId and iter_52_3.id ~= arg_52_1 then
					return iter_52_2
				end
			end
		end

		return -1
	end

	if var_52_0.recipe then
		for iter_52_4, iter_52_5 in ipairs(var_52_0.recipe.materials) do
			for iter_52_6, iter_52_7 in ipairs(self.panelItems) do
				if iter_52_7.id == iter_52_5.itemId and iter_52_7.id ~= arg_52_1 then
					return iter_52_6
				end
			end
		end

		return -1
	end

	return -1
end
