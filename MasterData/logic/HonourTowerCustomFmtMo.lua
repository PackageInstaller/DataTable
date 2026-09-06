-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/model/HonourTowerCustomFmtMo.lua

module("logic.extensions.honourtower.model.HonourTowerCustomFmtMo", package.seeall)

local HonourTowerCustomFmtMo = class("HonourTowerCustomFmtMo", ICustomFmtMo)

function HonourTowerCustomFmtMo:onReset()
	HonourTowerCustomFmtMo.super.onReset(self)
end

function HonourTowerCustomFmtMo:initParams(periodId, challengeId, stageId)
	self._periodId = periodId
	self._challengeId = challengeId
	self._stageId = stageId
	self.showBtnVideo = true

	local ccfg = HonourTowerConfig.instance:getChallengeCfg(challengeId)

	self._isExtreme = ccfg.isExtreme
	self._stageCfg = HonourTowerConfig.instance:getStageCfg(self._challengeId, self._stageId)

	self:clearAllPetList()
end

function HonourTowerCustomFmtMo:updateData()
	local cfg = self:getFmtInfoConfig()

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.description

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function HonourTowerCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		HonourTowerController.instance:sendPM_HonorTowerChallengeReq(self._periodId, self._challengeId, self._stageId, simpleForm)
		UIJumper.instance:pushOneStack(ViewName.HonourTowerSelectView)
		UIJumper.instance:pushOneStack(ViewName.HonourTowerView, nil, self._challengeId)
	end

	self:setFightHandler(handler, nil)
end

function HonourTowerCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		if self._isExtreme then
			self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
		else
			self:addPetToList(petMo)
		end
	end
end

function HonourTowerCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		if self._isExtreme then
			self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
		else
			self:updatePetMo(petMo)
		end
	end
end

function HonourTowerCustomFmtMo:updateCellTop(cell, petMo)
	return
end

function HonourTowerCustomFmtMo:clearCellTop(cell)
	HonourTowerCustomFmtMo.super.clearCellTop(self, cell)
end

function HonourTowerCustomFmtMo:getMonsterConfigList()
	return HonourTowerConfig.instance:getCreepsCfgs(self._stageCfg.creepsMasterId)
end

function HonourTowerCustomFmtMo:getFmtInfoConfig()
	return HonourTowerConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
end

function HonourTowerCustomFmtMo:sendVideoMsg()
	local rankKey = string.format("ht_%s_%s", self._challengeId, self._stageId)

	BattleRecordRankController.instance:enterView2(rankKey)
end

return HonourTowerCustomFmtMo
