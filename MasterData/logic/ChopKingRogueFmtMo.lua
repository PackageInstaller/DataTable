-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/model/ChopKingRogueFmtMo.lua

module("logic.extensions.chopking.model.ChopKingRogueFmtMo", package.seeall)

local ChopKingRogueFmtMo = class("ChopKingRogueFmtMo", BaseCustomFmtMo)

function ChopKingRogueFmtMo:initParams(activityId)
	self._activityId = activityId
	self._curStageId = ChopKingModel.instance:getRoguePassNum(activityId) + 1
	self._curStageId = ChopKingController:getFirstClgStartStageId(activityId, self._curStageId)

	local cfgStage = ChopKingConfig.instance:getFirstClgStageCfg(activityId, self._curStageId)

	self._monsterCfg = ChopKingConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = ChopKingConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = string.format("第%d阵", self._curStageId)
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self._supportPetIdList = ChopKingConfig.instance:getSupportPetIds(self._activityId, cfgStage.supportPetPoolId)
end

function ChopKingRogueFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, creepsId in ipairs(self._supportPetIdList) do
				local cfgSupport = ChopKingConfig.instance:getSupportPetCfg(self._activityId, creepsId)

				if cfgSupport then
					local fmo = FightingPowerPetMo.New()

					fmo:fromChallengeCreepCo(cfgSupport)
					fmo:setSupportedPet(true)

					local supportPetMo = fmo:toBaseBagPetMo()

					self:addPetToList(supportPetMo)
				end
			end
		end
	end

	self._lastSupportIdList = self._supportPetIdList
end

function ChopKingRogueFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		ChopKingController.instance:startOnceBattle(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function ChopKingRogueFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function ChopKingRogueFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function ChopKingRogueFmtMo:getExtendViewName()
	return ViewName.ChopKingRogueFmtPopupView
end

function ChopKingRogueFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if ChopKingModel.instance:isNeedSelectBuff(self._activityId) then
		return true
	end

	return ChopKingRogueFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function ChopKingRogueFmtMo:_changePetMo(petMo)
	local mo = petMo:GetClone()

	mo.attrMo:resetPublicAttr()
	mo.attrMo:calcTotalAttrs()
	mo:refreshAllAttr()

	return mo
end

function ChopKingRogueFmtMo:getActivityId()
	return self._activityId
end

function ChopKingRogueFmtMo:_isNeedUpdateSupportPet()
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

return ChopKingRogueFmtMo
