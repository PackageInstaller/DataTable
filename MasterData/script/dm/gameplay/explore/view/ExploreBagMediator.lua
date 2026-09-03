-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreBagMediator.lua

ExploreBagMediator = class("ExploreBagMediator", DmPopupViewMediator, _M)

ExploreBagMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local kBtnHandlers = {}
local kTabName = {
	{
		"EXPLORE_UI81",
		"UITitle_EN_Shouhuo"
	},
	{
		"EXPLORE_UI82",
		"UITitle_EN_Zhudong"
	},
	{
		"EXPLORE_UI83",
		"UITitle_EN_Teshu"
	}
}
local kTitleName = {
	{
		"EXPLORE_UI85",
		"UITitle_EN_Shouhuodaoju"
	},
	{
		"EXPLORE_UI86",
		"UITitle_EN_Zhudongdaoju"
	},
	{
		"EXPLORE_UI87",
		"UITitle_EN_Teshudaoju"
	}
}
local kColumnNum = 5
local kUseNum = 1

function ExploreBagMediator:initialize()
	super.initialize(self)
end

function ExploreBagMediator:dispose()
	super.dispose(self)
end

function ExploreBagMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
end

function ExploreBagMediator:bindWidgets()
	return
end

function ExploreBagMediator:mapEventListeners()
	return
end

function ExploreBagMediator:enterWithData(data)
	self:mapEventListeners()
	self:initData(data)
	self:setupView()
	self:initItemView()
	self:initTabView()
end

function ExploreBagMediator:setupView()
	self._mainPanel = self:getView():getChildByName("main")
	self._finishPanel = self._mainPanel:getChildByName("finishPanel")
	self._itemPanel = self._mainPanel:getChildByName("itemPanel")
	self._cellPanel = self._mainPanel:getChildByFullName("cellPanel")

	self._cellPanel:setVisible(false)

	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalTabWidget, {
		title = "",
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		bgSize = {
			width = 1063,
			height = 612
		}
	})
end

function ExploreBagMediator:initData(data)
	if data then
		self._curTabType = data.tabType or 1
	end

	self._allEntryIds = self._exploreSystem:getAllEntryIds()

	self:updateData()
end

function ExploreBagMediator:updateData()
	self._curEntryIds = {}

	local kTabFilterMap = self._exploreSystem:getTabFilterMap()
	local filterFunc = kTabFilterMap[self._curTabType]

	assert(filterFunc ~= nil)

	for _, entryId in ipairs(self._allEntryIds) do
		local entry = self._exploreSystem:getEntryById(entryId)

		if entry then
			local isVisible = entry.item:getIsVisible()

			if (isVisible or entry.item:getType() == ItemPages.kCurrency and entry.item:getSubType() ~= ItemTypes.K_POWER and entry.count > 0) and filterFunc(entry.item) then
				self._curEntryIds[#self._curEntryIds + 1] = entryId
			end
		end
	end
end

function ExploreBagMediator:updateView()
	self._allEntryIds = self._exploreSystem:getAllEntryIds()

	self:updateData()
	self._bagView:reloadData()
end

function ExploreBagMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #kTabName do
		data[#data + 1] = {
			tabText = Strings:get(kTabName[i][1]),
			tabTextTranslate = Strings:get(kTabName[i][2])
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 496)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function ExploreBagMediator:initItemView()
	local width = self._cellPanel:getContentSize().width
	local height = self._cellPanel:getContentSize().height

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function numberOfCellsInTableView(table)
		if self._curTabType ~= 1 then
			return #self._curEntryIds
		end

		return math.ceil(#self._curEntryIds / kColumnNum)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createCell(cell, idx + 1)

		return cell
	end

	self._itemPanel:removeAllChildren()

	local tableView = cc.TableView:create(self._itemPanel:getContentSize())

	self._bagView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._itemPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
end

function ExploreBagMediator:createCell(cell, index)
	if not cell:getChildByName("BagCell1") then
		local bagCell = cc.Layer:create()

		bagCell:addTo(cell)
		bagCell:setName("BagCell1")
	end

	if not cell:getChildByName("BagCell2") then
		local bagCell = self._cellPanel:clone()

		bagCell:setVisible(true)
		bagCell:addTo(cell)
		bagCell:setName("BagCell2")
		bagCell:setPosition(cc.p(0, -2))
	end

	local bagCell1 = cell:getChildByName("BagCell1")

	bagCell1:setVisible(self._curTabType == 1)

	local bagCell2 = cell:getChildByName("BagCell2")

	bagCell2:setVisible(self._curTabType ~= 1)

	if self._curTabType == 1 then
		bagCell1:removeAllChildren()

		for i = 1, kColumnNum do
			local entryId = self._curEntryIds[kColumnNum * (index - 1) + i]
			local entry = self._exploreSystem:getEntryById(entryId)

			if entry then
				local icon, info

				if ItemPages.kEquip == entry.item:getType() and entry.item:getSubType() ~= ItemTypes.K_EQUIP_EXP and entry.item:getSubType() ~= ItemTypes.K_EQUIP_STARITEM and entry.item:getSubType() ~= ItemTypes.K_EQUIP_STAREXP then
					icon = IconFactory:createEquipIcon({
						id = entry.item:getEquipId(),
						star = entry.item:getStar(),
						rarity = entry.item:getRarity()
					}, {
						hideLevel = true,
						isWidget = true
					})
					info = {
						code = entry.item:getEquipId(),
						amount = entry.count,
						type = RewardType.kEquipExplore
					}
				else
					icon = IconFactory:createIcon({
						id = entry.item:getConfigId(),
						amount = entry.count
					}, {
						isWidget = true,
						showAmount = true
					})
					info = {
						code = entry.item:getId(),
						amount = entry.count,
						type = RewardType.kItem
					}
				end

				if icon then
					bagCell1:addChild(icon)
					icon:setPosition(73 + (i - 1) * 143, 80)
					IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), info, {
						needDelay = true
					})
				end
			end
		end
	else
		local entryId = self._curEntryIds[index]
		local entry = self._exploreSystem:getEntryById(entryId)

		if entry then
			local itemData = entry.item
			local iconNode = bagCell2:getChildByName("iconNode")

			iconNode:removeAllChildren()

			local icon = IconFactory:createIcon({
				id = itemData:getConfigId(),
				amount = entry.count
			}, {
				showAmount = true
			})

			icon:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -2)
			icon:setScale(0.8)

			local name = bagCell2:getChildByName("name")

			name:setString(itemData:getName())
			name:disableEffect(1)
			GameStyle:setQualityText(name, itemData:getQuality())

			local desc = bagCell2:getChildByName("desc")

			desc:setString(itemData:getFunctionDesc())

			local useBtn = bagCell2:getChildByName("useBtn")

			useBtn:setVisible(self._curTabType == 2)

			if useBtn:isVisible() then
				useBtn:addClickEventListener(function()
					self:onClickUse(itemData)
				end)
			end
		end
	end
end

function ExploreBagMediator:onClickTab(name, tag)
	self._curTabType = tag

	self._bgWidget:updateTitle({
		title = Strings:get(kTitleName[self._curTabType][1]),
		title1 = Strings:get(kTitleName[self._curTabType][2])
	})
	self:updateData()
	self._bagView:reloadData()
end

function ExploreBagMediator:onClickUse(itemData)
	self:dispatch(ShowTipEvent({
		tip = "使用道具" .. itemData:getName()
	}))
	self._exploreSystem:requestUseItem(function()
		self:updateView()
	end, {
		itemId = itemData:getConfigId(),
		count = kUseNum
	})
end

function ExploreBagMediator:onClickBack()
	self:close()
end
