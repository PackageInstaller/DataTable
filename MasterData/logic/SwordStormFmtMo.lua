-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/model/SwordStormFmtMo.lua

module("logic.extensions.swordstorm.model.SwordStormFmtMo", package.seeall)

local SwordStormFmtMo = class("SwordStormFmtMo", BaseCustomFmtMo)

function SwordStormFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId

	local stageCfg = SwordStormConfig.instance:getStageCfg(self.activityId, self.phaseId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self.selectSeedMap = {}
	self._cfgEnemy = SwordStormConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = SwordStormConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.ruleViewName = ViewName.SwordStormRuleView
	self.ruleViewArgs = {
		self.activityId,
		self.phaseId,
		self.stageId
	}

	local phaseCfg = SwordStormConfig.instance:getPhaseCfg(self.activityId, self.phaseId)
	local supportPetCfgs = SwordStormConfig.instance:getSupportPetCfgs(phaseCfg.supportPetPlanId)

	self.supportPetPlanId = phaseCfg.supportPetPlanId
	self._supportPetIdList = {}

	for k, v in pairs(supportPetCfgs) do
		table.insert(self._supportPetIdList, v.creepsId)
	end

	self.useMaxFightPower = true
end

function SwordStormFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		SwordStormAgent.instance:sendPM_SwordStormChallengeReq(self.activityId, self.phaseId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SwordStormFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, creepsId in ipairs(self._supportPetIdList) do
				local cfgSupport = SwordStormConfig.instance:getSupportPetCfg(self.supportPetPlanId, creepsId)

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

function SwordStormFmtMo:_isNeedUpdateSupportPet()
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

function SwordStormFmtMo:getMonsterConfigList()
	return self._masterList
end

function SwordStormFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function SwordStormFmtMo:getExtendViewName()
	return ViewName.SwordStormFmtView
end

return SwordStormFmtMo
