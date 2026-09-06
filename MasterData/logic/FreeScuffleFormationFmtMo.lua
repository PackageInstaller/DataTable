-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/model/FreeScuffleFormationFmtMo.lua

module("logic.extensions.freescuffle.model.FreeScuffleFormationFmtMo", package.seeall)

local FreeScuffleFormationFmtMo = class("FreeScuffleFormationFmtMo", BaseCustomFmtMo)

function FreeScuffleFormationFmtMo:updateCfg(activityId)
	self._activityId = activityId
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	local defendForm = self._subMo:getDefendForm()

	if defendForm then
		self._heroSkillId = defendForm.heroSkill or 0
	end

	self._simpleForm = defendForm and defendForm.form
	self._fmtType = FreeScuffleEnum.FmtType_Defense
	self.isShowBtnFormationUse = false
	self.isShowBtnSave = false
	self.isShowBtnCutePet = false
	self.isOnlyUpdateExistPet = true
	self.isNeedOpenCustomFmtFeatureView = true
	self._curHeroPetId = checknumber(self._curHeroPetId)

	self:initPetList()
	self:refreshMyFmts()
end

function FreeScuffleFormationFmtMo:getActivityId()
	return self._activityId
end

function FreeScuffleFormationFmtMo:updateData()
	FreeScuffleFormationFmtMo.super.updateData(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)
end

function FreeScuffleFormationFmtMo:onExitView()
	FreeScuffleFormationFmtMo.super.onExitView(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
end

function FreeScuffleFormationFmtMo:initPetList()
	self:clearAllPetList()

	self._fMo = self._fMo or FightingPowerPetMo.New()

	local dic = self._subMo:getBattlePetIdDic()

	for _, creepsId in pairs(dic) do
		local data = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, creepsId)

		if data then
			self._fMo:fromChallengeCreepCo(data)

			local petMo = self._fMo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(petMo)
		else
			printError(string.format("存在未配置的精灵:%s", creepsId))
		end
	end
end

function FreeScuffleFormationFmtMo:onFmoSetDown()
	self:updateHerorSkill()
end

function FreeScuffleFormationFmtMo:onDispatchFormationChanged()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function FreeScuffleFormationFmtMo:onDispatchFormationChanged()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function FreeScuffleFormationFmtMo:refreshMyFmts()
	local formation = self:getCurFormation()

	if self._simpleForm then
		formation:SetData(self._simpleForm)
	else
		formation:ResetPosition()
	end

	if self._heroSkillId > 0 then
		local heroSkillIds = self:getHeroSkills()

		formation:SetExHeroSkills(heroSkillIds)
		formation:SetHeroSkillId(self._heroSkillId)
		formation:fixAndUpdateHeroSkill()

		self._heroSkillId = 0
	end

	self:updateHerorSkill()
end

function FreeScuffleFormationFmtMo:updateHerorSkill()
	local heroSkillIds = self:getHeroSkills()

	self:getCurFormation():SetExHeroSkills(heroSkillIds)

	local heroSkill = self:getCurFormation():GetHeroSkillId()

	if heroSkill > 0 and #heroSkillIds > 0 then
		local skillDic = self:_getHeroSkillDicOnFmt()

		for petId, skillId in pairs(skillDic) do
			if heroSkill == skillId then
				self._curHeroPetId = petId

				break
			end
		end
	else
		self._curHeroPetId = 0
	end
end

function FreeScuffleFormationFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function FreeScuffleFormationFmtMo:fmtVerifyReq(fromBtnSave)
	local formation = self:getCurFormation()

	if formation:isEmpty() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return
	end

	local simpleForm = self:getCurSimpleForm()

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_FreeScuffleSetFormRes, self._handlePM_FreeScuffleSetFormRes, self)

	local heroSkill = formation:GetHeroSkillId()
	local skillLists = self._subMo:getSkillListInPets(self._fmtType)
	local petSkillList = FreeScuffleController.instance:getCompleteSkillList(skillLists)
	local petSkillListOnFmt = {}

	for _, v in pairs(petSkillList) do
		local petId = v.creepsId

		if formation:HasPet(petId) then
			table.insert(petSkillListOnFmt, v)
		end
	end

	if not self._curHeroPetId then
		if heroSkill > 0 and self._curHeroPetId <= 0 then
			printError("缺失选择英雄技的精灵( heroSkillId:%s )", heroSkill)
		end

		FreeScuffleController.instance:sendPM_FreeScuffleSetFormReq(self._activityId, simpleForm, petSkillListOnFmt, heroSkill, self._curHeroPetId)
	end
end

function FreeScuffleFormationFmtMo:_handlePM_FreeScuffleSetFormRes(status)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_FreeScuffleSetFormRes, self._handlePM_FreeScuffleSetFormRes, self)

	if status ~= 0 then
		FloatWordMgr.instance:show("阵容保存失败")
	else
		FloatWordMgr.instance:show("阵容保存成功")
	end
end

function FreeScuffleFormationFmtMo:getFormationExtendViewName()
	return ViewName.FreeScuffleSkillFormationExtView
end

function FreeScuffleFormationFmtMo:isClickCanCloseInFomation()
	if self:getCurFormation():isEmpty() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return false
	end

	return true
end

function FreeScuffleFormationFmtMo:getCurFormation()
	if self.forMationMap[self.curTabIndex] == nil then
		self.forMationMap[self.curTabIndex] = FreeScuffleFormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	self.formationMo = self.forMationMap[self.curTabIndex]

	return self.forMationMap[self.curTabIndex]
end

function FreeScuffleFormationFmtMo:getHeroSkills()
	return self:_getHeroSkillListOnFmt()
end

function FreeScuffleFormationFmtMo:_getHeroSkillDicOnFmt()
	local formation = self:getCurFormation()
	local positions = formation:GetPositions()
	local skillDic = {}
	local teams = {}

	for i, v in ipairs(positions) do
		if v > 0 then
			local pet = formation:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	for _, petId in pairs(positions) do
		local id = self._subMo:getSkillIdInPets(self._fmtType, petId, FreeScuffleEnum.SkillTypes_Hero)
		local heroSkillId = 0
		local data = FreeScuffleConfig.instance:getSkillData(self._activityId, id)

		heroSkillId = data and data.battleSkillId or FreeScuffleController.instance:getCreepsSkillId(self._activityId, petId, FreeScuffleEnum.SkillTypes_Hero)

		if heroSkillId > 0 then
			local isValid = FightingPowerFormula.instance:_isHeroSkillsValid(heroSkillId, teams, formation:getCurElementRelationMap(), formation:GetSummonMasterPetId(), formation:GetSummonPetId())

			if isValid then
				skillDic[petId] = heroSkillId
			end
		end
	end

	return skillDic
end

function FreeScuffleFormationFmtMo:_getHeroSkillListOnFmt()
	local skillDic = self:_getHeroSkillDicOnFmt()
	local skillList = {}

	for petId, skillId in pairs(skillDic) do
		table.insert(skillList, skillId)
	end

	return skillList
end

function FreeScuffleFormationFmtMo:_OnHeroSkillChanged(id, exParmams)
	self._curHeroPetId = checknumber(exParmams)
end

function FreeScuffleFormationFmtMo:openCustomFmtFeatureView(skills, curHeroSkillId, curBonds, petMoMap, formation)
	local infoList = {}
	local skillDic = self:_getHeroSkillDicOnFmt()

	for petId, skillId in pairs(skillDic) do
		local info = {}

		info.skillId = skillId
		info.petId = petId

		table.insert(infoList, info)
	end

	ViewMgr.instance:open(ViewName.FreeScuffleFmtFeatureView, infoList, self._curHeroPetId, curBonds, petMoMap, formation)
end

function FreeScuffleFormationFmtMo:onClickShowPetTips(petMo)
	local curIdx = 0
	local petMoList = {}
	local positions = self:getCurFormation():GetPositions()

	for idx, creepsId in ipairs(positions) do
		if creepsId > 0 then
			local pet = self:getPetMoById(creepsId)

			if pet:getPetId() == petMo:getPetId() then
				curIdx = idx
			end

			table.insert(petMoList, petMo)
		end
	end

	if #petMoList > 0 then
		UIStateManager.instance:push(ViewName.FreeScuffleSkillBagView, self._activityId, FreeScuffleEnum.FmtType_Defense, petMoList, curIdx)

		return true
	else
		return false
	end
end

return FreeScuffleFormationFmtMo
