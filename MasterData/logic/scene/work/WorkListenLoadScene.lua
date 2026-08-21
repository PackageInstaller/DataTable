-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkListenLoadScene.lua

module("logic.scene.work.WorkListenLoadScene", package.seeall)

local M = class("WorkListenLoadScene", WorkBase)

function M:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:_onSceneLoaded(e, sceneType, sceneId)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	self:onDone(WorkResult.Succeed)
end

return M
