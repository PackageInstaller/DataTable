-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/model/HolyDragonFieldFmtMo.lua

module("logic.extensions.holydragonfield.model.HolyDragonFieldFmtMo", package.seeall)

local HolyDragonFieldFmtMo = class("HolyDragonFieldFmtMo", ICustomFmtMo)

function HolyDragonFieldFmtMo:initParams(activityId, fieldId, stageId, selectBossSettle)
	self._activityId = checknumber(activityId)
	self._fieldId = checknumber(fieldId)
	self._stageId = checknumber(stageId)
	self._selectBossSettleMap = {}
	self._selectBossSettle = {}
	self._fieldData = HolyDragonFieldConfig.instance:getFieldData(self._activityId, self._fieldId)
	self._stageData = HolyDragonFieldConfig.instance:getStageData(self._activityId, self._fieldId, self._stageId)

	self:_initSelectedBossSettle(selectBossSettle)

	self._masterData = self._stageData and HolyDragonFieldConfig.instance:getMasterData(self._stageData.creepsMasterId) or nil
	self._creepsDatas = self._stageData and HolyDragonFieldConfig.instance:getCreepsDatas(self._stageData.creepsMasterId) or nil
	self._supportPetPlan = self._fieldData and checknumber(self._fieldData.supportPetPlan) or 0
	self._mustDeployRace = self._fieldData and checknumber(self._fieldData.mustDeployRace) or 0
	self._heroSkillId = self._fieldData and checknumber(self._fieldData.lockHeroSkill) or 0

	self:clearAllPetList()
end

function HolyDragonFieldFmtMo:_initSelectedBossSettle(selectBossSettle)
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(self._stageData)

	for _, settleId in ipairs(selectBossSettle or {}) do
		local settleData = HolyDragonFieldConfig.instance:getBossSettleData(self._activityId, bossSettlePlan, checknumber(settleId))

		if settleData then
			self:setBossSettleSelected(settleData.settleType, settleId, true)
		end
	end
end

function HolyDragonFieldFmtMo:updateData()
	if self._masterData == nil then
		printError("HolyDragonFieldFmtMo masterData is nil", self._activityId, self._fieldId, self._stageId)

		return
	end

	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or ""
	self.validatorDescStr = self._masterData.ruleDesc or ""

	self:setFormCondition(self._masterData.formCondition)
	self:_syncMustDeployValidatorDesc()
	self:initPetList()
	self:_setDefaultHeroSkill()
end

function HolyDragonFieldFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if checknumber(self._heroSkillId) > 0 and simpleForm and simpleForm.extParams then
			simpleForm.extParams.heroSkillId = self:_getEffectiveLockHeroSkillId()
		end

		HolyDragonFieldController.instance:sendPM_HolyDragonFieldChallengeReq(self._activityId, simpleForm, self._fieldId, self._stageId, self._selectBossSettle)
	end

	self:setFightHandler(handler, nil)
end

function HolyDragonFieldFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList or {}) do
		self:addPetToList(petMo)
	end

	local supportPetDatas = HolyDragonFieldConfig.instance:getSupportPetDatas(self._supportPetPlan)

	for _, supportPetData in pairs(supportPetDatas or {}) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportPetData)
		fmo:setSupportedPet(true)

		local supportPetMo = fmo:toBaseBagPetMo()

		self:addPetToList(supportPetMo)
	end
end

function HolyDragonFieldFmtMo:getMonsterConfigList()
	return self._creepsDatas
end

function HolyDragonFieldFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HolyDragonFieldFmtMo:getHeroSkills()
	if checknumber(self._heroSkillId) <= 0 then
		return nil
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()

	if heroSkillId > 0 then
		return {
			heroSkillId
		}
	end

	return {}
end

function HolyDragonFieldFmtMo:getExtendViewName()
	if self._stageData and HolyDragonFieldConfig.instance:isBossStage(self._stageData) then
		return ViewName.HolyDragonFieldScoreFmtExView
	end

	return ""
end

function HolyDragonFieldFmtMo:getFinalFmoList(posList, petPool, needPets)
	local mustDeployPetMo = self:_getMustDeployPetMoFromList(petPool) or self:_getMustDeployPetMo()

	if mustDeployPetMo == nil then
		return posList, petPool
	end

	return CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petPool, needPets, {
		5
	}, {
		mustDeployPetMo
	}, self.needUpPetCount)
end

function HolyDragonFieldFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self._mustDeployRace > 0 and not self:_isMustDeployRaceMatch() then
		FloatWordMgr.instance:show(langPara("必须上阵%s", self:_getMustDeployPetName()))

		return true
	end

	return HolyDragonFieldFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function HolyDragonFieldFmtMo:onFormationChangeFinish()
	self:setValidatorDescYesOrNo(self:_isMustDeployRaceMatch())
end

function HolyDragonFieldFmtMo:isBossSettleSelected(settleType, settleId)
	return checknumber(self._selectBossSettleMap[checknumber(settleType)]) == checknumber(settleId)
end

function HolyDragonFieldFmtMo:setBossSettleSelected(settleType, settleId, isSelected)
	settleType = checknumber(settleType)
	settleId = checknumber(settleId)

	if settleType <= 0 or settleId <= 0 then
		return
	end

	if isSelected == true then
		self._selectBossSettleMap[settleType] = settleId
	elseif self:isBossSettleSelected(settleType, settleId) then
		self._selectBossSettleMap[settleType] = nil
	end

	self:_refreshSelectedBossSettleList()
end

function HolyDragonFieldFmtMo:getSelectedBossSettle()
	return self._selectBossSettle
end

function HolyDragonFieldFmtMo:getSelectedBossSettleId(settleType)
	return checknumber(self._selectBossSettleMap[checknumber(settleType)])
end

function HolyDragonFieldFmtMo:_refreshSelectedBossSettleList()
	local selectBossSettle = {}
	local hasSelected = false
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(self._stageData)
	local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

	for _, group in ipairs(bossSettleGroups) do
		local settleId = checknumber(self._selectBossSettleMap[group.settleType])

		if settleId > 0 then
			hasSelected = true

			table.insert(selectBossSettle, settleId)
		end
	end

	self._selectBossSettle = hasSelected and selectBossSettle or {}
end

function HolyDragonFieldFmtMo:_OnHeroSkillChanged(id, exParmams)
	if checknumber(self._heroSkillId) <= 0 then
		return
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()
	local formation = self:getCurFormation()

	if formation then
		formation:SetHeroSkillId(heroSkillId)
	end
end

function HolyDragonFieldFmtMo:getActivityId()
	return self._activityId
end

function HolyDragonFieldFmtMo:getFieldId()
	return self._fieldId
end

function HolyDragonFieldFmtMo:getStageId()
	return self._stageId
end

function HolyDragonFieldFmtMo:_getEffectiveLockHeroSkillId()
	local heroSkillId = checknumber(self._heroSkillId)

	if heroSkillId <= 0 then
		return 0
	end

	if self:_isLockHeroSkillValidInFormation(heroSkillId) then
		return heroSkillId
	end

	return 0
end

function HolyDragonFieldFmtMo:_setDefaultHeroSkill()
	if checknumber(self._heroSkillId) <= 0 then
		return
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()
	local formation = self:getCurFormation()

	if formation then
		formation:SetHeroSkillId(heroSkillId)
	end
end

function HolyDragonFieldFmtMo:_isLockHeroSkillValidInFormation(heroSkillId)
	local formation = self:getCurFormation()

	if formation == nil or formation._getValidHeroSkills == nil then
		return false
	end

	local validHeroSkills = formation:_getValidHeroSkills()

	return TableUtil.isHad(validHeroSkills, heroSkillId)
end

function HolyDragonFieldFmtMo:_getMustDeployPetMo()
	if self._mustDeployRace <= 0 then
		return nil
	end

	local var_26_0 = pairs
	local var_26_1 = self:getCurFormation():getHasPets()

	var_26_1 = var_26_1 or {}

	for _, petId in var_26_0(var_26_1) do
		local petMo = self:getPetMoById(petId)

		if petMo and petMo:getDefineId() == self._mustDeployRace then
			return petMo
		end
	end

	for _, petMo in pairs(self:getAllShowPetList() or {}) do
		if petMo and petMo:getDefineId() == self._mustDeployRace then
			return petMo
		end
	end

	return nil
end

function HolyDragonFieldFmtMo:_getMustDeployPetMoFromList(petList)
	for _, petMo in pairs(petList or {}) do
		if petMo and petMo:getDefineId() == self._mustDeployRace then
			return petMo
		end
	end

	return nil
end

function HolyDragonFieldFmtMo:_getMustDeployPetName()
	return CharacterConfig.instance:getPetName(self._mustDeployRace)
end

function HolyDragonFieldFmtMo:_isMustDeployRaceMatch()
	if self._mustDeployRace <= 0 then
		return true
	end

	return self:getCurFormation():HasRace(self._mustDeployRace)
end

function HolyDragonFieldFmtMo:_syncMustDeployValidatorDesc()
	if self._mustDeployRace <= 0 then
		return
	end

	self.validatorDescStr = langPara("必须上阵%s", self:_getMustDeployPetName())
	self.validatorDescIsShowYesOrNo = true

	self:setValidatorDescYesOrNo(self:_isMustDeployRaceMatch())
end

return HolyDragonFieldFmtMo
