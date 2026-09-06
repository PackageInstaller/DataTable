-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MCMissionFmtView.lua

module("logic.extensions.materialchallenge.view.MCMissionFmtView", package.seeall)

local MCMissionFmtView = class("MCMissionFmtView", MissionFmtView)

function MCMissionFmtView:_refreshFromation()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	local chapterId = params[1]
	local stageId = params[2]
	local cfgStage = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
	local teamId = cfgStage.teamIds
	local cCfg = MaterialChallengeConfig.instance:getTeamPets(teamId)
	local teams, formations = self:getTeamAndFormation(cCfg)

	self:_createExtParams(formations)

	local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams, self:getCurElementRelationMap(), self._summonMasterPetId, self._summonedPetId)

	self:initFormation(formations, teams, (heroSkillIs and #heroSkillIs > 0 or nil) and heroSkillIs[1])
end

return MCMissionFmtView
