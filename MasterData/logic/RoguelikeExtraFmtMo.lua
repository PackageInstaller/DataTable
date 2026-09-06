-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RoguelikeExtraFmtMo.lua

module("logic.extensions.roguelike.model.RoguelikeExtraFmtMo", package.seeall)

local RoguelikeExtraFmtMo = class("RoguelikeExtraFmtMo", BaseCustomFmtMo)

function RoguelikeExtraFmtMo:initParams(activityId, phaseId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._curStageId = 1

	local cfgStage = RoguelikeConfig.instance:getExtStageCfg(activityId, phaseId, self._curStageId)

	self._monsterCfg = RoguelikeConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = RoguelikeConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = string.format("第%d阵", self._curStageId)
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self._supportPetIdList = RoguelikeModel.instance:getRentPetIdList(self._activityId)
end

function RoguelikeExtraFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, creepsId in ipairs(self._supportPetIdList) do
				local cfgSupport = RoguelikeConfig.instance:getRentPetCfg(self._activityId, creepsId)

				if cfgSupport then
					local fmo = FightingPowerPetMo.New()

					fmo:fromChallengeCreepCo(cfgSupport)
					fmo:setSupportedPet(true)

					local supportPetMo = fmo:toBaseBagPetMo()

					self:addPetToList(self:_changePetMo(supportPetMo))
				end
			end
		end
	end

	self._lastSupportIdList = self._supportPetIdList
end

function RoguelikeExtraFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		RoguelikeController.instance:startBattle(self._activityId, self._phaseId, form)
	end

	self:setFightHandler(handler, nil)
end

function RoguelikeExtraFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function RoguelikeExtraFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function RoguelikeExtraFmtMo:getExtendViewName()
	return ViewName.RoguelikefmtpopupView
end

function RoguelikeExtraFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if RoguelikeModel.instance:isNeedSelectBuff(self._activityId, self._phaseId) then
		return true
	end

	return RoguelikeExtraFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function RoguelikeExtraFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcTotalAttrs()
		mo:refreshAllAttr()
		self:addPetToList(self:_changePetMo(mo))
	end
end

function RoguelikeExtraFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcTotalAttrs()
		mo:refreshAllAttr()
		self:updatePetMo(self:_changePetMo(mo))
	end
end

function RoguelikeExtraFmtMo:getActivityId()
	return self._activityId
end

function RoguelikeExtraFmtMo:getPhaseId()
	return self._phaseId
end

function RoguelikeExtraFmtMo:_isNeedUpdateSupportPet()
	local curSupportCount = #self._supportPetIdList

	if self._lastSupportIdList then
		if not #self._lastSupportIdList then
			local lastSupportCount = 0

			if curSupportCount ~= lastSupportCount then
				return true
			end

			if curSupportCount == 0 then
				return false
			end

			local sameCount = 0

			for i, id1 in ipairs(self._supportPetIdList) do
				for j, id2 in ipairs(self._lastSupportIdList) do
					if id1 == id2 then
						sameCount = sameCount + 1

						break
					end
				end
			end

			return sameCount ~= curSupportCount
		end
	end
end

return RoguelikeExtraFmtMo
