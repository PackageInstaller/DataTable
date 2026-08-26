-- chunkname: @modules/logic/rouge/common/comp/RougeCollectionBaseSlotComp.lua

module("modules.logic.rouge.common.comp.RougeCollectionBaseSlotComp", package.seeall)

local RougeCollectionBaseSlotComp = class("RougeCollectionBaseSlotComp", UserDataDispose)

function RougeCollectionBaseSlotComp.Get(go, isShowIcon)
	local comp = RougeCollectionBaseSlotComp.New()

	comp:init(go, isShowIcon)

	return comp
end

function RougeCollectionBaseSlotComp:init(go, isShowIcon)
	self:__onInit()
	self:initBaseInfo(isShowIcon)

	self.viewGO = go

	self:_onCollectionSlotLoaded()
end

function RougeCollectionBaseSlotComp:initBaseInfo(isShowIcon)
	self._isDirty = false
	self._isShowIcon = isShowIcon
end

function RougeCollectionBaseSlotComp:_onCollectionSlotLoaded()
	self:_editableInitView()
	self:checkIsNeedUpdate()
end

function RougeCollectionBaseSlotComp:_editableInitView()
	self._gomeshcontainer = gohelper.findChild(self.viewGO, "#go_meshcontainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "#go_meshcontainer/#go_meshItem")
	self._goplacecontainer = gohelper.findChild(self.viewGO, "#go_placecontainer")
	self._gochessitem = gohelper.findChild(self.viewGO, "#go_placecontainer/#go_chessitem")
	self._gridlayout = self._gomeshcontainer:GetComponent(gohelper.Type_GridLayoutGroup)
	self._coverCells = self:getUserDataTb_()
	self._collectionItemMap = self:getUserDataTb_()
	self._placeCollectionMap = {}

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotArea, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self.deleteSlotCollection, self)

	self._cellWidth = recthelper.getWidth(self._gochessitem.transform)
	self._cellHeight = recthelper.getHeight(self._gochessitem.transform)
	self._slotCellTab = self:getUserDataTb_()
end

function RougeCollectionBaseSlotComp:checkIsNeedUpdate()
	if self._isDirty then
		self:initCollectionSlot()
		self:initPlaceCollections()

		self._isDirty = false
	end
end

function RougeCollectionBaseSlotComp:onUpdateMO(col, row, placeCollectionMOs)
	if not col or col <= 0 or not row or row <= 0 then
		logError(string.format("初始化肉鸽棋盘失败,失败原因:棋盘宽或高不可小于或等于0, col = %s, row = %s", col, row))

		return
	end

	self._col = col
	self._row = row
	self._placeCollectionMOs = placeCollectionMOs

	self:start2InitSlot()
end

function RougeCollectionBaseSlotComp:start2InitSlot()
	if gohelper.isNil(self.viewGO) then
		self._isDirty = true

		return
	end

	self:initCollectionSlot()
	self:initPlaceCollections()

	self._isDirty = false
end

function RougeCollectionBaseSlotComp:initCollectionSlot()
	self._gridlayout.constraintCount = self._col

	for j = 0, self._row - 1 do
		for i = 0, self._col - 1 do
			self:createCollectionSlotCell(i, j)
		end
	end

	for colIndex, rows in pairs(self._slotCellTab) do
		for rowIndex, slotCellItem in pairs(rows) do
			local isVisible = colIndex >= 0 and colIndex < self._col and rowIndex >= 0 and rowIndex < self._row

			slotCellItem:setItemVisible(isVisible)
		end
	end
end

function RougeCollectionBaseSlotComp:initPlaceCollections()
	if self._placeCollectionMOs then
		for _, collectionMO in ipairs(self._placeCollectionMOs) do
			self:placeCollection2SlotArea(collectionMO)
		end
	end
end

function RougeCollectionBaseSlotComp:getCollectionSlotCell(slotPosX, slotPosY)
	return self._slotCellTab and self._slotCellTab[slotPosX] and self._slotCellTab[slotPosX][slotPosY]
end

function RougeCollectionBaseSlotComp:createCollectionSlotCell(slotPosX, slotPosY)
	if self._slotCellTab[slotPosX] then
		local slotCellItem = self._slotCellTab[slotPosX][slotPosY]

		if not self._slotCellTab[slotPosX] then
			local slotCell = gohelper.cloneInPlace(self._gomeshItem, string.format("%s_%s", slotPosX, slotPosY))

			gohelper.setActive(slotCell, true)

			slotCellItem = RougeCollectionSlotCellItem.New(slotCell, slotPosX, slotPosY)
			self._slotCellTab = self._slotCellTab or self:getUserDataTb_()
			self._slotCellTab[slotPosX] = self._slotCellTab[slotPosX] or self:getUserDataTb_()
			self._slotCellTab[slotPosX][slotPosY] = self._slotCellTab[slotPosX]
		end
	end
end

function RougeCollectionBaseSlotComp:placeCollection2SlotArea(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO and collectionMO.id

	if self._placeCollectionMap[collectionId] then
		self._placeCollectionMap[collectionId] = nil
	end

	local rotation = collectionMO:getRotation()
	local shapeCfgMap = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(collectionMO.cfgId, rotation)
	local centerSlotPos = collectionMO:getCenterSlotPos()
	local shapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionMO.cfgId, rotation, RougeEnum.CollectionEditorParamType.Shape)

	self:revertCoverCells(collectionMO.id)

	for _, cellOffset in ipairs(shapeCfg) do
		local cellSlotPos = Vector2(cellOffset.x + centerSlotPos.x, centerSlotPos.y - cellOffset.y)
		local slotCell = self:getCollectionSlotCell(cellSlotPos.x, cellSlotPos.y)

		if slotCell then
			local insideLines = RougeCollectionHelper.getSlotCellInsideLine(shapeCfgMap, cellOffset)

			slotCell:updateCellState(RougeEnum.LineState.Green)
			slotCell:hideInsideLines(insideLines)

			self._placeCollectionMap[collectionId] = self._placeCollectionMap[collectionId] or {}
			self._coverCells[collectionId] = self._coverCells[collectionId] or {}

			table.insert(self._placeCollectionMap[collectionId], cellSlotPos)
			table.insert(self._coverCells[collectionId], slotCell)
		end
	end

	if self._isShowIcon then
		self:showCollectionIcon(collectionMO)
	end
end

function RougeCollectionBaseSlotComp:showCollectionIcon(collectionMO)
	if not collectionMO then
		return
	end

	local collectionItem = self:getOrCreateCollectionItem(collectionMO.id)

	collectionItem:onUpdateMO(collectionMO)
end

function RougeCollectionBaseSlotComp:getOrCreateCollectionItem(collectionId)
	local collectionItem = self._collectionItemMap[collectionId]

	if not collectionItem then
		collectionItem = RougeCollectionBaseSlotItem.New()

		local go = gohelper.cloneInPlace(self._gochessitem, "item_" .. tostring(collectionId))

		collectionItem:onInit(go)
		collectionItem:setPerCellWidthAndHeight(self._cellWidth, self._cellHeight)

		self._collectionItemMap[collectionId] = collectionItem
	end

	return collectionItem
end

function RougeCollectionBaseSlotComp:deleteSlotCollection(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, cell in ipairs(self._coverCells) do
				cell:revertCellState()
			end

			self._coverCells[collectionId] = nil
		end
	end
end

function RougeCollectionBaseSlotComp:revertCoverCells(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, slotCell in pairs(self._coverCells) do
				slotCell:updateCellState(RougeEnum.LineState.Grey)
			end

			self._coverCells[collectionId] = {}
		end
	end
end

function RougeCollectionBaseSlotComp:disposeAllSlotCells()
	if self._slotCellTab then
		for _, lineCells in pairs(self._slotCellTab) do
			for _, slotCell in pairs(lineCells) do
				slotCell:destroy()
			end
		end

		self._slotCellTab = nil
	end

	self._coverCells = nil
end

function RougeCollectionBaseSlotComp:disposeAllCollections()
	if self._collectionItemMap then
		for _, collectionItem in pairs(self._collectionItemMap) do
			collectionItem:destroy()
		end
	end
end

function RougeCollectionBaseSlotComp:destroy()
	self:disposeAllSlotCells()

	if self._slotItemLoader then
		self._slotItemLoader:onDestroy()

		self._slotItemLoader = nil
	end
end

return RougeCollectionBaseSlotComp
