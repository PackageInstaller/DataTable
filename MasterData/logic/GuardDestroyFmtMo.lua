-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/model/GuardDestroyFmtMo.lua

module("logic.extensions.wuwenchallenge.model.GuardDestroyFmtMo", package.seeall)

local GuardDestroyFmtMo = class("GuardDestroyFmtMo", BaseCustomFmtMo)

function GuardDestroyFmtMo:initParams(activityId, stageId, type, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._type = type
	self._cfgEnemy = GuardDestroyConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = GuardDestroyConfig.instance:getCreepsCfg(creepsMasterId)

	local stageCfg = GuardDestroyConfig.instance:getStageCfg(self._activityId, self._stageId)

	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local cfgs = GuardDestroyConfig.instance:getSupportPetCfgs(stageCfg.supportPetPlanId)

	self._supportPetIdList = {}

	for k, v in pairs(cfgs) do
		table.insert(self._supportPetIdList, v.creepsId)
	end
end

function GuardDestroyFmtMo:updateData()
	local stageCfg = GuardDestroyConfig.instance:getStageCfg(self._activityId, self._stageId)

	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, creepsId in ipairs(self._supportPetIdList) do
				local cfgSupport = GuardDestroyConfig.instance:getSupportPetCfg(stageCfg.supportPetPlanId, creepsId)

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

function GuardDestroyFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		GuardDestroyAgent.instance:sendPM_GuardDestroyChallengeReq(self._activityId, self._stageId, self._type, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GuardDestroyFmtMo:getMonsterConfigList()
	return self._masterList
end

function GuardDestroyFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GuardDestroyFmtMo:_isNeedUpdateSupportPet()
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

return GuardDestroyFmtMo
