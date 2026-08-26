-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapMiddleLayerActorComp.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapMiddleLayerActorComp", package.seeall)

local RougeMapMiddleLayerActorComp = class("RougeMapMiddleLayerActorComp", RougeMapBaseActorComp)

function RougeMapMiddleLayerActorComp:initActor()
	RougeMapMiddleLayerActorComp.super.initActor(self)

	self.pathList = {}
	self.lenRateList = {}

	self:refreshDir()
end

function RougeMapMiddleLayerActorComp:refreshDir()
	self:initDirGo()

	local curPosIndex = RougeMapModel.instance:getCurPosIndex()
	local startPos, facePos

	if curPosIndex == 0 then
		startPos = RougeMapModel.instance:getMiddleLayerPosByIndex(1)
		facePos = RougeMapModel.instance:getMiddleLayerPathPos(1)
	else
		local pieceIndex = curPosIndex + 1
		local pathIndex = RougeMapModel.instance:getPathIndex(pieceIndex)

		startPos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)
		facePos = RougeMapModel.instance:getMiddleLayerPosByIndex(pieceIndex)
	end

	local angle = RougeMapHelper.getAngle(startPos.x, startPos.y, facePos.x, facePos.y)
	local dir = RougeMapHelper:getActorDir(angle)

	self:_refreshDir(dir)
end

function RougeMapMiddleLayerActorComp:initDirGo()
	if self.directionGoMap then
		return
	end

	self.directionGoMap = self:getUserDataTb_()

	for _, dir in pairs(RougeMapEnum.ActorDir) do
		self.directionGoMap[dir] = gohelper.findChild(self.goActor, tostring(dir))
	end
end

function RougeMapMiddleLayerActorComp:moveToLeaveItem(callback, callbackObj)
	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj

	local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()

	if not middleLayerCo.leavePos then
		self:onMovingDone()

		return
	end

	local startIndex = RougeMapModel.instance:getCurPosIndex() + 1

	startIndex = RougeMapModel.instance:getPathIndex(startIndex)

	local endIndex = RougeMapModel.instance:getMiddleLayerLeavePathIndex()

	tabletool.clear(self.pathList)
	tabletool.clear(self.lenRateList)
	RougeMapConfig.instance:getPathIndexList(middleLayerCo.pathDict, startIndex, endIndex, self.pathList)

	local len = RougeMapHelper.getMiddleLayerPathListLen(middleLayerCo, self.pathList, self.lenRateList)
	local duration = len / RougeMapEnum.MoveSpeed
	local pathIndex = RougeMapModel.instance:getMiddleLayerLeavePathIndex()
	local focusPos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = focusPos,
		pieceId = RougeMapEnum.LeaveId
	})

	self.targetPos = focusPos
	self.targetFacePos = middleLayerCo.leavePos
	self.lastStartIndex = nil
	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self.onMoveToPieceFrameCallback, self.onMovingDone, self, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	self:startBlock()
end

function RougeMapMiddleLayerActorComp:moveToPieceItem(pieceMo, callback, callbackObj)
	local startIndex = RougeMapModel.instance:getCurPosIndex() + 1

	startIndex = RougeMapModel.instance:getPathIndex(startIndex)

	local endIndex = RougeMapModel.instance:getPathIndex(pieceMo.index + 1)

	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj

	local pointIndex = pieceMo.index + 1
	local pathIndex = RougeMapModel.instance:getPathIndex(pointIndex)
	local focusPos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(pathIndex)

	if startIndex == endIndex then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
			focusPos = focusPos,
			pieceId = pieceMo.id
		})
		self:onMovingDone()

		return
	end

	tabletool.clear(self.pathList)
	tabletool.clear(self.lenRateList)

	local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()

	RougeMapConfig.instance:getPathIndexList(middleLayerCo.pathDict, startIndex, endIndex, self.pathList)

	local len = RougeMapHelper.getMiddleLayerPathListLen(middleLayerCo, self.pathList, self.lenRateList)
	local duration = len / RougeMapEnum.MoveSpeed

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = focusPos,
		pieceId = pieceMo.id
	})

	self.targetPos = focusPos
	self.targetFacePos = RougeMapModel.instance:getMiddleLayerPosByIndex(pointIndex)
	self.lastStartIndex = nil
	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self.onMoveToPieceFrameCallback, self.onMovingDone, self, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	self:startBlock()
end

function RougeMapMiddleLayerActorComp:onMoveToPieceFrameCallback(value)
	local startIndex

	for i, rate in ipairs(self.lenRateList) do
		startIndex = i

		if value < rate then
			break
		end
	end

	local startPos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(self.pathList[startIndex])
	local endPos = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(self.pathList[startIndex + 1])

	if self.lastStartIndex ~= startIndex then
		self.lastStartIndex = startIndex

		local angle = RougeMapHelper.getAngle(startPos.x, startPos.y, endPos.x, endPos.y)
		local dir = RougeMapHelper:getActorDir(angle)

		self:_refreshDir(dir)
	end

	if not self.lenRateList[startIndex - 1] then
		local preTotalRate = 0
		local rate = value - preTotalRate

		rate = rate / (self.lenRateList[startIndex] - preTotalRate)

		local x = Mathf.Lerp(startPos.x, endPos.x, rate)
		local y = Mathf.Lerp(startPos.y, endPos.y, rate)

		transformhelper.setLocalPos(self.trActor, x, y, RougeMapHelper.getOffsetZ(y))
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorPosChange, self.trActor.position)
	end
end

function RougeMapMiddleLayerActorComp:onMovingDone()
	if self.targetFacePos and self.targetPos then
		local angle = RougeMapHelper.getAngle(self.targetPos.x, self.targetPos.y, self.targetFacePos.x, self.targetFacePos.y)
		local dir = RougeMapHelper:getActorDir(angle)

		self:_refreshDir(dir)
	end

	RougeMapMiddleLayerActorComp.super.onMovingDone(self)
end

function RougeMapMiddleLayerActorComp:_refreshDir(dir)
	for _dir, go in pairs(self.directionGoMap) do
		gohelper.setActive(go, _dir == dir)
	end
end

return RougeMapMiddleLayerActorComp
