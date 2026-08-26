-- chunkname: @modules/logic/rouge/view/RougeCollectionChessView.lua

module("modules.logic.rouge.view.RougeCollectionChessView", package.seeall)

local RougeCollectionChessView = class("RougeCollectionChessView", RougeBaseDLCViewComp)

function RougeCollectionChessView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._goeffectContainer = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer")
	self._gotriggerContainer = gohelper.findChild(self.viewGO, "chessboard/#go_triggerContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	self._golineContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_lineContainer")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	self._btnlayout = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_layout")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_clear")
	self._btnauto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_auto")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_overview")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_handbook")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessView:addEvents()
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btnauto:AddClickListener(self._btnautoOnClick, self)
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
end

function RougeCollectionChessView:removeEvents()
	self._btnlayout:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btnauto:RemoveClickListener()
	self._btnoverview:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
end

function RougeCollectionChessView:_btnclearOnClick()
	local isCanDragCollection = RougeCollectionHelper.isCanDragCollection()

	if not isCanDragCollection then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyClearCollectionSlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyClearSlotArea)
end

function RougeCollectionChessView:_btnautoOnClick()
	local isCanDragCollection = RougeCollectionHelper.isCanDragCollection()

	if not isCanDragCollection then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyPlaceCollection2SlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyPlaceSlotArea)
end

function RougeCollectionChessView:_btnoverviewOnClick()
	RougeController.instance:openRougeCollectionOverView()
end

function RougeCollectionChessView:_btnhandbookOnClick()
	RougeController.instance:openRougeCollectionHandBookView()
end

function RougeCollectionChessView:_editableInitView()
	self:initAllContainerPosition()
	self:checkAndSetHandBookIconVisible()
end

function RougeCollectionChessView:onOpen()
	RougeCollectionChessView.super.onOpen(self)
	self:startCheckCollectionCfgs()
	RougeCollectionChessController.instance:onOpen()
	RougeStatController.instance:startAdjustBackPack()
end

function RougeCollectionChessView:onClose()
	RougeStatController.instance:endAdjustBackPack()
end

function RougeCollectionChessView:startCheckCollectionCfgs()
	RougeCollectionDebugHelper.checkCollectionStaticItmeCfgs()
	RougeCollectionDebugHelper.checkCollectionDescCfgs()
end

function RougeCollectionChessView:initAllContainerPosition()
	local cellSize = RougeCollectionHelper.CollectionSlotCellSize
	local containerTab = {
		self._gomeshContainer,
		self._goeffectContainer,
		self._gotriggerContainer,
		self._gocellModel,
		self._golineContainer,
		self._godragContainer
	}
	local anchorMin = Vector2(0, 1)
	local anchorMax = Vector2(0, 1)
	local posX = cellSize.x / 2
	local posY = -cellSize.y / 2

	for _, containerGO in pairs(containerTab) do
		recthelper.setSize(containerGO.transform, cellSize.x, cellSize.y)
		recthelper.setAnchor(containerGO.transform, posX, posY)

		containerGO.transform.anchorMin = anchorMin
		containerGO.transform.anchorMax = anchorMax
	end
end

function RougeCollectionChessView:checkAndSetHandBookIconVisible()
	local rougeRecord = RougeOutsideModel.instance:getRougeGameRecord()
	local isLayerPass = false

	if rougeRecord then
		local constCfg = lua_rouge_const.configDict[RougeEnum.Const.CompositeEntryVisible]
		local layerId = constCfg and tonumber(constCfg.value) or 0

		isLayerPass = rougeRecord:passLayerId(layerId)
	end

	gohelper.setActive(self._btnhandbook.gameObject, isLayerPass)
end

return RougeCollectionChessView
