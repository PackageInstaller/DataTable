-- chunkname: @modules/logic/versionactivity2_1/warmup/view/V2a1_WarmUpContainer.lua

module("modules.logic.versionactivity2_1.warmup.view.V2a1_WarmUpContainer", package.seeall)

local V2a1_WarmUpContainer = class("V2a1_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateBox = {
	Closed = 0,
	Opened = 1
}
local kResNameFormat = "v2a1_warmup_reward%s"

function V2a1_WarmUpContainer:getImgSpriteName(i)
	return (string.format(kResNameFormat, i))
end

function V2a1_WarmUpContainer:buildViews()
	self._warmUp = V2a1_WarmUp.New()
	self._warmUpLeftView = Act2_1WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V2a1_WarmUpContainer:onContainerInit()
	self.__isWaitingPlayHasGetAnim = false

	V2a1_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function V2a1_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V2a1_WarmUpContainer.super.onContainerOpen(self)
end

function V2a1_WarmUpContainer:onContainerClose()
	V2a1_WarmUpContainer.super.onContainerClose(self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:setCurSelectEpisodeIdSlient(nil)
end

function V2a1_WarmUpContainer:onContainerCloseFinish()
	return
end

function V2a1_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V2a1_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V2a1_WarmUpContainer:onDataUpdateDoneFirst()
	if not self:checkIsOpen(self:getCurSelectedEpisode()) then
		self:openGuide()

		return
	end

	self:tryTweenDesc()
end

function V2a1_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V2a1_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V2a1_WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
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

function V2a1_WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function V2a1_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V2a1_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V2a1_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V2a1_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V2a1_WarmUpContainer:tryTweenDesc()
	local isRecevied, localIsPlay = self:getRLOCCur()

	if isRecevied then
		return
	end

	if localIsPlay then
		return
	end

	local episodeId = self:getCurSelectedEpisode()

	if not self:checkIsOpen(episodeId) then
		return
	end

	self:openDesc()
end

function V2a1_WarmUpContainer:checkIsOpen(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:_get_box(episodeId, StateBox.Closed) == StateBox.Opened
end

function V2a1_WarmUpContainer:saveBoxState(episodeId, isOpen)
	episodeId = episodeId or self:getCurSelectedEpisode()

	self:_save_box(episodeId, (isOpen or nil) and (StateBox.Opened or StateBox.Closed))
end

function V2a1_WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self._warmUp:openDesc(function()
		self:setLocalIsPlayCur()
		self._warmUp:_refresh()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over)
		self._warmUp:setBlock_scroll(false)
	end)
end

function V2a1_WarmUpContainer:openGuide()
	self._warmUpLeftView:openGuide()
end

local k_box = "box|"

function V2a1_WarmUpContainer:_getPrefsKey_box(episodeId)
	return self:getPrefsKeyPrefix() .. k_box .. tostring(episodeId)
end

function V2a1_WarmUpContainer:_save_box(episodeId, value)
	local key = self:_getPrefsKey_box(episodeId)

	self:saveInt(key, value or StateBox.Closed)
end

function V2a1_WarmUpContainer:_get_box(episodeId, defaultValue)
	local key = self:_getPrefsKey_box(episodeId)

	return self:getInt(key, defaultValue or StateBox.Closed)
end

return V2a1_WarmUpContainer
