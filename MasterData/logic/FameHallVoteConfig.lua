-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/config/FameHallVoteConfig.lua

module("logic.extensions.famehallvote.config.FameHallVoteConfig", package.seeall)

local FameHallVoteConfig = class("FameHallVoteConfig", BaseConfig)

function FameHallVoteConfig:getNames()
	return {
		"fame_hall_vote_activity",
		"fame_hall_vote_player_title",
		"fame_hall_vote_progress_prize",
		"fame_hall_vote_fame_desc"
	}
end

function FameHallVoteConfig:handleConfig(name, content)
	if name == "fame_hall_vote_activity" then
		self._fame_hall_vote_activity = content
	elseif name == "fame_hall_vote_player_title" then
		self._fame_hall_vote_player_title = content
	elseif name == "fame_hall_vote_progress_prize" then
		self._fame_hall_vote_progress_prize = content
	elseif name == "fame_hall_vote_fame_desc" then
		self._fame_hall_vote_fame_desc = content
	end
end

function FameHallVoteConfig:getActCfg(activityId)
	return self._fame_hall_vote_activity[activityId]
end

function FameHallVoteConfig:getPlayerTitleCfg(activityId)
	return self._fame_hall_vote_player_title[activityId]
end

function FameHallVoteConfig:getPlayerIdRandomList(activityId)
	local list = {}
	local voteTitleCfgs = self._fame_hall_vote_player_title[activityId]

	for playerId, cfg in pairs(voteTitleCfgs) do
		table.insert(list, playerId)
	end

	GameUtil.permuteArray(list)

	return list
end

function FameHallVoteConfig:getProgressPrizeCfg(activityId)
	return self._fame_hall_vote_progress_prize[activityId]
end

function FameHallVoteConfig:getFameDescCfg(fameHallType)
	return self._fame_hall_vote_fame_desc[fameHallType]
end

FameHallVoteConfig.instance = FameHallVoteConfig.New()

return FameHallVoteConfig
