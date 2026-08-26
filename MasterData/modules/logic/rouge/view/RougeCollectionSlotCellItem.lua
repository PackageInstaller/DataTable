-- chunkname: @modules/logic/rouge/view/RougeCollectionSlotCellItem.lua

module("modules.logic.rouge.view.RougeCollectionSlotCellItem", package.seeall)

local RougeCollectionSlotCellItem = class("RougeCollectionSlotCellItem", RougeCollectionBaseSlotCellItem)

function RougeCollectionSlotCellItem:onInit(go, pos_x, pos_y, cellParams)
	RougeCollectionSlotCellItem.super.onInit(self, go, pos_x, pos_y, cellParams)
end

function RougeCollectionSlotCellItem:_onInitView(viewGO, pos_x, pos_y, cellParams)
	RougeCollectionSlotCellItem.super._onInitView(self, viewGO, pos_x, pos_y, cellParams)

	self._goarea = gohelper.findChild(self.viewGO, "area")
	self._imagestate = gohelper.findChildImage(self.viewGO, "area/state")
	self._goplace = gohelper.findChild(self.viewGO, "area/place")

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, self._onBeginDragCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, self._onEndDragCollection, self)
end

function RougeCollectionSlotCellItem:chechCellHasPlace()
	local placeCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX, self._cellPosY)
	local hasPlace = placeCollectionId ~= nil and placeCollectionId > 0

	return hasPlace, placeCollectionId
end

function RougeCollectionSlotCellItem:onCoverCollection(dragCollectionId, insideLines)
	local hasPlace, placeCollectionId = self:chechCellHasPlace()

	if hasPlace and placeCollectionId == dragCollectionId then
		self:updateCellState(RougeEnum.LineState.Green)
		self:hideInsideLines(insideLines)

		return
	end

	local dragCollectionMO = RougeCollectionModel.instance:getCollectionByUid(dragCollectionId)

	if not dragCollectionMO then
		return
	end

	if hasPlace then
		local isCanEnchant = self:checkIsCanEnchant2PlaceCollection(placeCollectionId, dragCollectionMO)

		if isCanEnchant then
			self:updateCellState(RougeEnum.LineState.Green)
		else
			self:updateCellState(RougeEnum.LineState.Red)
		end
	else
		self:updateCellState(RougeEnum.LineState.Green)
	end

	self:hideInsideLines(insideLines)
end

function RougeCollectionSlotCellItem:checkIsCanEnchant2PlaceCollection(placeCollectionId, dragCollectionMO)
	local placeCollectionMO = RougeCollectionModel.instance:getCollectionByUid(placeCollectionId)
	local placeCollectionCfg = RougeCollectionConfig.instance:getCollectionCfg(placeCollectionMO.cfgId)
	local isPlaceCollectionEnchant = placeCollectionCfg.type ~= RougeEnum.CollectionType.Enchant
	local dragCollectionCfg = RougeCollectionConfig.instance:getCollectionCfg(dragCollectionMO.cfgId)
	local isDragCollectionCanEnchant = dragCollectionCfg.type == RougeEnum.CollectionType.Enchant

	return isDragCollectionCanEnchant and isPlaceCollectionEnchant
end

function RougeCollectionSlotCellItem:updateCellColor(lineState)
	gohelper.setActive(self._imagestate.gameObject, true)

	if lineState == RougeEnum.LineState.Green then
		UISpriteSetMgr.instance:setRougeSprite(self._imagestate, "rouge_collection_grid_big_3")
	elseif lineState == RougeEnum.LineState.Blue then
		UISpriteSetMgr.instance:setRougeSprite(self._imagestate, "rouge_collection_grid_big_1")
	else
		gohelper.setActive(self._imagestate.gameObject, false)
	end
end

function RougeCollectionSlotCellItem:updateCellState(newCellState)
	RougeCollectionSlotCellItem.super.updateCellState(self, newCellState)
	self:updateCellColor(self._curCellState)
end

function RougeCollectionSlotCellItem:_onBeginDragCollection(dragMO)
	local placeCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(self._cellPosX, self._cellPosY)
	local isCouldPlace = dragMO and dragMO.id == placeCollectionId or not placeCollectionId or placeCollectionId <= 0

	gohelper.setActive(self._goplace, isCouldPlace)
end

function RougeCollectionSlotCellItem:_onEndDragCollection()
	gohelper.setActive(self._goplace, false)
end

function RougeCollectionSlotCellItem:onPlaceCollection(insideLines)
	RougeCollectionSlotCellItem.super.onPlaceCollection(self, insideLines)
	gohelper.setActive(self._imagestate.gameObject, false)
end

function RougeCollectionSlotCellItem:revertCellState(collectionId)
	RougeCollectionSlotCellItem.super.revertCellState(self, collectionId)
	gohelper.setActive(self._imagestate.gameObject, false)
end

function RougeCollectionSlotCellItem:destroy()
	RougeCollectionSlotCellItem.super.destroy(self)
end

return RougeCollectionSlotCellItem
