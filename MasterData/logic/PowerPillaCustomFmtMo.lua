-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/model/PowerPillaCustomFmtMo.lua

module("logic.extensions.maintainpowerpilla.model.PowerPillaCustomFmtMo", package.seeall)

local PowerPillaCustomFmtMo = class("PowerPillaCustomFmtMo", ICustomFmtMo)

function PowerPillaCustomFmtMo:onReset()
	PowerPillaCustomFmtMo.super.onReset(self)

	self.isShowBtnFormation = false
	self.isShowBtnCutePet = false
end

function PowerPillaCustomFmtMo:updateData()
	local monsterCfg
	local stageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, self._stageId)
	local gridData = PowerPillaConfig.instance:getGridCfg(stageData.mapId, self._nextGridId)
	local eventType = gridData.eventType

	if eventType == PPLMapCell.Battle then
		monsterCfg = PowerPillaConfig.instance:getMonsterCfgByEventId(self._eventId)
	elseif eventType == PPLMapCell.Boss then
		local creepsMasterId = PowerPillaConfig.instance:getCreepsMasterIdOfBossData(self._eventId)

		monsterCfg = PowerPillaConfig.instance:getMonsterCfg(creepsMasterId)
	end

	self._monsterCfg = monsterCfg
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.description
	self.isPopRuleDesc = true
	self.strShowRuleFlagKey = "PowerPillaCustomFmtMo_" .. self._activityId .. "_" .. self._stageId .. "_" .. self._nextGridId
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First

	self:setFormCondition(self._monsterCfg.formCondition)

	self.isHideFmtZdl = true
end

function PowerPillaCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(self._activityId, self._stageId, self._nextGridId, self._curGridId, simpleForm)
		UIJumper.instance:pushOneStack(ViewName.PowerPillaEnterView, true)

		if PowerPillaModel.instance:isOpenByCurrentStage() then
			UIJumper.instance:pushOneStack(ViewName.PowerPillaLevelView, true, PowerPillaModel.instance:getCurStage())
		end
	end

	self:setFightHandler(handler, nil)
end

function PowerPillaCustomFmtMo:initPetList()
	self._allMyPetList = {}

	local supportCfgs = PowerPillaConfig.instance:getSupportPetList(self._petPlanId)

	for i, v in pairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		self:addPetToList(petMo)
	end
end

function PowerPillaCustomFmtMo:getAllContractPetList()
	return self._allMyPetList
end

function PowerPillaCustomFmtMo:getMonsterConfigList()
	return PowerPillaConfig.instance:getCreepsList(self._monsterCfg.creepsMasterId)
end

function PowerPillaCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function PowerPillaCustomFmtMo:updateParam(activityId, stageId, curGridId, nextGridId, petPlanId, eventId)
	self._activityId = activityId
	self._stageId = stageId
	self._curGridId = curGridId
	self._nextGridId = nextGridId
	self._petPlanId = petPlanId
	self._eventId = eventId
end

return PowerPillaCustomFmtMo
