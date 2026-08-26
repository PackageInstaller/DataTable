-- chunkname: @modules/logic/rouge/map/map/RougeMiddleLayerMap.lua

module("modules.logic.rouge.map.map.RougeMiddleLayerMap", package.seeall)

local RougeMiddleLayerMap = class("RougeMiddleLayerMap", RougeBaseMap)

function RougeMiddleLayerMap:initMap()
	RougeMiddleLayerMap.super.initMap(self)

	local cameraSize = self:getCameraSize()

	RougeMapModel.instance:setCameraSize(cameraSize)
	transformhelper.setLocalPos(self.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
end

function RougeMiddleLayerMap:getCameraSize()
	return RougeMapHelper.getMiddleLayerCameraSize()
end

function RougeMiddleLayerMap:createMapNodeContainer()
	RougeMiddleLayerMap.super.createMapNodeContainer(self)

	self.goPieceIconContainer = gohelper.create3d(self.mapGo, "pieceIconContainer")

	transformhelper.setLocalPos(self.goPieceIconContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PieceIcon)
end

function RougeMiddleLayerMap:handleOtherRes(loader)
	self.middleLayerLeavePrefab = loader:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
	self.luoLeiLaiEffectPrefab = loader:getAssetItem(RougeMapEnum.PieceBossEffect):GetResource()
	self.piecePrefabDict = self:getUserDataTb_()

	local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()
	local dayOrNight = middleLayerCo.dayOrNight
	local pieceMoList = RougeMapModel.instance:getPieceList()

	for _, pieceMo in ipairs(pieceMoList) do
		local co = pieceMo:getPieceCo()
		local res = co.pieceRes

		if not string.nilorempty(res) then
			res = RougeMapHelper.getPieceResPath(res, dayOrNight)
			self.piecePrefabDict[res] = self.piecePrefabDict[res] or loader:getAssetItem(res):GetResource()
		end
	end

	self.iconPrefabDict = self:getUserDataTb_()

	for key, res in pairs(RougeMapEnum.PieceIconRes) do
		self.iconPrefabDict[key] = loader:getAssetItem(res):GetResource()
	end

	self.iconBgPrefabDict = self:getUserDataTb_()

	for key, res in pairs(RougeMapEnum.PieceIconBgRes) do
		self.iconBgPrefabDict[key] = loader:getAssetItem(res):GetResource()
	end

	local actorPiecePath = RougeMapHelper.getPieceResPath(RougeMapEnum.ActorPiecePath, dayOrNight)

	loader:addPath(actorPiecePath)

	self.actorPiecePrefab = loader:getAssetItem(actorPiecePath):GetResource()
end

function RougeMiddleLayerMap:createMap()
	self:createPiece()
	self:createLeavePiece()

	self.goActor = gohelper.clone(self.actorPiecePrefab, self.goLayerPiecesContainer, "actor")
	self.actorComp = RougeMapMiddleLayerActorComp.New()

	self.actorComp:init(self.goActor, self)

	self.animator = self.mapGo:GetComponent(gohelper.Type_Animator)
	self.animator.speed = 0

	TaskDispatcher.runDelay(self.playEnterAnim, self, RougeMapEnum.WaitMiddleLayerEnterTime)
	RougeMiddleLayerMap.super.createMap(self)
end

function RougeMiddleLayerMap:playEnterAnim()
	self.animator.speed = 1
end

function RougeMiddleLayerMap:createPiece()
	local pieceList = RougeMapModel.instance:getPieceList()

	for _, pieceMo in ipairs(pieceList) do
		local pieceItem = RougeMapPieceItem.New()

		pieceItem:init(pieceMo, self)
		self:addMapItem(pieceItem)
	end
end

function RougeMiddleLayerMap:createLeavePiece()
	if not RougeMapModel.instance:hadLeavePos() then
		return
	end

	local leaveItem = RougeMapLeaveItem.New()

	leaveItem:init(self)
	self:addMapItem(leaveItem)
end

function RougeMiddleLayerMap:onMiddleActorBeforeMove(data)
	local focusPos = data.focusPos

	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOLocalMove(self.mapTransform, -focusPos.x, -focusPos.y, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, self.onMovingDone, self)
end

function RougeMiddleLayerMap:onExitPieceChoiceEvent()
	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOLocalMove(self.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, self.onMovingDone, self)
end

function RougeMiddleLayerMap:onMovingDone()
	self.movingTweenId = nil
end

function RougeMiddleLayerMap:getActorPos()
	local posIndex = RougeMapModel.instance:getCurPosIndex() + 1
	local pathIndex = RougeMapModel.instance:getPathIndex(posIndex)
	local pos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	return pos.x, pos.y
end

function RougeMiddleLayerMap:getLeaveItem()
	return self:getMapItem(RougeMapEnum.LeaveId)
end

function RougeMiddleLayerMap:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function RougeMiddleLayerMap:destroy()
	TaskDispatcher.cancelTask(self.playEnterAnim, self)
	self:clearTween()
	RougeMiddleLayerMap.super.destroy(self)
end

return RougeMiddleLayerMap
