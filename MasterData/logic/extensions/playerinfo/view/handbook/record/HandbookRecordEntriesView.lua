-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEntriesView.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEntriesView", package.seeall)

local M = class("HandbookRecordEntriesView", ViewComponent)

M.ItemType = {
	Entries = 2,
	Title = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._goRightPanel = self:getGo("handbook_record_entries_view_1328775357")
	self._scrollDesc = self:getUIComponent("handbook_record_entries_view_480723757", UIComponentType.ScrollRect)
	self._txtDescTitle = self:getText("handbook_record_entries_view_-1065725274")
	self._txtDescContent = self:getText("handbook_record_entries_view_796526627")
	self._imgIcon = self:getImage("handbook_record_entries_view_-831018677")

	local goScroll = self:getGo("handbook_record_entries_view_-1010050357")

	self._loopList = LoopListHelper.New(goScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._goRightPanel = nil
	self._scrollDesc = nil
	self._txtDescTitle = nil
	self._txtDescContent = nil
	self._imgIcon = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self._titleCell = {}
	self._id2Cell = {}

	self:refreshInfo(nil)
	self:refreshEntryTab()
	self:selectFirstUnlockItem()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)

	self._titleCell = nil
	self._id2Cell = nil

	self:setLastCell(nil)
	self._loopList:ClearCells()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_handleHandbookUnreadInfoChange(e)
	for typ, cell in pairs(self._titleCell or {}) do
		cell:updateNewMark()
	end
end

function M:_onClickReturn()
	self:close()
end

function M:onCellTitleClick(cell)
	local data = self._eventDataLst[cell:getIndex()]

	data.isExpand = not data.isExpand

	cell:setIsSelected(data.isExpand)
	self:refreshShowItemData()

	local itemCount = self:getShowItemCount()

	self._loopList:SetListItemCount(itemCount, false)
	self._loopList:RefreshAllShownItem()
end

function M:onCellClick(cell)
	if cell:getIsLock() then
		FloatWordMgr.instance:show(lang("tip_clause_not_active"))

		return
	end

	if self:getLastDataIndex() and self:getLastDataIndex() == cell:getIndex() then
		return
	end

	local lastCell = self:getLastCell()

	if lastCell then
		lastCell:setIsSelected(false)
	end

	cell:setIsSelected(true)
	self:setLastCell(cell)
	self:refreshInfo(cell:getIndex())
end

function M:getLastCell()
	return self._id2Cell[self:getLastDataId()]
end

function M:setLastCell(cell)
	self._lastDataIndex = cell and cell:getIndex() or nil
	self._lastDataId = cell and cell:getId() or nil
end

function M:getLastDataIndex()
	return self._lastDataIndex
end

function M:getLastDataId()
	return self._lastDataId
end

function M:selectFirstUnlockItem()
	local cellId

	for index, value in ipairs(self._eventDataLst or {}) do
		if value.itemTyp ~= self.ItemType.Title and GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Word, value.cfg.id) then
			cellId = value.cfg.id

			break
		end
	end

	if cellId then
		DoTweenUtil.DelayedCall(0.1, function()
			local cell = self._id2Cell[cellId]

			if cell then
				self:onCellClick(cell)
			end
		end)
	end
end

function M:refreshInfo(cellIndex)
	local show = cellIndex ~= nil

	if show then
		local cfg = self._eventDataLst[cellIndex].cfg

		self._scrollDesc.verticalNormalizedPosition = 1
		self._txtDescTitle.text = cfg.name
		self._txtDescContent.text = cfg.content

		if cfg.typ == 2 then
			local campId = cfg.id - 20000

			IconLoader.setSprite(self._imgIcon, IconType.BigCamp, CommEnum.CampType2BigIcon[campId])
			goutil.setActive(self._imgIcon.gameObject, true)
		else
			goutil.setActive(self._imgIcon.gameObject, false)
		end
	end

	goutil.setActive(self._goRightPanel, show)
end

function M:refreshEntryTab()
	self._eventDataLst = {}

	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryWord)
	local itemTypDef = self.ItemType
	local typCache

	if cfgLst and #cfgLst > 0 then
		table.sort(cfgLst, function(cfgA, cfgB)
			if cfgA.typ ~= cfgB.typ then
				return cfgA.typ < cfgB.typ
			end

			if cfgA.sortType ~= cfgB.sortType then
				return cfgA.sortType > cfgB.sortType
			end

			return cfgA.id < cfgB.id
		end)

		local treeIndex = 1

		for index, cfg in ipairs(cfgLst) do
			local dataTyp = cfg.typ

			if not typCache then
				self:_addEventData(self._eventDataLst, itemTypDef.Title, dataTyp, treeIndex)
			elseif typCache ~= cfg.typ then
				treeIndex = #self._eventDataLst + 1

				self:_addEventData(self._eventDataLst, itemTypDef.Title, dataTyp, treeIndex)
			end

			typCache = cfg.typ

			self:_addEventData(self._eventDataLst, itemTypDef.Entries, dataTyp, treeIndex, cfg)
		end
	end

	self:refreshShowItemData()

	local itemCount = self:getShowItemCount()

	self._loopList:SetListItemCount(itemCount, true)
	self._loopList:RefreshAllShownItem()
end

function M:_addEventData(theTable, itemTyp, dataTyp, treeIndex, cfg)
	local data = {
		isExpand = true,
		itemTyp = itemTyp,
		dataTyp = dataTyp,
		treeIndex = treeIndex,
		cfg = cfg
	}

	table.insert(theTable, data)

	data.index = #theTable
end

function M:refreshShowItemData()
	self._showItemIndex2DataIndex = {}

	for index, value in ipairs(self._eventDataLst) do
		if value.itemTyp == self.ItemType.Title then
			table.insert(self._showItemIndex2DataIndex, index)
		elseif self._eventDataLst[value.treeIndex].isExpand then
			table.insert(self._showItemIndex2DataIndex, index)
		end
	end
end

function M:getShowItemCount()
	return #self._showItemIndex2DataIndex
end

function M:getItemDataByShowIndex(showIndex)
	local dataIndex = self._showItemIndex2DataIndex[showIndex]

	return self._eventDataLst[dataIndex]
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self:getItemDataByShowIndex(curIndex)
	local id = data.cfg and data.cfg.id or nil
	local isTitle = data.itemTyp == self.ItemType.Title
	local prefabName = isTitle and "entries_title_item" or "entries_item"
	local className = isTitle and HandbookEntriesTitleCell or HandbookEntriesItemCell
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, className)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, className)
	end

	shower:setHandler(self)
	shower:setData(data)

	local showSelect = false

	if isTitle then
		showSelect = data.isExpand
		self._titleCell[data.dataTyp] = shower
	else
		self._id2Cell[id] = shower
		showSelect = self:getLastDataId() and self:getLastDataId() == id
	end

	shower:setIsSelected(showSelect)

	return item
end

return M
