-- chunkname: @modules/logic/rouge/view/RougeCollectionBaseSlotCellItem.lua

module("modules.logic.rouge.view.RougeCollectionBaseSlotCellItem", package.seeall)

local RougeCollectionBaseSlotCellItem = class("RougeCollectionBaseSlotCellItem", UserDataDispose)

function RougeCollectionBaseSlotCellItem:onInit(viewGO, pos_x, pos_y, cellParams)
	self:__onInit()
	self:_onInitView(viewGO, pos_x, pos_y, cellParams)
	self:_editableInitView()
end

function RougeCollectionBaseSlotCellItem:_onInitView(viewGO, pos_x, pos_y, cellParams)
	self.viewGO = viewGO
	self._cellPosX = pos_x
	self._cellPosY = pos_y
	self._curLineState = RougeEnum.LineState.Grey
	self._curInsideLines = nil
	self._cellLineNameMap = cellParams.cellLineNameMap
	self._cellWidth = cellParams.cellWidth
	self._cellHeight = cellParams.cellHeight
end

function RougeCollectionBaseSlotCellItem:_editableInitView()
	self:buildLineTranMap()
	self:initSlotCellLines()
end

local directionLineNameMap = {
	[RougeEnum.SlotCellDirection.Top] = "top",
	[RougeEnum.SlotCellDirection.Bottom] = "bottom",
	[RougeEnum.SlotCellDirection.Left] = "left",
	[RougeEnum.SlotCellDirection.Right] = "right"
}

function RougeCollectionBaseSlotCellItem:buildLineTranMap()
	self._directionTranMap = self:getUserDataTb_()

	for _, direction in pairs(RougeEnum.SlotCellDirection) do
		self:buildSingleLineTranMap(direction, self._directionTranMap)
	end
end

local cellLineWidth = 2

function RougeCollectionBaseSlotCellItem:buildSingleLineTranMap(direction, directionTranMap)
	if direction and directionTranMap then
		local lineName = directionLineNameMap[direction]
		local lineImage = gohelper.findChildImage(self.viewGO, lineName)

		directionTranMap[direction] = lineImage

		recthelper.setSize(lineImage.transform, self._cellWidth, cellLineWidth)
	end
end

function RougeCollectionBaseSlotCellItem:initSlotCellLines()
	local hasPlace, placeCollectionId = self:chechCellHasPlace()
	local insideLines
	local lineState = RougeEnum.LineState.Grey

	if hasPlace then
		insideLines = self:getInsideLines(placeCollectionId)
		lineState = RougeEnum.LineState.Green
	end

	self:updateCellState(lineState)
	self:hideInsideLines(insideLines)
end

function RougeCollectionBaseSlotCellItem:chechCellHasPlace()
	return false, nil
end

function RougeCollectionBaseSlotCellItem:getInsideLines(placeCollectionId)
	local insideLines = {}
	local rightPlaceId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX + 1, self._cellPosY)
	local leftPlaceId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX - 1, self._cellPosY)
	local topPlaceId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX, self._cellPosY - 1)
	local bottomPlaceId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX, self._cellPosY + 1)

	if rightPlaceId == placeCollectionId then
		table.insert(insideLines, RougeEnum.SlotCellDirection.Right)
	end

	if leftPlaceId == placeCollectionId then
		table.insert(insideLines, RougeEnum.SlotCellDirection.Left)
	end

	if topPlaceId == placeCollectionId then
		table.insert(insideLines, RougeEnum.SlotCellDirection.Top)
	end

	if bottomPlaceId == placeCollectionId then
		table.insert(insideLines, RougeEnum.SlotCellDirection.Bottom)
	end

	return insideLines
end

function RougeCollectionBaseSlotCellItem:onPlaceCollection(insideLines)
	self:updateCellState(RougeEnum.LineState.Green)
	self:hideInsideLines(insideLines)
end

function RougeCollectionBaseSlotCellItem:revertCellState(collectionId)
	local placeCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX, self._cellPosY)

	if placeCollectionId and collectionId and placeCollectionId == collectionId then
		self:updateCellState()

		return
	end

	self:initSlotCellLines()
end

function RougeCollectionBaseSlotCellItem:hideInsideLines(insideLines)
	if insideLines then
		for _, direction in pairs(insideLines) do
			local lineImage = self._directionTranMap[direction]

			gohelper.setActive(lineImage.gameObject, false)
		end
	end
end

function RougeCollectionBaseSlotCellItem:updateCellState(newCellState)
	self._curCellState = newCellState or RougeEnum.LineState.Grey

	self:updateAllCellLine(self._curCellState)
end

function RougeCollectionBaseSlotCellItem:updateAllCellLine(state)
	if self._directionTranMap then
		for _, lineImage in pairs(self._directionTranMap) do
			if self._cellLineNameMap then
				gohelper.setActive(lineImage.transform, true)
				UISpriteSetMgr.instance:setRougeSprite(lineImage, self._cellLineNameMap)
			end
		end
	end
end

function RougeCollectionBaseSlotCellItem:getSlotCellPosition()
	return self._cellPosX, self._cellPosY
end

function RougeCollectionBaseSlotCellItem:setItemVisible(isVisible)
	gohelper.setActive(self.viewGO, isVisible)
end

function RougeCollectionBaseSlotCellItem:destroy()
	self:__onDispose()
end

return RougeCollectionBaseSlotCellItem
