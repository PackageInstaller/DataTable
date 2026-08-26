-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapNormalLayerActorComp.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapNormalLayerActorComp", package.seeall)

local Rouge2_MapNormalLayerActorComp = class("Rouge2_MapNormalLayerActorComp", Rouge2_MapBaseActorComp)

function Rouge2_MapNormalLayerActorComp:init(go, map)
	Rouge2_MapNormalLayerActorComp.super.init(self, go, map)

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goModel)

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onBeforeActorMoveToEnd, self.moveToEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function Rouge2_MapNormalLayerActorComp:moveToMapItem(id, callback, callbackObj)
	id = id or Rouge2_MapModel.instance:getCurNode().nodeId

	local mapItem = self.map:getMapItem(id)
	local x, y, z = mapItem:getActorPos()

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onNormalActorBeforeMove)
	self:clearTween()

	self.callback = callback
	self.callbackObj = callbackObj
	self.targetX, self.targetY = x, y

	AudioMgr.instance:trigger(AudioEnum.Rouge2.StartMoveActor)
	self.animatorPlayer:Play("start", self.onStartAnimDone, self)
	TaskDispatcher.runDelay(self.onStartAnimDone, self, 0.5)
	self:startBlock()
end

function Rouge2_MapNormalLayerActorComp:onStartAnimDone()
	TaskDispatcher.cancelTask(self.onStartAnimDone, self)
	transformhelper.setLocalPos(self.trActor, self.targetX, self.targetY, Rouge2_MapHelper.getOffsetZ(self.targetY))
	self.animatorPlayer:Play("stop", self.onMovingDone, self)
	TaskDispatcher.runDelay(self.onMovingDone, self, 0.8)
end

function Rouge2_MapNormalLayerActorComp:onCloseViewFinish(viewName)
	if self.waitViewClose then
		self:moveToEnd()
	end
end

function Rouge2_MapNormalLayerActorComp:moveToEnd()
	if not Rouge2_MapHelper.checkMapViewOnTop() then
		self.waitViewClose = true

		return
	end

	self.waitViewClose = nil

	if not Rouge2_MapModel.instance:isNormalLayer() then
		logError("不在路线层了？")
		self:onMoveToEndDoneCallback()

		return
	end

	local endId = Rouge2_MapModel.instance:getEndNodeId()

	self.movingToEnd = true

	self.moveToMapItem(self, endId, self.onMoveToEndDoneCallback, self)
end

function Rouge2_MapNormalLayerActorComp:onMovingDone()
	TaskDispatcher.cancelTask(self.onMovingDone, self)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EndMoveActor)
	self:endBlock()

	self.movingTweenId = nil

	if self.callback then
		self.callback(self.callbackObj)
	end

	self.callback = nil
	self.callbackObj = nil

	if not self.movingToEnd then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onActorMovingDone)
	end

	self.movingToEnd = nil
end

function Rouge2_MapNormalLayerActorComp:onMoveToEndDoneCallback()
	self:endBlock()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onEndActorMoveToEnd)

	local co = Rouge2_MapModel.instance:getLayerCo()
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

function Rouge2_MapNormalLayerActorComp:onStoryPlayDone()
	TaskDispatcher.runDelay(self._updateMapInfo, self, Rouge2_MapEnum.WaitStoryCloseAnim)
end

function Rouge2_MapNormalLayerActorComp:_updateMapInfo()
	Rouge2_MapModel.instance:updateToNewMapInfo()
end

function Rouge2_MapNormalLayerActorComp:destroy()
	TaskDispatcher.cancelTask(self.onMovingDone, self)
	TaskDispatcher.cancelTask(self.onStartAnimDone, self)
	self.animatorPlayer:Stop()
	TaskDispatcher.cancelTask(self._updateMapInfo, self)
	Rouge2_MapNormalLayerActorComp.super.destroy(self)
end

return Rouge2_MapNormalLayerActorComp
