-- chunkname: @modules/logic/versionactivity1_5/act146/controller/Activity146Controller.lua

module("modules.logic.versionactivity1_5.act146.controller.Activity146Controller", package.seeall)

local Activity146Controller = class("Activity146Controller", BaseController)

function Activity146Controller:getAct146InfoFromServer(actId)
	actId = actId or ActivityEnum.Activity.Activity1_5WarmUp

	Activity146Rpc.instance:sendGetAct146InfosRequest(actId)
end

function Activity146Controller:onCloseView()
	Activity146Model.instance:setCurSelectedEpisode(nil)
end

function Activity146Controller:onFinishActEpisode(actId)
	actId = actId or ActivityEnum.Activity.Activity1_5WarmUpId

	local episodeId = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Rpc.instance:sendFinishAct146EpisodeRequest(actId, episodeId)
end

function Activity146Controller:tryReceiveEpisodeRewards(actId)
	actId = actId or ActivityEnum.Activity.Activity1_5WarmUpId

	local episodeId = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Rpc.instance:sendAct146EpisodeBonusRequest(actId, episodeId)
end

local signal = "Activity146"

function Activity146Controller:isActFirstEnterToday()
	return TimeUtil.getDayFirstLoginRed(signal)
end

function Activity146Controller:saveEnterActDateInfo()
	TimeUtil.setDayFirstLoginRed(signal)
end

function Activity146Controller:setCurSelectedEpisode(episodeId)
	local isCurEpisodeId = Activity146Model.instance:getCurSelectedEpisode()

	if episodeId ~= isCurEpisodeId then
		local isUnLock = Activity146Model.instance:isEpisodeUnLock(episodeId)

		if isUnLock then
			Activity146Model.instance:setCurSelectedEpisode(episodeId)
			self:notifyUpdateView()
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function Activity146Controller:onActModelUpdate()
	local couldSelectEpisode = self:computeCurNeedSelectEpisode()

	Activity146Model.instance:setCurSelectedEpisode(couldSelectEpisode)
	self:notifyUpdateView()
end

function Activity146Controller:computeCurNeedSelectEpisode()
	local curSelectEpisodeId = Activity146Model.instance:getCurSelectedEpisode()

	if curSelectEpisodeId then
		return curSelectEpisodeId
	end

	local episodeCfgList = Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp)

	if episodeCfgList then
		local episodeCount = #episodeCfgList
		local lastUnLockEpisodeId

		for i = 1, episodeCount do
			local episodeId = episodeCfgList[i].id
			local finishButUnReceive = Activity146Model.instance:isEpisodeFinishedButUnReceive(episodeId)
			local unLockAndUnFinish = Activity146Model.instance:isEpisodeUnLockAndUnFinish(episodeId)
			local isUnLock = Activity146Model.instance:isEpisodeUnLock(episodeId)

			if isUnLock then
				lastUnLockEpisodeId = episodeId
			end

			if finishButUnReceive or unLockAndUnFinish then
				return episodeId
			end
		end

		return lastUnLockEpisodeId
	end
end

function Activity146Controller:markHasEnterEpisode()
	local episodeId = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Model.instance:markHasEnterEpisode(episodeId)
end

function Activity146Controller:notifyUpdateView()
	Activity146Controller.instance:dispatchEvent(Activity146Event.DataUpdate)
end

Activity146Controller.instance = Activity146Controller.New()

return Activity146Controller
