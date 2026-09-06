-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/model/DivineEmpressNormalFmtMo.lua

module("logic.extensions.divineempress.model.DivineEmpressNormalFmtMo", package.seeall)

local DivineEmpressNormalFmtMo = class("DivineEmpressNormalFmtMo", BaseCustomFmtMo)

function DivineEmpressNormalFmtMo:initParams(activityId, groupId, stageId)
	self.activityId = activityId
	self.groupId = groupId
	self.stageId = stageId

	local stageCfg = DivineEmpressConfig.instance:getNormalStageCfg(self.activityId, self.groupId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = DivineEmpressConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineEmpressConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local supportPetCfgs = DivineEmpressConfig.instance:getSupportPetCfgs(self.activityId)

	self._supportPetIdList = {}

	for k, v in pairs(supportPetCfgs) do
		table.insert(self._supportPetIdList, v.creepsId)
	end

	self.useMaxFightPower = true
end

function DivineEmpressNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressNormalClgReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineEmpressNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineEmpressNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineEmpressNormalFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, shopPosId in ipairs(self._supportPetIdList) do
				local cfgSupport = DivineEmpressConfig.instance:getSupportPetCfg(self.activityId, shopPosId)

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

function DivineEmpressNormalFmtMo:_isNeedUpdateSupportPet()
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

function DivineEmpressNormalFmtMo:getExtendViewName()
	return ViewName.DivineEmpressNormalFmtView
end

return DivineEmpressNormalFmtMo
