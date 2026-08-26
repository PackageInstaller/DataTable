-- chunkname: @modules/logic/rouge/common/comp/RougeCollectionSlotComp.lua

module("modules.logic.rouge.common.comp.RougeCollectionSlotComp", package.seeall)

local RougeCollectionSlotComp = class("RougeCollectionSlotComp", UserDataDispose)

function RougeCollectionSlotComp.Get(go, params)
	local comp = RougeCollectionSlotComp.New()

	params = params or RougeCollectionHelper.DefaultSlotParam

	comp:init(go, params)

	return comp
end

function RougeCollectionSlotComp:init(go, params)
	self:__onInit()

	self.params = params
	self._slotItemLoader = PrefabInstantiate.Create(go)

	self._slotItemLoader:startLoad(RougeEnum.ResPath.CommonCollectionSlotItem, self._onCollectionSlotLoaded, self)
end

function RougeCollectionSlotComp:_onCollectionSlotLoaded()
	self.viewGO = self._slotItemLoader:getInstGO()

	self:_editableInitView()
	self:checkIsNeedUpdate()
end

function RougeCollectionSlotComp:_editableInitView()
	self._gomeshcontainer = gohelper.findChild(self.viewGO, "#go_meshcontainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "#go_meshcontainer/#go_meshItem")
	self._goplacecontainer = gohelper.findChild(self.viewGO, "#go_placecontainer")
	self._gochessitem = gohelper.findChild(self.viewGO, "#go_placecontainer/#go_chessitem")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_meshcontainer/#effect")
	self._coverCells = self:getUserDataTb_()
	self._collectionItemMap = self:getUserDataTb_()
	self._placeCollectionMap = {}

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotArea, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self.deleteSlotCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.GetNewCollections, self._onGetNewCollections, self)
	self:initCellPrefabItem()

	self._slotCellTab = self:getUserDataTb_()
end

function RougeCollectionSlotComp:initCellPrefabItem()
	if not self.params then
		return
	end

	self._cellWidth = self.params.cellWidth
	self._cellHeight = self.params.cellHeight

	recthelper.setSize(self._gochessitem.transform, self._cellWidth, self._cellHeight)

	self._gridlayout = self._gomeshcontainer:GetComponent(gohelper.Type_GridLayoutGroup)
	self._gridlayout.cellSize = Vector2(self._cellWidth, self._cellHeight)

	recthelper.setSize(self._goplacecontainer.transform, self._cellWidth, self._cellHeight)
end

function RougeCollectionSlotComp:checkIsNeedUpdate()
	if self._isDirty then
		self:start2InitSlot()
	end
end

function RougeCollectionSlotComp:onUpdateMO(col, row, placeCollectionMOs)
	if not col or col <= 0 or not row or row <= 0 then
		logError(string.format("初始化肉鸽棋盘失败,失败原因:棋盘宽或高不可小于或等于0, col = %s, row = %s", col, row))

		return
	end

	self._placeCollectionMOs = placeCollectionMOs
	self._col = col
	self._row = row

	self:start2InitSlot()
end

function RougeCollectionSlotComp:start2InitSlot()
	if gohelper.isNil(self.viewGO) then
		self._isDirty = true

		return
	end

	self:initCollectionSlot()
	self:initPlaceCollections()

	self._isDirty = false
end

function RougeCollectionSlotComp:initCollectionSlot()
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

	local posY = -(self._row / 2 - 0.5) * self._cellHeight
	local posX = (self._col / 2 - 0.5) * self._cellWidth

	recthelper.setAnchor(self._goplacecontainer.transform, posY, posX)
end

function RougeCollectionSlotComp:initPlaceCollections()
	if self._placeCollectionMOs then
		for _, collectionMO in ipairs(self._placeCollectionMOs) do
			self:placeCollection2SlotArea(collectionMO)
		end
	end
end

function RougeCollectionSlotComp:getCollectionSlotCell(slotPosX, slotPosY)
	return self._slotCellTab and self._slotCellTab[slotPosX] and self._slotCellTab[slotPosX][slotPosY]
end

function RougeCollectionSlotComp:createCollectionSlotCell(slotPosX, slotPosY)
	if self._slotCellTab[slotPosX] then
		local slotCellItem = self._slotCellTab[slotPosX][slotPosY]

		if not self._slotCellTab[slotPosX] then
			local slotCell = gohelper.cloneInPlace(self._gomeshItem, string.format("%s_%s", slotPosX, slotPosY))

			gohelper.setActive(slotCell, true)

			local cls = self.params.cls

			slotCellItem = cls.New()

			self._slotCellTab[slotPosX]:onInit(slotCell, slotPosX, slotPosY, self.params)

			self._slotCellTab = self._slotCellTab or self:getUserDataTb_()
			self._slotCellTab[slotPosX] = self._slotCellTab[slotPosX] or self:getUserDataTb_()
			self._slotCellTab[slotPosX][slotPosY] = self._slotCellTab[slotPosX]
		end

		self._slotCellTab[slotPosX]:initSlotCellLines()
	end
end

RougeCollectionSlotComp.PlayEffectDuration = 0.5

function RougeCollectionSlotComp:placeCollection2SlotArea(collectionMO, reason)
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

			slotCell:onPlaceCollection(insideLines)

			self._placeCollectionMap[collectionId] = self._placeCollectionMap[collectionId] or {}
			self._coverCells[collectionId] = self._coverCells[collectionId] or {}

			table.insert(self._placeCollectionMap[collectionId], cellSlotPos)
			table.insert(self._coverCells[collectionId], slotCell)
		end
	end

	if self.params and self.params.showIcon then
		self:showCollectionIcon(collectionMO)
	end
end

function RougeCollectionSlotComp:showCollectionIcon(collectionMO)
	if not collectionMO then
		return
	end

	local collectionItem = self:getOrCreateCollectionItem(collectionMO.id)

	collectionItem:onUpdateMO(collectionMO)
end

function RougeCollectionSlotComp:getOrCreateCollectionItem(collectionId)
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

function RougeCollectionSlotComp:deleteSlotCollection(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, cell in ipairs(self._coverCells) do
				cell:revertCellState()
			end

			self._coverCells[collectionId] = nil
		end
	end
end

function RougeCollectionSlotComp:_onGetNewCollections(collectionIds, reason, collectionPlaceArea)
	if not collectionIds or not reason then
		return
	end

	if collectionPlaceArea == RougeEnum.CollectionPlaceArea.SlotArea then
		for _, collectionId in ipairs(collectionIds) do
			local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

			RougeCollectionHelper.foreachCollectionCells(collectionMO, self._playEffectAfterGetNewSlotCollection, self)
		end
	end

	self:showGetCollectionEffect()
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionChange)
end

function RougeCollectionSlotComp:_playEffectAfterGetNewSlotCollection(collectionMO, row, col)
	local originLeftTopPos = collectionMO:getLeftTopPos()
	local cellPosX = originLeftTopPos.x + col - 1
	local cellPosY = originLeftTopPos.y + row - 1
	local slotCell = self:getCollectionSlotCell(cellPosX, cellPosY)

	if slotCell then
		slotCell:playGetCollectionEffect()
	end
end

function RougeCollectionSlotComp:showGetCollectionEffect()
	if self._isPlayingEffect then
		return
	end

	TaskDispatcher.cancelTask(self._delay2HideEffect, self)
	TaskDispatcher.runDelay(self._delay2HideEffect, self, RougeCollectionSlotComp.PlayEffectDuration)
	gohelper.setActive(self._goeffect, true)

	self._isPlayingEffect = true
end

function RougeCollectionSlotComp:_delay2HideEffect()
	gohelper.setActive(self._goeffect, false)

	self._isPlayingEffect = false
end

function RougeCollectionSlotComp:revertCoverCells(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, slotCell in pairs(self._coverCells) do
				slotCell:updateCellState(RougeEnum.LineState.Normal)
			end

			self._coverCells[collectionId] = {}
		end
	end
end

function RougeCollectionSlotComp:disposeAllSlotCells()
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

function RougeCollectionSlotComp:disposeAllCollections()
	if self._collectionItemMap then
		for _, collectionItem in pairs(self._collectionItemMap) do
			collectionItem:destroy()
		end
	end
end

function RougeCollectionSlotComp:destroy()
	self:disposeAllSlotCells()

	if self._slotItemLoader then
		self._slotItemLoader:onDestroy()

		self._slotItemLoader = nil
	end

	TaskDispatcher.cancelTask(self._delay2HideEffect, self)
	self:__onDispose()
end

return RougeCollectionSlotComp
