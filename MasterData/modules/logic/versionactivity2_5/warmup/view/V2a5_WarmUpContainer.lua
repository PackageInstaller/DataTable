-- chunkname: @modules/logic/versionactivity2_5/warmup/view/V2a5_WarmUpContainer.lua

module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpContainer", package.seeall)

local V2a5_WarmUpContainer = class("V2a5_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateEpisode = {
	Done = 1999,
	None = 0
}

function V2a5_WarmUpContainer:buildViews()
	self._warmUp = V2a5_WarmUp.New()
	self._warmUpLeftView = V2a5_WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V2a5_WarmUpContainer:onContainerInit()
	self.__isWaitingPlayHasGetAnim = false

	V2a5_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function V2a5_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V2a5_WarmUpContainer.super.onContainerOpen(self)
end

function V2a5_WarmUpContainer:onContainerClose()
	V2a5_WarmUpContainer.super.onContainerClose(self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:setCurSelectEpisodeIdSlient(nil)
end

function V2a5_WarmUpContainer:onContainerCloseFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_tangren_telegram_25251417)
end

function V2a5_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V2a5_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V2a5_WarmUpContainer:onDataUpdateDoneFirst()
	self:tryTweenDesc()
end

function V2a5_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_tangren_telegram_25251417)
	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V2a5_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V2a5_WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
	if self._tweenSwitchContext.lastEpisode then
		return
	end

	if not curEpisodeId then
		self._tweenSwitchContext.lastEpisode = false
		self._tweenSwitchContext.curEpisodeId = false

		return
	end

	self._isPlaying = false
	self._tweenSwitchContext.lastEpisode = lastEpisode
	self._tweenSwitchContext.curEpisodeId = curEpisodeId

	self._warmUp:tweenSwitch(function()
		self._tweenSwitchContext.lastEpisode = false
	end)
end

function V2a5_WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function V2a5_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V2a5_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V2a5_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V2a5_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V2a5_WarmUpContainer:tryTweenDesc()
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

function V2a5_WarmUpContainer:checkIsDone(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:getState(episodeId) == StateEpisode.Done
end

function V2a5_WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self._warmUp:openDesc(function()
		self._isPlaying = false

		self:_onAnimDone()
		self._warmUp:setBlock_scroll(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over_25005506)
	end)
end

local kEpisode = "Act125Episode|"

function V2a5_WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. tostring(episodeId)
end

function V2a5_WarmUpContainer:saveState(episodeId, value)
	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, value or StateEpisode.None)
end

function V2a5_WarmUpContainer:getState(episodeId, defaultValue)
	local key = self:_getPrefsKey(episodeId)

	return self:getInt(key, defaultValue or StateEpisode.None)
end

function V2a5_WarmUpContainer:saveStateDone(episodeId, isDone)
	self:saveState(episodeId, (isDone or nil) and (StateEpisode.Done or StateEpisode.None))
end

function V2a5_WarmUpContainer:setLocalIsPlayCurByUser()
	self._isPlaying = true
end

function V2a5_WarmUpContainer:onContainerDestroy()
	self:setCurSelectEpisodeIdSlient(nil)

	self._isPlaying = false

	V2a5_WarmUpContainer.super:onContainerDestroy()
end

function V2a5_WarmUpContainer:onUpdateActivity()
	if self._isPlaying then
		self:setLocalIsPlayCur()
		self._warmUp:onUpdateActivity()

		self._isPlaying = false
	end
end

function V2a5_WarmUpContainer:_onAnimDone()
	self:setLocalIsPlayCur()
	self._warmUp:_refresh()
end

return V2a5_WarmUpContainer
