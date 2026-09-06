-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/model/FreeScuffleFmtMo.lua

module("logic.extensions.freescuffle.model.FreeScuffleFmtMo", package.seeall)

local FreeScuffleFmtMo = class("FreeScuffleFmtMo", BaseCustomFmtMo)

function FreeScuffleFmtMo:updateCfg(activityId, opponent)
	self._activityId = activityId
	self._opponent = opponent
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._fmtType = FreeScuffleEnum.FmtType_Pk
	self._fMo = self._fMo or FightingPowerPetMo.New()
	self.isShowBtnFormationUse = false
	self.isShowBtnCutePet = false
	self.isOnlyUpdateExistPet = true
	self.isNeedOpenCustomFmtFeatureView = true
	self._curHeroPetId = checknumber(self._curHeroPetId)

	self:initPetList()
	self:updateHerorSkill()
	self:_updateEnemyFmt()
end

function FreeScuffleFmtMo:getActivityId()
	return self._activityId
end

function FreeScuffleFmtMo:updateHerorSkill()
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

function FreeScuffleFmtMo:updateData()
	FreeScuffleFmtMo.super.updateData(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)
end

function FreeScuffleFmtMo:onExitView()
	FreeScuffleFmtMo.super.onExitView(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
end

function FreeScuffleFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local heroSkill = self:getCurFormation():GetHeroSkillId()

		if not self._curHeroPetId then
			if heroSkill > 0 and self._curHeroPetId <= 0 then
				printError("缺失选择英雄技的精灵( heroSkillId:%s )", heroSkill)
			end

			FreeScuffleController.instance:sendPM_FreeScuffleBattleReq(self._activityId, simpleForm, heroSkill, self._curHeroPetId)
		end
	end, nil)
end

function FreeScuffleFmtMo:initPetList()
	self:clearAllPetList()

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

function FreeScuffleFmtMo:getExtendViewName()
	return ViewName.FreeScuffleSkillPkFmtExtView
end

function FreeScuffleFmtMo:onFmoSetDown()
	self:updateHerorSkill()
end

function FreeScuffleFmtMo:onDispatchFormationChanged()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function FreeScuffleFmtMo:getCurFormation()
	if self.forMationMap[self.curTabIndex] == nil then
		self.forMationMap[self.curTabIndex] = FreeScuffleFormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	self.formationMo = self.forMationMap[self.curTabIndex]

	return self.forMationMap[self.curTabIndex]
end

function FreeScuffleFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("您正在进行战斗，不可退出")

	return false
end

function FreeScuffleFmtMo:_updateEnemyFmt()
	local headInfo = self._opponent.headInfo
	local userId = checknumber(headInfo.userId)

	self._isSystemEnemy = userId <= 0

	if self._isSystemEnemy then
		local creepsMasterId = Mathf.Abs(userId)

		self._masterData = FreeScuffleConfig.instance:getMasterData(creepsMasterId)
		self._creepsCfg = FreeScuffleConfig.instance:getCreepsCfg(creepsMasterId)
	else
		self._creepsCfg = {}

		local simpleForm = self._opponent.form.form

		self._masterData = simpleForm.extParams

		for _, creepsId in ipairs(simpleForm.pos) do
			local data = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, creepsId)

			if data then
				self._fMo:fromChallengeCreepCo(data)

				local petMo = self._fMo:toBaseBagPetMo()

				petMo.isMyPackPet = false
				self._petMapAsRight[creepsId] = petMo
			elseif creepsId > 0 then
				printError(string.format("存在未配置的精灵:%s", creepsId))
			end
		end

		self._formationMoOfEnemy:SetData(simpleForm)

		local enemyHeroSkill = self._opponent.form.heroSkill

		if enemyHeroSkill > 0 then
			self._formationMoOfEnemy:SetExHeroSkills({
				enemyHeroSkill
			})
			self._formationMoOfEnemy:SetHeroSkillId(enemyHeroSkill)
			self._formationMoOfEnemy:fixAndUpdateHeroSkill()
		end
	end
end

function FreeScuffleFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function FreeScuffleFmtMo:getFmtInfoConfig()
	return self._masterData
end

function FreeScuffleFmtMo:initFormationMo()
	FreeScuffleFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._formationMoOfEnemy = FreeScuffleFormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
end

function FreeScuffleFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function FreeScuffleFmtMo:getTeamAndFormation(creepCfg)
	if self._isSystemEnemy then
		return FreeScuffleFmtMo.super.getTeamAndFormation(self, creepCfg)
	else
		return self:_getTeamAndFormationOfPlayer(creepCfg)
	end
end

function FreeScuffleFmtMo:_getTeamAndFormationOfPlayer(creepCfg)
	local fmtMo = self._formationMoOfEnemy
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		local fightingPowerMo = bagPetMo:toFightingPowerPetMo()

		fightingPowerMo.petId = bagPetMo:getPetId()
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

function FreeScuffleFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function FreeScuffleFmtMo:getHeroSkills()
	return self:_getHeroSkillListOnFmt()
end

function FreeScuffleFmtMo:_getHeroSkillDicOnFmt()
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

function FreeScuffleFmtMo:_getHeroSkillListOnFmt()
	local skillDic = self:_getHeroSkillDicOnFmt()
	local skillList = {}

	for petId, skillId in pairs(skillDic) do
		table.insert(skillList, skillId)
	end

	return skillList
end

function FreeScuffleFmtMo:_OnHeroSkillChanged(id, exParmams)
	self._curHeroPetId = checknumber(exParmams)
end

function FreeScuffleFmtMo:openCustomFmtFeatureView(skills, curHeroSkillId, curBonds, petMoMap, formation)
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

function FreeScuffleFmtMo:updateCellTop(cell, petMo)
	local luaCls = FreeScuffleSwitchSkillTag
	local url = FreeScuffleSwitchSkillTag.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local creepsId = petMo:getPetId()
		local isUseOrgin = true

		for _, skillType in pairs(FreeScuffleEnum.SkillTypes) do
			local skillId = self._subMo:getSkillIdInPets(self._fmtType, creepsId, skillType)

			if skillId > 0 then
				isUseOrgin = false

				break
			end
		end

		GameUtil.setUIGroupIdx(self._tagSwitch, isUseOrgin and 0 or 1)

		local groupIdx = isUseOrgin and 1 or 0

		proxy.binder:setTagSwitchUI(groupIdx)
		proxy.binder:addClickHandler(function()
			UIStateManager.instance:push(ViewName.FreeScuffleSkillBagView, self._activityId, self._fmtType, self._rightPetList, creepsId)
		end)
	end
end

return FreeScuffleFmtMo
