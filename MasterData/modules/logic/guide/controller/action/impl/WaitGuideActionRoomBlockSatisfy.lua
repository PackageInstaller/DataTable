-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomBlockSatisfy.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBlockSatisfy", package.seeall)

local WaitGuideActionRoomBlockSatisfy = class("WaitGuideActionRoomBlockSatisfy", BaseGuideAction)

function WaitGuideActionRoomBlockSatisfy:onStart(context)
	WaitGuideActionRoomBlockSatisfy.super.onStart(self, context)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._check, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._check, self)

	self._blockCount = tonumber(self.actionParam)

	self:_check()
end

function WaitGuideActionRoomBlockSatisfy:_check()
	if self:_checkBlockCount() and self:_checkRoomOb() then
		GuidePriorityController.instance:add(self.guideId, self._satisfyPriority, self, 0.01)
	end
end

function WaitGuideActionRoomBlockSatisfy:_checkBlockCount()
	local fullBlockCount = RoomMapBlockModel.instance:getFullBlockCount()

	return fullBlockCount >= self._blockCount
end

function WaitGuideActionRoomBlockSatisfy:_checkRoomOb()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		return RoomController.instance:isObMode()
	end
end

function WaitGuideActionRoomBlockSatisfy:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._check, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._check, self)
	GuidePriorityController.instance:remove(self.guideId)
end

function WaitGuideActionRoomBlockSatisfy:_satisfyPriority()
	self:onDone(true)
end

return WaitGuideActionRoomBlockSatisfy
