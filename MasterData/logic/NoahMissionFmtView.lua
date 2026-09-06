-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahMissionFmtView.lua

module("logic.extensions.noahchallenge.view.NoahMissionFmtView", package.seeall)

local NoahMissionFmtView = class("NoahMissionFmtView", MissionFmtView)

function NoahMissionFmtView:_getCreepCos()
	local cCfg
	local param = self:getOpenParam()
	local challengeId = param[1]
	local stageId = param[2]
	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(challengeId)

	if cfgChallenge then
		local cfgStage = NoahChallengeConfig.instance:getChallengeStage(cfgChallenge.challengePlanId, stageId)

		if cfgStage then
			cCfg = NoahChallengeConfig.instance:getChallengeCreeps(cfgStage.creepsMasterId)
		end
	end

	return cCfg
end

function NoahMissionFmtView:_getMonsterCo()
	local param = self:getOpenParam()
	local cCfg

	if param then
		local challengeId = param[1]
		local stageId = param[2]
		local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(challengeId)

		if cfgChallenge then
			return (NoahChallengeConfig.instance:getChallengeStage(cfgChallenge.challengePlanId, stageId))
		end
	end

	return {}
end

function NoahMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return NoahMissionFmtView
