-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkLoadScene.lua

module("logic.scene.work.WorkLoadScene", package.seeall)

local M = class("WorkLoadScene", WorkBase)

function M:onEnter(context)
	local sceneId = context.model:getSceneId()

	if SceneMgr.instance:getCurSceneId() == sceneId then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setEvent(true)

	local sceneType = context.model:getSceneType()

	self._sceneType = sceneType

	SceneMgr.instance:enter(sceneType, sceneId, 0, 0)
end

function M:onExit(isInterrupt)
	self:_setEvent(false)

	self._sceneType = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	end
end

function M:_onSceneLoaded(e, sceneType, sceneId)
	if sceneType == self._sceneType then
		self:onDone(WorkResult.Succeed)
	end
end

return M
