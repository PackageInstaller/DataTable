-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestQualifierFmtMo.lua

module("logic.extensions.youngchampionking.model.MartialContestQualifierFmtMo", package.seeall)

local MartialContestQualifierFmtMo = class("MartialContestQualifierFmtMo", BaseCustomFmtMo)

function MartialContestQualifierFmtMo:initParams(activityId, stepId)
	self.activityId = activityId
	self.curStepId = stepId

	local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

	if stepCfg then
		local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, stepCfg.roundId)

		self.topTitleStr = roundCfg.roundName
	else
		self.topTitleStr = lang("娱乐赛")
	end

	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self.activityId, self.curStepId)

	self.curOpponent = qualifyInfo and qualifyInfo.opponent
	self._equipToPetInfo = self._equipToPetInfo or {}
	self._petToEquipInfo = self._petToEquipInfo or {}
	self.curTabIndex = 1

	self:clearAllPetList()
end

function MartialContestQualifierFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self.curStepId == MartialContestEnum.Qualify_Step_Id then
		local supportPet = MartialContestConfig.instance:getSupportPetList()

		for i, v in ipairs(supportPet) do
			local fMo = FightingPowerPetMo.New()

			fMo:fromChallengeCreepCo(v)

			local petMo = fMo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function MartialContestQualifierFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function MartialContestQualifierFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function MartialContestQualifierFmtMo:initFightHandler()
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

function MartialContestQualifierFmtMo:_sendFightReq()
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local equipList = {}

	if self._equipToPetInfo then
		for equipId, petId in pairs(self._equipToPetInfo) do
			table.insert(equipList, {
				equipId = equipId,
				petId = petId
			})
		end
	end

	local formNos = {}
	local form = {}

	form.formId = 1
	form.simpleForm = self:getCurSimpleForm()
	form.equipList = equipList

	table.insert(formNos, form)
	MartialContestController.instance:sendPM_MCQualifierFightReq(self.activityId, self.curStepId, formNos)
end

function MartialContestQualifierFmtMo:isAllEquip()
	local equipCfgs = MartialContestConfig.instance:getEquipTypeCfgs(self.activityId)
	local hasEquipNotBeEquip = false

	for i, v in ipairs(equipCfgs) do
		if MartialContestModel.instance:getEquipLevel(self.activityId, v.equipId) > 0 and checknumber(self._equipToPetInfo[v.equipId]) == 0 then
			hasNotEquip = true

			break
		end
	end

	local hasPetNotBeEquip = false

	for i, v in ipairs(self.formationMo:GetPositions()) do
		if v ~= 0 and checknumber(self._petToEquipInfo[v]) == 0 then
			hasPetNotBeEquip = true
		end
	end

	return not hasEquipNotBeEquip or not hasPetNotBeEquip
end

function MartialContestQualifierFmtMo:getMonsterConfigList()
	return {}
end

function MartialContestQualifierFmtMo:getFmtInfoConfig()
	if self.curOpponent.forms and #self.curOpponent.forms > 1 then
		return self.curOpponent.forms[1].view.curForm.extParams
	else
		return {}
	end
end

function MartialContestQualifierFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if self.curOpponent then
		local opForm = self.curOpponent.forms[1]

		for _, basePetView in ipairs((opForm or nil) and (opForm.view.petSimpleView or {})) do
			local posId

			for i = 1, 9 do
				if basePetView.petId == opForm.view.curForm.pos[i] then
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

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function MartialContestQualifierFmtMo:checkCanFight()
	local canFight, resultCode, tips = MartialContestController.instance:getIsAbleEnterQualifyFight(self.activityId, self.curStepId)

	if resultCode < 0 then
		TipsFacade.instance:openCommonTips(tips)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
	end

	return canFight
end

function MartialContestQualifierFmtMo:getExtendViewName()
	return ViewName.MartialContestQualifierFmtView
end

function MartialContestQualifierFmtMo:setEquipInfo(petId, equipId)
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

function MartialContestQualifierFmtMo:resetEquipInfo(petId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldEquipId = self._petToEquipInfo[petId]

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = nil
end

function MartialContestQualifierFmtMo:getCurEquipId(petId)
	if self._petToEquipInfo then
		return self._petToEquipInfo[petId]
	end
end

function MartialContestQualifierFmtMo:getCurEquipPetId(equipId)
	if self._equipToPetInfo then
		return self._equipToPetInfo[equipId]
	end
end

function MartialContestQualifierFmtMo:refreshCurEquipState()
	local resetList = {}

	if self._petToEquipInfo then
		for petId, equipId in pairs(self._petToEquipInfo) do
			if equipId and equipId > 0 then
				if not self:getCurFormation():GetPetPosition(petId) then
					table.insert(resetList, petId)
				end
			end
		end
	end

	for i, v in ipairs(resetList) do
		self:resetEquipInfo(v)
	end
end

return MartialContestQualifierFmtMo
