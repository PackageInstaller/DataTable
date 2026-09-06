-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/model/DestroyEvilCustomFmtMo.lua

module("logic.extensions.destroyevil.model.DestroyEvilCustomFmtMo", package.seeall)

local DestroyEvilCustomFmtMo = class("DestroyEvilCustomFmtMo", ICustomFmtMo)

function DestroyEvilCustomFmtMo:initParams(activityId, targetPlayerId, monsterId, monsterUniqueId, strongChallenge, isNoPaid)
	self._activityId = activityId
	self._targetPlayerId = targetPlayerId
	self._monsterId = monsterId
	self._monsterUniqueId = monsterUniqueId
	self._isStrongChallenge = strongChallenge
	self._isNoPaid = isNoPaid

	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(activityId, monsterId)

	self._monsterCfg = DestroyEvilConfig.instance:getMaster(cfgMonster.creepsMasterId)
	self._creepsCfgs = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
end

function DestroyEvilCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function DestroyEvilCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function DestroyEvilCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DestroyEvilCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DestroyEvilAgent.instance:sendPM_DestroyEvilChallengeReq(self._activityId, self._targetPlayerId, self._monsterUniqueId, form, self._isStrongChallenge, self._isNoPaid)
	end

	self:setFightHandler(handler, nil)
end

function DestroyEvilCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DestroyEvilCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DestroyEvilCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return DestroyEvilCustomFmtMo
