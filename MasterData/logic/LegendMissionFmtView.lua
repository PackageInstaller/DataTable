-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendMissionFmtView.lua

module("logic.extensions.legend.view.LegendMissionFmtView", package.seeall)

local LegendMissionFmtView = class("LegendMissionFmtView", MissionFmtView)

function LegendMissionFmtView:_getTeamFormationCfg()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfg = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local teamId = cfg.teamId

	return LegendConfig.instance:getLegendChallengeCreepsCfgList(teamId)
end

function LegendMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function LegendMissionFmtView:_getCreepCos()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfg = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local teamId = cfg.teamId

	return LegendConfig.instance:getLegendChallengeCreepsCfgList(teamId)
end

function LegendMissionFmtView:_getMonsterCo()
	return {}
end

return LegendMissionFmtView
