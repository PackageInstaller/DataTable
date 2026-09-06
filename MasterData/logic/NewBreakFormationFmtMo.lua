-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/model/NewBreakFormationFmtMo.lua

module("logic.extensions.newbreakformation.model.NewBreakFormationFmtMo", package.seeall)

local NewBreakFormationFmtMo = class("NewBreakFormationFmtMo", ICustomFmtMo)

function NewBreakFormationFmtMo:initParams(seasonId, tabId, periodId, stageId, allBuffId, uniqueBuffId, petRaceId1, petRaceId2)
	self._seasonId = seasonId
	self._tabId = tabId
	self._periodId = periodId
	self._stageId = stageId
	self._allBuffId = allBuffId
	self._uniqueBuffId = uniqueBuffId
	self._petRaceId1 = petRaceId1
	self._petRaceId2 = petRaceId2

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(seasonId, tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, periodId)

	self._stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, stageId)
	self._cfgEnemy = NewBreakFormationConfig.instance:getMasterTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = NewBreakFormationConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
end

function NewBreakFormationFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function NewBreakFormationFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.NewBreakFormationMainView, true)
		UIJumper.instance:pushOneStack(ViewName.NewBreakFormationLevelView, true, self._seasonId, self._tabId, self._stageId)

		local simpleForm = self:getCurSimpleForm()
		local buffOption = NewBreachFormationExtension_pb.PM_NewBreachFormationBuffOption()

		if self._stageCfg.petBuffPlan > 0 then
			local raceIds = {}

			if self._petRaceId1 and self._petRaceId1 > 0 then
				table.insert(raceIds, self._petRaceId1)
			end

			if self._petRaceId2 and self._petRaceId2 > 0 then
				table.insert(raceIds, self._petRaceId2)
			end

			local buff = NewBreachFormationExtension_pb.PM_NewBreachFormationPetBuff()

			for i, v in ipairs(raceIds) do
				buff.raceIds:append(v)
			end

			buffOption.petBuff:ParseFromString(buff:SerializeToString())
			NewBreachFormationAgent.instance:sendPM_NewBreachFormationChallengeReq(self._seasonId, self._tabId, self._periodId, self._stageId, buffOption, simpleForm)
		else
			local buff = NewBreachFormationExtension_pb.PM_NewBreachFormationGlobalBuff()

			buff.allPetBuffId = self._allBuffId
			buff.specialBuffId = self._uniqueBuffId

			buffOption.globalBuff:ParseFromString(buff:SerializeToString())
			NewBreachFormationAgent.instance:sendPM_NewBreachFormationChallengeReq(self._seasonId, self._tabId, self._periodId, self._stageId, buffOption, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function NewBreakFormationFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function NewBreakFormationFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function NewBreakFormationFmtMo:_changePetMo(petMo)
	return FightingPowerPetMo.getMaxPetMoByData(petMo)
end

function NewBreakFormationFmtMo:getMonsterConfigList()
	return self._masterList
end

function NewBreakFormationFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function NewBreakFormationFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

return NewBreakFormationFmtMo
