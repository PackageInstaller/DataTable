-- chunkname: @modules/logic/fight/controller/FightFailRecommendController.lua

module("modules.logic.fight.controller.FightFailRecommendController", package.seeall)

local FightFailRecommendController = class("FightFailRecommendController", BaseController)
local FailCountRecommend = 2

function FightFailRecommendController:addConstEvents()
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._pushEndFight, self)
end

function FightFailRecommendController:onClickRecommend()
	local key = self:_getKey()

	PlayerPrefsHelper.deleteKey(key)
end

function FightFailRecommendController:needShowRecommend(episodeId)
	local key = self:_getKey()
	local saveFailEpisodeData = PlayerPrefsHelper.getString(key, "")
	local temp = string.splitToNumber(saveFailEpisodeData, "#")
	local failEpisode = temp and temp[1]

	if not failEpisode or failEpisode ~= episodeId then
		return false
	end

	local failCount = temp and temp[2]

	return failCount and failCount >= FailCountRecommend
end

function FightFailRecommendController:_respBeginFight()
	local fightParam = FightModel.instance:getFightParam()

	self._isReplay = fightParam and fightParam.isReplay

	if self._isReplay then
		return
	end

	local episodeId = fightParam and fightParam.episodeId
	local key = self:_getKey()
	local saveFailEpisodeData = PlayerPrefsHelper.getString(key, "")
	local temp = string.splitToNumber(saveFailEpisodeData, "#")
	local failEpisode = temp and temp[1]

	if failEpisode and episodeId ~= failEpisode then
		PlayerPrefsHelper.deleteKey(key)
	end
end

function FightFailRecommendController:_pushEndFight()
	local fightParam = FightModel.instance:getFightParam()

	self._isReplay = fightParam and fightParam.isReplay

	if self._isReplay then
		self._isReplay = nil

		return
	end

	local fightRecordMO = FightModel.instance:getRecordMO()
	local isFail = fightRecordMO and fightRecordMO.fightResult ~= FightEnum.FightResult.Succ
	local key = self:_getKey()

	if isFail then
		local episodeId
		local fightParam = FightModel.instance:getFightParam()

		episodeId = fightParam and fightParam.episodeId

		if not episodeId then
			local fightReason = FightModel.instance:getFightReason()

			episodeId = fightReason and fightReason.episodeId

			if not episodeId then
				return
			end
		end

		local saveFailEpisodeData = PlayerPrefsHelper.getString(key, "")
		local temp = string.splitToNumber(saveFailEpisodeData, "#")
		local failEpisode = temp and temp[1]
		local failCount = temp and temp[2]

		if failEpisode and failEpisode == episodeId then
			failCount = failCount and failCount + 1 or 1
		else
			failEpisode = episodeId
			failCount = 1
		end

		if failEpisode then
			PlayerPrefsHelper.setString(key, failEpisode .. "#" .. failCount)
		end
	else
		PlayerPrefsHelper.deleteKey(key)
	end
end

function FightFailRecommendController:_getKey()
	return PlayerModel.instance:getMyUserId() .. "_" .. PlayerPrefsKey.FightFailEpisode
end

FightFailRecommendController.instance = FightFailRecommendController.New()

return FightFailRecommendController
