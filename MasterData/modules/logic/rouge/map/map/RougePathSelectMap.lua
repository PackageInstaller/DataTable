-- chunkname: @modules/logic/rouge/map/map/RougePathSelectMap.lua

module("modules.logic.rouge.map.map.RougePathSelectMap", package.seeall)

local RougePathSelectMap = class("RougePathSelectMap", RougeBaseMap)

function RougePathSelectMap:initMap()
	RougePathSelectMap.super.initMap(self)

	local cameraSize = RougeMapConfig.instance:getPathSelectInitCameraSize()

	RougeMapModel.instance:setCameraSize(cameraSize)

	local mapSize = RougeMapModel.instance:getMapSize()

	transformhelper.setLocalPos(self.mapTransform, -mapSize.x / 2, mapSize.y / 2, RougeMapEnum.OffsetZ.Map)
end

function RougePathSelectMap:createMap()
	self.actorComp = nil

	RougePathSelectMap.super.createMap(self)
	TaskDispatcher.runDelay(self.focusToTarget, self, RougeMapEnum.PathSelectMapWaitTime)

	self.openViewDone = ViewMgr.instance:isOpen(ViewName.RougeMapView)

	if not ViewMgr.instance:isOpen(ViewName.RougeMapView) then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	end
end

function RougePathSelectMap:onOpenView(viewName)
	if viewName == ViewName.RougeMapView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)

		self.openViewDone = true

		self:_focusToTarget()
	end
end

function RougePathSelectMap:focusToTarget()
	self.delayDone = true

	self:_focusToTarget()
end

function RougePathSelectMap:_focusToTarget()
	if not self.delayDone or not self.openViewDone then
		return
	end

	self:clearTween()

	local pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	local focusPos = string.splitToNumber(pathSelectCo.focusMapPos, "#")

	self.movingTweenId = ZProj.TweenHelper.DOLocalMove(self.mapTransform, focusPos[1], focusPos[2], RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, self.onMovingDone, self)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocus, pathSelectCo.focusCameraSize)
end

function RougePathSelectMap:onMovingDone()
	self.movingTweenId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocusDone)
end

function RougePathSelectMap:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function RougePathSelectMap:destroy()
	self:clearTween()
	TaskDispatcher.cancelTask(self.focusToTarget, self)
	RougePathSelectMap.super.destroy(self)
end

return RougePathSelectMap
