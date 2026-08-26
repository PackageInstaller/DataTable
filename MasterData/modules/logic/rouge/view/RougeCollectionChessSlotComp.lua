-- chunkname: @modules/logic/rouge/view/RougeCollectionChessSlotComp.lua

module("modules.logic.rouge.view.RougeCollectionChessSlotComp", package.seeall)

local RougeCollectionChessSlotComp = class("RougeCollectionChessSlotComp", BaseView)

function RougeCollectionChessSlotComp:onInitView()
	self._btnclosetipArea = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_closetipArea")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gochessContainer = gohelper.findChild(self.viewGO, "chessboard/#go_chessContainer")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_cellModel")
	self._gochessitem = gohelper.findChild(self.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	self._goraychessitem = gohelper.findChild(self.viewGO, "chessboard/#go_raychessitem")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._scrollbag = gohelper.findChildScrollRect(self.viewGO, "#scroll_bag")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content")
	self._gocollectionItem = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._gosingleTipsContent = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	self._gosingleAttributeItem = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessSlotComp:addEvents()
	return
end

function RougeCollectionChessSlotComp:removeEvents()
	return
end

function RougeCollectionChessSlotComp:_editableInitView()
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateSlotCellState, self.updateSlotCellState, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotAreaSucc, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, self.onNullSpace2PlaceCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self.placeCollection2SlotAreaFailed, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self.deleteSlotCollection, self)
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateCollectionEnchant, self)

	self._coverCells = self:getUserDataTb_()
	self._conflictIds = self:getUserDataTb_()
	self._placeCollectionMap = {}
end

function RougeCollectionChessSlotComp:onOpen()
	local slotAreaSize = RougeCollectionModel.instance:getCurSlotAreaSize()

	self:initCollectionSlot(slotAreaSize.col, slotAreaSize.row)
	self:updateAllFilledCellState()
end

function RougeCollectionChessSlotComp:initCollectionSlot(col, row)
	col = col or 0
	row = row or 0

	local cellWidth = RougeCollectionHelper.CollectionSlotCellSize.x
	local cellHeight = RougeCollectionHelper.CollectionSlotCellSize.y
	local slotArea = gohelper.findChild(self.viewGO, "chessboard")

	recthelper.setWidth(slotArea.transform, col * cellWidth)
	recthelper.setHeight(slotArea.transform, row * cellHeight)
	recthelper.setAnchor(self._gomeshContainer.transform, cellWidth / 2, -cellHeight / 2)
	recthelper.setAnchor(self._godragContainer.transform, cellWidth / 2, -cellHeight / 2)
	recthelper.setAnchor(self._gocellModel.transform, cellWidth / 2, -cellHeight / 2)

	for j = 0, row - 1 do
		for i = 0, col - 1 do
			self:createCollectionSlotCell(i, j)
		end
	end
end

function RougeCollectionChessSlotComp:updateAllFilledCellState()
	local collections = RougeCollectionModel.instance:getSlotAreaCollection()

	if collections then
		for _, collectionMO in ipairs(collections) do
			self:placeCollection2SlotAreaSucc(collectionMO)
		end
	end
end

function RougeCollectionChessSlotComp:getCollectionSlotCell(slotPosX, slotPosY)
	return self._slotCellTab and self._slotCellTab[slotPosX] and self._slotCellTab[slotPosX][slotPosY]
end

function RougeCollectionChessSlotComp:createCollectionSlotCell(slotPosX, slotPosY)
	local slotCell = gohelper.cloneInPlace(self._gomeshItem, string.format("%s_%s", slotPosX, slotPosY))
	local cellAnchorPosX, cellAnchorPosY = RougeCollectionHelper.slotPos2AnchorPos(Vector2(slotPosX, slotPosY))

	recthelper.setAnchor(slotCell.transform, cellAnchorPosX, cellAnchorPosY)
	gohelper.setActive(slotCell, true)

	local slotCellItem = RougeCollectionSlotCellItem.New()

	slotCellItem:onInit(slotCell, slotPosX, slotPosY, RougeCollectionHelper.ResultReViewCollectionSlotParam)

	self._slotCellTab = self._slotCellTab or self:getUserDataTb_()
	self._slotCellTab[slotPosX] = self._slotCellTab[slotPosX] or self:getUserDataTb_()
	self._slotCellTab[slotPosX][slotPosY] = slotCellItem
end

function RougeCollectionChessSlotComp:updateSlotCellState(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO.id

	self:revertCoverCells(collectionId)
	self:revertConflictCells()
	self:updateSlotCells(collectionMO)
end

function RougeCollectionChessSlotComp:updateSlotCells(collectionMO)
	local collectionId = collectionMO.id
	local collectionCfgId = collectionMO.cfgId
	local rotation = collectionMO:getRotation()
	local centerSlotPos = collectionMO:getCenterSlotPos()
	local shapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Shape)
	local effectCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Effect)
	local shapeCfgMap = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(collectionCfgId, rotation)

	if not shapeCfg then
		return
	end

	local isConflict = false

	for _, cellOffset in ipairs(shapeCfg) do
		local cellSlotPos = RougeCollectionHelper.getCollectionCellSlotPos(centerSlotPos, cellOffset)
		local slotCell = self:getCollectionSlotCell(cellSlotPos.x, cellSlotPos.y)
		local conflictId = RougeCollectionModel.instance:getSlotFilledCollectionId(cellSlotPos.x, cellSlotPos.y)

		if slotCell and conflictId > 0 and conflictId ~= collectionId then
			self._conflictIds[conflictId] = true
			isConflict = true
		end
	end

	if isConflict then
		self:refreshConflictCells(collectionCfgId)

		return
	end

	local leftTopPos = collectionMO:getLeftTopPos()
	local isOutSlotArea = RougeCollectionHelper.checkIsCollectionSlotArea(collectionCfgId, leftTopPos, rotation, true)

	for _, cellOffset in ipairs(shapeCfg) do
		local cellSlotPos = RougeCollectionHelper.getCollectionCellSlotPos(centerSlotPos, cellOffset)
		local slotCell = self:getCollectionSlotCell(cellSlotPos.x, cellSlotPos.y)

		if slotCell then
			local insideLines = RougeCollectionHelper.getSlotCellInsideLine(shapeCfgMap, cellOffset)

			if isOutSlotArea then
				slotCell:updateCellState(RougeEnum.LineState.Red)
				slotCell:hideInsideLines(insideLines)
			else
				slotCell:onCoverCollection(collectionId, insideLines)
			end

			self._coverCells[collectionId] = self._coverCells[collectionId] or {}

			table.insert(self._coverCells[collectionId], slotCell)
		end
	end

	for _, cellOffset in ipairs(effectCfg) do
		local cellSlotPos = RougeCollectionHelper.getCollectionCellSlotPos(centerSlotPos, cellOffset)
		local slotCell = self:getCollectionSlotCell(cellSlotPos.x, cellSlotPos.y)

		if slotCell then
			slotCell:updateCellState(RougeEnum.LineState.Blue)

			self._coverCells[collectionId] = self._coverCells[collectionId] or {}

			table.insert(self._coverCells[collectionId], slotCell)
		end
	end
end

function RougeCollectionChessSlotComp:foreachCollectionCells(collectionMO, callBack, callbackObj)
	if not collectionMO or not callBack or not callbackObj then
		return
	end

	local collectionCfgId = collectionMO.cfgId
	local rotation = collectionMO:getRotation()
	local rotationMatrix = RougeCollectionConfig.instance:getShapeMatrix(collectionCfgId, rotation)

	if rotationMatrix then
		for posX, rows in ipairs(rotationMatrix) do
			for posY, value in ipairs(rows) do
				if value and value > 0 then
					callBack(callbackObj, collectionMO, rotationMatrix, posX, posY)
				end
			end
		end
	end
end

function RougeCollectionChessSlotComp:onCoverCellCallBack(collectionMO, rotationMatrix, posX, posY)
	local leftTopPos = collectionMO:getLeftTopPos()
	local targetPosX = leftTopPos.y + posY - 1
	local targetPosY = leftTopPos.x + posX - 1
	local slotCell = self:getCollectionSlotCell(targetPosX, targetPosY)

	if slotCell then
		local insideLines = self:getSlotCellInsideLine(rotationMatrix, posY, posX)
		local collectionId = collectionMO.id

		slotCell:onCoverCollection(collectionId, insideLines)

		self._coverCells[collectionId] = self._coverCells[collectionId] or {}

		table.insert(self._coverCells[collectionId], slotCell)
	end
end

function RougeCollectionChessSlotComp:getSlotCellInsideLine(shapeMatrix, posX, posY)
	local result = {}

	if self:isCellExist(shapeMatrix, posX, posY - 1) then
		table.insert(result, RougeEnum.SlotCellDirection.Top)
	end

	if self:isCellExist(shapeMatrix, posX, posY + 1) then
		table.insert(result, RougeEnum.SlotCellDirection.Bottom)
	end

	if self:isCellExist(shapeMatrix, posX - 1, posY) then
		table.insert(result, RougeEnum.SlotCellDirection.Left)
	end

	if self:isCellExist(shapeMatrix, posX + 1, posY) then
		table.insert(result, RougeEnum.SlotCellDirection.Right)
	end

	return result
end

function RougeCollectionChessSlotComp:isCellExist(shapeMatrix, posX, posY)
	return shapeMatrix[posX] and shapeMatrix[posX][posY] and shapeMatrix[posX][posY] > 0
end

function RougeCollectionChessSlotComp:refreshConflictCells(collectionCfgId)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
	local isEnchant = collectionCfg and collectionCfg.type == RougeEnum.CollectionType.Enchant

	if isEnchant then
		if not RougeEnum.LineState.Green then
			local lineState = RougeEnum.LineState.Red

			for conflictId, _ in pairs(self._conflictIds) do
				if self._coverCells and self._coverCells[conflictId] then
					local findEnchantCollection = false

					if isEnchant then
						local conflictMO = RougeCollectionModel.instance:getCollectionByUid(conflictId)
						local conflictCfgId = conflictMO and conflictMO.cfgId
						local conflictCfg = RougeCollectionConfig.instance:getCollectionCfg(conflictCfgId)

						if conflictCfg then
							if not conflictCfg.holeNum then
								local holeNum = 0

								findEnchantCollection = holeNum > 0
								lineState = findEnchantCollection and RougeEnum.LineState.Green or RougeEnum.LineState.Red
							end
						end
					else
						lineState = RougeEnum.LineState.Red
					end

					for _, coverCell in ipairs(self._coverCells[conflictId]) do
						local slotPosX, slotPosY = coverCell:getSlotCellPosition()
						local insideLines = self:getInsideLines(slotPosX, slotPosY, conflictId)

						coverCell:updateCellState(lineState)
						coverCell:hideInsideLines(insideLines)
					end

					if findEnchantCollection then
						break
					end
				end
			end
		end
	end
end

function RougeCollectionChessSlotComp:getInsideLines(slotPosX, slotPosY, collectionId)
	local slotCellPos = Vector2(slotPosX, slotPosY)
	local topPos = slotCellPos - Vector2(0, 1)
	local bottomPos = slotCellPos + Vector2(0, 1)
	local leftPos = slotCellPos - Vector2(1, 0)
	local rightPos = slotCellPos + Vector2(1, 0)
	local result = {}

	if RougeCollectionModel.instance:getSlotFilledCollectionId(topPos.x, topPos.y) == collectionId then
		table.insert(result, RougeEnum.SlotCellDirection.Top)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(bottomPos.x, bottomPos.y) == collectionId then
		table.insert(result, RougeEnum.SlotCellDirection.Bottom)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(leftPos.x, leftPos.y) == collectionId then
		table.insert(result, RougeEnum.SlotCellDirection.Left)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(rightPos.x, rightPos.y) == collectionId then
		table.insert(result, RougeEnum.SlotCellDirection.Right)
	end

	return result
end

function RougeCollectionChessSlotComp:placeCollection2SlotAreaSucc(collectionMO)
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
		local cellSlotPos = RougeCollectionHelper.getCollectionCellSlotPos(centerSlotPos, cellOffset)
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
end

function RougeCollectionChessSlotComp:placeCollection2SlotAreaFailed(collectionId, isDelete)
	self:revertCoverCells(collectionId)
	self:revertConflictCells()

	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

	if isInSlotArea and not isDelete then
		local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

		self:placeCollection2SlotAreaSucc(collectionMO)
	end
end

function RougeCollectionChessSlotComp:revertCoverCells(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, slotCell in pairs(self._coverCells) do
				slotCell:revertCellState(collectionId)
			end

			self._coverCells[collectionId] = {}
		end
	end
end

function RougeCollectionChessSlotComp:revertConflictCells()
	if self._conflictIds then
		for conflictId, _ in pairs(self._conflictIds) do
			if self._coverCells then
				if self._coverCells then
					for _, slotCell in pairs(self._coverCells) do
						slotCell:revertCellState()
					end
				end
			end
		end

		self._conflictIds = {}
	end
end

function RougeCollectionChessSlotComp:deleteSlotCollection(collectionId)
	if self._coverCells then
		if self._coverCells then
			for _, cell in ipairs(self._coverCells) do
				cell:revertCellState()
			end

			self._coverCells[collectionId] = nil
		end

		self:revertConflictCells()
	end
end

function RougeCollectionChessSlotComp:updateCollectionEnchant(collectionId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local enchantIds = collectionMO:getAllEnchantId()

	if not enchantIds then
		return
	end

	for _, enchantId in pairs(enchantIds) do
		if self._coverCells then
			if self._coverCells then
				for _, cell in pairs(self._coverCells) do
					cell:updateCellState(RougeEnum.LineState.Grey)
				end

				self._coverCells[enchantId] = nil
			end
		end
	end
end

function RougeCollectionChessSlotComp:onNullSpace2PlaceCollection(collectionMO)
	self:updateSlotCellState(collectionMO)
end

function RougeCollectionChessSlotComp:disposeAllSlotCells()
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

function RougeCollectionChessSlotComp:onClose()
	self:disposeAllSlotCells()
end

function RougeCollectionChessSlotComp:onDestroyView()
	return
end

return RougeCollectionChessSlotComp
