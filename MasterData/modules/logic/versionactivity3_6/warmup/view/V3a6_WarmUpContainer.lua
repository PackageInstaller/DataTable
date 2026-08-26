-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUpContainer.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUpContainer", package.seeall)

local V3a6_WarmUpContainer = class("V3a6_WarmUpContainer", Activity125WarmUpViewBaseContainer)

function V3a6_WarmUpContainer:buildViews()
	self._warmUp = V3a6_WarmUp.New()

	return {
		self._warmUp
	}
end

function V3a6_WarmUpContainer:onContainerInit()
	V3a6_WarmUpContainer.super.onContainerInit(self)
end

function V3a6_WarmUpContainer:onContainerOpen()
	V3a6_WarmUpContainer.super.onContainerOpen(self)
	Activity125Controller.instance:sendGetTaskInfoRequest()
end

function V3a6_WarmUpContainer:onContainerClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:setCurSelectEpisodeIdSlient(nil)
	V3a6_WarmUpContainer.super.onContainerClose(self)
end

function V3a6_WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.V3a6_WarmUp_TaskView then
		return
	end

	self._warmUp:_refreshTaskInfo()
	self._warmUp:_refreshTaskReward()
	self._warmUp:_autoSelectTab()
	self._warmUp:_tryPlayUnlockAnim()
end

function V3a6_WarmUpContainer:_onDailyRefresh()
	Activity125Controller.instance:getAct125InfoFromServer(self:actId(), self._onsendGetAct125InfosRequestDone, self)
end

function V3a6_WarmUpContainer:_onsendGetAct125InfosRequestDone()
	self._warmUp:_refreshTaskInfo()
end

function V3a6_WarmUpContainer:getCurPlayingEpisodeId()
	local episodeList = self:getEpisodeList()

	for i = #episodeList, 1, -1 do
		local episodeCO = episodeList[i]
		local episodeId = episodeCO.id
		local preIdEpisodeId = episodeCO.preId
		local _, _, _, canGetReward = self:getRLOC(episodeId)

		if canGetReward then
			return episodeId
		end

		if preIdEpisodeId > 0 then
			local isRecevied = self:getRLOC(preIdEpisodeId)

			if isRecevied then
				return episodeId
			end
		end
	end

	return self:day1Episode()
end

function V3a6_WarmUpContainer:day1Episode()
	return 1
end

function V3a6_WarmUpContainer:onContainerCloseFinish()
	return
end

function V3a6_WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
end

function V3a6_WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
end

function V3a6_WarmUpContainer:openV3a6_WarmUp_DialogueView(episodeId)
	local viewParam = {
		level = episodeId
	}

	ViewMgr.instance:openView(ViewName.V3a6_WarmUp_DialogueView, viewParam)
end

local kEpisode = "V3a6_WarmUp|"

function V3a6_WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. episodeId
end

function V3a6_WarmUpContainer:savePlayedUnlock(episodeId, bPlayed)
	if self:getSavedPlayedUnlock(episodeId) == bPlayed then
		return
	end

	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, bPlayed and 1 or 0)
end

function V3a6_WarmUpContainer:getSavedPlayedUnlock(episodeId)
	local key = self:_getPrefsKey(episodeId)
	local value = self:getInt(key, 0)

	return value ~= 0
end

return V3a6_WarmUpContainer
