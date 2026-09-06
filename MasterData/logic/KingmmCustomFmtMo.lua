-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/model/KingmmCustomFmtMo.lua

module("logic.extensions.kingmengmeng.model.KingmmCustomFmtMo", package.seeall)

local KingmmCustomFmtMo = class("KingmmCustomFmtMo", ICustomFmtMo)

function KingmmCustomFmtMo:initParams(activityId, formId, conditionId, formCheckId)
	self._activityId = activityId
	self._formId = formId
	self._conditionId = conditionId
	self._formCheckId = formCheckId

	local cfgForm = KingmmConfig.instance:getFormCfg(activityId, formId)

	self._cfgCondition = KingmmConfig.instance:getConditionCfg(activityId, conditionId)
	self._monsterCfg = KingmmConfig.instance:getMonsterCfg(cfgForm.creepsMasterId)
	self._creepsCfgs = KingmmConfig.instance:getCreepsCfgList(cfgForm.creepsMasterId)
	self.isShowBtnCutePet = false
end

function KingmmCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._cfgCondition.passDesc
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_DailyOnce
	self.strShowRuleFlagKey = "KingmmCustomFmtMo" .. self._activityId .. self._formId .. self._conditionId
	self.isShowMaxBuffFormLv = true

	self:setFormCondition(self._formCheckId)
	self:initPetList()
end

function KingmmCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function KingmmCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		KingmmAgent.instance:sendPM_KMMChallengeCommonChallengeReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function KingmmCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function KingmmCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function KingmmCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = self:_getMaxInfoPetList()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function KingmmCustomFmtMo:_getMaxInfoPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in ipairs(pets) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(v)

		table.insert(list, mo)
	end

	return list
end

function KingmmCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		self:updatePetMo(mo)
	end
end

return KingmmCustomFmtMo
