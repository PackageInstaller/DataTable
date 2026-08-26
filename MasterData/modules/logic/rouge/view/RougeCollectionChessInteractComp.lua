-- chunkname: @modules/logic/rouge/view/RougeCollectionChessInteractComp.lua

module("modules.logic.rouge.view.RougeCollectionChessInteractComp", package.seeall)

local RougeCollectionChessInteractComp = class("RougeCollectionChessInteractComp", BaseView)

function RougeCollectionChessInteractComp:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_left/#go_btns")
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
	self._godragarea = gohelper.findChild(self.viewGO, "chessboard/#go_dragarea")
	self._btnslotclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_slotclosetips")
	self._btnbagclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bagclosetips")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessInteractComp:addEvents()
	self._click = gohelper.getClick(self._godragarea)

	self._click:AddClickListener(self._onClick, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godragarea)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._btnslotclosetips:AddClickListener(self._closeCollectionTipView, self)
	self._btnbagclosetips:AddClickListener(self._closeCollectionTipView, self)
end

function RougeCollectionChessInteractComp:removeEvents()
	self._click:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	self._btnslotclosetips:RemoveClickListener()
	self._btnbagclosetips:RemoveClickListener()
end

function RougeCollectionChessInteractComp:_closeCollectionTipView()
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionChessInteractComp:_onClick()
	if self._isDraging then
		return
	end

	local mousePosition = GamepadController.instance:getMousePosition()
	local placeCollectionMO = self:getPlaceCollectionMO(mousePosition)

	if not placeCollectionMO then
		self:onClickEmptyArea()

		return
	end

	self:onClickPlaceCollection(placeCollectionMO)
end

function RougeCollectionChessInteractComp:onClickEmptyArea()
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionChessInteractComp:onClickPlaceCollection(clickCollection)
	local collectionId = clickCollection.id
	local isSelect = RougeCollectionBagListModel.instance:isCollectionSelect(collectionId)

	if not isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:try2OpenCollectionTipView(clickCollection)
		RougeCollectionChessController.instance:selectCollection(collectionId)

		return
	end

	if self._tmpCollection.id ~= collectionId then
		self._tmpCollection:copyOtherMO(clickCollection)
	end

	self:rotateCollection()
end

function RougeCollectionChessInteractComp:try2OpenCollectionTipView(tipCollection)
	if not tipCollection or tipCollection.id <= 0 then
		return
	end

	local collectionId = tipCollection.id
	local source = RougeCollectionModel.instance:getCollectionPlaceArea(collectionId)
	local viewParam = {
		useCloseBtn = false,
		collectionId = collectionId,
		viewPosition = RougeEnum.CollectionTipPos.Slot,
		source = source
	}

	self._attrCallBackId = RougeCollectionChessController.instance:try2OpenCollectionTipView(collectionId, viewParam)
end

function RougeCollectionChessInteractComp:_onDragBegin(param, pointerEventData)
	local canDragCollection = RougeCollectionHelper.isCanDragCollection()

	if not canDragCollection then
		return
	end

	local collectionMO = self:getPlaceCollectionMO(pointerEventData.position)

	if not collectionMO then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, collectionMO, pointerEventData)
end

function RougeCollectionChessInteractComp:getPlaceCollectionMO(mousePosition)
	local targetGOPos = recthelper.screenPosToAnchorPos(mousePosition, self._godragContainer.transform)
	local slotPosX, slotPosY = RougeCollectionHelper.anchorPos2SlotPos(targetGOPos)
	local clickCollectionId
	local isClickSuspendCollection = self:checkIsClickSuspendCollection(slotPosX, slotPosY)

	if isClickSuspendCollection then
		clickCollectionId = self._suspendCollection.id
	end

	if not clickCollectionId or clickCollectionId <= 0 then
		clickCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(slotPosX, slotPosY)

		if self._suspendCollection and clickCollectionId == self._suspendCollection.id then
			return
		end
	end

	return (RougeCollectionModel.instance:getCollectionByUid(clickCollectionId))
end

function RougeCollectionChessInteractComp:checkIsClickSuspendCollection(posX, posY)
	if self._suspendCollection then
		local leftTopPos = self._suspendCollection:getLeftTopPos()
		local rotation = self._suspendCollection:getRotation()
		local shapeMatrix = RougeCollectionConfig.instance:getShapeMatrix(self._suspendCollection.cfgId, rotation)
		local col = posX - leftTopPos.x + 1
		local row = posY - leftTopPos.y + 1

		if shapeMatrix then
			::label_11_0::

			local var_11_0 = shapeMatrix[row]

			if shapeMatrix[row] then
				local cellValuae = shapeMatrix[row][col]

				return cellValuae and cellValuae > 0
			end
		end
	end
end

function RougeCollectionChessInteractComp:rotateCollection()
	if not self._tmpCollection then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RotateCollection)

	local isSquare = RougeCollectionHelper.isCollectionShapeAsSquare(self._tmpCollection.cfgId)

	if isSquare then
		return
	end

	local rotation = self._tmpCollection:getRotation()

	rotation = Mathf.Clamp((rotation + 1) % 4, 0, 4)

	self._tmpCollection:updateRotation(rotation)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.RotateSlotCollection, self._tmpCollection)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, self._tmpCollection)
end

function RougeCollectionChessInteractComp:_onDrag(param, pointerEventData)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, pointerEventData)
end

function RougeCollectionChessInteractComp:_onDragEnd(param, pointerEventData)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, pointerEventData)
end

function RougeCollectionChessInteractComp:_editableInitView()
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, self._beginDragCollectionCallBack, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnDragCollection, self._dragCollectionCallBack, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, self._endDragCollectionCallBack, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self._deleteSlotCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, self.onNullSpace2PlaceCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.ClearTmpCollection, self._clearTmpCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self._failed2PlaceSlotCollection, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCallBack, self)

	self._leftTopPos = Vector2.zero
	self._isDraging = false
	self._goleftCanvasGroup = gohelper.onceAddComponent(self._goleft, gohelper.Type_CanvasGroup)
end

function RougeCollectionChessInteractComp:onOpen()
	self._poolView = self.viewContainer:getRougePoolComp()
	self._tmpCollection = RougeCollectionSlotMO.New()
end

function RougeCollectionChessInteractComp:_beginDragCollectionCallBack(collectionMO, pointerEventData)
	if not collectionMO or collectionMO.id <= 0 then
		return
	end

	local isCanDragCollection = RougeCollectionHelper.isCanDragCollection()

	if not isCanDragCollection then
		return
	end

	self._isDraging = true
	self._pointerId = pointerEventData.pointerId
	self._suspendCollection = nil

	gohelper.setActive(self._godragContainer, true)

	if self._tmpCollection.id ~= collectionMO.id then
		self._tmpCollection:copyOtherMO(collectionMO)
	end

	local isBagCollection = RougeCollectionModel.instance:isCollectionPlaceInBag(collectionMO.id)

	if isBagCollection then
		RougeCollectionChessController.instance:closeCollectionTipView()
	else
		local isOpen = ViewMgr.instance:isOpen(ViewName.RougeCollectionTipView)

		if isOpen then
			self:try2OpenCollectionTipView(collectionMO)
		end

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, false)
	end

	RougeCollectionChessController.instance:selectCollection(collectionMO.id)
	self:updateDragCollection(pointerEventData)
	AudioMgr.instance:trigger(AudioEnum.UI.DragCollection)
end

function RougeCollectionChessInteractComp:_dragCollectionCallBack(pointerEventData)
	local isRespone = self:checkIsResponeDragEvent(pointerEventData)

	if not isRespone then
		return
	end

	self:updateDragCollection(pointerEventData)
end

function RougeCollectionChessInteractComp:_endDragCollectionCallBack(pointerEventData)
	local isRespone = self:checkIsResponeDragEvent(pointerEventData)

	if not isRespone then
		return
	end

	self:updateDragCollection(pointerEventData)
	self:onAfterEndDragCollection()
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, true)
end

function RougeCollectionChessInteractComp:updateDragCollection(pointerEventData)
	if not self._isDraging or not self._tmpCollection then
		return
	end

	local collectionMO = self._tmpCollection
	local dragPosition = recthelper.screenPosToAnchorPos(pointerEventData.position, self._godragContainer.transform)
	local collectionCfgId = collectionMO.cfgId
	local rotation = collectionMO:getRotation()
	local dragPosX, dragPosY = RougeCollectionHelper.getCollectionDragPos(collectionCfgId, rotation)

	if dragPosX and dragPosY then
		local slotCellSize = RougeCollectionHelper.getSlotCellSize()
		local goPosX = dragPosition.x - slotCellSize.x * (dragPosX - 0.5)
		local goPosY = dragPosition.y + slotCellSize.y * (dragPosY - 0.5)
		local dragSlotPosX, dragSlotPosY = RougeCollectionHelper.anchorPos2SlotPos(dragPosition)

		self._leftTopPos.x = dragSlotPosX - dragPosX + 1
		self._leftTopPos.y = dragSlotPosY - dragPosY + 1

		collectionMO:updateLeftTopPos(self._leftTopPos)

		self._curDragItem = self:_getOrCreateTmpCollection()

		self._curDragItem:onUpdateMO(collectionMO)
		self._curDragItem:setCollectionPosition(goPosX, goPosY)
		self._curDragItem:setShapeCellsVisible(true)
		self._curDragItem:setSelectFrameVisible(true)
		self._curDragItem:setHoleToolVisible(false)
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCellState, collectionMO)
	end
end

function RougeCollectionChessInteractComp:checkIsResponeDragEvent(pointerEventData)
	local isSamePointerId = pointerEventData and pointerEventData.pointerId == self._pointerId

	return isSamePointerId and self._isDraging
end

function RougeCollectionChessInteractComp:onAfterEndDragCollection()
	if not self._curDragItem or not self._tmpCollection then
		return
	end

	self._isDraging = false

	gohelper.setActive(self._godragContainer, self._isDraging)

	local collectionTran = self._curDragItem:getCollectionTransform()
	local dragCollectionPos = recthelper.rectToRelativeAnchorPos(collectionTran.position, self._godragContainer.transform)

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, self._tmpCollection, dragCollectionPos)
	self:_recycleDragCollection()
end

function RougeCollectionChessInteractComp:onNullSpace2PlaceCollection(collectionMO)
	self._suspendCollection = collectionMO
end

function RougeCollectionChessInteractComp:_getOrCreateTmpCollection()
	if not self._curDragItem then
		self._curDragItem = self._poolView:getCollectionItem(RougeCollectionDragItem.__cname)

		self._curDragItem:setParent(self._godragContainer.transform, false)
	end

	return self._curDragItem
end

function RougeCollectionChessInteractComp:_recycleDragCollection()
	if self._curDragItem then
		self._poolView:recycleCollectionItem(RougeCollectionDragItem.__cname, self._curDragItem)

		self._curDragItem = nil
	end
end

function RougeCollectionChessInteractComp:_recycleSuspendCollection()
	if self._suspendCollection then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, self._suspendCollection.id)

		self._suspendCollection = nil
	end
end

function RougeCollectionChessInteractComp:_clearTmpCollection()
	self._isDraging = false

	self:_recycleDragCollection()
	self:_recycleSuspendCollection()
	RougeCollectionChessController.instance:deselectCollection()
end

function RougeCollectionChessInteractComp:_deleteSlotCollection(collectionId)
	if self._tmpCollection and self._tmpCollection.id == collectionId then
		self._tmpCollection:reset()
	end
end

function RougeCollectionChessInteractComp:_failed2PlaceSlotCollection(collectionId, isDelete)
	self:_deleteSlotCollection(collectionId)
end

function RougeCollectionChessInteractComp:_onOpenViewCallBack(viewName, viewParam)
	if viewName == ViewName.RougeCollectionTipView then
		self:_setLeftInteractable(false)

		local isOpenSlotTips = viewParam and viewParam.source == RougeEnum.OpenCollectionTipSource.SlotArea
		local isOpenBagTips = viewParam and viewParam.source == RougeEnum.OpenCollectionTipSource.BagArea

		gohelper.setActive(self._btnslotclosetips.gameObject, isOpenSlotTips)
		gohelper.setActive(self._btnbagclosetips.gameObject, isOpenBagTips)
	end
end

function RougeCollectionChessInteractComp:_onCloseViewCallBack(viewName)
	if viewName == ViewName.RougeCollectionTipView then
		self:_setLeftInteractable(true)
		gohelper.setActive(self._btnslotclosetips.gameObject, false)
		gohelper.setActive(self._btnbagclosetips.gameObject, false)
	end
end

function RougeCollectionChessInteractComp:_setLeftInteractable(interactable)
	self._goleftCanvasGroup.blocksRaycasts = interactable
end

function RougeCollectionChessInteractComp:onClose()
	return
end

function RougeCollectionChessInteractComp:onDestroyView()
	self._poolView = nil

	if self._curDragItem then
		self._curDragItem:destroy()

		self._curDragItem = nil
	end

	if self._attrCallBackId then
		RougeRpc.instance:removeCallbackById(self._attrCallBackId)

		self._attrCallBackId = nil
	end
end

return RougeCollectionChessInteractComp
