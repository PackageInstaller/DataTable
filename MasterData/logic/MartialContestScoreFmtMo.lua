-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestScoreFmtMo.lua

module("logic.extensions.youngchampionking.model.MartialContestScoreFmtMo", package.seeall)

local MartialContestScoreFmtMo = class("MartialContestScoreFmtMo", BaseCustomFmtMo)

function MartialContestScoreFmtMo:initParams(activityId, stepId)
	self.activityId = activityId
	self.curStepId = stepId

	local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)
	local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, stepCfg.roundId)

	self.topTitleStr = roundCfg.roundName

	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self.activityId, self.curStepId)

	self.curOpponent = qualifyInfo and qualifyInfo.opponent
	self._equipToPetInfo = {}
	self._petToEquipInfo = {}
	self.isShowTab = true
	self.curTabIndex = 1
	self.maxTabCount = 3

	for i = 1, self.maxTabCount do
		local form = self.forMationMap[i]

		if not form then
			form = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
			self.forMationMap[i] = form
		end
	end

	self:clearAllPetList()
end

function MartialContestScoreFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function MartialContestScoreFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function MartialContestScoreFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function MartialContestScoreFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self:checkCanFight() then
			if self:isAllEquip() == true then
				self:_sendFightReq()
			else
				TipsFacade.instance:openPopupWindow(lang("提示"), lang("仍有精灵未装备功法，是否进入战斗"), function()
					self:_sendFightReq()
				end, function()
					GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
				end)
			end
		end
	end, nil)
end

function MartialContestScoreFmtMo:_sendFightReq()
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local formNos = {}

	for formId, fmtMo in pairs(self.forMationMap) do
		local simpleForm = {}

		simpleForm.simpleForm = CustomFmtController.instance:createFormPb(fmtMo)
		simpleForm.formId = formId
		simpleForm.equipList = {}

		if self._equipToPetInfo then
			for equipId, petId in pairs(self._equipToPetInfo) do
				if fmtMo:GetPetPosition(petId) then
					table.insert(simpleForm.equipList, {
						equipId = equipId,
						petId = petId
					})
				end
			end
		end

		table.insert(formNos, simpleForm)
	end

	MartialContestController.instance:sendPM_MCQualifierFightReq(self.activityId, self.curStepId, formNos)
end

function MartialContestScoreFmtMo:isAllEquip()
	local equipCfgs = MartialContestConfig.instance:getEquipTypeCfgs(self.activityId)
	local hasEquipNotBeEquip = false

	for i, v in ipairs(equipCfgs) do
		if MartialContestModel.instance:getEquipLevel(self.activityId, v.equipId) > 0 and checknumber(self._equipToPetInfo[v.equipId]) == 0 then
			hasNotEquip = true

			break
		end
	end

	local hasPetNotBeEquip = false

	for i = 1, self.maxTabCount do
		local formation = self.forMationMap[i]

		for j, v in ipairs(formation:GetPositions()) do
			if v ~= 0 and checknumber(self._petToEquipInfo[v]) == 0 then
				hasPetNotBeEquip = true
			end
		end
	end

	return not hasEquipNotBeEquip or not hasPetNotBeEquip
end

function MartialContestScoreFmtMo:getMonsterConfigList()
	return {}
end

function MartialContestScoreFmtMo:getFmtInfoConfig()
	for i, v in ipairs(self.curOpponent.forms) do
		if v.formId == self.curTabIndex then
			return v.view.curForm.extParams
		end
	end
end

function MartialContestScoreFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if self.curOpponent then
		local opForm = self.curOpponent.forms

		for i, v in ipairs(opForm) do
			if v.formId == self.curTabIndex then
				for _, basePetView in ipairs(v.view.petSimpleView or {}) do
					local posId

					for i = 1, 9 do
						if basePetView.petId == v.view.curForm.pos[i] then
							posId = i
						end
					end

					if posId then
						local petMo = FightingPowerPetMo.fromBasePetView(basePetView, nil, posId)

						table.insert(teams, petMo)

						formations[posId] = petMo
					end
				end
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function MartialContestScoreFmtMo:checkCanFight()
	local canFight, resultCode, tips = MartialContestController.instance:getIsAbleEnterQualifyFight(self.activityId, self.curStepId)

	if resultCode < 0 then
		TipsFacade.instance:openCommonTips(tips)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
	end

	return canFight
end

function MartialContestScoreFmtMo:getExtendViewName()
	return ViewName.MartialContestQualifierFmtView
end

function MartialContestScoreFmtMo:setEquipInfo(petId, equipId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldPetId = self._equipToPetInfo[equipId]
	local oldEquipId = self._petToEquipInfo[petId]

	if oldPetId and oldPetId > 0 then
		self._petToEquipInfo[oldPetId] = nil
	end

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = equipId
	self._equipToPetInfo[equipId] = petId
end

function MartialContestScoreFmtMo:resetEquipInfo(petId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldEquipId = self._petToEquipInfo[petId]

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = nil
end

function MartialContestScoreFmtMo:getCurEquipId(petId)
	if self._petToEquipInfo then
		return self._petToEquipInfo[petId]
	end
end

function MartialContestScoreFmtMo:getCurEquipPetId(equipId)
	if self._equipToPetInfo then
		return self._equipToPetInfo[equipId]
	end
end

function MartialContestScoreFmtMo:refreshCurEquipState()
	local resetList = {}

	if self._petToEquipInfo then
		for petId, equipId in pairs(self._petToEquipInfo) do
			if equipId and equipId > 0 then
				local isInFromation = false

				for i, form in pairs(self.forMationMap) do
					if form:GetPetPosition(petId) then
						isInFromation = true

						break
					end
				end

				if not isInFromation then
					table.insert(resetList, petId)
				end
			end
		end
	end

	for i, v in ipairs(resetList) do
		self:resetEquipInfo(v)
	end
end

function MartialContestScoreFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function MartialContestScoreFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false then
		for i, form in ipairs(self.forMationMap) do
			if i ~= self.curTabIndex then
				local pet_poisition = form:GetPositions() or {}

				for idx, v in ipairs(pet_poisition) do
					if v ~= 0 then
						local petmo = self:getPetMoById(v)

						if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
							isForbit = true
							tips = langPara("【%s】阵型中已使用该精灵", i)

							break
						end
					end
				end
			end
		end
	end

	return isForbit, tips
end

return MartialContestScoreFmtMo
