-- chunkname: @modules/logic/warmup/v3a8/view/V3a8_WarmUpContainer.lua

module("modules.logic.warmup.v3a8.view.V3a8_WarmUpContainer", package.seeall)

local V3a8_WarmUpContainer = class("V3a8_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateEpisode = {
	Done = 1999,
	None = 0
}
local kResNameFormat = "v3a8_warmup_panel_day0%s"

function V3a8_WarmUpContainer:getImgResUrl(i)
	local resName = string.format(kResNameFormat, i)

	return ResUrl.getV3a8WarmUpSingleBg(resName)
end

function V3a8_WarmUpContainer:buildViews()
	self._warmUp = V3a8_WarmUp.New()
	self._warmUpLeftView = V3a8_WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V3a8_WarmUpContainer:onContainerInit()
	self._needWaitCount = 0
	self.__isWaitingPlayHasGetAnim = false

	V3a8_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		curEpisodeId = false,
		lastEpisodeId = false
	}
end

function V3a8_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V3a8_WarmUpContainer.super.onContainerOpen(self)

	if self._needWaitCount > 0 then
		self:tryTweenDesc()
	end
end

function V3a8_WarmUpContainer:onContainerClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	V3a8_WarmUpContainer.super.onContainerClose(self)
end

function V3a8_WarmUpContainer:onContainerDestroy()
	self:setCurSelectEpisodeIdSlient(nil)

	self._needWaitCount = 0
	self._isPlaying = false

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	V3a8_WarmUpContainer.super.onContainerDestroy(self)
end

function V3a8_WarmUpContainer:onContainerCloseFinish()
	self:_play_stop_UI_Bus()
end

function V3a8_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V3a8_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V3a8_WarmUpContainer:onDataUpdateDoneFirst()
	self:tryTweenDesc()
end

function V3a8_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self:_play_stop_UI_Bus()
	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V3a8_WarmUpContainer:onUpdateActivity()
	if self._isPlaying then
		self:setLocalIsPlayCur()
		self._warmUp:onUpdateActivity()

		self._isPlaying = false
	end
end

function V3a8_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V3a8_WarmUpContainer:switchTabWithAnim(lastEpisodeId, curEpisodeId)
	local ctx = self._tweenSwitchContext

	if ctx.lastEpisodeId then
		return
	end

	if not curEpisodeId then
		ctx.lastEpisodeId = false
		ctx.curEpisodeId = false
		ctx.cbTweenSwitch = nil
		ctx.cbObjTweenSwitch = nil

		return
	end

	self._isPlaying = false
	ctx.lastEpisodeId = lastEpisodeId
	ctx.curEpisodeId = curEpisodeId
	ctx.cbTweenSwitch = self._onTweenSwitchDone
	ctx.cbObjTweenSwitch = self

	self._warmUp:tweenSwitch(lastEpisodeId, curEpisodeId)
end

function V3a8_WarmUpContainer:_onTweenSwitchDone(optToSelectEpisodeId)
	local ctx = self._tweenSwitchContext

	ctx.curEpisodeId = optToSelectEpisodeId or ctx.curEpisodeId

	self._warmUp:onSwitch(ctx.curEpisodeId, ctx.lastEpisodeId)

	ctx.lastEpisodeId = false
	ctx.cbTweenSwitch = nil
	ctx.cbObjTweenSwitch = nil
end

function V3a8_WarmUpContainer:switchTabNoAnim(curEpisodeId, bSlient)
	local ctx = self._tweenSwitchContext

	curEpisodeId = curEpisodeId or ctx.curEpisodeId
	ctx.lastEpisodeId = false
	ctx.curEpisodeId = false
	ctx.cbTweenSwitch = nil
	ctx.cbObjTweenSwitch = nil

	self:setCurSelectEpisodeIdSlient(curEpisodeId)

	if not bSlient then
		Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
	end
end

function V3a8_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V3a8_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V3a8_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()
	self._warmUp:playTabItemsUnlockAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V3a8_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V3a8_WarmUpContainer:tryTweenDesc(bNoAnim)
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

	if bNoAnim then
		self:_onOpenDescDone()
	else
		self:openDesc()
	end
end

function V3a8_WarmUpContainer:checkIsDone(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:getState(episodeId) == StateEpisode.Done
end

function V3a8_WarmUpContainer:openDesc()
	if self._isPlaying then
		return true
	end

	self._isPlaying = true

	self._warmUp:setBlock_scroll(true)
	self:addNeedWaitCount()
	self._warmUp:openDesc(self._onOpenDescDone, self)
end

function V3a8_WarmUpContainer:_onOpenDescDone()
	self._isPlaying = false

	self:onAnimDone()
	self._warmUp:setBlock_scroll(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

function V3a8_WarmUpContainer:setNeedWaitCount(needWaitCount)
	self._needWaitCount = needWaitCount or 1
end

function V3a8_WarmUpContainer:addNeedWaitCount()
	self:setNeedWaitCount((self._needWaitCount or nil) and (self._needWaitCount + 1 or 1))
end

function V3a8_WarmUpContainer:onAnimDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:setLocalIsPlayCur()
	self._warmUp:_refresh()
end

local kEpisode = "Act125Episode|"

function V3a8_WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. tostring(episodeId)
end

function V3a8_WarmUpContainer:saveState(episodeId, value)
	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, value or StateEpisode.None)
end

function V3a8_WarmUpContainer:getState(episodeId, defaultValue)
	local key = self:_getPrefsKey(episodeId)

	return self:getInt(key, defaultValue or StateEpisode.None)
end

function V3a8_WarmUpContainer:saveStateDone(episodeId, isDone)
	self:saveState(episodeId, (isDone or nil) and (StateEpisode.Done or StateEpisode.None))

	if isDone then
		self:onAnimDone()
	end
end

function V3a8_WarmUpContainer:_play_stop_UI_Bus()
	if not self._isPlaying then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	end
end

function V3a8_WarmUpContainer:getPlayCO(day)
	return V3a8_WarmUpConfig.instance:getPlayCO(self:actId(), day)
end

return V3a8_WarmUpContainer
