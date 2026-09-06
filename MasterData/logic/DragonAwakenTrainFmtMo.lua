-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/model/DragonAwakenTrainFmtMo.lua

module("logic.extensions.dragonawaken.model.DragonAwakenTrainFmtMo", package.seeall)

local DragonAwakenTrainFmtMo = class("DragonAwakenTrainFmtMo", BaseCustomFmtMo)

function DragonAwakenTrainFmtMo:initParams(activityId, hard)
	self.activityId = activityId
	self.hard = hard

	local baseInfo = DragonAwakenModel.instance:getBaseInfoByActId(self.activityId)

	self.curPhaseId = baseInfo.curPhaseId

	if not baseInfo.trainingFormList then
		local formId = -1

		for _, formInfo in ipairs(baseInfo.trainingFormList) do
			if hard == formInfo.hard then
				formId = formInfo.formId
			end
		end

		local trainFormCfg = DragonAwakenConfig.instance:getTrainingFormCfgByFromId(self.activityId, hard, formId) or {}

		self.creepsMasterId = trainFormCfg.creepsMasterId
		self.masterCfg = DragonAwakenConfig.instance:getFormationCfg(self.creepsMasterId) or {}
		self.creeps = DragonAwakenConfig.instance:getCreepCfgs(self.creepsMasterId) or {}

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.isPopRuleDesc = false

		self:clearAllPetList()
	end
end

function DragonAwakenTrainFmtMo:initPetList()
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

function DragonAwakenTrainFmtMo:getMonsterConfigList()
	return self.creeps
end

function DragonAwakenTrainFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DragonAwakenTrainFmtMo:refreshPetList(changePetMoMap)
	return
end

function DragonAwakenTrainFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self:checkCanFight() then
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
			DragonAwakenController.instance:startTrainingFight(self.activityId, self.hard, self:getCurSimpleForm())
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	end, nil)
end

function DragonAwakenTrainFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateFormInfo)
end

function DragonAwakenTrainFmtMo:getExtendViewName()
	return ViewName.DragonAwakenFmtExView
end

function DragonAwakenTrainFmtMo:checkCanFight()
	local canFight = false
	local curPhasePetCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self.activityId, self.curPhaseId)

	if curPhasePetCfg then
		canFight = self:getCurFormation():HasPet(curPhasePetCfg.creepsId)
	else
		return true
	end

	if not canFight then
		local tips = string.format("%s必须上阵", curPhasePetCfg.creepsName)

		TipsFacade.instance:openCommonTips(tips)
	end

	return canFight
end

return DragonAwakenTrainFmtMo
