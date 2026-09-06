-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/model/ElementSparkFmtMo.lua

module("logic.extensions.elementspark.model.ElementSparkFmtMo", package.seeall)

local ElementSparkFmtMo = class("ElementSparkFmtMo", ICustomFmtMo)

function ElementSparkFmtMo:onReset()
	ElementSparkFmtMo.super.onReset(self)
end

function ElementSparkFmtMo:initParams(activityId, teamId, isSetTeam, chunkId, challengeType)
	self._activityId = activityId
	self._chunkId = chunkId
	self._challengeType = challengeType
	self._isSetTeam = isSetTeam
	self.isShowTab = isSetTeam
	self.curTabIndex = teamId
	self._teamId = teamId
	self.isShowBtnSave = self._isSetTeam

	local forms = ElementSparkModel.instance:getForm()

	for i = 1, self.maxTabCount do
		self.formationMoList[i]:SetData(forms[i])
	end

	if self._isSetTeam then
		self._teamId = self.curTabIndex > 2 and 101 or self.curTabIndex
		self.formationTips = "队伍1&2用于攻击，队伍3用于布置守军"
	else
		self.formationTips = ""
	end

	self:clearAllPetList()
end

function ElementSparkFmtMo:getChallengeParams()
	return self._teamId, self._chunkId, self._challengeType
end

function ElementSparkFmtMo:initFormationMo()
	self.formationMoList = {}

	for i = 1, 3 do
		self.formationMoList[i] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end
end

function ElementSparkFmtMo:getCurFormation()
	return self.formationMoList[self.curTabIndex]
end

function ElementSparkFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local fmoList = self.formationMoList
	local totalUsePetCount = 0
	local totalNeedCount = 0
	local totalPos = MissionModel.instance:getMaxPetNum()
	local emptyMap = {}
	local notEnougthMap = {}

	for i, formationMo in ipairs(fmoList) do
		local numPos = FormationFacade.instance:curFormationPetNum(formationMo)

		totalUsePetCount = totalUsePetCount + numPos
		totalNeedCount = totalNeedCount + totalPos

		if numPos < totalPos then
			notEnougthMap[i] = true
		end

		if numPos == 0 then
			emptyMap[i] = true
		end
	end

	local petsNum = BagModel.instance:diffRacePetCount()
	local isLimit = false
	local minNeedCount = math.min(petsNum, totalNeedCount)

	if totalUsePetCount == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	elseif totalUsePetCount > 0 and totalUsePetCount < minNeedCount then
		isLimit = true

		local tipTab = ""
		local firstIdx = -1

		for i, v in pairs(notEnougthMap) do
			local str = i .. "号阵型"

			tipTab = string.nilorempty(tipTab) and tipTab .. str or tipTab .. "、" .. str

			if firstIdx < 0 then
				firstIdx = i
			end
		end

		local text = langPara("当前<color=#d56d08>%s</color>未上满%s只精灵，是否进入战斗？", tipTab, totalPos)

		TipsFacade.instance:openPopupWindowWithX(lang("tip"), text, function()
			self:sendFightMsg()
		end, function()
			self:jumpToTabIndex(firstIdx)
		end, lang("进入战斗"), lang("去布阵"))
	end

	return isLimit
end

function ElementSparkFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local petShopItems = ElementSparkModel.instance:getPetShopItems()

	if #petShopItems > 0 then
		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkId = ElementSparkModel.instance:getPetShopChunkId()
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)
		local shopId = chunkCfg.petShopId

		for _, shopItemId in ipairs(petShopItems) do
			local supportPetId = ElementSparkConfig.instance:getPetShopCfgById(shopId, shopItemId).supportPetId
			local supportPetCfg = ElementSparkConfig.instance:getSupportPetCfg(supportPetId)
			local fMo = FightingPowerPetMo.New()

			fMo:fromChallengeCreepCo(supportPetCfg)

			local petMo = fMo:toBaseBagPetMo()

			petMo.petId = supportPetId
			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function ElementSparkFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function ElementSparkFmtMo:checkPetIsForbit(checkPetMo)
	for i = 1, 3 do
		if i ~= self.curTabIndex then
			local otherFormationMo = self.formationMoList[i]
			local pet_poisition = otherFormationMo:GetPositions() or {}

			for idx, v in ipairs(pet_poisition) do
				if v ~= 0 then
					local petmo = self:getPetMoById(v)

					if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
						return true, i
					end
				end
			end
		end
	end

	return false
end

function ElementSparkFmtMo:getCurFormationList()
	return self.formationMoList or {}
end

function ElementSparkFmtMo:showForbitPetAlert(petMo)
	local boo, tabIdx = self:checkPetIsForbit(petMo)

	if boo then
		FloatWordMgr.instance:show(langPara("【%s】阵型中已使用该精灵", tabIdx))
	end
end

function ElementSparkFmtMo:getMonsterConfigList()
	local planId = ElementSparkController.instance:getMapPlanId()
	local creepsMasterId = ElementSparkConfig.instance:getMapChunkCfgs(planId)

	return ElementSparkConfig.instance:getCreepsCfg(creepsMasterId)
end

function ElementSparkFmtMo:getFmtInfoConfig()
	local planId = ElementSparkController.instance:getMapPlanId()
	local creepsMasterId = ElementSparkConfig.instance:getMapChunkCfgs(planId)

	return ElementSparkConfig.instance:getMasterCfg(creepsMasterId)
end

function ElementSparkFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function ElementSparkFmtMo:fmtVerifyReq(fromBtnSave)
	if not fromBtnSave then
		return
	end

	local list = {}

	for i, v in ipairs(self.formationMoList) do
		if self._isSetTeam or self.curTabIndex == i then
			self:_insertFormDataToSaveList(i, list)
		end
	end

	if #list > 0 then
		ElementSparkController.instance:sendPM_EleSparkSetMyFormsReq(self._activityId, list)
	else
		FloatWordMgr.instance:show("阵容无变化")
	end
end

function ElementSparkFmtMo:getFormationExtendViewName()
	if self._isSetTeam then
		return ""
	end

	return ViewName.ElementSparkFormationView
end

function ElementSparkFmtMo:_insertFormDataToSaveList(tabIdx, list)
	if tabIdx >= 3 then
		local chunkId2TeamId = ElementSparkModel.instance:getDefenseChunkId2TeamId()
		local defenseTeamIsWork = table.nums(chunkId2TeamId) > 0

		if defenseTeamIsWork then
			FloatWordMgr.instance:show("守军处于派遣状态，无法保存其阵型")

			return
		end
	end

	local formMo = self.formationMoList[tabIdx]
	local data = {
		teamId = tabIdx,
		form = formMo:createFormPb()
	}

	if tabIdx >= 3 then
		data.teamId = 100 + tabIdx - 2
	end

	table.insert(list, data)
end

return ElementSparkFmtMo
