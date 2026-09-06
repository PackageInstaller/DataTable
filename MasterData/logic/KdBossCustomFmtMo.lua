-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/model/KdBossCustomFmtMo.lua

module("logic.extensions.kingdragonchallenge.model.KdBossCustomFmtMo", package.seeall)

local KdBossCustomFmtMo = class("KdBossCustomFmtMo", ICustomFmtMo)

function KdBossCustomFmtMo:onReset()
	KdBossCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function KdBossCustomFmtMo:updateData()
	local challengeId = KdChallengeModel.instance:getCurChallengeId()
	local bossData = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local enemyData = KdChallengeConfig.instance:getKdChallengeEnemyCfg(bossData.creepsMasterId)

	self.topTitleStr = enemyData.name
	self.ruleDescStr = enemyData.WinDesc
	self.validatorDescStr = enemyData.missionDesc

	self:setFormCondition(enemyData.formCondition)
	self:initPetList()
end

function KdBossCustomFmtMo:initFightHandler()
	local function handler()
		local challengeId = KdChallengeModel.instance:getCurChallengeId()
		local simpleForm = self:getCurSimpleForm()

		KdChallengeController.instance:sendPM_TQKingDragonBossClgReq(challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KdBossCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end

	local challengeId = KdChallengeModel.instance:getCurChallengeId()
	local bossData = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local helpCfg = KdChallengeConfig.instance:getKdHelpPetCfg(bossData.helpPlanId)

	if helpCfg then
		local fmo = FightingPowerPetMo.New()

		for _, helpData in pairs(helpCfg) do
			local systemPetData = KdChallengeConfig.instance:getKdChallengeSystemPetData(helpData.creepsSysId)

			fmo:fromChallengeCreepCo(systemPetData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end

		fmo = nil
	end
end

function KdBossCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KdBossCustomFmtMo:getMonsterConfigList()
	local challengeId = KdChallengeModel.instance:getCurChallengeId()
	local bossData = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)

	return KdChallengeConfig.instance:getKdChallengeCreepsCfg(bossData.creepsMasterId)
end

function KdBossCustomFmtMo:getFmtInfoConfig()
	local challengeId = KdChallengeModel.instance:getCurChallengeId()

	return (KdChallengeConfig.instance:getKdBossDataByCId(challengeId))
end

return KdBossCustomFmtMo
