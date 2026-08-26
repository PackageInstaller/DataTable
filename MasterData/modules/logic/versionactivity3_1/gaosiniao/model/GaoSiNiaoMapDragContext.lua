-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoMapDragContext.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapDragContext", package.seeall)

local GaoSiNiaoMapDragContext = class("GaoSiNiaoMapDragContext", UserDataDispose)

function GaoSiNiaoMapDragContext:ctor()
	self:clear()
end

function GaoSiNiaoMapDragContext:_mapMO()
	return GaoSiNiaoBattleModel.instance:mapMO()
end

function GaoSiNiaoMapDragContext:_single(gridItemList, isKeepDirty)
	return self:_mapMO():single(gridItemList, isKeepDirty)
end

function GaoSiNiaoMapDragContext:_single1(gridItemObj, isKeepDirty)
	return self:_mapMO():single({
		gridItemObj._mo
	}, isKeepDirty)
end

function GaoSiNiaoMapDragContext:_tryMergeAll(gridItemList)
	return self:_mapMO():tryMergeAll(gridItemList)
end

function GaoSiNiaoMapDragContext:_tryMerge1(gridItemObj)
	return self:_tryMergeAll({
		gridItemObj._mo
	})
end

function GaoSiNiaoMapDragContext:_gridObjList()
	return self._viewObj._gridObjList
end

function GaoSiNiaoMapDragContext:_goMapTransform()
	return self._viewObj._goMapTran
end

function GaoSiNiaoMapDragContext:clear()
	self:__onDispose()
	self:__onInit()

	self._enabled = false
	self._viewObj = false
	self._viewContainer = false
	self._draggingItemTran = false
	self._draggingItemImg = false
	self._hitGridItemObj = false
	self._isCompleted = false
	self._gridItem2placedBagItem = {}
	self._gridItemObj2placedBagItemObj = self:getUserDataTb_()
	self._draggingBagItemFromGrid = self:getUserDataTb_()
end

function GaoSiNiaoMapDragContext:reset(current_V3a1_GaoSiNiao_GameView, dragItemTran, dragItemImage)
	self:clear()

	self._viewObj = current_V3a1_GaoSiNiao_GameView
	self._viewContainer = self._viewObj.viewContainer
	self._draggingItemTran = dragItemTran
	self._draggingItemImg = dragItemImage
	self._draggingItemImgTran = dragItemImage.transform

	self:_setActive(false)
	gohelper.setActive(dragItemTran.gameObject, true)
	self:setEnabled(true)
end

function GaoSiNiaoMapDragContext:isPlacedBagItemObj(gridItemObj)
	if not gridItemObj then
		return nil
	end

	return not not self:getPlacedBagItemObj(gridItemObj)
end

function GaoSiNiaoMapDragContext:getPlacedBagItemObj(gridItemObj)
	if not gridItemObj then
		return nil
	end

	return self._gridItemObj2placedBagItemObj[gridItemObj]
end

function GaoSiNiaoMapDragContext:isPlacedBagItem(gridItem)
	if not gridItem then
		return nil
	end

	return not not self:getPlacedBagItem(gridItem)
end

function GaoSiNiaoMapDragContext:getPlacedBagItem(gridItem)
	if not gridItem then
		return nil
	end

	return self._gridItem2placedBagItem[gridItem]
end

function GaoSiNiaoMapDragContext:_setPlacedBagItemObj(toGridItemObj, fromBagItemObj)
	self._gridItemObj2placedBagItemObj[toGridItemObj] = fromBagItemObj

	local toGridItem = toGridItemObj._mo

	if fromBagItemObj then
		if not fromBagItemObj._mo then
			local fromBagItem

			self._gridItem2placedBagItem[toGridItem] = fromBagItem
		end
	end
end

function GaoSiNiaoMapDragContext:_setLocalRotZ(zRot)
	self._viewContainer:setLocalRotZ(self._draggingItemImgTran, zRot)
end

function GaoSiNiaoMapDragContext:_setAPos(x, y)
	recthelper.setAnchor(self._draggingItemTran, x, y)
end

function GaoSiNiaoMapDragContext:_setActive(isActive)
	GameUtil.setActive01(self._draggingItemTran, isActive)
end

function GaoSiNiaoMapDragContext:_setSprite(sprite)
	self._draggingItemImg.sprite = sprite
end

function GaoSiNiaoMapDragContext:_refreshDraggingItem(isActive, optAnchorPosV2, optDragObjItem)
	self:_setActive(isActive)

	if optAnchorPosV2 then
		self:_setAPos(optAnchorPosV2.x, optAnchorPosV2.y)
	end

	if optDragObjItem then
		local sprite, zRot = optDragObjItem:getDraggingSpriteAndZRot()

		self:_setLocalRotZ(zRot)
		self:_setSprite(sprite)
	end
end

function GaoSiNiaoMapDragContext:_isInsideMapArea(dragObj)
	return gohelper.isMouseOverGo(self:_goMapTransform(), dragObj.screenPos)
end

function GaoSiNiaoMapDragContext:_setDragInstToTargetItemObj(dragObj, targetItemObj)
	local anchorPosV2 = dragObj:screenPosV2ToAnchorPosV2(self._draggingItemTran)

	self:_refreshDraggingItem(true, anchorPosV2, targetItemObj)
end

function GaoSiNiaoMapDragContext:_calcHitWhichGridItemObj(dragObj)
	local gridObjList = self:_gridObjList()

	for _, gridItemObj in ipairs(gridObjList) do
		if gohelper.isMouseOverGo(gridItemObj:transform(), dragObj.screenPos) and gridItemObj:isSelectable() then
			self:_onHitGridItemObj(gridItemObj)

			return
		end
	end

	self:_onHitGridItemObj(nil)
end

function GaoSiNiaoMapDragContext:_isValidDrag_TargetItemObj(targetItemObj)
	if not self._enabled then
		return false
	end

	if self:_peakFlyingBagItemObj(targetItemObj) then
		return true
	end

	if not targetItemObj:isDraggable() then
		return false
	end

	return true
end

function GaoSiNiaoMapDragContext:_clearHitInfo()
	self:_onHitGridItemObj(nil)
	self:_collectFlyingBagItemObjBackToBag()
end

function GaoSiNiaoMapDragContext:_critical_beforeClear()
	self:setEnabled(false)
	self:_onHitGridItemObj(nil)
end

function GaoSiNiaoMapDragContext:_onHitGridItemObj(gridItemObj)
	if self._hitGridItemObj then
		self._hitGridItemObj:setSelected(false)
	end

	self._hitGridItemObj = gridItemObj

	if gridItemObj then
		gridItemObj:setSelected(true)
	end
end

function GaoSiNiaoMapDragContext:_peakFlyingBagItemObj(gridItemObj)
	return self._draggingBagItemFromGrid[gridItemObj]
end

function GaoSiNiaoMapDragContext:_detachFlyingBagItemObj(gridItemObj)
	local bagItemObj = self:_peakFlyingBagItemObj(gridItemObj)

	if bagItemObj then
		rawset(self._draggingBagItemFromGrid, gridItemObj, nil)

		return bagItemObj
	end
end

function GaoSiNiaoMapDragContext:_collectFlyingBagItemObjBackToBag()
	local isNeedRefreshBag = false

	for gridItemObj, danglingBagItemObj in pairs(self._draggingBagItemFromGrid) do
		if danglingBagItemObj then
			danglingBagItemObj._mo:addCnt(1)

			isNeedRefreshBag = true
		end

		rawset(self._draggingBagItemFromGrid, gridItemObj, nil)
	end

	if isNeedRefreshBag and self._viewObj then
		self._viewObj:_refreshBagList()
	end
end

function GaoSiNiaoMapDragContext:onBeginDrag_BagItemObj(bagItemObj, dragObj)
	if not self._enabled then
		return
	end

	self:_clearHitInfo()

	if not self:_isValidDrag_TargetItemObj(bagItemObj) then
		return
	end

	bagItemObj:setShowCount(bagItemObj:getCount() - 1)
	self:_setDragInstToTargetItemObj(dragObj, bagItemObj)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_anzhu)
end

function GaoSiNiaoMapDragContext:onDragging_BagItemObj(bagItemObj, dragObj)
	if not self:_isValidDrag_TargetItemObj(bagItemObj) then
		self:_clearHitInfo()

		return
	end

	dragObj:tweenToScreenPos(self._draggingItemTran, nil, 0.1)

	if not self:_isInsideMapArea(dragObj) then
		self:_onHitGridItemObj(nil)

		return
	end

	self:_calcHitWhichGridItemObj(dragObj)
end

function GaoSiNiaoMapDragContext:onEndDrag_BagItemObj(bagItemObj, dragObj)
	if not self:_isValidDrag_TargetItemObj(bagItemObj) then
		self:_clearHitInfo()

		return
	end

	if self._hitGridItemObj then
		self:onPushBagToGrid(bagItemObj, self._hitGridItemObj, dragObj)
	end

	self:_refreshDraggingItem(false)
	bagItemObj:refresh()
	self:_clearHitInfo()
end

function GaoSiNiaoMapDragContext:onPushBagToGrid(bagItemObj, gridItemObj, dragObj)
	if not gohelper.isMouseOverGo(gridItemObj:transform(), dragObj.screenPos) then
		return
	end

	bagItemObj._mo:addCnt(-1)

	if self:_onPushBagToGrid(bagItemObj, gridItemObj) == false then
		bagItemObj._mo:addCnt(1)
	end
end

function GaoSiNiaoMapDragContext:_onPushBagToGrid(bagItemObj, gridItemObj)
	local lastBagItemObj = self:getPlacedBagItemObj(gridItemObj)
	local isAlreadyExist = not not lastBagItemObj

	if isAlreadyExist then
		if lastBagItemObj:getType() == bagItemObj:getType() then
			return false
		end

		lastBagItemObj._mo:addCnt(1)
		lastBagItemObj:refresh()
	end

	self:_setPlacedBagItemObj(gridItemObj, bagItemObj)

	if isAlreadyExist then
		self:_single1(gridItemObj)
	else
		self:_tryMerge1(gridItemObj)
	end

	gridItemObj:refresh()
	gridItemObj:onPushBagToGrid()
	self._viewObj:_refresh()
	self:_checkCompleteAndSetFinished()
end

function GaoSiNiaoMapDragContext:onBeginDrag_GridItemObj(gridItemObj, dragObj)
	self:_clearHitInfo()

	if not self:_isValidDrag_TargetItemObj(gridItemObj) then
		return
	end

	self._draggingBagItemFromGrid[gridItemObj] = self:getPlacedBagItemObj(gridItemObj)

	self:_setDragInstToTargetItemObj(dragObj, gridItemObj)
	self:_setPlacedBagItemObj(gridItemObj, nil)
	self:_single1(gridItemObj)
	self._viewObj:_refresh()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_anzhu)
end

function GaoSiNiaoMapDragContext:onDragging_GridItemObj(gridItemObj, dragObj)
	if not self:_isValidDrag_TargetItemObj(gridItemObj) then
		self:_clearHitInfo()

		return
	end

	dragObj:tweenToScreenPos(self._draggingItemTran, nil, 0.1)

	if not self:_isInsideMapArea(dragObj) then
		self:_onHitGridItemObj(nil)

		return
	end

	self:_calcHitWhichGridItemObj(dragObj)
end

function GaoSiNiaoMapDragContext:onEndDrag_GridItemObj(gridItemObj, dragObj)
	if not self:_isValidDrag_TargetItemObj(gridItemObj) then
		self:_clearHitInfo()

		return
	end

	self._hitGridItemObj = self._hitGridItemObj or gridItemObj

	self:_onPushGridToGrid(gridItemObj, self._hitGridItemObj, dragObj)
	self:_refreshDraggingItem(false)
	self:_clearHitInfo()
end

function GaoSiNiaoMapDragContext:_onPushGridToGrid(fromGridItemObj, toGridItemObj, dragObj)
	if not gohelper.isMouseOverGo(toGridItemObj:transform(), dragObj.screenPos) then
		return
	end

	local fromGridBagObj = self:_detachFlyingBagItemObj(fromGridItemObj)

	if fromGridItemObj == toGridItemObj then
		self:_onPushBagToGrid(fromGridBagObj, toGridItemObj)

		return
	end

	local toBagItemObj = self:getPlacedBagItemObj(toGridItemObj)

	if not toBagItemObj then
		if toGridItemObj._mo:isEmpty() then
			self:_onPushBagToGrid(fromGridBagObj, toGridItemObj)
		else
			logError("unsupported")
		end

		return
	end

	local dirtyGridItemList = self:_single({
		fromGridItemObj._mo,
		toGridItemObj._mo
	}, true)

	self:_setPlacedBagItemObj(fromGridItemObj, toBagItemObj)
	self:_setPlacedBagItemObj(toGridItemObj, fromGridBagObj)
	self:_tryMergeAll(dirtyGridItemList)
	fromGridItemObj:refresh()
	fromGridItemObj:onPushBagToGrid()
	toGridItemObj:refresh()
	toGridItemObj:onPushBagToGrid()
	self._viewObj:_refresh()
	self:_checkCompleteAndSetFinished()
end

function GaoSiNiaoMapDragContext:setEnabled(isEnabled)
	self._enabled = not not isEnabled
end

function GaoSiNiaoMapDragContext:isCompleted()
	return self._isCompleted
end

function GaoSiNiaoMapDragContext:_checkCompleteAndSetFinished()
	if self:_mapMO():isCompleted() then
		self._isCompleted = true

		self:setEnabled(false)
		self._viewObj:completeGame()
	end
end

return GaoSiNiaoMapDragContext
