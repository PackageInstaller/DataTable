-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapNormalLayerActorComp.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapNormalLayerActorComp", package.seeall)

local RougeMapNormalLayerActorComp = class("RougeMapNormalLayerActorComp", RougeMapBaseActorComp)

function RougeMapNormalLayerActorComp:init(go, map)
	RougeMapNormalLayerActorComp.super.init(self, go, map)

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goActor)

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, self.moveToEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function RougeMapNormalLayerActorComp:moveToMapItem(id, callback, callbackObj)
	id = id or RougeMapModel.instance:getCurNode().nodeId

	local mapItem = self.map:getMapItem(id)
	local x, y, z = mapItem:getActorPos()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNormalActorBeforeMove)
	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj
	self.targetX, self.targetY = x, y

	AudioMgr.instance:trigger(AudioEnum.UI.NormalLayerMove)
	self.animatorPlayer:Play("start", self.onStartAnimDone, self)
	TaskDispatcher.runDelay(self.onStartAnimDone, self, 0.5)
	self:startBlock()
end

function RougeMapNormalLayerActorComp:onStartAnimDone()
	TaskDispatcher.cancelTask(self.onStartAnimDone, self)
	transformhelper.setLocalPos(self.trActor, self.targetX, self.targetY, RougeMapHelper.getOffsetZ(self.targetY))
	self.animatorPlayer:Play("stop", self.onMovingDone, self)
	TaskDispatcher.runDelay(self.onMovingDone, self, 0.8)
end

function RougeMapNormalLayerActorComp:onCloseViewFinish(viewName)
	if self.waitViewClose then
		self:moveToEnd()
	end
end

function RougeMapNormalLayerActorComp:moveToEnd()
	if not RougeMapHelper.checkMapViewOnTop() then
		self.waitViewClose = true

		return
	end

	self.waitViewClose = nil

	if not RougeMapModel.instance:isNormalLayer() then
		logError("不在路线层了？")
		self:onMoveToEndDoneCallback()

		return
	end

	local endId = RougeMapModel.instance:getEndNodeId()

	self.movingToEnd = true

	self.moveToMapItem(self, endId, self.onMoveToEndDoneCallback, self)
end

function RougeMapNormalLayerActorComp:onMovingDone()
	TaskDispatcher.cancelTask(self.onMovingDone, self)
	self:endBlock()

	self.movingTweenId = nil

	if self.callback then
		self.callback(self.callbackObj)
	end

	self.callback = nil
	self.callbackObj = nil

	if not self.movingToEnd then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
	end

	self.movingToEnd = nil
end

function RougeMapNormalLayerActorComp:onMoveToEndDoneCallback()
	self:endBlock()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndActorMoveToEnd)

	local co = RougeMapModel.instance:getLayerCo()
	local endId = co.endStoryId

	if string.nilorempty(endId) then
		self:_updateMapInfo()

		return
	end

	local storyIdList = string.splitToNumber(endId, "|")

	if StoryModel.instance:isStoryFinished(storyIdList[1]) then
		self:_updateMapInfo()

		return
	end

	StoryController.instance:playStories(storyIdList, nil, self.onStoryPlayDone, self)
end

function RougeMapNormalLayerActorComp:onStoryPlayDone()
	TaskDispatcher.runDelay(self._updateMapInfo, self, RougeMapEnum.WaitStoryCloseAnim)
end

function RougeMapNormalLayerActorComp:_updateMapInfo()
	RougeMapModel.instance:updateToNewMapInfo()
end

function RougeMapNormalLayerActorComp:destroy()
	TaskDispatcher.cancelTask(self.onMovingDone, self)
	TaskDispatcher.cancelTask(self.onStartAnimDone, self)
	self.animatorPlayer:Stop()
	TaskDispatcher.cancelTask(self._updateMapInfo, self)
	RougeMapNormalLayerActorComp.super.destroy(self)
end

return RougeMapNormalLayerActorComp
