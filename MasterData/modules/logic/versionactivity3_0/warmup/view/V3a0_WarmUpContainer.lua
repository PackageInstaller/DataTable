-- chunkname: @modules/logic/versionactivity3_0/warmup/view/V3a0_WarmUpContainer.lua

module("modules.logic.versionactivity3_0.warmup.view.V3a0_WarmUpContainer", package.seeall)

local V3a0_WarmUpContainer = class("V3a0_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateEpisode = {
	Done = 1999,
	None = 0
}
local kResNameFormat = "v3a0_warmup_pic_%s"

function V3a0_WarmUpContainer:getImgResUrl(i)
	local resName = string.format(kResNameFormat, i)

	return ResUrl.getV3a0WarmUpSingleBg(resName)
end

function V3a0_WarmUpContainer:buildViews()
	self._warmUp = V3a0_WarmUp.New()
	self._warmUpLeftView = V3a0_WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V3a0_WarmUpContainer:onContainerInit()
	self._needWaitCount = 0
	self.__isWaitingPlayHasGetAnim = false

	V3a0_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function V3a0_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V3a0_WarmUpContainer.super.onContainerOpen(self)

	if self._needWaitCount > 0 then
		self:tryTweenDesc()
	end
end

function V3a0_WarmUpContainer:onContainerClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	V3a0_WarmUpContainer.super.onContainerClose(self)
end

function V3a0_WarmUpContainer:onContainerDestroy()
	self:setCurSelectEpisodeIdSlient(nil)

	self._needWaitCount = 0
	self._isPlaying = false

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	V3a0_WarmUpContainer.super:onContainerDestroy()
end

function V3a0_WarmUpContainer:onContainerCloseFinish()
	self:_play_stop_UI_Bus()
end

function V3a0_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V3a0_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V3a0_WarmUpContainer:onDataUpdateDoneFirst()
	self:tryTweenDesc()
end

function V3a0_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self:_play_stop_UI_Bus()
	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V3a0_WarmUpContainer:onUpdateActivity()
	if self._isPlaying then
		self:setLocalIsPlayCur()
		self._warmUp:onUpdateActivity()

		self._isPlaying = false
	end
end

function V3a0_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V3a0_WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
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

function V3a0_WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function V3a0_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V3a0_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V3a0_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V3a0_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V3a0_WarmUpContainer:tryTweenDesc()
	self._needWaitCount = 0

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

	self:setLocalIsPlayCurByUser()
	self:openDesc()
end

function V3a0_WarmUpContainer:checkIsDone(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:getState(episodeId) == StateEpisode.Done
end

function V3a0_WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self:addNeedWaitCount()
	self._warmUp:openDesc(function()
		self._isPlaying = false

		self:onAnimDone()
		self._warmUp:setBlock_scroll(false)
		AudioMgr.instance:trigger(AudioEnum3_0.WarmUp.stop_ui_lushang_yure_typewriter)
	end)
end

function V3a0_WarmUpContainer:setNeedWaitCount(needWaitCount)
	self._needWaitCount = needWaitCount or 1
end

function V3a0_WarmUpContainer:addNeedWaitCount()
	self:setNeedWaitCount((self._needWaitCount or nil) and (self._needWaitCount + 1 or 1))
end

function V3a0_WarmUpContainer:onAnimDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:setLocalIsPlayCur()
	self._warmUp:_refresh()
end

local kEpisode = "Act125Episode|"

function V3a0_WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. tostring(episodeId)
end

function V3a0_WarmUpContainer:saveState(episodeId, value)
	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, value or StateEpisode.None)
end

function V3a0_WarmUpContainer:getState(episodeId, defaultValue)
	local key = self:_getPrefsKey(episodeId)

	return self:getInt(key, defaultValue or StateEpisode.None)
end

function V3a0_WarmUpContainer:saveStateDone(episodeId, isDone)
	self:saveState(episodeId, (isDone or nil) and (StateEpisode.Done or StateEpisode.None))

	if isDone then
		self:onAnimDone()
	end
end

function V3a0_WarmUpContainer:setLocalIsPlayCurByUser()
	self._isPlaying = true
end

function V3a0_WarmUpContainer:_play_stop_UI_Bus()
	if not self._isPlaying then
		-- block empty
	end
end

return V3a0_WarmUpContainer
