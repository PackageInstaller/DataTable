-- chunkname: @modules/logic/versionactivity2_0/warmup/view/V2a0_WarmUpContainer.lua

module("modules.logic.versionactivity2_0.warmup.view.V2a0_WarmUpContainer", package.seeall)

local V2a0_WarmUpContainer = class("V2a0_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateLid = {
	Closed = 0,
	Opened = 1
}
local StateEye = {
	Big = 1,
	Small = 0
}
local kResNameFormat = "v2a0_warmup_img%s"

function V2a0_WarmUpContainer:getImgResUrl(i)
	local resName = string.format(kResNameFormat, i)

	return ResUrl.getV2a0WarmUpSingleBg(resName)
end

function V2a0_WarmUpContainer:buildViews()
	self._warmUp = V2a0_WarmUp.New()
	self._warmUpLeftView = Act2_0WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function V2a0_WarmUpContainer:onContainerInit()
	self.__isWaitingPlayHasGetAnim = false

	V2a0_WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function V2a0_WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	V2a0_WarmUpContainer.super.onContainerOpen(self)
end

function V2a0_WarmUpContainer:onContainerClose()
	V2a0_WarmUpContainer.super.onContainerClose(self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:setCurSelectEpisodeIdSlient(nil)
end

function V2a0_WarmUpContainer:onContainerCloseFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_yure_caption_20200115)
end

function V2a0_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function V2a0_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function V2a0_WarmUpContainer:onDataUpdateDoneFirst()
	if not self:checkLidIsOpened() then
		self:openGuide()

		return
	end

	self:tryTweenDesc()
end

function V2a0_WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function V2a0_WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function V2a0_WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
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

function V2a0_WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function V2a0_WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	V2a0_WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function V2a0_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function V2a0_WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function V2a0_WarmUpContainer:tryTweenDesc()
	local isRecevied, localIsPlay = self:getRLOCCur()

	if isRecevied then
		return
	end

	if localIsPlay then
		return
	end

	if self:checkEyeIsClicked() then
		self:openDesc()
	end
end

function V2a0_WarmUpContainer:checkLidIsOpened()
	return self:_get_lid(StateLid.Closed) == StateLid.Opened
end

function V2a0_WarmUpContainer:checkEyeIsClicked(episodeId)
	episodeId = episodeId or self:getCurSelectedEpisode()

	if not self:isEpisodeReallyOpen(episodeId) then
		return false
	end

	return self:_get_eye(episodeId, StateEye.Small) == StateEye.Big
end

function V2a0_WarmUpContainer:saveLidState(isOpen)
	self:_save_lid((isOpen or nil) and (StateLid.Opened or StateLid.Closed))
end

function V2a0_WarmUpContainer:saveEyeState(episodeId, isOpen)
	episodeId = episodeId or self:getCurSelectedEpisode()

	self:_save_eye(episodeId, (isOpen or nil) and (StateEye.Big or StateEye.Small))
end

function V2a0_WarmUpContainer:openGuide()
	self._warmUpLeftView:openGuide()
end

function V2a0_WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self._warmUp:openDesc(function()
		self:setLocalIsPlayCur()
		self._warmUp:_refresh()
		self._warmUp:setBlock_scroll(false)
	end)
end

local k_lid = "lid|"

function V2a0_WarmUpContainer:_getPrefsKey_lid()
	return self:getPrefsKeyPrefix() .. k_lid
end

function V2a0_WarmUpContainer:_save_lid(value)
	local key = self:_getPrefsKey_lid()

	self:saveInt(key, value or StateLid.Closed)
end

function V2a0_WarmUpContainer:_get_lid(defaultValue)
	local key = self:_getPrefsKey_lid()

	return self:getInt(key, defaultValue or StateLid.Closed)
end

local k_eye = "eye|"

function V2a0_WarmUpContainer:_getPrefsKey_eye(episodeId)
	return self:getPrefsKeyPrefix() .. k_eye .. tostring(episodeId)
end

function V2a0_WarmUpContainer:_save_eye(episodeId, value)
	local key = self:_getPrefsKey_eye(episodeId)

	self:saveInt(key, value or StateLid.Closed)
end

function V2a0_WarmUpContainer:_get_eye(episodeId, defaultValue)
	local key = self:_getPrefsKey_eye(episodeId)

	return self:getInt(key, defaultValue or StateEye.Small)
end

return V2a0_WarmUpContainer
