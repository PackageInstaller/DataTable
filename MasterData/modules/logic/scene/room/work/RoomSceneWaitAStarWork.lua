-- chunkname: @modules/logic/scene/room/work/RoomSceneWaitAStarWork.lua

module("modules.logic.scene.room.work.RoomSceneWaitAStarWork", package.seeall)

local RoomSceneWaitAStarWork = class("RoomSceneWaitAStarWork", BaseWork)

function RoomSceneWaitAStarWork:ctor(scene)
	self._scene = scene
end

function RoomSceneWaitAStarWork:onStart()
	self._isLoadingFinish = false

	TaskDispatcher.runDelay(self._overtime, self, 30)
	TaskDispatcher.runRepeat(self._onUpdate, self, 0)
	self:_logState()
end

function RoomSceneWaitAStarWork:_onUpdate()
	self:_logState()

	if not self._scene.loader:isLoaderInProgress() and (not RoomEnum.UseAStarPath or not ZProj.AStarPathBridge.IsAStarInProgress()) then
		self:_finish()
	else
		logNormal("RoomSceneWaitAStarWork: waiting")
	end
end

function RoomSceneWaitAStarWork:_logState()
	local a = self._scene.loader:isLoaderInProgress() and "true" or "false"
	local b = ZProj.AStarPathBridge.IsAStarInProgress() and "true" or "false"

	RoomHelper.logElapse(string.format("loading = %s, scaning = %s", a, b))
end

function RoomSceneWaitAStarWork:_overtime()
	logError("RoomSceneWaitAStarWork: 超时, 直接进场景")
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomEnterLoadingTimeOut, MsgBoxEnum.BoxType.Yes, function()
		if not self._isLoadingFinish then
			TaskDispatcher.runDelay(self._overtime, self, 30)
		end
	end)
end

function RoomSceneWaitAStarWork:_finish()
	logNormal("RoomSceneWaitAStarWork: finish")

	self._isLoadingFinish = true

	TaskDispatcher.cancelTask(self._overtime, self)
	TaskDispatcher.cancelTask(self._onUpdate, self)

	self._scene = nil

	self:onDone(true)
end

function RoomSceneWaitAStarWork:clearWork()
	TaskDispatcher.cancelTask(self._overtime, self)
	TaskDispatcher.cancelTask(self._onUpdate, self)

	self._scene = nil
end

return RoomSceneWaitAStarWork
