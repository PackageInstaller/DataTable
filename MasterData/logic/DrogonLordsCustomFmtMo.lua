-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/model/DrogonLordsCustomFmtMo.lua

module("logic.extensions.dragonlords.model.DrogonLordsCustomFmtMo", package.seeall)

local DrogonLordsCustomFmtMo = class("DrogonLordsCustomFmtMo", ICustomFmtMo)

function DrogonLordsCustomFmtMo:onReset()
	DrogonLordsCustomFmtMo.super.onReset(self)
end

function DrogonLordsCustomFmtMo:initFightHandler()
	local function handler()
		local actId = DrogonLordsModel.instance:getActivityId()
		local curFmo = self:getCurFormation()
		local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
		local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(self._stagePlanId, stageInfo.curStageId)
		local formationCfg = DragonLordsConfig.instance:getteamPlanCfg(stageCfg.teamPlanId, self._formationId)
		local score = formationCfg.score

		DragonLordsController.instance:sendPM_UniversalChallengeReq(actId, self._challengeId, curFmo, self._formationId)
		DrogonLordsModel.instance:setLastScore(score)
	end

	self:setFightHandler(handler, nil)
end

function DrogonLordsCustomFmtMo:initPetList()
	local petList = DrogonLordsFightMo.instance:GetAllPetList()

	for i, petMo in ipairs(petList) do
		self:addPetToList(petMo)
	end
end

function DrogonLordsCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DrogonLordsCustomFmtMo:getMonsterConfigList()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(self._stagePlanId, stageInfo.curStageId)
	local formationCfg = DragonLordsConfig.instance:getteamPlanCfg(stageCfg.teamPlanId, self._formationId)

	return DragonLordsConfig.instance:getCreepsMasterById(formationCfg.creepsMasterId)
end

function DrogonLordsCustomFmtMo:getFmtInfoConfig()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(self._stagePlanId, stageInfo.curStageId)
	local formationCfg = DragonLordsConfig.instance:getteamPlanCfg(stageCfg.teamPlanId, self._formationId)

	return DragonLordsConfig.instance:getCreepsMasterById(formationCfg.creepsMasterId)
end

function DrogonLordsCustomFmtMo:initParams(challengeId, formationId, stagePlanId)
	self._challengeId = challengeId
	self._formationId = formationId
	self._stagePlanId = stagePlanId
end

function DrogonLordsCustomFmtMo:updateData()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(self._stagePlanId, stageInfo.curStageId)
	local formationCfg = DragonLordsConfig.instance:getteamPlanCfg(stageCfg.teamPlanId, self._formationId)
	local teamData = DragonLordsConfig.instance:getTeamData(formationCfg.creepsMasterId)

	self.isHideFmtZdl = true
	self.needUpPetCount = 5
	self.ruleDescStr = teamData.levelDescription

	self:setFormCondition(teamData.formCondition)
	DrogonLordsFightMo.instance:onReset()
	self:clearAllPetList()
	self:initFormationMo()
end

return DrogonLordsCustomFmtMo
