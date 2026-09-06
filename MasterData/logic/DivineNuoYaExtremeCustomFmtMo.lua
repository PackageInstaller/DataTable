-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/model/DivineNuoYaExtremeCustomFmtMo.lua

module("logic.extensions.divinenuoyachallenge.model.DivineNuoYaExtremeCustomFmtMo", package.seeall)

local DivineNuoYaExtremeCustomFmtMo = class("DivineNuoYaExtremeCustomFmtMo", ICustomFmtMo)

function DivineNuoYaExtremeCustomFmtMo:initParams(activityId, stageId, monsterId)
	self._activityId = activityId
	self._stageId = stageId
	self._monsterId = monsterId

	local cfgStage = DivineNuoYaChallengeConfig.instance:getMonster(activityId, stageId, monsterId)

	self._monsterCfg = DivineNuoYaChallengeConfig.instance:getMaster(cfgStage.creepsMasterId)
	self._creepsCfgs = DivineNuoYaChallengeConfig.instance:getCreeps(cfgStage.creepsMasterId)
end

function DivineNuoYaExtremeCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.missionDesc

	self:setFormCondition(self._monsterCfg.formCondition)
	self:initPetList()
end

function DivineNuoYaExtremeCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function DivineNuoYaExtremeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo, true)
	end
end

function DivineNuoYaExtremeCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleFacade.instance:startDivineNuoYaBattle()
		DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaClgExtremeFightReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineNuoYaExtremeCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineNuoYaExtremeCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineNuoYaExtremeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local petInfoList = DivineNuoYaChallengeModel.instance:getPetInfoList()

	for _, v in pairs(petInfoList) do
		self:addPetToList(v.petMo)
	end
end

function DivineNuoYaExtremeCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return DivineNuoYaChallengeModel.instance:isPetLock(petMo.petId)
end

function DivineNuoYaExtremeCustomFmtMo:showForbitPetAlert(petMo)
	if DivineNuoYaChallengeModel.instance:getPetHp(petMo.petId) == 0 then
		FloatWordMgr.instance:show(string.format("%s血量为0,请使用其他精灵破阵", petMo.name))
	end
end

return DivineNuoYaExtremeCustomFmtMo
