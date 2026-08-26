-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapMiddleLayerActorComp.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapMiddleLayerActorComp", package.seeall)

local Rouge2_MapMiddleLayerActorComp = class("Rouge2_MapMiddleLayerActorComp", Rouge2_MapBaseActorComp)

function Rouge2_MapMiddleLayerActorComp:initActor()
	Rouge2_MapMiddleLayerActorComp.super.initActor(self)

	self.pathList = {}
	self.lenRateList = {}

	self:refreshDir()
end

function Rouge2_MapMiddleLayerActorComp:refreshDir()
	self:initDirGo()

	local curPosIndex = Rouge2_MapModel.instance:getCurPosIndex()
	local startPos, facePos

	if curPosIndex == 0 then
		startPos = Rouge2_MapModel.instance:getMiddleLayerPosByIndex(1)
		facePos = Rouge2_MapModel.instance:getMiddleLayerPathPos(1)
	else
		local pieceIndex = curPosIndex + 1
		local pathIndex = Rouge2_MapModel.instance:getPathIndex(pieceIndex)

		startPos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)
		facePos = Rouge2_MapModel.instance:getMiddleLayerPosByIndex(pieceIndex)
	end

	local angle = Rouge2_MapHelper.getAngle(startPos.x, startPos.y, facePos.x, facePos.y)
	local dir = Rouge2_MapHelper.getActorDir(angle)

	self:_refreshDir(dir)
end

function Rouge2_MapMiddleLayerActorComp:initDirGo()
	if self.directionGoMap then
		return
	end

	self.directionGoMap = self:getUserDataTb_()

	for _, dir in pairs(Rouge2_MapEnum.ActorDir) do
		self.directionGoMap[dir] = gohelper.findChild(self.goActor, string.format("zhu_%s", dir))
	end
end

function Rouge2_MapMiddleLayerActorComp:moveToLeaveItem(callback, callbackObj)
	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj

	local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()

	if not middleLayerCo.leavePos then
		self:onMovingDone()

		return
	end

	local startIndex = Rouge2_MapModel.instance:getCurPosIndex() + 1

	startIndex = Rouge2_MapModel.instance:getPathIndex(startIndex)

	local endIndex = Rouge2_MapModel.instance:getMiddleLayerLeavePathIndex()

	tabletool.clear(self.pathList)
	tabletool.clear(self.lenRateList)
	Rouge2_MapConfig.instance:getPathIndexList(middleLayerCo.pathDict, startIndex, endIndex, self.pathList)

	local len = Rouge2_MapHelper.getMiddleLayerPathListLen(middleLayerCo, self.pathList, self.lenRateList)
	local duration = len / Rouge2_MapEnum.MoveSpeed
	local pathIndex = Rouge2_MapModel.instance:getMiddleLayerLeavePathIndex()
	local focusPos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onMiddleActorBeforeMove, {
		focusPos = focusPos,
		pieceId = Rouge2_MapEnum.LeaveId
	})

	self.targetPos = focusPos
	self.targetFacePos = middleLayerCo.leavePos
	self.lastStartIndex = nil
	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self.onMoveToPieceFrameCallback, self.onMovingDone, self, nil, Rouge2_MapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.Rouge2.StartMoveActor)
	self:startBlock()
end

function Rouge2_MapMiddleLayerActorComp:moveToPieceItem(pieceMo, callback, callbackObj)
	local startIndex = Rouge2_MapModel.instance:getCurPosIndex() + 1

	startIndex = Rouge2_MapModel.instance:getPathIndex(startIndex)

	local endIndex = Rouge2_MapModel.instance:getPathIndex(pieceMo.index + 1)

	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj

	local pointIndex = pieceMo.index + 1
	local pathIndex = Rouge2_MapModel.instance:getPathIndex(pointIndex)
	local focusPos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	if startIndex == endIndex then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onMiddleActorBeforeMove, {
			focusPos = focusPos,
			pieceId = pieceMo.id
		})
		self:onMovingDone()

		return
	end

	tabletool.clear(self.pathList)
	tabletool.clear(self.lenRateList)

	local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()

	Rouge2_MapConfig.instance:getPathIndexList(middleLayerCo.pathDict, startIndex, endIndex, self.pathList)

	local len = Rouge2_MapHelper.getMiddleLayerPathListLen(middleLayerCo, self.pathList, self.lenRateList)
	local duration = len / Rouge2_MapEnum.MoveSpeed

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onMiddleActorBeforeMove, {
		focusPos = focusPos,
		pieceId = pieceMo.id
	})

	self.targetPos = focusPos
	self.targetFacePos = Rouge2_MapModel.instance:getMiddleLayerPosByIndex(pointIndex)
	self.lastStartIndex = nil
	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self.onMoveToPieceFrameCallback, self.onMovingDone, self, nil, Rouge2_MapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	self:startBlock()
end

function Rouge2_MapMiddleLayerActorComp:onMoveToPieceFrameCallback(value)
	local startIndex

	for i, rate in ipairs(self.lenRateList) do
		startIndex = i

		if value < rate then
			break
		end
	end

	local startPos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(self.pathList[startIndex])
	local endPos = Rouge2_MapModel.instance:getMiddleLayerPathPosByPathIndex(self.pathList[startIndex + 1])

	if self.lastStartIndex ~= startIndex then
		self.lastStartIndex = startIndex

		local angle = Rouge2_MapHelper.getAngle(startPos.x, startPos.y, endPos.x, endPos.y)
		local dir = Rouge2_MapHelper.getActorDir(angle)

		self:_refreshDir(dir)
	end

	if not self.lenRateList[startIndex - 1] then
		local preTotalRate = 0
		local rate = value - preTotalRate

		rate = rate / (self.lenRateList[startIndex] - preTotalRate)

		local x = Mathf.Lerp(startPos.x, endPos.x, rate)
		local y = Mathf.Lerp(startPos.y, endPos.y, rate)

		transformhelper.setLocalPos(self.trActor, x, y, Rouge2_MapHelper.getOffsetZ(y))
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onActorPosChange, self.trActor.position)
	end
end

function Rouge2_MapMiddleLayerActorComp:onMovingDone()
	if self.targetFacePos and self.targetPos then
		local angle = Rouge2_MapHelper.getAngle(self.targetPos.x, self.targetPos.y, self.targetFacePos.x, self.targetFacePos.y)
		local dir = Rouge2_MapHelper.getActorDir(angle)

		self:_refreshDir(dir)
	end

	Rouge2_MapMiddleLayerActorComp.super.onMovingDone(self)
end

function Rouge2_MapMiddleLayerActorComp:_refreshDir(dir)
	for _dir, go in pairs(self.directionGoMap) do
		gohelper.setActive(go, _dir == dir)
	end
end

return Rouge2_MapMiddleLayerActorComp
