-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/model/DreamTeamChapterHotMMFmtMo.lua

module("logic.extensions.dreamteamchapter.model.DreamTeamChapterHotMMFmtMo", package.seeall)

local DreamTeamChapterHotMMFmtMo = class("DreamTeamChapterHotMMFmtMo", BaseCustomFmtMo)

function DreamTeamChapterHotMMFmtMo:updateCfg(activityId, challengeId, stageId)
	self._activityId = checknumber(activityId)
	self._challengeId = checknumber(challengeId)
	self._stageId = checknumber(stageId)

	local stageCfg = DreamTeamChapterConfig.instance:getBattleStageCfg(self._activityId, self._challengeId, self._stageId)

	if stageCfg then
		self._creepsMasterId = stageCfg.creepsMasterId or 0
	end

	self._masterData = DreamTeamChapterConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DreamTeamChapterConfig.instance:getCreepsCfg(self._creepsMasterId)

	local var_1_0 = DreamTeamChapterConfig.instance:getSupportPetCfgs((stageCfg or nil) and (stageCfg.supportPetPlan or 0))

	var_1_0 = var_1_0 or {}
	self._extraPetCfgs = var_1_0

	if self._masterData then
		self.topTitleStr = self._masterData.name or ""
	end

	if self._masterData then
		self.ruleDescStr = self._masterData.ruleDesc or ""
	end

	self.isOnlyUpdateExistPet = true

	self:setFormCondition((stageCfg or nil) and (stageCfg.formConditionId or 0))
	self:clearAllPetList()
end

function DreamTeamChapterHotMMFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DreamTeamChapterController.instance:sendPM_DreamTeamChapterChallengeReq(self._activityId, self._challengeId, self._stageId, simpleForm)
	end, nil)
end

function DreamTeamChapterHotMMFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, supportCfg in pairs(self._extraPetCfgs or {}) do
		fMo:fromChallengeCreepCo(supportCfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DreamTeamChapterHotMMFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DreamTeamChapterHotMMFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DreamTeamChapterHotMMFmtMo
