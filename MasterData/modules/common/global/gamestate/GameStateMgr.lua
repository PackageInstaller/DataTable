-- chunkname: @modules/common/global/gamestate/GameStateMgr.lua

module("modules.common.global.gamestate.GameStateMgr", package.seeall)

local GameStateMgr = class("GameStateMgr")

function GameStateMgr:ctor()
	LuaEventSystem.addEventMechanism(self)

	self._hasLogLowMemory = nil
end

function GameStateMgr:init()
	SLFramework.GameState.Instance:SetApplicationPauseCallback(self.onApplicationPause, self)
	SLFramework.GameState.Instance:SetApplicationLowMemoryCallback(self.onApplicationLowMemory, self)

	if SLFramework.FrameworkSettings.IsEditor then
		self:_addApplicationQuit()
	end
end

function GameStateMgr:_addApplicationQuit()
	setGlobal("OnApplicationQuit", function()
		GameStateMgr.instance:dispatchEvent(GameStateEvent.OnApplicationQuit)
	end)
end

function GameStateMgr:onApplicationPause(isFront)
	GameStateMgr.instance:dispatchEvent(GameStateEvent.onApplicationPause, isFront)
end

function GameStateMgr:onApplicationLowMemory()
	if not self._hasLogLowMemory then
		self._hasLogLowMemory = true

		logWarn("可用内存不足")
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
end

GameStateMgr.instance = GameStateMgr.New()

return GameStateMgr
