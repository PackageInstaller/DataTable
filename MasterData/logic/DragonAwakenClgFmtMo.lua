-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/model/DragonAwakenClgFmtMo.lua

module("logic.extensions.dragonawaken.model.DragonAwakenClgFmtMo", package.seeall)

local DragonAwakenClgFmtMo = class("DragonAwakenClgFmtMo", BaseCustomFmtMo)

function DragonAwakenClgFmtMo:initParams(activityId, phaseId)
	self.activityId = activityId

	local baseInfo = DragonAwakenModel.instance:getBaseInfoByActId(self.activityId)

	self.curPhaseId = baseInfo.curPhaseId
	self.curStageId = baseInfo.curStageId

	local phaseCfgs = DragonAwakenConfig.instance:getPhaseCfgs(self.activityId)

	self._isFinalClg = self.curPhaseId == #phaseCfgs

	local phaseCfg = phaseCfgs[self.curPhaseId]

	self.curStageCfg = DragonAwakenConfig.instance:getStageCfgByStageId(phaseCfg.stagePlan, self.curStageId)
	self.creepsMasterId = self.curStageCfg.creepsMasterId
	self.masterCfg = DragonAwakenConfig.instance:getFormationCfg(self.creepsMasterId) or {}
	self.creeps = DragonAwakenConfig.instance:getCreepCfgs(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.isPopRuleDesc = false

	self:clearAllPetList()
end

function DragonAwakenClgFmtMo:initPetList()
	local petsMap = DragonAwakenModel.instance:getPetMoMap(self.activityId) or {}
	local unlockCreepIds = DragonAwakenModel.instance:getCurCreepIds(self.activityId) or {}
	local level = DragonAwakenModel.instance:getCurUpgradeLevelByType(self.activityId, DragonAwakenController.UpgradeType.Pet)
	local awakenLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self.activityId, DragonAwakenController.UpgradeType.Awaken)
	local equipmentLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self.activityId, DragonAwakenController.UpgradeType.Equip)
	local starGodPlusLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self.activityId, DragonAwakenController.UpgradeType.StarGod)
	local holyStripeLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self.activityId, DragonAwakenController.UpgradeType.HolyStripe)

	for i, petId in ipairs(unlockCreepIds) do
		local petMo = petsMap[petId]

		if petMo then
			petMo = DragonAwakenModel.instance:updatePetMo(self.activityId, petMo, level, awakenLv, equipmentLv, starGodPlusLv, holyStripeLv)

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function DragonAwakenClgFmtMo:getMonsterConfigList()
	return self.creeps
end

function DragonAwakenClgFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DragonAwakenClgFmtMo:refreshPetList(changePetMoMap)
	return
end

function DragonAwakenClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self:checkCanFight() then
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
			DragonAwakenController.instance:startFightRequest(self.activityId, self:getCurSimpleForm())
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	end, nil)
end

function DragonAwakenClgFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateFormInfo)
end

function DragonAwakenClgFmtMo:getExtendViewName()
	return ViewName.DragonAwakenFmtExView
end

function DragonAwakenClgFmtMo:checkCanFight()
	local curPhasePetCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self.activityId, self.curPhaseId)

	if curPhasePetCfg then
		if not self:getCurFormation():HasPet(curPhasePetCfg.creepsId) then
			local tips = string.format("%s必须上阵", curPhasePetCfg.creepsName)

			TipsFacade.instance:openCommonTips(tips)

			return false
		end
	end

	local cost = self.curStageCfg.cost

	if not GameUtil.isEmptyString(cost) and not MaterialMgr.getMatEnough(cost) then
		local type, id, num = MaterialMgr.getMatParams(cost)
		local name = MaterialMgr.getMaterialsName(type, id)
		local showNum = 1

		if type == MatType.ACTIVITY_ENERGY then
			local energyCfg = EnergyConfig.instance:getEnergyCfg(id)

			if energyCfg then
				showNum = energyCfg.recoveryEfficiency / 60
			end
		end

		local tips = string.format("%s数量不足，每%s分钟恢复1点，晚点再来吧", name, showNum)

		TipsFacade.instance:openCommonTips(tips)

		return false
	end

	return true
end

return DragonAwakenClgFmtMo
