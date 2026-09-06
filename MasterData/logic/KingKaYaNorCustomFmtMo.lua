-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/model/KingKaYaNorCustomFmtMo.lua

module("logic.extensions.kingkaya.model.KingKaYaNorCustomFmtMo", package.seeall)

local KingKaYaNorCustomFmtMo = class("KingKaYaNorCustomFmtMo", ICustomFmtMo)

function KingKaYaNorCustomFmtMo:onReset()
	KingKaYaNorCustomFmtMo.super.onReset(self)
end

function KingKaYaNorCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._kingKaYaMo = KingKaYaController.instance:getKingKaYaMo(self._activityId)
	self._stageData = KingKaYaConfig.instance:getNorStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._difficulty = self._stageData.difficulty
	self._selfPositionBuffs = self._stageData.selfPositionBuffs
	self._enemyPositionBuffs = self._stageData.enemyPositionBuffs
	self._masterData = KingKaYaConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = KingKaYaConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._winScoreRequirements = {}
end

function KingKaYaNorCustomFmtMo:getActivityId()
	return self._activityId
end

function KingKaYaNorCustomFmtMo:getWinScoreRequirements()
	return self._winScoreRequirements
end

function KingKaYaNorCustomFmtMo:getSelfPositionBuffs()
	return self._selfPositionBuffs
end

function KingKaYaNorCustomFmtMo:getEnemyPositionBuffs()
	return self._enemyPositionBuffs
end

function KingKaYaNorCustomFmtMo:getCreepsMasterId()
	return self._creepsMasterId
end

function KingKaYaNorCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function KingKaYaNorCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KingKaYaController.instance:sendPM_KingKaYaNormalChallengeReq(self._activityId, self._difficulty, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KingKaYaNorCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KingKaYaNorCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KingKaYaNorCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KingKaYaNorCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KingKaYaNorCustomFmtMo:getExtendViewName()
	return ViewName.KingKaYaFmtExtisonView
end

return KingKaYaNorCustomFmtMo
