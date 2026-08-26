-- chunkname: @modules/common/gc/GameGCMgr.lua

module("modules.common.gc.GameGCMgr", package.seeall)

local GameGCMgr = class("GameGCMgr")

function GameGCMgr:ctor()
	LuaEventSystem.addEventMechanism(self)

	self.minInterval = 2
	self.minAudioGcInterval = 2
end

function GameGCMgr:init()
	self:addGCEvent()
end

function GameGCMgr:addGCEvent()
	self.registerCallback(self, GameGCEvent.FullGC, self._fullGC, self)
	self.registerCallback(self, GameGCEvent.DelayFullGC, self._delayFullGC, self)
	self.registerCallback(self, GameGCEvent.ResGC, self._resGC, self)
	self.registerCallback(self, GameGCEvent.CancelDelayFullGC, self._cancelDelayFullGC, self)
	self.registerCallback(self, GameGCEvent.StoryGC, self._storyGC, self)
	self.registerCallback(self, GameGCEvent.AudioGC, self._audioGC, self)
	self.registerCallback(self, GameGCEvent.DelayAudioGC, self._delayAudioGC, self)
	self.registerCallback(self, GameGCEvent.CancelDelayAudioGC, self._cancelDelayAudioGC, self)
end

function GameGCMgr:_fullGC(callGCObj)
	if self.lastCgTime and UnityEngine.Time.realtimeSinceStartup - self.lastCgTime < self.minInterval then
		logNormal("GameGCMgr._fullGC, interval less than " .. self.minInterval .. "s, cancel this gc call !!")

		return
	end

	if callGCObj then
		logNormal("GameGCMgr FullGC Called By " .. callGCObj.__cname)
	else
		logNormal("GameGCMgr FullGC !")
	end

	self.lastCgTime = UnityEngine.Time.realtimeSinceStartup

	SLFramework.UnityHelper.LuaGC()
	self:_resGC(callGCObj)
	self:dispatchEvent(GameGCEvent.OnFullGC)
end

function GameGCMgr:_storyGC(callGCObj)
	if callGCObj then
		logNormal("GameGCMgr StoryGC Called By " .. callGCObj.__cname)
	else
		logNormal("GameGCMgr StoryGC !")
	end

	SLFramework.UnityHelper.LuaGC()
	PostProcessingMgr.instance:ClearPPRenderRts()
	self:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function GameGCMgr:_audioGC(callGCObj)
	if self._audioLastGcTime and UnityEngine.Time.realtimeSinceStartup - self._audioLastGcTime < self.minAudioGcInterval then
		logNormal("GameGCMgr._audioGC, interval less than " .. self.minAudioGcInterval .. "s, cancel this audio gc call !!")

		return
	end

	if callGCObj then
		logNormal("GameGCMgr AudioGC Called By " .. callGCObj.__cname)
	else
		logNormal("GameGCMgr AudioGC !")
	end

	self._audioLastGcTime = UnityEngine.Time.realtimeSinceStartup

	AudioMgr.instance:clearUnusedBanks()
end

function GameGCMgr:_resGC(callResGCObj)
	if callResGCObj then
		logNormal("GameGCMgr ResGC Called By " .. callResGCObj.__cname)
	else
		logNormal("GameGCMgr ResGC !")
	end

	AudioMgr.instance:clearUnusedBanks()
	PostProcessingMgr.instance:ClearPPRenderRts()
	self:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function GameGCMgr:_tryDispose()
	logNormal("GameGCMgr TryDispose!")
	UISpriteSetMgr.instance:tryDispose()
	LuaMonoContainer.tryDispose()
	LuaNoUpdateMonoContainer.tryDispose()
end

function GameGCMgr:_delayFullGC(delay, callDelayGCObj)
	if callDelayGCObj then
		logNormal("GameGCMgr DelayFullGC In " .. delay .. " Second By " .. callDelayGCObj.__cname)
	else
		logNormal("GameGCMgr DelayFullGC In " .. delay .. " Second")
	end

	TaskDispatcher.cancelTask(self._fullGC, self)
	TaskDispatcher.runDelay(self._fullGC, self, delay)
end

function GameGCMgr:_cancelDelayFullGC()
	logNormal("GameGCMgr CancelDelayFullGC !")
	TaskDispatcher.cancelTask(self._fullGC, self)
end

function GameGCMgr:_delayAudioGC(delay, callObj)
	if callObj then
		logNormal("GameGCMgr._delayAudioGC In " .. delay .. " Second By " .. callObj.__cname)
	else
		logNormal("GameGCMgr._delayAudioGC In " .. delay .. " Second")
	end

	TaskDispatcher.cancelTask(self._audioGC, self)
	TaskDispatcher.runDelay(self._audioGC, self, delay)
end

function GameGCMgr:_cancelDelayAudioGC()
	logNormal("GameGCMgr._cancelDelayAudioGC !")
	TaskDispatcher.cancelTask(self._audioGC, self)
end

GameGCMgr.instance = GameGCMgr.New()

return GameGCMgr
