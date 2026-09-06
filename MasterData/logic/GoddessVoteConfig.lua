-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/config/GoddessVoteConfig.lua

module("logic.extensions.goddessvote.config.GoddessVoteConfig", package.seeall)

local GoddessVoteConfig = class("GoddessVoteConfig", BaseConfig)

function GoddessVoteConfig:onInit()
	GoddessVoteConfig.super.onInit(self)

	self._activityCfgs = nil
	self._voteRaceCfgs = nil
end

function GoddessVoteConfig:getNames()
	return {
		"goddess_vote_activity",
		"goddess_vote_race"
	}
end

function GoddessVoteConfig:handleConfig(name, content)
	if name == "goddess_vote_activity" then
		self._activityCfgs = content
	elseif name == "goddess_vote_race" then
		self._voteRaceCfgs = content
	end
end

function GoddessVoteConfig:getGoddessActivityCfg(actId)
	if checknumber(actId) <= 0 or self._activityCfgs == nil then
		return nil
	end

	return self._activityCfgs[actId]
end

function GoddessVoteConfig:GetGoddessAllRaces(actId)
	if checknumber(actId) < 1 or self._voteRaceCfgs == nil then
		return nil
	end

	return self._voteRaceCfgs[actId]
end

function GoddessVoteConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.GoddessVote)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

GoddessVoteConfig.instance = GoddessVoteConfig.New()

return GoddessVoteConfig
