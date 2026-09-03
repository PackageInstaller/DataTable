-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagMediator.lua

require("dm.gameplay.develop.view.bag.BagItemIconHandler")
require("dm.gameplay.develop.view.bag.BagEquipPancel")
require("dm.gameplay.develop.view.bag.BagTSoulPanel")

BagMediator = class("BagMediator", DmAreaViewMediator, _M)

BagMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BagMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
BagMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local Box_Rarity = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Box_Rarity", "content")
local kBtnHandlers = {
	["mainpanel.equipPanel.nodeDesc.lockBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLock"
	},
	["mainpanel.tsoulPanel.nodeDesc.lockBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTsoulLock"
	},
	["mainpanel.detail_panel.frombtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickFrom"
	},
	["mainpanel.detail_panel.lockBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickItemLock"
	}
}
local kMinItemNum = 20
local kInvalidEntryId = -1
local kColumnNum = 4
local kCellHeight = 155
local kHideItemType = {}
local descHeight = 140
local kTabBtnsNames_model = {
	{
		"bag_UI1",
		"UITitle_EN_Quanbu",
		false,
		"ALL"
	},
	{
		"bag_UI30",
		"UITitle_EN_MiJuan",
		true,
		ItemPages.kCompose
	},
	{
		"bag_UI5",
		"UITitle_EN_Xiaohaopin",
		true,
		ItemPages.kConsumable
	},
	{
		"bag_UI3",
		"UITitle_EN_Cailiao",
		false,
		ItemPages.kStuff
	},
	{
		"bag_UI4",
		"UITitle_EN_Suipian",
		false,
		ItemPages.kFragament
	},
	{
		"bag_UI2",
		"UITitle_EN_Zhuangbei",
		false,
		ItemPages.kEquip
	},
	{
		"TimeSoul_Main_Button_ShiPo",
		"",
		false,
		ItemPages.kTsoul
	},
	{
		"bag_UI24",
		"UITitle_EN_Qita",
		false,
		ItemPages.kOther
	}
}
local kEquipTabBtnsNames = {
	{
		"Equip_Sort_1",
		EquipBagShowType.kAll
	},
	{
		"Equip_Sort_2",
		EquipBagShowType.kWeapon
	},
	{
		"Equip_Sort_3",
		EquipBagShowType.kTops
	},
	{
		"Equip_Sort_4",
		EquipBagShowType.kShoes
	},
	{
		"Equip_Sort_5",
		EquipBagShowType.kDecoration
	}
}
local kTab_button_width = 110
local kTabBtnsNames = {}

function BagMediator:initialize()
	super.initialize(self)
end

function BagMediator:dispose()
	super.dispose(self)
end

function BagMediator:userInject()
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._tSoulSystem = self._developSystem:getTSoulSystem()

	local index = 1

	for i = 1, #kTabBtnsNames_model do
		local canAdd = true

		if i == 2 then
			local result, tip = self._systemKeeper:isUnlock("Bag_Secret")

			canAdd = result == true or self._bagSystem:isHasCompose() == true
		elseif i == 7 then
			local result, tip = self._systemKeeper:isUnlock("Bag_TSoul")

			canAdd = not not (result or self._bagSystem:isHasTSoulItem())
		end

		if canAdd then
			kTabBtnsNames[index] = kTabBtnsNames_model[i]
			index = index + 1
		end
	end

	self._equipType = EquipBagShowType.kAll
	self._onEquipTab = false
end

function BagMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ITEM_LOCK_SUCC, self, self.refreshViewByLock)

	self._composeBtn = self:bindWidget("mainpanel.detail_panel.composebtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onComposeClicked, self)
		}
	})
	self._sellbtn = self:bindWidget("mainpanel.detail_panel.sellbtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onSellClicked, self)
		}
	})
	self._usebtn = self:bindWidget("mainpanel.detail_panel.usebtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onUseClicked, self)
		}
	})
	self.useRedPoint = self:getView():getChildByFullName("mainpanel.detail_panel.usebtn.hongdian")

	self.useRedPoint:setLocalZOrder(10)
	self.useRedPoint:setVisible(false)
end

function BagMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("BAG_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BagMediator:checkBtnIsSwitch()
	local tab = {}

	for k, v in pairs(kTabBtnsNames) do
		if v[4] ~= ItemPages.kCompose then
			tab[#tab + 1] = v
		elseif CommonUtils.GetSwitch("fn_bag_mijuan_btn") then
			tab[#tab + 1] = v
		end
	end

	kTabBtnsNames = tab
end

function BagMediator:enterWithData(data)
	data = data or {}

	self:checkBtnIsSwitch()
	self:setupTopInfoWidget()
	self:initNodes()
	self:createData()
	self:createTabController()
	self:createItemsTableView()
	self:selectTab(data)
	self:createEquipTypeBtn()
	self:refreshEquipTypeBtn()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.dealItemChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SELL_ITEM_SUCC, self, self.dealItemChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BAG_USE_RECHARGEITEM_SUCC, self, self.useRechargeItemSucc)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BagMediator:selectTab(data)
	if not data.showType then
		local tabType = 0

		for k, v in pairs(kTabBtnsNames) do
			tabType = tabType + 1

			if v[4] == data.showType then
				break
			end
		end

		self._showItemType = data.showItemType or ""
		self._curTabType = tabType

		self._tabBtnWidget:selectTabByTag(self._curTabType)
		self._tabBtnWidget:scrollTabPanel(self._curTabType)
	end
end

function BagMediator:resumeWithData(data)
	self:dealItemChange()
end

function BagMediator:createData()
	self._allEntryIds = {}
	self._cannotUseConsumableKindMap = {
		[ComsumableKind.kGoldSell] = true
	}

	self:initAllEntryIds()
end

function BagMediator:getCurItems()
	self._curEntryIds = {}

	local kTabFilterMap = self._bagSystem:getTabFilterMap()
	local filterFunc = kTabFilterMap[kTabBtnsNames[self._curTabType][4]]

	assert(filterFunc ~= nil)

	for _, entryId in ipairs(self._allEntryIds) do
		local entry = self._bagSystem:getEntryById(entryId)
		local isvislble = self._bagSystem:getItemIsVisible(entryId)

		if entry and isvislble and filterFunc(entry.item) and (not kHideItemType[entry.item:getSubType()] or kHideItemType[entry.item:getSubType()] and entry.item:getSubType() == self._showItemType) then
			if self._onEquipTab then
				if entry.item:getPosition() == self._equipType or self._equipType == EquipBagShowType.kAll then
					self._curEntryIds[#self._curEntryIds + 1] = entryId
				end
			else
				self._curEntryIds[#self._curEntryIds + 1] = entryId
			end
		end
	end
end

function BagMediator:assureItemsEnough()
	for i = #self._curEntryIds + 1, kMinItemNum do
		self._curEntryIds[#self._curEntryIds + 1] = kInvalidEntryId
	end
end

function BagMediator:initNodes()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._itemScroll = self._mainPanel:getChildByFullName("cellback")
	self._notHasBackText = self._mainPanel:getChildByFullName("nothasbacktext")

	self._notHasBackText:setVisible(false)
	self._notHasBackText:setLocalZOrder(11)

	self._itemNode = self._itemScroll:getChildByFullName("node")
	self._itemCell = self._itemNode:getChildByFullName("item_cell")

	self._itemCell:setVisible(false)

	self._itemCellTop = self._itemNode:getChildByFullName("cell_top")

	self._itemCellTop:setVisible(false)

	self._indicatorClone = self._itemNode:getChildByFullName("selectimg")
	self._indicator = self._indicatorClone:clone()

	self._indicator:addTo(self._itemNode)

	local equipPanelUI = self._mainPanel:getChildByFullName("equipPanel")

	AdjustUtils.ignorSafeAreaRectForNode(equipPanelUI, AdjustUtils.kAdjustType.Right)

	local equipPanel = BagEquipPancel:new(self, equipPanelUI)

	equipPanel:hide()

	self._equipPanel = equipPanel

	local tsoulPanelUI = self._mainPanel:getChildByFullName("tsoulPanel")

	AdjustUtils.ignorSafeAreaRectForNode(tsoulPanelUI, AdjustUtils.kAdjustType.Right)

	local tsoulPanel = BagTSoulPanel:new(self, tsoulPanelUI)

	tsoulPanel:hide()

	self._tsoulPanel = tsoulPanel
	self.URLevelLimit = self._mainPanel:getChildByFullName("detail_panel.URLevelLimit")

	self.URLevelLimit:setVisible(false)
	self.URLevelLimit:setString("")

	self._equipTabPanel = self._mainPanel:getChildByFullName("equipTabPanel")
	self._node_BuildBtn = self._equipTabPanel:getChildByFullName("Node_buildBtn")
	self._tabBuildBtn = self._equipTabPanel:getChildByFullName("Panel_tabBuildBtn")

	self._tabBuildBtn:setVisible(false)

	self._line_line = self._equipTabPanel:getChildByFullName("line_line")

	local detailPanel = self._mainPanel:getChildByFullName("detail_panel")

	self._lockBtn_compose = detailPanel:getChildByFullName("lockBtn")

	local moneyIcon = detailPanel:getChildByFullName("sellpanel.goldimg")
	local icon = IconFactory:createResourcePic({
		id = CurrencyIdKind.kGold
	})

	icon:addTo(moneyIcon)

	self._detailPanel = detailPanel

	AdjustUtils.ignorSafeAreaRectForNode(detailPanel, AdjustUtils.kAdjustType.Right)

	local csFuncLabel = detailPanel:getChildByFullName("des1label")

	csFuncLabel:setVisible(false)
	csFuncLabel:setString("")
	csFuncLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._notSellLabel = detailPanel:getChildByFullName("tiplabel")

	local size = csFuncLabel:getContentSize()

	size.height = descHeight

	local x, y = csFuncLabel:getPosition()
	local descScrollView = ccui.ScrollView:create()

	descScrollView:setScrollBarEnabled(false)
	descScrollView:setTouchEnabled(true)
	descScrollView:setBounceEnabled(true)
	descScrollView:setDirection(ccui.ScrollViewDir.vertical)
	descScrollView:setContentSize(size)
	descScrollView:setPosition(cc.p(x, y))
	descScrollView:setAnchorPoint(cc.p(0, 1))
	detailPanel:addChild(descScrollView, csFuncLabel:getLocalZOrder())

	local function createLabel()
		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, csFuncLabel:getFontSize())

		label:setDimensions(csFuncLabel:getContentSize().width, 0)
		label:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		label:setAnchorPoint(cc.p(0, 1))
		label:setPosition(cc.p(0, size.height))
		descScrollView:addChild(label, 1)

		return label
	end

	local sepLine = detailPanel:getChildByFullName("sepLine")

	sepLine:setVisible(false)

	local function createLine()
		local spr = sepLine:clone()

		spr:setPosition(0, 0)
		spr:setVisible(false)
		descScrollView:addChild(spr, 2)

		return spr
	end

	self._detailArea = {
		descScrollView = descScrollView,
		iconBg = detailPanel:getChildByFullName("iconpanel"),
		rarity = detailPanel:getChildByFullName("rarity"),
		nameLabel = detailPanel:getChildByFullName("namelabel"),
		nameBackImg = detailPanel:getChildByFullName("nameimg"),
		haveNumLabel = detailPanel:getChildByFullName("numlabel"),
		haveNumLabel1 = detailPanel:getChildByFullName("numlabel1"),
		pieceLabel = detailPanel:getChildByFullName("piece_label"),
		sellLabel = detailPanel:getChildByFullName("sell_label"),
		sepLine = createLine(),
		funcLabel = createLabel(),
		descLabel = createLabel(),
		sellPanel = {
			sellLabel = detailPanel:getChildByFullName("sellpanel.costnamelabel"),
			priceLabel = detailPanel:getChildByFullName("sellpanel.costnumlabel"),
			strLabel = detailPanel:getChildByFullName("sellpanel.str"),
			moneyIcon = detailPanel:getChildByFullName("sellpanel.goldimg")
		},
		buttons = {
			sellBtn = self._sellbtn,
			composeBtn = self._composeBtn,
			useBtn = self._usebtn,
			lockBtn = self._lockBtn_compose,
			fromBtn = detailPanel:getChildByFullName("frombtn")
		}
	}

	self._detailArea.buttons.fromBtn:getChildByFullName("name"):setString(Strings:get("bag_UI22"))

	local detailArea = self._detailArea

	detailArea.nameLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	detailArea.haveNumLabel1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	detailArea.sellPanel.priceLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self:adjustView()
end

function BagMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local scrollview = self._itemScroll:getChildByName("scrollview")

	scrollview:setContentSize(cc.size(572, winSize.height - 63))

	local tabPanel = self:getView():getChildByFullName("tab_panel")
	local w = winSize.width - tabPanel:getContentSize().width - self._detailPanel:getContentSize().width / 2 - (winSize.width - self._detailPanel:getPositionX() - (winSize.width - 1136) / 2)

	self._itemScroll:setPositionX(w / 2 + tabPanel:getPositionX() + tabPanel:getContentSize().width)
end

function BagMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #kTabBtnsNames do
		data[#data + 1] = {
			tabText = Strings:get(kTabBtnsNames[i][1]),
			tabTextTranslate = Strings:get(kTabBtnsNames[i][2]),
			redPointFunc = function()
				if kTabBtnsNames[i][3] == false then
					return false
				end

				local pageType = kTabBtnsNames[i][4]

				return self._bagSystem:getBagTabRedByType(pageType)
			end
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)
	self._tabBtnWidget:refreshAllRedPoint()

	local view = self._tabBtnWidget:getMainView()
	local tabPanel = self:getView():getChildByFullName("tab_panel")

	view:addTo(tabPanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function BagMediator:updateTabArea()
	self._tabBtnWidget:refreshAllRedPoint()
	self:getView():stopAllActions()
	self:getCurItems()
	self:updateItemsArea()

	self._curEntryId = self._curEntryIds[1]

	if self:isEntryIdValid(self._curEntryId) then
		if not self._itemCellMap[self._curEntryId] then
			local curCell

			self._curEntryCell = curCell

			self:selectItem(curCell)
			self:runListAnim()
		end
	end
end

function BagMediator:selectItem(itemCell)
	if itemCell ~= nil then
		local iconHandler = itemCell.handler

		if self._curEntryId ~= iconHandler:getEntryId() then
			-- block empty
		end

		self._curEntryId = iconHandler:getEntryId()

		self:changeIndicator(itemCell)
	else
		self._indicator:setVisible(false)

		self._curEntryId = kInvalidEntryId
	end

	self:refreshView()
end

function BagMediator:refreshView()
	local hasItem = self:isEntryIdValid(self._curEntryIds[1])

	if not hasItem then
		self._notHasBackText:setVisible(true)
		self._line_line:setContentSize(cc.size(3, 1200))
		self._itemScroll:setVisible(false)
		self._detailPanel:setVisible(false)
		self._equipPanel:hide()
		self._tsoulPanel:hide()

		return
	end

	self._notHasBackText:setVisible(false)
	self._line_line:setContentSize(cc.size(3, 578))
	self._itemScroll:setVisible(true)
	self:updateRightPancel()
end

function BagMediator:updateRightPancel()
	local entry = self._bagSystem:getEntryById(self._curEntryId)

	if entry and ItemPages.kEquip == entry.item:getType() and ItemTypes.K_EQUIP_NEW == entry.item:getSubType() then
		self._detailPanel:setVisible(false)
		self._tsoulPanel:hide()
		self._equipPanel:show(entry)
	elseif entry and ItemPages.kTsoul == entry.item:getType() then
		self._detailPanel:setVisible(false)
		self._equipPanel:hide()
		self._tsoulPanel:show(entry)
	else
		self._tsoulPanel:hide()
		self._detailPanel:setVisible(true)
		self._equipPanel:hide()
		self:updateDetailArea()
	end
end

function BagMediator:changeIndicator(itemCell)
	local iconHandler = itemCell.handler
	local cellNode = iconHandler:getCellNode()
	local bar = cellNode:getParent()

	if bar and bar:getParent() then
		bar:getParent():reorderChild(bar, 0)
	end

	if cellNode and cellNode:getParent() then
		cellNode:getParent():reorderChild(cellNode, 0)
	end

	local indicator = self._indicator
	local size = cellNode:getContentSize()

	indicator:setVisible(true)
	indicator:setPosition(size.width / 2, size.height / 2)
	indicator:setLocalZOrder(10)
	indicator:changeParent(cellNode)
	self:stopIndicatorAni()

	self._actIndicator = performWithDelay(self:getView(), function()
		self:stopIndicatorAni()

		if not indicator:isVisible() then
			return
		end

		indicator:runAction(cc.FadeIn:create(0.1))
		indicator:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.95), cc.ScaleTo:create(0.5, 1))))
	end, 0.1)
end

function BagMediator:stopIndicatorAni()
	if self._actIndicator then
		self:getView():stopAction(self._actIndicator)
	end

	self._actIndicator = nil

	self._indicator:stopAllActions()
	self._indicator:setScale(1)
end

function BagMediator:updateDetailArea()
	self:updateDetailBasicArea()
	self:updateDetailButtons()
end

function BagMediator:updateDetailButtons(notHasShow)
	self.useRedPoint:setVisible(false)

	local buttons = self._detailArea.buttons

	for _, button in pairs(buttons) do
		button:setVisible(false)
	end

	if self:isEntryIdValid(self._curEntryId) then
		local entry = self._bagSystem:getEntryById(self._curEntryId)

		if not entry then
			return
		end

		local item = entry.item

		self._currentItem = item

		buttons.sellBtn:setVisible(item:getSellNumber() > 0)
		self:setButtonEnabled(buttons.sellBtn, item:getSellNumber() > 0)
		buttons.useBtn:getButton():setGray(false)
		buttons.useBtn:setVisible(false)
		buttons.lockBtn:setVisible(false)
		buttons.composeBtn:setVisible(false)
		buttons.composeBtn:setButtonName(Strings:get("bag_UI21"), Strings:get("bag_UI21"))

		local subType = item:getSubType()
		local page = item:getType()

		if subType == ItemTypes.K_EQUIP_F then
			buttons.composeBtn:setVisible(true)
			self:setButtonEnabled(buttons.composeBtn, true)
		elseif subType == ItemTypes.K_MASTER_F then
			buttons.useBtn:setVisible(true)
			buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))

			local masterModel = self._masterSystem:getShowMaster(item:getTargetId())

			if masterModel and masterModel:getIsLock() then
				local upid = masterModel:getStarUpItemId()
				local number = self._bagSystem:getItemCount(upid)
				local maxnumber = masterModel:getCompositePay()
				local str = maxnumber <= number and "bag_UI21" or "bag_UI22"
				local str1 = maxnumber <= number and "UITitle_EN_Hecheng" or "UITitle_EN_Laiyuan"

				buttons.useBtn:setButtonName(Strings:get(str), Strings:get(str1))
			end
		elseif subType == ItemTypes.K_COMPOSE then
			buttons.sellBtn:setVisible(false)
			buttons.useBtn:setButtonName(Strings:get("bag_UI31"), Strings:get("UITitle_EN_ZueXi"))
			buttons.useBtn:setVisible(true)
			self:setButtonEnabled(buttons.useBtn, true)

			if self:checkCanUseCompose(item) == false then
				buttons.useBtn:setButtonName(Strings:get("bag_Compose_UI_1"), Strings:get("bag_Compose_UI_1_EN"))
			end

			buttons.composeBtn:setVisible(true)
			buttons.composeBtn:setButtonName(Strings:get("Shop_URMap_Button_Desc3"), Strings:get("Shop_URMap_Button_Desc3"))
		elseif subType == ItemTypes.K_HERO_F then
			buttons.useBtn:setVisible(true)
			buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))

			if not self._heroSystem:hasHero(item:getTargetId()) then
				local str = self._heroSystem:checkHeroCanComp(item:getTargetId()) and "bag_UI21" or "bag_UI22"
				local str1 = self._heroSystem:checkHeroCanComp(item:getTargetId()) and "UITitle_EN_Hecheng" or "UITitle_EN_Laiyuan"

				buttons.useBtn:setButtonName(Strings:get(str), Strings:get(str1))
			end

			self:setButtonEnabled(buttons.useBtn, true)
		elseif subType == ItemTypes.K_HEROSTONE_F then
			buttons.useBtn:setVisible(true)
			buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))
			self:setButtonEnabled(buttons.useBtn, true)
		elseif subType == ItemTypes.K_HERO_QUALITY or subType == ItemTypes.K_MASTER_EMBLEM_QUALITY_UP then
			buttons.useBtn:setVisible(true)
			buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))
			self:setButtonEnabled(buttons.useBtn, true)
		elseif subType == ItemTypes.k_ACTIVITY_ITEM then
			local jumplink = item:getPrototype()._itemBase.Link

			if jumplink and jumplink ~= "" then
				buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))

				local canUse = subType and not self._cannotUseConsumableKindMap[subType]

				buttons.useBtn:setVisible(canUse)
				self:setButtonEnabled(buttons.useBtn, canUse)
			else
				buttons.useBtn:setVisible(false)
			end
		elseif subType == ItemTypes.K_HERO_STAR or subType == ItemTypes.K_MasterLeadStage then
			buttons.useBtn:setVisible(true)
			buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))
			self:setButtonEnabled(buttons.useBtn, true)
		elseif page == ItemPages.kConsumable then
			if item:getSubType() == ItemTypes.k_MAP_IN then
				buttons.useBtn:setVisible(false)
				buttons.composeBtn:setVisible(false)
			else
				buttons.useBtn:setButtonName(Strings:get("bag_UI13"), Strings:get("UITitle_EN_Shiyong"))

				local canUse = subType and not self._cannotUseConsumableKindMap[subType]

				buttons.useBtn:setVisible(canUse)
				self:setButtonEnabled(buttons.useBtn, canUse)
			end
		elseif page == ItemPages.kEquip then
			buttons.useBtn:setVisible(false)
		end

		if buttons.sellBtn:isVisible() and (buttons.useBtn:isVisible() or buttons.composeBtn:isVisible()) then
			buttons.sellBtn:getView():setPositionX(95)
			buttons.useBtn:getView():setPositionX(278)
			buttons.composeBtn:getView():setPositionX(278)
		elseif buttons.sellBtn:isVisible() and not buttons.useBtn:isVisible() and not buttons.composeBtn:isVisible() then
			buttons.sellBtn:getView():setPositionX(186)
		elseif buttons.composeBtn:isVisible() and buttons.useBtn:isVisible() and not buttons.sellBtn:isVisible() then
			buttons.composeBtn:getView():setPositionX(95)
			buttons.useBtn:getView():setPositionX(278)
		else
			buttons.useBtn:getView():setPositionX(186)
			buttons.composeBtn:getView():setPositionX(186)
		end

		if item:isExistResource() and (item:getSubType() == ItemTypes.K_HERO_F or item:getSubType() == ItemTypes.K_MASTER_F or item:getSubType() == ItemTypes.K_HERO_QUALITY) then
			buttons.fromBtn:setVisible(true)
		end

		buttons.lockBtn:setVisible(item:getCanLock())

		if buttons.lockBtn:isVisible() then
			if entry.unlock then
				if not kLockImage[2] then
					local image = kLockImage[1]

					buttons.lockBtn:getChildByName("image"):loadTexture(image)
				end
			end
		end
	end
end

function BagMediator:setButtonEnabled(button, isEnable)
	if button then
		button:getButton():setEnabled(isEnable)
	end
end

function BagMediator:checkDetailAreaHidden()
	local detailArea = self._detailArea
	local hiddenNodes = {
		detailArea.nameLabel,
		detailArea.nameBackImg,
		detailArea.haveNumLabel,
		detailArea.haveNumLabel1,
		detailArea.funcLabel,
		detailArea.descLabel,
		detailArea.pieceLabel,
		detailArea.sepLine,
		detailArea.sellPanel.sellLabel,
		detailArea.sellPanel.priceLabel,
		detailArea.sellPanel.moneyIcon
	}
	local isEntryValid = self:isEntryIdValid(self._curEntryId)

	for _, node in ipairs(hiddenNodes) do
		node:setVisible(isEntryValid)
	end
end

function BagMediator:updateNameAndPieceLabel(detailArea, item)
	local isPiece = item:getType() == ItemTypes.kHeroPiece or item:getType() == ItemTypes.kMasterPiece or item:getType() == ItemTypes.kEquipPiece

	GameStyle:setQualityText(detailArea.nameLabel, item:getQuality())

	if isPiece then
		local strName = ""

		if item:getType() == ItemTypes.kHeroPiece then
			local config = ConfigReader:getRecordById("HeroBase", tostring(item:getSubType()))

			strName = Strings:get(config.Name)
		elseif item:getType() == ItemTypes.kEquipPiece then
			local config = ConfigReader:getRecordById("ItemConfig", tostring(item:getSubType()))

			strName = Strings:get(config.Name)
		elseif item:getType() == ItemTypes.kMasterPiece then
			local config = ConfigReader:getRecordById("MasterBase", tostring(item:getSubType()))

			strName = Strings:get(config.Name)
		end

		detailArea.nameLabel:setString(strName)
	else
		detailArea.nameLabel:setString(item:getName())
	end
end

function BagMediator:updateDescLabel(detailArea, item)
	local entry = self._bagSystem:getEntryById(self._curEntryId)
	local funcLabel, descLabel = detailArea.funcLabel, detailArea.descLabel
	local sepLine = detailArea.sepLine
	local haveNumLabel, haveNumLabel1 = detailArea.haveNumLabel, detailArea.haveNumLabel1

	haveNumLabel1:setString(tostring(entry.count))
	funcLabel:setString(item:getFunctionDesc())

	local bgDesc = item:getDesc() or ""

	if bgDesc ~= "" and bgDesc ~= " " then
		sepLine:setVisible(true)
		descLabel:setVisible(true)
		descLabel:setString(bgDesc)
	else
		descLabel:setVisible(false)
		sepLine:setVisible(false)
	end

	local descScrollView = detailArea.descScrollView
	local result, tipsCode = self._bagSystem:canUse({
		item = item
	})

	if not result then
		descScrollView:setContentSize(cc.size(descScrollView:getContentSize().width, 124))
	else
		descScrollView:setContentSize(cc.size(descScrollView:getContentSize().width, 144))
	end

	local size = descScrollView:getContentSize()

	size.height = funcLabel:getContentSize().height + 10
	size.height = size.height + descLabel:getContentSize().height + 10

	if size.height > descScrollView:getContentSize().height then
		descScrollView:setTouchEnabled(true)
	else
		size = descScrollView:getContentSize()

		descScrollView:setTouchEnabled(false)
	end

	descScrollView:setInnerContainerSize(size)

	local offy = size.height

	funcLabel:setPositionY(size.height)

	offy = offy - funcLabel:getContentSize().height - 8

	sepLine:setPositionY(offy)

	offy = offy - 8

	descLabel:setPositionY(offy)
end

function BagMediator:updateLockArea(detailArea, item)
	local canSell = item:getSellNumber() > 0

	detailArea.sellPanel.moneyIcon:setVisible(canSell)
	detailArea.sellPanel.priceLabel:setVisible(canSell)
	detailArea.sellPanel.strLabel:setVisible(false)

	if canSell then
		local textNode = detailArea.sellPanel.priceLabel
		local strNode = detailArea.sellPanel.strLabel
		local numLabel = tostring(item:getSellNumber())
		local show = false

		if item:getSellNumber() > 100000 then
			show = true
			numLabel = tostring(math.floor(item:getSellNumber() / 1000))
		end

		textNode:setString(numLabel)
		strNode:setPositionX(textNode:getPositionX() + textNode:getContentSize().width)
		strNode:setString("K")
		strNode:setVisible(show)
		detailArea.sellPanel.sellLabel:setString(Strings:get("bag_UI9"))
	else
		detailArea.sellPanel.sellLabel:setString("")
	end

	self._notSellLabel:setVisible(not canSell)

	if self._notSellLabel:isVisible() then
		self._notSellLabel:setString(Strings:get("bag_UI19"))
	end
end

function BagMediator:updateDetailBasicArea(notHasShow)
	self.URLevelLimit:setVisible(false)

	local detailArea = self._detailArea

	detailArea.iconBg:removeAllChildren(true)
	detailArea.rarity:removeAllChildren()
	self:checkDetailAreaHidden()

	if self:isEntryIdValid(self._curEntryId) then
		local entry = self._bagSystem:getEntryById(self._curEntryId)

		if not entry then
			return
		end

		local item = entry.item
		local config = ConfigReader:getRecordById("ItemConfig", tostring(item:getConfigId()))
		local rarity
		local subType = item:getSubType()

		if ItemTypes.K_EQUIP_EXP == subType or ItemTypes.K_EQUIP_STAREXP == subType or ItemTypes.K_EQUIP_STARITEM == subType or table.indexof(Box_Rarity, item:getConfigId()) then
			local rarityPanel = detailArea.rarity

			rarityPanel:removeAllChildren()

			rarity = item:getRarity()

			if rarity >= 15 then
				local flashFile = GameStyle:getEquipRarityFlash(rarity)
				local anim = cc.MovieClip:create(flashFile)

				anim:addTo(rarityPanel)
			else
				local imageFile = GameStyle:getEquipRarityImage(rarity)
				local rarityImage = ccui.ImageView:create(imageFile)

				rarityImage:addTo(rarityPanel)
				rarityImage:setName("RarityImage")
				rarityImage:ignoreContentAdaptWithSize(true)
				rarityImage:setScale(0.9)
			end
		end

		local result, tipsCode = self._bagSystem:canUse({
			item = item
		})

		if not result then
			self.URLevelLimit:setVisible(true)

			local limitLevel = tonumber(item:getUseLevel())

			self.URLevelLimit:setString(Strings:get("bag_UI36", {
				level = limitLevel
			}))
		end

		local icon = IconFactory:createPic({
			id = item:getConfigId(),
			rarity = rarity
		}, {
			ignoreScaleSize = true,
			largeIcon = true,
			shine = (config and config.ShinePack == 1 or nil) and true
		})

		icon:addTo(detailArea.iconBg):center(detailArea.iconBg:getContentSize())

		if ItemTypes.K_HERO_F == subType or ItemTypes.K_MASTER_F == subType then
			icon:setScale(0.7)
		end

		self:updateNameAndPieceLabel(detailArea, item)
		self:updateDescLabel(detailArea, item)
		self:updateLockArea(detailArea, item)
	end
end

function BagMediator:getLockData(item)
	local lockData

	return lockData
end

function BagMediator:updateItemsArea()
	local hasValidItem = self:isEntryIdValid(self._curEntryIds[1])

	self._tableView:setVisible(hasValidItem)

	if hasValidItem then
		self._itemCellMap = {}

		self._tableView:reloadData()
	end
end

function BagMediator:isEntryIdValid(entryId)
	return entryId and entryId ~= kInvalidEntryId
end

function BagMediator:createItemsTableView(reset)
	local scrollview = self._itemScroll:getChildByName("scrollview")
	local viewSize = scrollview:getContentSize()

	if reset then
		if self._onEquipTab then
			viewSize = cc.size(viewSize.width, viewSize.height - 110)
		end
	elseif self._tableView then
		return
	end

	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
		self._indicator = self._indicatorClone:clone()

		self._indicator:addTo(self._itemNode)
	end

	local kFirstCellPos = cc.p(viewSize.width / 4 - 5, kCellHeight / 2 - 8)
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return math.ceil(#self._curEntryIds / kColumnNum)
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local bar = table:dequeueCell()

		if bar == nil then
			bar = cc.TableViewCell:new()

			for i = 1, kColumnNum do
				local itemCell = self._itemCell:clone()
				local hongdian = itemCell:getChildByFullName("hongdian")

				hongdian:setLocalZOrder(20)
				itemCell:addTouchEventListener(function(sender, eventType)
					self:onItemClicked(sender, eventType)

					if eventType == ccui.TouchEventType.ended and self._curEntryCell ~= nil then
						local iconHandler = self._curEntryCell.handler

						if iconHandler and iconHandler:getEntryId() ~= kInvalidEntryId then
							local entryId = iconHandler:getEntryId()
							local redState = self._bagSystem:getEntryRedStateById(entryId)

							if redState then
								self._curEntryCell:getChildByFullName("hongdian"):setVisible(false)
								self._bagSystem:hideEntryRedById(entryId)
								self._tabBtnWidget:refreshAllRedPoint()
							end

							self:selectItem(self._curEntryCell)
						end
					end
				end)
				itemCell:setSwallowTouches(false)

				itemCell.handler = BagItemIconHandler:new(itemCell, self._bagSystem, self._itemCellTop)

				local posX = 25 + kFirstCellPos.x * (i - 1)

				itemCell:setPosition(cc.p(posX, kFirstCellPos.y))
				bar:addChild(itemCell, 0, i)
			end
		end

		for i = 1, kColumnNum do
			local itemCell = bar:getChildByTag(i)

			itemCell:stopAllActions()

			local hongdian = itemCell:getChildByFullName("hongdian")
			local curIndex = idx * kColumnNum + i
			local entryId = self._curEntryIds[curIndex]
			local isvislble = self._bagSystem:getItemIsVisible(entryId)

			itemCell:setVisible(entryId ~= nil and isvislble)

			if itemCell:isVisible() then
				itemCell.handler:decorateWithData(entryId)

				local isShowRed = kTabBtnsNames[self._curTabType][3]

				hongdian:setVisible(isShowRed and self._bagSystem:getEntryRedStateById(entryId))

				self._itemCellMap[entryId] = itemCell

				if entryId == self._curEntryId and self:isEntryIdValid(entryId) then
					self:changeIndicator(itemCell)
				elseif itemCell == self._indicator:getParent() then
					self._indicator:setVisible(false)
				end
			end
		end

		return bar
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	scrollview:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(10)

	self._tableView = tableView
end

function BagMediator:initAllEntryIds()
	self._allEntryIds = self._bagSystem:getAllEntryIds()
end

function BagMediator:dealItemChange(event)
	local entry = self._bagSystem:getEntryById(self._curEntryId)
	local oldEntryId = self._curEntryId
	local oldEntryIds = self._curEntryIds
	local oldViewSize, oldContainerSize, oldOffset = self:_getTableviewStatus()

	self:initAllEntryIds()
	self:getCurItems()

	local index = table.find(oldEntryIds, oldEntryId) or 1
	local lineIndex = math.ceil(index / kColumnNum)

	if entry == nil then
		self._curEntryId = self._curEntryIds[index]

		if not self:isEntryIdValid(self._curEntryId) then
			for i = #self._curEntryIds, 1, -1 do
				if self:isEntryIdValid(self._curEntryIds[i]) then
					self._curEntryId = self._curEntryIds[i]

					break
				end
			end
		end
	end

	self:updateItemsArea()

	local indexNew = table.find(self._curEntryIds, self._curEntryId) or 1

	if index < indexNew and oldEntryId == self._curEntryId then
		indexNew = index
	end

	local newLineIndex = math.ceil(indexNew / kColumnNum)
	local newViewSize, newContainerSize = self:_getTableviewStatus()
	local newOffsetY = oldContainerSize.height + oldOffset.y - newContainerSize.height + kCellHeight * (newLineIndex - lineIndex)
	local tempAdd = newOffsetY + newContainerSize.height
	local tempSub = newViewSize.height - newContainerSize.height

	if newOffsetY < 0 then
		if tempAdd < newViewSize.height then
			newOffsetY = tempSub
		end
	elseif tempAdd < newViewSize.height then
		newOffsetY = tempSub
	elseif tempAdd > newViewSize.height then
		newOffsetY = math.max(tempSub, 0)
	end

	local newOffset = cc.p(oldOffset.x, newOffsetY)

	self._tableView:setContentOffset(newOffset)
	self:refreshView()
end

function BagMediator:_getTableviewStatus()
	local viewSize = self._tableView:getViewSize()
	local containerSize = self._tableView:getContainer():getContentSize()
	local offset = self._tableView:getContentOffset()

	return viewSize, containerSize, offset
end

function BagMediator:useRechargeItemSucc(event)
	local data = event:getData()

	if not data.rewards then
		local rewards = {}

		if not data.itemName then
			local itemName = ""
			local tipStr = Strings:get("Mail_Reward_Reissue", {
				name = itemName
			})
			local tipStr

			if itemName == "" then
				tipStr = ""
			end

			if #rewards > 0 then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					needClick = true,
					rewards = rewards,
					tipStr = tipStr
				}))
			end
		end
	end
end

function BagMediator:onClickBack(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function BagMediator:onClickTab(name, tag)
	print("-----self._curTabType--------" .. self._curTabType)
	dump(kTabBtnsNames, "===-=-=-=kTabBtnsNames-=-=-=-=")

	if kTabBtnsNames[self._curTabType][3] then
		self._bagSystem:clearBagTabRedPointByType(kTabBtnsNames[self._curTabType][4])
	end

	local refreshTabelView = false

	self._onEquipTab = false

	if kTabBtnsNames[self._curTabType][4] == ItemPages.kEquip then
		refreshTabelView = true
	end

	self._curTabType = tag

	if kTabBtnsNames[self._curTabType][4] == ItemPages.kEquip then
		refreshTabelView = true
		self._onEquipTab = true

		self:showEquipTypePanel(true)
	else
		self:showEquipTypePanel(false)
	end

	self:createItemsTableView(refreshTabelView)
	self:updateTabArea()
end

function BagMediator:onItemClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._curEntryCell = sender
	end
end

function BagMediator:onSellClicked(sender, eventType)
	local entry = self._bagSystem:getEntryById(self._curEntryId)

	if not entry then
		return
	end

	if entry.item:getCanLock() and entry.unlock == false then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_Ur_Lock_1")
		}))

		return
	end

	local redState = self._bagSystem:getEntryRedStateById(self._curEntryId)

	if redState then
		self._curEntryCell:getChildByFullName("hongdian"):setVisible(false)
		self._bagSystem:hideEntryRedById(self._curEntryId)
		self._tabBtnWidget:refreshAllRedPoint()
	end

	local item = entry.item

	local function sureSell()
		if item:getType() == ItemTypes.K_EQUIP_NEW then
			-- block empty
		else
			local kMinShowViewCnt = 1

			if kMinShowViewCnt < entry.count then
				self:readyShowSelectCountView(SelectItemType.kForSell, self._curEntryId)
			else
				local function callBack()
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Tips_3010002")
					}))
				end

				self._bagSystem:requestSellItem(self._curEntryId, kMinShowViewCnt, callBack)
			end
		end
	end

	if item:getQuality() >= ItemQuality.kQuality4 then
		local data = {
			title = Strings:get("bag_UI17"),
			title1 = Strings:get("bag_UI17"),
			content = Strings:get("bag_UI20"),
			sureBtn = {},
			cancelBtn = {}
		}
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				sureSell()
			end
		end

		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		sureSell()
	end
end

function BagMediator:onUseClicked(sender, eventType)
	if not self:isEntryIdValid(self._curEntryId) then
		return
	end

	local entry = self._bagSystem:getEntryById(self._curEntryId)

	if not entry then
		return
	end

	local redState = self._bagSystem:getEntryRedStateById(self._curEntryId)

	if redState then
		self._curEntryCell:getChildByFullName("hongdian"):setVisible(false)
		self._bagSystem:hideEntryRedById(self._curEntryId)
		self._tabBtnWidget:refreshAllRedPoint()
	end

	if self._itemLockData and self._itemLockData.cannotUseTip then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._itemLockData.cannotUseTip)
		}))

		return
	end

	local item = entry.item
	local result, tipsCode = self._bagSystem:canUse({
		item = item
	})

	if not result then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(tipsCode)
		}))

		return
	end

	local pageType = item:getType()
	local subType = item:getSubType()

	if subType == ItemTypes.K_HEROSTONE_F then
		self:useHeroStonePiece(self._curEntryId)
	elseif subType == ItemTypes.K_COMPOSE then
		if self:checkCanUseCompose(item) == false then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("bag_UR_LearnTip")
			}))

			return
		end

		self:useScroll(self._curEntryId)
	elseif subType == ItemTypes.K_HERO_F then
		self:useHeroPiece(self._curEntryId)
	elseif subType == ItemTypes.K_HERO_STAR then
		self:useMaterial(self._curEntryId)
	elseif subType == ItemTypes.K_MasterLeadStage then
		self:useMaterial(self._curEntryId)
	elseif subType == ItemTypes.K_MASTER_F then
		self:useMasterPiece(self._curEntryId)
	elseif subType == ItemTypes.K_EQUIP_F then
		self:useEquipPiece(self._curEntryId)
	elseif pageType == ItemPages.kConsumable or subType == ItemTypes.k_ACTIVITY_ITEM then
		self:useConsumable(self._curEntryId)
	elseif pageType == ItemPages.kStuff then
		self:useMaterial(self._curEntryId)
	elseif pageType == ItemPages.kEquip then
		self:useEquipItem(self._curEntryId)
	end
end

function BagMediator:onComposeClicked(sender, eventType)
	if not self:isEntryIdValid(self._curEntryId) then
		return
	end

	local entry = self._bagSystem:getEntryById(self._curEntryId)

	if not entry then
		return
	end

	local item = entry.item
	local pageType = item:getType()
	local subType = item:getSubType()

	if subType == ItemTypes.K_COMPOSE then
		if self:checkCanUseCompose(item) and entry.count == 1 then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Shop_URMap_Untransform_Tips_Desc1")
			}))

			return
		end

		local ChangeTipView = self:getInjector():getInstance("BagURExhangeView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, ChangeTipView, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			sourceId = self._curEntryId
		}, nil))
	else
		self:onUseClicked(sender, eventType)
	end
end

function BagMediator:getUseConsumConfigMap()
	self._useConsumConfigMap = self._useConsumConfigMap or {
		[ComsumableKind.kActionPoint] = {
			directUse = true
		},
		[ComsumableKind.kDiamondBox] = {
			directUse = true
		},
		[ComsumableKind.kBox] = {
			directUse = true
		},
		[ComsumableKind.kCrystalItem] = {
			directUse = true
		},
		[ComsumableKind.kOreCollect] = {
			directUse = true
		},
		[ComsumableKind.kBoxSelect] = {
			directUse = true
		},
		[ComsumableKind.kExp] = {
			self.readyShowHeroStrenghenView,
			{}
		},
		[ComsumableKind.kBoxKey] = {
			self.readyGoShop,
			{}
		},
		[ComsumableKind.kEquipRecruitKey] = {
			self.readyUseRecruitKey,
			{
				recruitType = RecruitPoolType.kEquip
			}
		},
		[ComsumableKind.kRecruitKey] = {
			self.readyUseRecruitKey,
			{
				recruitType = RecruitPoolType.kDiamond
			}
		},
		[ComsumableKind.kGoldRecruitKey] = {
			self.readyUseRecruitKey,
			{
				recruitType = RecruitPoolType.kGold
			}
		},
		[ComsumableKind.kGalleryItem] = {
			self.readyUseGalleryItem,
			{}
		},
		[ComsumableKind.kActivityUse] = {
			self.jumpToActivity,
			{}
		}
	}

	return self._useConsumConfigMap
end

function BagMediator:useConsumable(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item
	local subType = item:getSubType()

	if self._bagSystem:isUsedRechargeItem(subType) then
		local params = {
			itemId = item:getId(),
			itemName = item:getName()
		}

		self._bagSystem:requestUseRechargeItem(params)

		return
	end

	local jumplink = item:getPrototype()._itemBase.Link
	local useConsumConfigMap = self:getUseConsumConfigMap()
	local useConfig = useConsumConfigMap[subType]

	if jumplink and jumplink ~= "" then
		useConfig[2].param = jumplink
	end

	assert(useConfig ~= nil, "error: unknown config .. " .. item:getId())

	if useConfig.directUse then
		self._directUseItemSubType = subType

		if ItemTypes.K_BOX_SELECT == self._directUseItemSubType then
			self:readyShowBoxSelectView(curEntryId)
		else
			local needBatchUse = false

			if item:canBatchUse() then
				local minCnt, maxCnt = self._bagSystem:getItemBatchUseCount()

				if minCnt <= entry.count then
					needBatchUse = true
				end
			end

			if needBatchUse then
				self:readyShowSelectCountView(SelectItemType.kForUse, curEntryId)
			else
				local useAmount = 1

				self._bagSystem:tryUseActionPointItem(curEntryId, useAmount)
			end
		end
	else
		local func = useConfig[1]
		local param = useConfig[2]

		if param ~= nil then
			func(self, param)
		else
			func(self)
		end
	end
end

function BagMediator:useScroll(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local param = {
		curEntryId = curEntryId,
		curEntryIds = self._curEntryIds
	}
	local view = self:getInjector():getInstance("BagUseScrollView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function BagMediator:useHeroPiece(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item

	if self._heroSystem:hasHero(item:getTargetId()) then
		self._bagSystem:goToViewByUrl(curEntryId)
	elseif self._heroSystem:checkHeroCanComp(item:getTargetId()) then
		local config = PrototypeFactory:getInstance():getHeroPrototype(item:getTargetId()):getConfig()

		local function callBack(data)
			local view = self:getInjector():getInstance("newHeroView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				heroId = data.id
			}))
		end

		self._bagSystem:requestHeroCompose(config.ItemId, callBack)
	else
		local config = PrototypeFactory:getInstance():getHeroPrototype(item:getTargetId()):getConfig()
		local needCount = self._heroSystem:getHeroComposeFragCount(item:getTargetId())
		local hasCount = self._heroSystem:getHeroDebrisCount(item:getTargetId())
		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = config.ItemId,
			hasNum = hasCount,
			needNum = needCount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function BagMediator:useMasterPiece(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item

	if self._masterSystem:hasMaster(item:getTargetId()) then
		self._bagSystem:goToViewByUrl(curEntryId)
	else
		local masterConfig = ConfigReader:getRecordById("MasterBase", item:getTargetId())
		local number = self._bagSystem:getItemCount(masterConfig.StarUpItemId)
		local maxnumber = masterConfig.CompositePay

		if maxnumber <= number then
			local function callBack()
				local masterData = self._masterSystem:getMasterById(item:getTargetId())
				local view = self:getInjector():getInstance("NewMasterView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					masterId = masterData:getId()
				}))
			end

			self._masterSystem:sendApplyComposeMaster(masterConfig.StarUpItemId, callBack)
		else
			local param = {
				isNeed = true,
				hasWipeTip = true,
				itemId = masterConfig.StarUpItemId,
				hasNum = number,
				needNum = maxnumber
			}
			local view = self:getInjector():getInstance("sourceView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, param))
		end
	end
end

function BagMediator:useEquipPiece(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item
	local count = self._bagSystem:getItemCount(curEntryId)
	local targetNum = item:getTargetNum()

	if targetNum <= count then
		self._equipSystem:requestDebrisCompose({
			itemId = curEntryId
		}, function()
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("bag_UI26")
			}))
		end)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Error_EquipFragment")
		}))
	end
end

function BagMediator:useEquipItem(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item

	if item:getSubType() == ItemTypes.K_EQUIP_STAR then
		if self._heroSystem:hasHero(item:getTargetId()) then
			self._bagSystem:goToViewByUrl(curEntryId)
		else
			local heroConfig = ConfigReader:getRecordById("HeroBase", item:getTargetId())

			if heroConfig then
				local name = Strings:get(heroConfig.Name)
				local str = Strings:get("bag_UI25", {
					name = name
				})

				self:dispatch(ShowTipEvent({
					tip = str
				}))
			end
		end
	elseif item:getSubType() == ItemTypes.K_EQUIP_ORNAMENT then
		self._bagSystem:goToViewByUrl(curEntryId)
	end
end

function BagMediator:useMaterial(curEntryId)
	self._bagSystem:goToViewByUrl(curEntryId)
end

function BagMediator:useHeroStonePiece(curEntryId)
	local entry = self._bagSystem:getEntryById(curEntryId)

	if not entry then
		return
	end

	self:readyShowSelectCountView(SelectItemType.kForUse, curEntryId)
end

function BagMediator:readyShowSelectCountView(selectType, curEntryId)
	local title = ""
	local title1 = ""

	if selectType == SelectItemType.kForSell then
		title = Strings:get("UITitle_CH_Piliangchushou")
		title1 = Strings:get("UITitle_EN_Piliangchushou")
	elseif selectType == SelectItemType.kForUse then
		title = Strings:get("UITitle_CH_Piliangshiyong")
		title1 = Strings:get("UITitle_EN_Piliangshiyong")
	end

	local data = {
		selectType = selectType,
		title = title,
		title1 = title1,
		entryId = curEntryId
	}
	local bagBatchUseSellMediator = self:getInjector():getInstance("BagBatchUseSellView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bagBatchUseSellMediator, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function BagMediator:readyShowBoxSelectView(curEntryId)
	local title = Strings:get("bag_ChoiceReward_Title")
	local title1 = Strings:get("UITitle_EN_Jianglixuanze")
	local data = {
		title = title,
		title1 = title1,
		entryId = curEntryId
	}
	local mediator = self:getInjector():getInstance("BagGiftChooseOneView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, mediator, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function BagMediator:readyGoShop(tabType)
	self._shopSystem:tryEnter({
		shopId = "Shop_Normal"
	})
end

function BagMediator:readyUseRecruitKey(param)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)

	recruitSystem:tryEnter(param)
end

function BagMediator:jumpToActivity(param)
	if param then
		if type(param) == "table" and not param.param then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Item_ActivityFinish_Tips")
			}))

			return
		end

		local activitySystem = self:getInjector():getInstance(ActivitySystem)
		local context = self:getInjector():instantiate(URLContext)
		local _, params = UrlEntryManage.resolveUrlWithUserData(param)

		if activitySystem:getActivityOpenStatusById(params.id) then
			self:dispatch(Event:new(EVT_OPENURL, {
				url = param
			}))

			return
		end

		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Item_ActivityFinish_Tips")
		}))
	end
end

function BagMediator:readyUseGalleryItem()
	local unlock, unlockTips = self._systemKeeper:isUnlock("Hero_Gift")

	if not unlock then
		if not ignoreTip then
			self:dispatch(ShowTipEvent({
				tip = unlockTips
			}))
		end

		return false
	end

	local view = self:getInjector():getInstance("GalleryPartnerNewView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
end

function BagMediator:readyUseChat()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("ARENAVIEW_NOTICE")
	}))
end

function BagMediator:readyUseArena()
	local arenaSystem = self:getInjector():getInstance("ArenaSystem")

	arenaSystem:tryEnter()
end

function BagMediator:readyShowHeroStrenghenView()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tip = systemKeeper:isUnlock("Hero_LevelUp")

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	self._heroSystem:tryEnterShowMain({
		ignoreSound = true
	})
	self._heroSystem:tryEnterLevel()
end

function BagMediator:onClickFrom()
	local entry = self._bagSystem:getEntryById(self._curEntryId)

	if not entry then
		return
	end

	local item = entry.item
	local subType = item:getSubType()
	local itemId = 0
	local hasNum = 0
	local needNum = 0

	if subType == ItemTypes.K_HERO_F then
		local config = PrototypeFactory:getInstance():getHeroPrototype(item:getTargetId()):getConfig()

		itemId = config.ItemId
		hasNum = self._heroSystem:getHeroDebrisCount(item:getTargetId())
		needNum = self._heroSystem:getHeroComposeFragCount(item:getTargetId())
	elseif subType == ItemTypes.K_MASTER_F then
		local masterConfig = ConfigReader:getRecordById("MasterBase", item:getTargetId())

		itemId = masterConfig.StarUpItemId
		hasNum = self._bagSystem:getItemCount(masterConfig.StarUpItemId)
		needNum = masterConfig.CompositePay
	elseif subType == ItemTypes.K_HERO_QUALITY then
		itemId = item:getId()
		hasNum = self._bagSystem:getItemCount(entry)
		needNum = 0
	end

	local param = {
		isNeed = true,
		hasWipeTip = true,
		hideProgress = true,
		itemId = itemId,
		hasNum = hasNum,
		needNum = needNum
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function BagMediator:runListAnim()
	local idsNum = #self._curEntryIds

	if idsNum == 0 then
		return
	end

	local delayPancel = 0.1

	delayPancel = idsNum >= 12 and delayPancel * 4 or delayPancel * (idsNum / 4 + 1)

	local showPanel = self._detailPanel:isVisible() and self._detailPanel or self._equipPanel._uiNode

	showPanel:stopAllActions()
	showPanel:setOpacity(0)
	showPanel:setScale(0.8)

	local seq = cc.Sequence:create(cc.DelayTime:create(delayPancel), cc.Spawn:create(cc.FadeIn:create(0.4), cc.ScaleTo:create(0.25, 1)))

	showPanel:runAction(seq)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kColumnNum do
				local itemCell = child:getChildByTag(j)

				if itemCell then
					local node = itemCell:getChildByFullName("pancel"):getChildByFullName("icon")
					local hongdian = itemCell:getChildByFullName("hongdian")

					if node then
						node:setOpacity(0)
						hongdian:setOpacity(0)
					end
				end
			end
		end
	end

	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667
	local maxDelayTime = 0

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kColumnNum do
				local itemCell = child:getChildByTag(j)

				itemCell:stopAllActions()

				if itemCell and itemCell:isVisible() then
					local itemCellTop = itemCell:getChildByFullName("pancel"):getChildByFullName("itemCellTop")

					if itemCellTop then
						itemCellTop:setOpacity(0)
					end

					local node = itemCell:getChildByFullName("pancel"):getChildByFullName("icon")
					local hongdian = itemCell:getChildByFullName("hongdian")

					if node then
						local time = (i - 1) * delayTime + (j - 1) * delayTime1
						local delayAction = cc.DelayTime:create(time)

						if maxDelayTime < time then
							maxDelayTime = time
						end

						local callfunc1 = cc.CallFunc:create(function()
							if node then
								CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
							end

							if hongdian then
								CommonUtils.runActionEffect(hongdian, "Node_1.myPetClone1", "TaskDailyEffect", "anim2", false)
							end
						end)
						local callfunc2 = cc.CallFunc:create(function()
							if itemCellTop then
								itemCellTop:runAction(cc.FadeIn:create(0.2))
							end
						end)
						local seq = cc.Sequence:create(delayAction, callfunc1, callfunc2)

						itemCell:runAction(seq)

						if itemCell == self._indicator:getParent() then
							self:stopIndicatorAni()

							local indicator = self._indicator

							indicator:setOpacity(0)
							indicator:setScale(1.2)

							local seq = cc.Sequence:create(cc.DelayTime:create(delayPancel), cc.CallFunc:create(function()
								indicator:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 0.95)), cc.ScaleTo:create(0.1, 1.05), cc.ScaleTo:create(0.1, 1)))
							end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
								indicator:setOpacity(255)
								indicator:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.95), cc.ScaleTo:create(0.5, 1))))
							end))

							self:getView():runAction(seq)
						end
					end
				end
			end
		end
	end
end

function BagMediator:checkCanUseCompose(item)
	local result = true
	local composeTimes = self._bagSystem:getComposeTimes()

	if item:getSubType() == ItemTypes.K_COMPOSE and composeTimes then
		local configData = ConfigReader:getRecordById("Compose", item:getId())

		if configData and configData.Times and configData.Times > 0 then
			local currentTime = composeTimes[item:getId()]

			if currentTime and currentTime >= configData.Times then
				result = false
			end
		end
	end

	return result
end

function BagMediator:createEquipTypeBtn()
	for k, v in pairs(kEquipTabBtnsNames) do
		local panelNew = self._tabBuildBtn:clone()

		panelNew:setVisible(true)
		self._node_BuildBtn:addChild(panelNew)
		panelNew:setPosition((k - 1) * kTab_button_width, 0)
		panelNew:setName(v[2])

		local button = panelNew:getChildByFullName("Button")
		local textName = panelNew:getChildByFullName("name")

		textName:setString(Strings:get(v[1]))
		button:addClickEventListener(function()
			self:onClickEquipType(v[2])
		end)
	end
end

function BagMediator:onClickEquipType(equipType)
	if self._equipType ~= equipType then
		self._equipType = equipType

		self:refreshEquipTypeBtn()
		self:refreshEquipByType()
	end
end

function BagMediator:showEquipTypePanel(show)
	self._equipTabPanel:setVisible(show)
end

function BagMediator:refreshEquipByType()
	self:updateTabArea()
end

function BagMediator:refreshEquipTypeBtn()
	local children = self._node_BuildBtn:getChildren()

	for index = 1, #children do
		local child = children[index]
		local image1 = child:getChildByFullName("Image_1")
		local image2 = child:getChildByFullName("Image_2")

		image1:setVisible(true)
		image2:setVisible(false)

		if child:getName() == self._equipType then
			image1:setVisible(false)
			image2:setVisible(true)
		end
	end
end

function BagMediator:refreshViewByLock(event)
	local data = event:getData()

	if self._currentItem then
		local entry = self._bagSystem:getEntryById(self._currentItem:getId())

		if data.viewtype == 1 then
			if entry.unlock then
				local var_91_0 = Strings:get("Equip_Ur_Lock_4")

				if not var_91_0 then
					var_91_0 = Strings:get("Equip_Ur_Lock_3")

					local tip = var_91_0

					self:dispatch(ShowTipEvent({
						tip = tip
					}))
				end
			end
		end
	end
end

function BagMediator:onClickItemLock()
	if self._currentItem and self._currentItem:getCanLock() then
		local params = {
			viewtype = 1,
			itemId = self._currentItem:getId()
		}

		self._bagSystem:requestItemLock(params)
	end
end
