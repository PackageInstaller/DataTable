-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpContainer.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpContainer", package.seeall)

local V2a2_WarmUpContainer = class("V2a2_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateEpisode = {
	Done = 1999,
	None = 0
}

function V2a2_WarmUpContainer:buildViews()
	self._warmUp = V2a2_WarmUp.New()
	self._warmUpLeftView = V2a2_WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V2a2_WarmUpContainer:onContainerInit()
	self.__isWaitingPlayHasGetAnim = false

	V2a2_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function V2a2_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V2a2_WarmUpContainer.super.onContainerOpen(self)
end

function V2a2_WarmUpContainer:onContainerClose()
	V2a2_WarmUpContainer.super.onContainerClose(self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:setCurSelectEpisodeIdSlient(nil)
end

function V2a2_WarmUpContainer:onContainerCloseFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

function V2a2_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V2a2_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V2a2_WarmUpContainer:onDataUpdateDoneFirst()
	self:tryTweenDesc()
end

function V2a2_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V2a2_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V2a2_WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
	if self._tweenSwitchContext.lastEpisode then
		return
	end

	if not curEpisodeId then
		self._tweenSwitchContext.lastEpisode = false
		self._tweenSwitchContext.curEpisodeId = false

		return
	end

	self._tweenSwitchContext.lastEpisode = lastEpisode
	self._tweenSwitchContext.curEpisodeId = curEpisodeId

	self._warmUp:tweenSwitch(function()
		self._tweenSwitchContext.lastEpisode = false
	end)
end

function V2a2_WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function V2a2_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V2a2_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V2a2_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V2a2_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V2a2_WarmUpContainer:tryTweenDesc()
	local isRecevied, localIsPlay = self:getRLOCCur()

	if isRecevied then
		return
	end

	if localIsPlay then
		return
	end

	if not self:checkIsDone() then
		return
	end

	self:openDesc()
end

function V2a2_WarmUpContainer:checkIsDone(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:getState(episodeId) == StateEpisode.Done
end

function V2a2_WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self._warmUp:openDesc(function()
		self:setLocalIsPlayCur()
		self._warmUp:_refresh()
		self._warmUp:setBlock_scroll(false)
	end)
end

local kEpisode = "episode|"

function V2a2_WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. tostring(episodeId)
end

function V2a2_WarmUpContainer:saveState(episodeId, value)
	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, value or StateEpisode.None)
end

function V2a2_WarmUpContainer:getState(episodeId, defaultValue)
	local key = self:_getPrefsKey(episodeId)

	return self:getInt(key, defaultValue or StateEpisode.None)
end

function V2a2_WarmUpContainer:saveStateDone(episodeId, isDone)
	self:saveState(episodeId, (isDone or nil) and (StateEpisode.Done or StateEpisode.None))
end

return V2a2_WarmUpContainer
