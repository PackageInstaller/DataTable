-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/controller/Activity156Controller.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.controller.Activity156Controller", package.seeall)

local Activity156Controller = class("Activity156Controller", BaseController)

function Activity156Controller:getAct125InfoFromServer(actId)
	actId = actId or ActivityEnum.Activity.Activity1_6WarmUp

	Activity156Rpc.instance:sendGetAct125InfosRequest(actId)
end

function Activity156Controller:onFinishActEpisode(actId, episodeId, targetFrequencyIndex)
	Activity156Rpc.instance:sendFinishAct125EpisodeRequest(actId, episodeId, targetFrequencyIndex)
end

local keyHead = PlayerPrefsKey.FirstEnterAct125Today .. "#" .. ActivityEnum.Activity.Activity1_6WarmUp .. "#"

function Activity156Controller:isActFirstEnterToday()
	local key = keyHead .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local curDate = ServerTime.nowInLocal()
	local dateObj = os.date("*t", curDate)

	if PlayerPrefsHelper.hasKey(key) then
		local lastEnterTime = tonumber(PlayerPrefsHelper.getString(key, curDate))

		dateObj.hour = 5
		dateObj.min = 0
		dateObj.sec = 0

		local today5H = os.time(dateObj)

		if lastEnterTime and TimeUtil.getDiffDay(curDate, lastEnterTime) < 1 and (curDate - today5H) * (lastEnterTime - today5H) > 0 then
			return false
		end
	end

	return true
end

function Activity156Controller:saveEnterActDateInfo()
	local key = keyHead .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local stamp = ServerTime.nowInLocal()

	PlayerPrefsHelper.setString(key, tostring(stamp))
end

function Activity156Controller:setCurSelectedEpisode(episodeId, ctrlrefresh)
	local isCurEpisodeId = Activity156Model.instance:getCurSelectedEpisode()

	if episodeId ~= isCurEpisodeId then
		local isUnLock = Activity156Model.instance:isEpisodeUnLock(episodeId)

		if isUnLock then
			Activity156Model.instance:setCurSelectedEpisode(episodeId)

			if not ctrlrefresh then
				self:notifyUpdateView()
			end
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function Activity156Controller:tryReceiveEpisodeRewards(actId)
	actId = actId or ActivityEnum.Activity.Activity1_6WarmUp

	local episodeId = Activity156Model.instance:getCurSelectedEpisode()
	local isRecevied = Activity156Model.instance:isEpisodeHasReceivedReward(episodeId)

	if not isRecevied then
		Activity156Rpc.instance:sendFinishAct125EpisodeRequest(actId, episodeId)
	end
end

function Activity156Controller:notifyUpdateView()
	Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
end

Activity156Controller.instance = Activity156Controller.New()

return Activity156Controller
