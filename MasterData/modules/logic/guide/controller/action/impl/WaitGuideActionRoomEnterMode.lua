-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomEnterMode.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomEnterMode", package.seeall)

local WaitGuideActionRoomEnterMode = class("WaitGuideActionRoomEnterMode", BaseGuideAction)

function WaitGuideActionRoomEnterMode:onStart(context)
	WaitGuideActionRoomEnterMode.super.onStart(self, context)

	local params = string.splitToNumber(self.actionParam, "#")

	self._modeRequire = params[1]
	self._needEnterToTrigger = params[2] == 1

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, self._checkDone, self)

	if not self._needEnterToTrigger then
		self:_checkDone()
	end
end

function WaitGuideActionRoomEnterMode:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, self._checkDone, self)
	GuidePriorityController.instance:remove(self.guideId)
end

function WaitGuideActionRoomEnterMode:_checkDone()
	if self:checkGuideLock() then
		return
	end

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		local curMode = RoomModel.instance:getGameMode()
		local isRightMode = false

		isRightMode = self._modeRequire and curMode == self._modeRequire or RoomController.instance:isEditMode()

		if isRightMode then
			GuidePriorityController.instance:add(self.guideId, self._satisfyPriority, self, 0.01)
		end
	end
end

function WaitGuideActionRoomEnterMode:_satisfyPriority()
	self:onDone(true)
end

return WaitGuideActionRoomEnterMode
