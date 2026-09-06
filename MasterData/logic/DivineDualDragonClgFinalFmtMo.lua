-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/model/DivineDualDragonClgFinalFmtMo.lua

module("logic.extensions.divinedualdragonclg.model.DivineDualDragonClgFinalFmtMo", package.seeall)

local DivineDualDragonClgFinalFmtMo = class("DivineDualDragonClgFinalFmtMo", BaseCustomFmtMo)

function DivineDualDragonClgFinalFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._activityType = DivineDualDragonClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)

	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stageCfg = DivineDualDragonClgConfig.instance:getStageCfg(phaseCfg.stagePlanId, stageId)

	self._cfgEnemy = DivineDualDragonClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = DivineDualDragonClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.isOnlyUpdateExistPet = true

	self:setFormCondition(self._cfgEnemy.formCondition)

	local existPet = DivineDualDragonClgModel.instance:getFinalFightPet(self.activityId, self.phaseId)

	self._existPetList = {}

	table.clear(self._existPetList)

	for k, v in pairs(existPet) do
		table.insert(self._existPetList, k)
	end
end

function DivineDualDragonClgFinalFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self.activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineDualDragonClgAgent.instance:sendPM_DivineDualDragonClgChallengeReq(self.activityId, self.phaseId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineDualDragonClgFinalFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdatePet() then
		self:initPetList()
	end

	self._lastSupportIdList = self._existPetList
end

function DivineDualDragonClgFinalFmtMo:initPetList()
	self:clearAllPetList()

	for i, id in pairs(self._existPetList) do
		local petMo = BagPetsController.instance:getPet(id)

		if petMo then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function DivineDualDragonClgFinalFmtMo:_changePetMo(petMo)
	return petMo
end

function DivineDualDragonClgFinalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineDualDragonClgFinalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineDualDragonClgFinalFmtMo:_isNeedUpdatePet()
	local curSupportCount = #self._existPetList

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

			for i, id1 in ipairs(self._existPetList) do
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

return DivineDualDragonClgFinalFmtMo
