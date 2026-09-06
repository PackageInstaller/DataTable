-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/model/HolyStripeCopySoloFmtMo.lua

module("logic.extensions.holystripecopy.model.HolyStripeCopySoloFmtMo", package.seeall)

local HolyStripeCopySoloFmtMo = class("HolyStripeCopySoloFmtMo", ICustomFmtMo)

function HolyStripeCopySoloFmtMo:initParams(tabId, stageId)
	self.isShowTab = true
	self._curTabId = tabId
	self._curStageId = stageId
	self._tabCfg = HolyStripeCopyConfig.instance:getTabCfgByTabId(self._curTabId)
	self._stateCfg = HolyStripeCopyConfig.instance:getStageCfg(self._curTabId, self._curStageId)

	if self._tabCfg and self._stateCfg then
		self._creepsCfgs = HolyStripeCopyConfig.instance:getCreepCfgsByPlanId(self._stateCfg.teamPlanId)
		self._masterList = {}

		for i = 1, 3 do
			local masterList = HolyStripeCopyConfig.instance:getCreepMonsterCfgs(self._creepsCfgs[i].creepsMasterId)

			table.insert(self._masterList, masterList)
		end
	else
		printError("传参或配置错误")
	end

	self.topTitleStr = self._creepsCfgs[self.curTabIndex].name
	self.ruleDescStr = self._creepsCfgs[self.curTabIndex].WinDesc or lang("击败敌阵所有精灵即可过关")

	local infoList = HolyStripeCopyModel.instance:getSoloFormationInfoList()

	for i = 1, 3 do
		self.formationMoList[i]:SetData(infoList[i])
	end

	self:initPetList()
end

function HolyStripeCopySoloFmtMo:initFormationMo()
	self.formationMoList = {}

	for i = 1, 3 do
		self.formationMoList[i] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end
end

function HolyStripeCopySoloFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
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

function HolyStripeCopySoloFmtMo:checkStartSoloFight()
	if not GameUtil.checkTimeStr(self._tabCfg.openTime) then
		FloatWordMgr.instance:show(lang("当前副本未开放"))

		return false
	end

	local curMaxLevel = HolyStripeCopyModel.instance:getMaxLevel(self._curTabId)

	if curMaxLevel < self._curStageId - 1 then
		FloatWordMgr.instance:show(lang("请先通关上一层"))

		return false
	end

	local timeChallenge = HolyStripeCopyModel.instance:getLeftSoloTime()

	if timeChallenge <= 0 then
		FloatWordMgr.instance:show(lang("今日挑战次数已耗尽"))

		return false
	end

	local costStengthNum = MaterialModel.instance:getMaterialsNumber(MatType.Strength, 1)

	if costStengthNum < self._stateCfg.strengthCost then
		FloatWordMgr.instance:show(lang("当前体力不满足本次挑战消耗"))

		return false
	end

	return true
end

function HolyStripeCopySoloFmtMo:initFightHandler()
	local function handler()
		if self:checkStartSoloFight() then
			UIJumper.instance:pushOneStack(ViewName.HolyStripeCopyChallengeView, true, self._curTabId)
			HolyStripeCopyController.instance:startFight(self._curTabId, self._curStageId)
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
		end
	end

	self.setFightHandler(self, handler, self)
end

function HolyStripeCopySoloFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	pets = PetHireModel.instance:appendListByHirePets(pets)

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function HolyStripeCopySoloFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function HolyStripeCopySoloFmtMo:jumpToTabIndex(idx)
	self.topTitleStr = self._creepsCfgs[idx].name
	self.ruleDescStr = self._creepsCfgs[idx].WinDesc or lang("击败敌阵所有精灵即可过关")

	HolyStripeCopySoloFmtMo.super.jumpToTabIndex(self, idx)
end

function HolyStripeCopySoloFmtMo:getMonsterConfigList()
	return self._masterList[self.curTabIndex]
end

function HolyStripeCopySoloFmtMo:getFmtInfoConfig()
	return self._creepsCfgs[self.curTabIndex]
end

function HolyStripeCopySoloFmtMo:getCurFormation()
	return self.formationMoList[self.curTabIndex]
end

function HolyStripeCopySoloFmtMo:autoExitFormation()
	HolyStripeCopySoloFmtMo.super.autoExitFormation(self)
	HolyStripeCopyController.instance:saveForm(false)
end

function HolyStripeCopySoloFmtMo:checkPetIsForbit(checkPetMo)
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

function HolyStripeCopySoloFmtMo:getCurFormationList()
	return self.formationMoList or {}
end

function HolyStripeCopySoloFmtMo:showForbitPetAlert(petMo)
	local boo, tabIdx = self:checkPetIsForbit(petMo)

	if boo then
		FloatWordMgr.instance:show(langPara("【%s】阵型中已使用该精灵", tabIdx))
	end
end

return HolyStripeCopySoloFmtMo
