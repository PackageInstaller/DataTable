-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/model/YouthArenaThirdDefenseFmtMo.lua

module("logic.extensions.youtharenathird.model.YouthArenaThirdDefenseFmtMo", package.seeall)

local YouthArenaThirdDefenseFmtMo = class("YouthArenaThirdDefenseFmtMo", BaseCustomFmtMo)

local function _copyBuffMap(source, maxTabCount)
	local result = {}

	for i = 1, maxTabCount do
		result[i] = checknumber(source and source[i])
	end

	return result
end

function YouthArenaThirdDefenseFmtMo:initParams(activityId, isFun, mode, stepId, formList)
	self._activityId = checknumber(activityId)
	self._isFun = checkbool(isFun)
	self._stepId = checknumber(stepId)

	self:clearAllPetList()

	self._modeFormationMap = {}
	self._modeOriginMap = {}
	self._modeBuffMap = {}
	self._modeBuffOriginMap = {}
	self._modeLoadedMap = {}
	self.topTitleStr = "防守布阵"
	self.isShowBtnSave = true

	self:applyModeData(mode, formList)
	self:switchMode(mode, false)
end

function YouthArenaThirdDefenseFmtMo:getActivityId()
	return self._activityId
end

function YouthArenaThirdDefenseFmtMo:getIsFun()
	return self._isFun
end

function YouthArenaThirdDefenseFmtMo:getMode()
	return self._mode
end

function YouthArenaThirdDefenseFmtMo:getStepId()
	return self._stepId
end

function YouthArenaThirdDefenseFmtMo:getFormationExtendViewName()
	return ViewName.YouthArenaThirdFormationExView
end

function YouthArenaThirdDefenseFmtMo:getBuffPlanId()
	if self._isFun then
		return 0
	end

	local stepData = YouthArenaThirdConfig.instance:getDefenseBuffStepData(self._activityId, self._stepId)
	local buffPlanId = checknumber(stepData and stepData.buffPlanId)
	local buffDatas = YouthArenaThirdConfig.instance:getKnockoutBuffPlanDatas(buffPlanId)

	return buffPlanId > 0 and buffDatas and #buffDatas > 0 and buffPlanId or 0
end

function YouthArenaThirdDefenseFmtMo:getBuffId(mode, tabIndex)
	mode = self:_normalizeMode(mode)
	tabIndex = checknumber(tabIndex)

	return checknumber(self._modeBuffMap and self._modeBuffMap[mode] and self._modeBuffMap[mode][tabIndex])
end

function YouthArenaThirdDefenseFmtMo:getCurBuffId()
	return self:getBuffId(self._mode, self.curTabIndex)
end

function YouthArenaThirdDefenseFmtMo:copyModeBuffMap(mode)
	mode = self:_normalizeMode(mode)

	return _copyBuffMap(self._modeBuffMap and self._modeBuffMap[mode], self:_getModeMaxTabCount(mode))
end

function YouthArenaThirdDefenseFmtMo:findBuffOwner(mode, buffId, buffMap)
	mode = self:_normalizeMode(mode)
	buffId = checknumber(buffId)

	if buffId <= 0 then
		return 0
	end

	buffMap = buffMap or self._modeBuffMap and self._modeBuffMap[mode]

	for i = 1, self:_getModeMaxTabCount(mode) do
		if checknumber(buffMap and buffMap[i]) == buffId then
			return i
		end
	end

	return 0
end

function YouthArenaThirdDefenseFmtMo:applyModeBuffMap(mode, buffMap)
	mode = self:_normalizeMode(mode)
	self._modeBuffMap[mode] = _copyBuffMap(buffMap, self:_getModeMaxTabCount(mode))

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function YouthArenaThirdDefenseFmtMo:clearBuffId(mode, tabIndex)
	mode = self:_normalizeMode(mode)
	tabIndex = checknumber(tabIndex)

	if tabIndex <= 0 or tabIndex > self:_getModeMaxTabCount(mode) then
		return
	end

	self._modeBuffMap[mode] = self._modeBuffMap[mode] or {}
	self._modeBuffMap[mode][tabIndex] = 0

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function YouthArenaThirdDefenseFmtMo:hasModeData(mode)
	return checkbool(self._modeLoadedMap and self._modeLoadedMap[checknumber(mode)])
end

function YouthArenaThirdDefenseFmtMo:applyModeData(mode, formList)
	mode = self:_normalizeMode(mode)

	local maxTabCount = self:_getModeMaxTabCount(mode)
	local formationMap = {}
	local originMap = {}
	local buffMap = {}

	for i = 1, maxTabCount do
		local formationMo = self:_createFormationMo()
		local formInfo = formList and formList[i]

		if formInfo and formInfo.form then
			formationMo:SetData(formInfo.form)
		end

		formationMap[i] = formationMo
		originMap[i] = formationMo:trySaveMySelf()
		buffMap[i] = checknumber(formInfo and formInfo.buffId)
	end

	self._modeFormationMap[mode] = formationMap
	self._modeOriginMap[mode] = originMap
	self._modeBuffMap[mode] = buffMap
	self._modeBuffOriginMap[mode] = _copyBuffMap(buffMap, maxTabCount)
	self._modeLoadedMap[mode] = true
end

function YouthArenaThirdDefenseFmtMo:switchMode(mode, isDispatch)
	mode = self:_normalizeMode(mode)
	self._mode = mode
	self.ruleDescStr = mode == YouthArenaThirdEnum.BattleMode.Three and "预设3支队伍，被挑战时按顺序依次出战" or "设置被挑战时使用的防守阵容"
	self.isShowTab = mode == YouthArenaThirdEnum.BattleMode.Three
	self.maxTabCount = self:_getModeMaxTabCount(mode)
	self.curTabIndex = 1

	if self._modeFormationMap then
		self.forMationMap = self._modeFormationMap[mode] or {}
	end

	self.formationMo = self.forMationMap[self.curTabIndex]

	if isDispatch ~= false then
		GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
	end
end

function YouthArenaThirdDefenseFmtMo:restoreCurMode()
	local mode = self:_normalizeMode(self._mode)

	self:_restoreMode(mode)
	self:switchMode(mode)
end

function YouthArenaThirdDefenseFmtMo:markModeSaved(mode)
	mode = self:_normalizeMode(mode)

	if self._modeFormationMap then
		if self._modeFormationMap == nil then
			return
		end

		local originMap = {}

		for i = 1, self:_getModeMaxTabCount(mode) do
			if self._modeFormationMap[i] then
				originMap[i] = self._modeFormationMap[i]:trySaveMySelf()
			end
		end

		self._modeOriginMap[mode] = originMap
		self._modeBuffOriginMap[mode] = _copyBuffMap(self._modeBuffMap and self._modeBuffMap[mode], self:_getModeMaxTabCount(mode))
		self._modeLoadedMap[mode] = true
	end
end

function YouthArenaThirdDefenseFmtMo:isCurModeDirty()
	local mode = self:_normalizeMode(self._mode)

	if self._modeFormationMap then
		if self._modeOriginMap then
			local originMap = self._modeOriginMap[mode]

			if self._modeFormationMap == nil or originMap == nil then
				return false
			end

			for i = 1, self:_getModeMaxTabCount(mode) do
				if self:_getFormationSnapshot(self._modeFormationMap[i]) ~= self:_getFormationSnapshot(originMap[i]) then
					return true
				end

				if self:getBuffId(mode, i) ~= checknumber(self._modeBuffOriginMap and self._modeBuffOriginMap[mode] and self._modeBuffOriginMap[mode][i]) then
					return true
				end
			end

			return false
		end
	end
end

function YouthArenaThirdDefenseFmtMo:_restoreMode(mode)
	if self._modeFormationMap then
		if self._modeOriginMap then
			local originMap = self._modeOriginMap[mode]

			if self._modeFormationMap == nil or originMap == nil then
				return
			end

			for i = 1, self:_getModeMaxTabCount(mode) do
				if self._modeFormationMap[i] and originMap[i] then
					self._modeFormationMap[i]:Clone(originMap[i], originMap[i].summonedPetId)
				end
			end

			self._modeBuffMap[mode] = _copyBuffMap(self._modeBuffOriginMap and self._modeBuffOriginMap[mode], self:_getModeMaxTabCount(mode))
		end
	end
end

function YouthArenaThirdDefenseFmtMo:_createFormationMo()
	return FormationMO.New(GameUtil.handler(self.getPetMoById, self))
end

function YouthArenaThirdDefenseFmtMo:_normalizeMode(mode)
	mode = checknumber(mode)

	if mode ~= YouthArenaThirdEnum.BattleMode.Three then
		mode = YouthArenaThirdEnum.BattleMode.One
	end

	return mode
end

function YouthArenaThirdDefenseFmtMo:_getModeMaxTabCount(mode)
	return self:_normalizeMode(mode) == YouthArenaThirdEnum.BattleMode.Three and 3 or 1
end

function YouthArenaThirdDefenseFmtMo:_getFormationSnapshot(formationMo)
	if formationMo == nil then
		return ""
	end

	return CustomFmtController.instance:createFormPb(formationMo):SerializeToString()
end

function YouthArenaThirdDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList or {}) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if not self._isFun then
		local canUseSupportPet = self._stepId == YouthArenaThirdEnum.TimeStepId.QualifierStart

		if not canUseSupportPet then
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
end

function YouthArenaThirdDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YouthArenaThirdDefenseFmtMo:checkPetIsForbit(petMo, baseCheck)
	if baseCheck then
		return true
	end

	if petMo == nil or self._mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return false
	end

	return self:checkPetIsInOtherTab(petMo, true)
end

function YouthArenaThirdDefenseFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) then
		FloatWordMgr.instance:show("其他队伍中已使用该精灵")
	end
end

function YouthArenaThirdDefenseFmtMo:initSaveHandler()
	local function handler(_, fromBtnSave)
		if fromBtnSave ~= true then
			return
		end

		self:trySave()
	end

	self.setSaveHandler(self, handler, self)
end

function YouthArenaThirdDefenseFmtMo:trySave(onSaved)
	if not YouthArenaThirdController.instance:checkDefenseFormationSaveAvailable(self, true) then
		self:_dispatchMissionBattleResBack(-1)

		return false
	end

	local function doSave()
		YouthArenaThirdController.instance:saveDefenseFormation(self, onSaved)
	end

	if self:checkFormationEmptyAndPosNumLimit(doSave) then
		self:_dispatchMissionBattleResBack(-1)

		return false
	end

	return doSave()
end

function YouthArenaThirdDefenseFmtMo:_dispatchMissionBattleResBack(status)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function YouthArenaThirdDefenseFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	for i = 1, self.maxTabCount do
		if self.forMationMap then
			if self.forMationMap == nil or self.forMationMap:isEmpty() then
				TipsFacade.instance:openTipWindowNoX("提示", (self.maxTabCount > 1 or nil) and langPara("%d号阵型为空阵", i), function()
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

	if self:_checkBuffSelection() then
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

function YouthArenaThirdDefenseFmtMo:_checkBuffSelection()
	local mode = self:_normalizeMode(self._mode)
	local buffPlanId = self:getBuffPlanId()

	if buffPlanId <= 0 then
		return false
	end

	if self._modeBuffMap then
		if not self._modeBuffMap[mode] then
			local buffMap = {}
			local ownerMap = {}

			for i = 1, self:_getModeMaxTabCount(mode) do
				local buffId = checknumber(buffMap[i])

				if buffId <= 0 or YouthArenaThirdConfig.instance:getKnockoutBuffPlanData(buffPlanId, buffId) == nil then
					local tip = mode == YouthArenaThirdEnum.BattleMode.Three and langPara("3v3模式，阵型%d未选择buff", i) or "1v1模式未选择buff"

					self:jumpToTabIndex(i)
					TipsFacade.instance:openTipWindowNoX("提示", tip)

					return true
				end

				if ownerMap[buffId] then
					local firstTab = ownerMap[buffId]

					self:jumpToTabIndex(i)
					TipsFacade.instance:openTipWindowNoX("提示", langPara("3v3模式，阵型%d与阵型%d选择了相同buff", firstTab, i))

					return true
				end

				ownerMap[buffId] = i
			end

			return false
		end
	end
end

function YouthArenaThirdDefenseFmtMo:_checkRaceIdRepeatInMode()
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

function YouthArenaThirdDefenseFmtMo:_getFormList()
	local formList = {}

	for i = 1, self.maxTabCount do
		table.insert(formList, {
			form = CustomFmtController.instance:createFormPb(self.forMationMap[i]),
			buffId = self:getBuffId(self._mode, i)
		})
	end

	return formList
end

function YouthArenaThirdDefenseFmtMo:getCurModeFormList()
	return self:_getFormList()
end

return YouthArenaThirdDefenseFmtMo
