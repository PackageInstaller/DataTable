-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/model/OriginJiuTabFmtMo.lua

module("logic.extensions.originjiu.model.OriginJiuTabFmtMo", package.seeall)

local OriginJiuTabFmtMo = class("OriginJiuTabFmtMo", BaseCustomFmtMo)

function OriginJiuTabFmtMo:onInit()
	OriginJiuTabFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
	self.isShowTab = false
	self.curTabIndex = 1
	self.maxTabCount = 2
end

function OriginJiuTabFmtMo:initParams(activityId, modelId, phaseId, stageId, stageRoad)
	self.activityId = activityId
	self.modelId = modelId
	self.phaseId = phaseId
	self.stageId = stageId
	self.stageRoad = stageRoad
	self._isTeamFirst = self.stageId == 1

	local phaseData = OriginJiuConfig.instance:getPhaseData(activityId, modelId, phaseId)

	self._clgType = phaseData.type
	self._openPetHp = OriginJiuModel.instance:isOpenPetHp(activityId, modelId)

	if self._clgType == OriginJiuModel.ClgType_Wheel then
		self._openPetHp = true
	end

	OriginJiuModel.instance:resetAllPetLockState(activityId, modelId)

	local stageCfg = OriginJiuConfig.instance:getStageData(activityId, modelId, phaseId, stageId) or {}

	self.creepsMasterId = stageRoad == 1 and stageCfg.creepsMasterIdA or stageCfg.creepsMasterIdB
	self.masterCfg = OriginJiuConfig.instance:getTeamData(self.creepsMasterId)
	self.creeps = OriginJiuConfig.instance:getCreepsDatas(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc or self.masterCfg.WinDesc
	self._changeTabIdx = true

	local curKey = string.format("%s_%s_%s_%s_%s", self.activityId, self.modelId, self.phaseId, self.stageId, self.stageRoad)

	self._oldKey = self._oldKey or ""

	if self._oldKey ~= curKey then
		self:initPetList()

		self._oldKey = curKey
	end

	for idx = 1, self.maxTabCount do
		local formationMo = self:getFormationMoByTabIndex(idx)
		local positions = formationMo:GetPositions()

		for posId, petId in pairs(positions) do
			if petId ~= 0 then
				local petMo = BagPetsController.instance:getPet(petId)

				if petMo == nil or not petMo:isExist() or OriginJiuModel.instance:checkLockPet(petMo) then
					positions[posId] = 0
				end
			end
		end
	end
end

function OriginJiuTabFmtMo:initPetList()
	self:clearAllPetList()

	self._teamPetsMap = {}
	self._petsHp = {}
	self._lockedRaceMap = {}
	self._teamIdSortList = OriginJiuModel.instance:getSortList(self.activityId)

	local modelInfo = OriginJiuModel.instance:getInfoByModelId(self.activityId, self.modelId) or {}

	for i, phase in ipairs((not modelInfo.phases or nil) and {}) do
		if phase.phaseId == self.phaseId then
			if not phase.wheelInfo then
				local wheelInfo = {}

				for j, wheelTeam in ipairs((not wheelInfo.wheelTeam or nil) and {}) do
					self._teamPetsMap[wheelTeam.teamId] = {}

					for k, petInfo in ipairs(wheelTeam.pets or {}) do
						self._petsHp[petInfo.petId] = petInfo.leftHp

						table.insert(self._teamPetsMap[wheelTeam.teamId], petInfo.petId)
					end
				end

				break
			end
		end
	end

	if self._isTeamFirst then
		local pets = self:getFightBagPet()

		for i, petMo in ipairs(pets) do
			self:addPetToList(self:_changePetMo(petMo))
		end
	elseif not self._teamPetsMap[self.curTabIndex] then
		local pets = {}

		for i, petId in ipairs(pets) do
			local petMo = BagPetsController.instance:getPet(petId)

			if petMo then
				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function OriginJiuTabFmtMo:getCurFormation()
	self.formationMo = self:getFormationMoByTabIndex(self.curTabIndex)

	return self.formationMo
end

function OriginJiuTabFmtMo:getFormationMoByTabIndex(tabIndex)
	if self.forMationMap[tabIndex] == nil then
		self.forMationMap[tabIndex] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	return self.forMationMap[tabIndex]
end

function OriginJiuTabFmtMo:getMonsterConfigList()
	return self.creeps
end

function OriginJiuTabFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function OriginJiuTabFmtMo:initFightHandler()
	self:setFightHandler(function()
		local function okFunc()
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

			local list = {}

			for i = 1, self.maxTabCount do
				local idx = self._teamIdSortList[i]

				self.forMationMap[idx] = self.forMationMap[idx] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))

				local curFmtMo = self.forMationMap[idx]
				local req = OriginJiuClgExtension_pb.OriginJiuClgSetFormation()

				req.teamId = idx

				FormationFacade.createFormPb(req.simpleForm, curFmtMo)
				table.insert(list, req)
			end

			OriginJiuController.instance:sendPM_OriginJiuClgChallengeReq(self.activityId, self.modelId, self.phaseId, self.stageId, self.stageRoad, list)
		end

		if self._isTeamFirst then
			local tipsContent = "是否确认挑战该关卡？挑战后其他关卡将在本层通关后才可进行挑战？"

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		else
			okFunc()
		end
	end, nil)
end

function OriginJiuTabFmtMo:getExtendViewName()
	return ViewName.OriginjiufmttabextView
end

function OriginJiuTabFmtMo:jumpToTabIndex(idx)
	if idx ~= checknumber(self.curTabIndex) and not self._isTeamFirst then
		self:clearAllPetList()
	end

	self.curTabIndex = idx

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function OriginJiuTabFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵不能上阵")
end

function OriginJiuTabFmtMo:updateCellTop(cell, petMo)
	if not self._openPetHp then
		return
	end

	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local right = self._petsHp[petMo.petId]

		proxy.binder:onUpdateHp((right and right >= 0 or nil) and right / petMo._maxHp)
	end
end

function OriginJiuTabFmtMo:getTeamSortList()
	return self._teamIdSortList
end

function OriginJiuTabFmtMo:setTeamSortList(list)
	self._teamIdSortList = list

	OriginJiuModel.instance:setSortList(self.activityId, list)
end

function OriginJiuTabFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self:checkPetIsInOtherTab(petMo, true) then
		return true
	end

	return OriginJiuModel.instance:checkLockPet(petMo)
end

function OriginJiuTabFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	for i = 1, self.maxTabCount do
		self.forMationMap[i] = self.forMationMap[i] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))

		local curFmtMo = self.forMationMap[i]
		local petCount = 0
		local check = false

		if self._isTeamFirst then
			check = true

			if not self._rightPetList then
				local petlist = {}

				petCount = #petlist
			end
		else
			local list = self._teamPetsMap[i]

			petCount = list and #list or 0
		end

		if curFmtMo:isEmpty() and check then
			TipsFacade.instance:openTipWindow("提示", langPara("[%s]阵是空阵不能进行挑战，请返回布阵", i), function()
				self:jumpToTabIndex(i)
			end, "去布阵")

			return true
		end

		local isLimit = FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, curFmtMo, petCount)

		if isLimit then
			self:jumpToTabIndex(i)

			return isLimit
		end
	end

	return false
end

return OriginJiuTabFmtMo
