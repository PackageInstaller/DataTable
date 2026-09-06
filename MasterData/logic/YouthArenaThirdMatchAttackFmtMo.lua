-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/model/YouthArenaThirdMatchAttackFmtMo.lua

module("logic.extensions.youtharenathird.model.YouthArenaThirdMatchAttackFmtMo", package.seeall)

local YouthArenaThirdMatchAttackFmtMo = class("YouthArenaThirdMatchAttackFmtMo", BaseCustomFmtMo)

function YouthArenaThirdMatchAttackFmtMo:initParams(activityId, stepId, mode)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)
	mode = checknumber(mode)

	if self._activityId ~= activityId or self._stepId ~= stepId then
		self._formationMapByMode = {}
	end

	self._activityId = activityId
	self._stepId = stepId
	self._mode = mode
	self._actCfg = YouthArenaThirdConfig.instance:getActivityData(self._activityId)
	self._matchCfg = YouthArenaThirdConfig.instance:getMatchData(self._activityId, self._stepId)
	self._subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	self._opponent = self._subMo and self._subMo:getOpponent(self._stepId, self._mode)

	if self._matchCfg then
		self.topTitleStr = self._matchCfg.stepName or "少年竞技大赛"
	end

	self.ruleDescStr = self._mode == YouthArenaThirdEnum.BattleMode.Three and "预设3支队伍，挑战时按顺序依次出战" or "布置攻阵后发起挑战"
	self.isShowTab = self._mode == YouthArenaThirdEnum.BattleMode.Three
	self.maxTabCount = self.isShowTab and 3 or 1
	self.curTabIndex = 1

	self:_initModeFormationMap()
	self:clearAllPetList()
end

function YouthArenaThirdMatchAttackFmtMo:getBuffPlanId()
	return checknumber(self._matchCfg and self._matchCfg.buffPlanId)
end

function YouthArenaThirdMatchAttackFmtMo:getExtendViewName()
	if self:getBuffPlanId() <= 0 then
		return ""
	end

	return ViewName.YouthArenaThirdPetBuffFormationExView
end

function YouthArenaThirdMatchAttackFmtMo:_initModeFormationMap()
	self._formationMapByMode = self._formationMapByMode or {}
	self._formationMapByMode[self._mode] = self._formationMapByMode[self._mode] or {}
	self.forMationMap = self._formationMapByMode[self._mode]

	for i = 1, self.maxTabCount do
		self.forMationMap[i] = self.forMationMap[i] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	self.formationMo = self.forMationMap[self.curTabIndex]
end

function YouthArenaThirdMatchAttackFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList or {}) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self._stepId ~= YouthArenaThirdEnum.MatchStepId.Qualifier and self._stepId ~= YouthArenaThirdEnum.MatchStepId.Fun then
		return
	end

	local supportPetDatas = YouthArenaThirdConfig.instance:getSupportPetDatas(self._activityId)

	for _, data in pairs(supportPetDatas or {}) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(data)

		local petMo = fMo:toBaseBagPetMo()

		if petMo then
			petMo.isSupportedPet = true

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function YouthArenaThirdMatchAttackFmtMo:refreshPetList(changePetMoMap)
	for _, petMo in pairs(changePetMoMap or {}) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YouthArenaThirdMatchAttackFmtMo:_changePetMo(petMo)
	if YouthArenaThirdController.instance:getUseSystemProperty(self._activityId, self._stepId) then
		return self:_changeSystemPropertyPetMo(petMo)
	end

	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YouthArenaThirdMatchAttackFmtMo:_changeSystemPropertyPetMo(petMo)
	if not petMo then
		return
	end

	if petMo.isSupportedPet then
		return petMo:GetClone()
	end

	local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)
	local sysZdlRate = checknumber((self._actCfg or nil) and self._actCfg.sysZdlWanPercent) / 10000

	for _, attrModelType in pairs(GameEnum.AttrModelType) do
		maxPetMo.attrMo.extModelBaseAttrRate[attrModelType] = sysZdlRate
	end

	maxPetMo.isMyPackPet = false

	maxPetMo:calcAllAttr()

	maxPetMo.isMyPackPet = petMo.isMyPackPet

	return maxPetMo
end

function YouthArenaThirdMatchAttackFmtMo:checkPetIsForbit(petMo, baseCheck)
	if baseCheck then
		return true
	end

	if petMo == nil or self._mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return false
	end

	return self:checkPetIsInOtherTab(petMo, true)
end

function YouthArenaThirdMatchAttackFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) then
		FloatWordMgr.instance:show("其他队伍中已使用该精灵")
	end
end

function YouthArenaThirdMatchAttackFmtMo:initFightHandler()
	self:setFightHandler(function()
		if not YouthArenaThirdController.instance:checkMatchChallengeAvailable(self._activityId, self._stepId, self._mode, true) then
			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierFightReq(self._activityId, self._stepId, self._mode, self:_getFormList(), YouthArenaThirdController.instance:getUseSystemProperty(self._activityId, self._stepId))
	end, nil)
end

function YouthArenaThirdMatchAttackFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	self._opponent = self._subMo and self._subMo:getOpponent(self._stepId, self._mode)

	if not self._opponent then
		FloatWordMgr.instance:show("请先匹配对手")

		return true
	end

	if self._mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return YouthArenaThirdMatchAttackFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end

	for i = 1, self.maxTabCount do
		if self.forMationMap then
			if self.forMationMap == nil or self.forMationMap:isEmpty() then
				TipsFacade.instance:openTipWindowNoX("提示", langPara("%d号阵型为空阵", i), function()
					self:jumpToTabIndex(i)
				end)

				return true
			end
		end
	end

	local hasRepeat, repeatTab, firstTab = self:_checkRaceIdRepeatInMode()

	if hasRepeat then
		TipsFacade.instance:openTipWindowNoX("提示", langPara("%d号阵型与%d号阵型存在相同精灵", repeatTab, firstTab), function()
			self:jumpToTabIndex(repeatTab)
		end)

		return true
	end

	for i = 1, self.maxTabCount do
		if self.forMationMap then
			local formationMo = self.forMationMap[i]
			local isLimit = FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, formationMo)

			if isLimit then
				self:jumpToTabIndex(i)

				return true
			end
		end
	end

	return false
end

function YouthArenaThirdMatchAttackFmtMo:_checkRaceIdRepeatInMode()
	if self.maxTabCount <= 1 then
		return false
	end

	local raceTabMap = {}

	for i = 1, self.maxTabCount do
		if self.forMationMap then
			local positions = self.forMationMap and self.forMationMap:GetPositions() or {}

			for _, petId in ipairs(positions) do
				petId = checknumber(petId)

				if petId > 0 then
					local petMo = self:getPetMoById(petId)
					local raceId = checknumber(petMo and petMo:getDefineId())

					if raceId > 0 then
						local firstTab = raceTabMap[raceId]

						if firstTab and firstTab ~= i then
							return true, i, firstTab
						end

						raceTabMap[raceId] = i
					end
				end
			end
		end
	end

	return false
end

function YouthArenaThirdMatchAttackFmtMo:_getFormList()
	local formList = {}

	for i = 1, self.maxTabCount do
		table.insert(formList, CustomFmtController.instance:createFormPb(self.forMationMap[i]))
	end

	return formList
end

function YouthArenaThirdMatchAttackFmtMo:getMonsterConfigList()
	return {}
end

function YouthArenaThirdMatchAttackFmtMo:getFmtInfoConfig()
	local opForm = self:_getCurOpponentForm()

	return (opForm and opForm.view and opForm.view.curForm or nil) and (opForm.view.curForm.extParams or {})
end

function YouthArenaThirdMatchAttackFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function YouthArenaThirdMatchAttackFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}
	local opForm = self:_getCurOpponentForm()
	local view = opForm and opForm.view
	local curForm = view and view.curForm

	if view and curForm then
		for _, basePetView in ipairs(view.petSimpleView or {}) do
			local posId

			for i = 1, 9 do
				if basePetView.petId == curForm.pos[i] then
					posId = i

					break
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

function YouthArenaThirdMatchAttackFmtMo:_getCurOpponentForm()
	if self._opponent then
		if not self._opponent.forms then
			local forms = {}

			for _, form in ipairs(forms) do
				if checknumber(form.formId) == self.curTabIndex then
					return form
				end
			end

			return forms[self.curTabIndex] or forms[1]
		end
	end
end

return YouthArenaThirdMatchAttackFmtMo
