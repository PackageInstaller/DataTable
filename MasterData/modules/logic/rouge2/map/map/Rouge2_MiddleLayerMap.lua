-- chunkname: @modules/logic/rouge2/map/map/Rouge2_MiddleLayerMap.lua

module("modules.logic.rouge2.map.map.Rouge2_MiddleLayerMap", package.seeall)

local Rouge2_MiddleLayerMap = class("Rouge2_MiddleLayerMap", Rouge2_BaseMap)

function Rouge2_MiddleLayerMap:initMap()
	Rouge2_MiddleLayerMap.super.initMap(self)

	local cameraSize = self:getCameraSize()

	Rouge2_MapModel.instance:setCameraSize(cameraSize)
	transformhelper.setLocalPos(self.mapTransform, 0, 0, Rouge2_MapEnum.OffsetZ.Map)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
end

function Rouge2_MiddleLayerMap:getCameraSize()
	return Rouge2_MapHelper.getMiddleLayerCameraSize()
end

function Rouge2_MiddleLayerMap:createMapNodeContainer()
	Rouge2_MiddleLayerMap.super.createMapNodeContainer(self)

	self.goPieceIconContainer = gohelper.create3d(self.mapGo, "pieceIconContainer")

	transformhelper.setLocalPos(self.goPieceIconContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.PiecesContainer)
end

function Rouge2_MiddleLayerMap:handleOtherRes(loader)
	self.luoLeiLaiEffectPrefab = loader:getAssetItem(Rouge2_MapEnum.PieceBossEffect):GetResource()
	self.piecePrefabDict = self:getUserDataTb_()

	local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()
	local dayOrNight = middleLayerCo.dayOrNight
	local pieceMoList = Rouge2_MapModel.instance:getPieceList()

	for _, pieceMo in ipairs(pieceMoList) do
		local co = pieceMo:getPieceCo()
		local res = co.pieceRes

		if not string.nilorempty(res) then
			res = Rouge2_MapHelper.getPieceResPath(res, dayOrNight)
			self.piecePrefabDict[res] = self.piecePrefabDict[res] or loader:getAssetItem(res):GetResource()
		end
	end

	local actorPiecePath = Rouge2_MapHelper.getPieceResPath(Rouge2_MapEnum.ActorPiecePath, dayOrNight)

	loader:addPath(actorPiecePath)

	self.actorPiecePrefab = loader:getAssetItem(actorPiecePath):GetResource()
	self.iconCanvasPrefab = loader:getAssetItem(Rouge2_MapEnum.MiddlePieceIconCanvas):GetResource()
end

function Rouge2_MiddleLayerMap:createMap()
	self:createIconContainer()
	self:createPiece()
	self:createLeavePiece()

	self.goActor = gohelper.clone(self.actorPiecePrefab, self.goLayerPiecesContainer, "actor")
	self.actorComp = Rouge2_MapMiddleLayerActorComp.New()

	self.actorComp:init(self.goActor, self)

	self.animator = gohelper.onceAddComponent(self.mapGo, gohelper.Type_Animator)
	self.animator.speed = 0

	TaskDispatcher.runDelay(self.playEnterAnim, self, Rouge2_MapEnum.WaitMiddleLayerEnterTime)
	Rouge2_MiddleLayerMap.super.createMap(self)
end

function Rouge2_MiddleLayerMap:playEnterAnim()
	self.animator.speed = 1
end

function Rouge2_MiddleLayerMap:createIconContainer()
	local goPieceIconCanvas = gohelper.clone(self.iconCanvasPrefab, self.goPieceIconContainer, "pieceIconCanvas")

	self.pieceIconCanvas = MonoHelper.addNoUpdateLuaComOnceToGo(goPieceIconCanvas, Rouge2_MiddleMapPieceIconCanvas)
end

function Rouge2_MiddleLayerMap:createPiece()
	local pieceList = Rouge2_MapModel.instance:getPieceList()

	for _, pieceMo in ipairs(pieceList) do
		local pieceItem = Rouge2_MapPieceItem.New()

		pieceItem:init(pieceMo, self)
		self:addMapItem(pieceItem)
	end
end

function Rouge2_MiddleLayerMap:createLeavePiece()
	if not Rouge2_MapModel.instance:hadLeavePos() then
		return
	end

	local leaveItem = Rouge2_MapLeaveItem.New()

	leaveItem:init(self)
	self:addMapItem(leaveItem)
end

function Rouge2_MiddleLayerMap:onMiddleActorBeforeMove(data)
	local focusPos = data.focusPos

	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOLocalMove(self.mapTransform, -focusPos.x, -focusPos.y, Rouge2_MapEnum.OffsetZ.Map, Rouge2_MapEnum.RevertDuration, self.onMovingDone, self)
end

function Rouge2_MiddleLayerMap:onExitPieceChoiceEvent()
	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOLocalMove(self.mapTransform, 0, 0, Rouge2_MapEnum.OffsetZ.Map, Rouge2_MapEnum.RevertDuration, self.onMovingDone, self)
end

function Rouge2_MiddleLayerMap:onMovingDone()
	self.movingTweenId = nil
end

function Rouge2_MiddleLayerMap:getActorPos()
	local posIndex = Rouge2_MapModel.instance:getCurPosIndex() + 1
	local pathIndex = Rouge2_MapModel.instance:getPathIndex(posIndex)
	local pos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	return pos.x, pos.y
end

function Rouge2_MiddleLayerMap:getLeaveItem()
	return self:getMapItem(Rouge2_MapEnum.LeaveId)
end

function Rouge2_MiddleLayerMap:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function Rouge2_MiddleLayerMap:destroy()
	TaskDispatcher.cancelTask(self.playEnterAnim, self)
	self:clearTween()
	Rouge2_MiddleLayerMap.super.destroy(self)
end

return Rouge2_MiddleLayerMap
