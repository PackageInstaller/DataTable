-- chunkname: @modules/logic/rouge/view/RougeCollectionSizeBagItem.lua

module("modules.logic.rouge.view.RougeCollectionSizeBagItem", package.seeall)

local RougeCollectionSizeBagItem = class("RougeCollectionSizeBagItem", RougeCollectionBaseSlotItem)

function RougeCollectionSizeBagItem:onInit(go)
	RougeCollectionSizeBagItem.super.onInit(self, go)

	self._gomodelcontainer = gohelper.findChild(self.viewGO, "go_center/go_modelcontainer")
	self._gocell = gohelper.findChild(self.viewGO, "go_center/go_modelcontainer/go_cell")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionSizeBagItem:_editableInitView()
	RougeCollectionSizeBagItem.super._editableInitView(self)
	self:addClickListener()
	self:addDragListeners()

	self._edgeTab = self:getUserDataTb_()

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.SelectCollection, self._selectCollection, self)
end

function RougeCollectionSizeBagItem:addClickListener()
	self._btnclick = gohelper.getClick(self.viewGO)

	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionSizeBagItem:addDragListeners()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.viewGO)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
end

function RougeCollectionSizeBagItem:releaseAllListeners()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()

		self._drag = nil
	end

	self._btnclick:RemoveClickListener()
end

function RougeCollectionSizeBagItem:_btnclickOnClick()
	if not self._mo then
		return
	end

	local params = {
		useCloseBtn = false,
		collectionId = self._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	}

	RougeController.instance:openRougeCollectionTipView(params)
	RougeCollectionChessController.instance:selectCollection(self._mo.id)
end

function RougeCollectionSizeBagItem:_onDragBegin(param, pointerEventData)
	local canDrag = RougeCollectionHelper.isCanDragCollection()

	self._isDraging = canDrag

	if not canDrag then
		return
	end

	self:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, self._mo, pointerEventData)
end

function RougeCollectionSizeBagItem:_onDrag(param, pointerEventData)
	if not self._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, pointerEventData)
end

function RougeCollectionSizeBagItem:_onDragEnd(param, pointerEventData)
	if not self._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, pointerEventData)

	self._isDraging = false
end

function RougeCollectionSizeBagItem:onUpdateMO(mo)
	RougeCollectionSizeBagItem.super.onUpdateMO(self, mo)
	self:setShapeCellsVisible(true)
end

function RougeCollectionSizeBagItem:onUpdateRotateAngle()
	RougeCollectionSizeBagItem.super.onUpdateRotateAngle(self)
	self:refreshShapeGrids()
end

function RougeCollectionSizeBagItem:refreshShapeGrids()
	local rotation = self._mo:getRotation()
	local shapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(self._mo.cfgId, rotation, RougeEnum.CollectionEditorParamType.Shape) or {}

	gohelper.CreateObjList(self, self.refreshSlotCell, shapeCfg, self._gomodelcontainer, self._gocell)
end

function RougeCollectionSizeBagItem:refreshSlotCell(obj, cellPos, index)
	self:setCellAnchor(obj, cellPos)
	self:setCellIconImage(obj)
	self:checkAndPlaceAroundLine(obj, cellPos)
end

function RougeCollectionSizeBagItem:checkAndPlaceAroundLine(obj, cellPos)
	local shapeMap = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(self._mo.cfgId, self._mo:getRotation())
	local insideLines = RougeCollectionHelper.getSlotCellInsideLine(shapeMap, cellPos)
	local goedge = gohelper.findChild(obj, "go_edge")
	local goleft = gohelper.findChild(obj, "go_edge/go_left")
	local goright = gohelper.findChild(obj, "go_edge/go_right")
	local gobottom = gohelper.findChild(obj, "go_edge/go_bottom")
	local gotop = gohelper.findChild(obj, "go_edge/go_top")

	gohelper.setActive(goleft, true)
	gohelper.setActive(goright, true)
	gohelper.setActive(gobottom, true)
	gohelper.setActive(gotop, true)

	if insideLines then
		for _, aroundLine in pairs(insideLines) do
			if aroundLine == RougeEnum.SlotCellDirection.Left then
				gohelper.setActive(goleft, false)
			elseif aroundLine == RougeEnum.SlotCellDirection.Right then
				gohelper.setActive(goright, false)
			elseif aroundLine == RougeEnum.SlotCellDirection.Bottom then
				gohelper.setActive(gobottom, false)
			elseif aroundLine == RougeEnum.SlotCellDirection.Top then
				gohelper.setActive(gotop, false)
			end
		end
	end

	self._edgeTab[goedge] = self._edgeTab[goedge] or true
end

function RougeCollectionSizeBagItem:setCellAnchor(obj, cellPos)
	local rotation = self._mo:getRotation()
	local leftTopPos = RougeCollectionHelper.getCollectionTopLeftPos(self._mo.cfgId, rotation)
	local offset = cellPos - leftTopPos
	local anchorPosX = offset.x * self._perCellWidth
	local anchorPosY = offset.y * self._perCellHeight

	recthelper.setAnchor(obj.transform, anchorPosX, anchorPosY)
end

function RougeCollectionSizeBagItem:setCellIconImage(obj)
	local cellImg = gohelper.findChildImage(obj, "icon")

	if self._collectionCfg then
		UISpriteSetMgr.instance:setRougeSprite(cellImg, "rouge_collection_grid_big_" .. tostring(self._collectionCfg))
		recthelper.setSize(obj.transform, self._perCellWidth, self._perCellHeight)
	end
end

function RougeCollectionSizeBagItem:_selectCollection()
	if self._mo then
		local collectionId = self._mo.id
		local isSelect = RougeCollectionBagListModel.instance:isCollectionSelect(collectionId)

		self:setSelectFrameVisible(isSelect)
	end
end

function RougeCollectionSizeBagItem:setSelectFrameVisible(isVisible)
	if self._edgeTab then
		for edgeParentGO, _ in pairs(self._edgeTab) do
			gohelper.setActive(edgeParentGO, isVisible)
		end
	end
end

function RougeCollectionSizeBagItem:reset()
	RougeCollectionSizeBagItem.super.reset(self)
	self:setSelectFrameVisible(false)

	self._isDraging = false
end

function RougeCollectionSizeBagItem:setShapeCellsVisible(isVisible)
	gohelper.setActive(self._gomodelcontainer, isVisible)
end

function RougeCollectionSizeBagItem:destroy()
	self:releaseAllListeners()
	RougeCollectionSizeBagItem.super.destroy(self)
end

return RougeCollectionSizeBagItem
