-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/model/HolyStripeCopyTeamFmtMo.lua

module("logic.extensions.holystripecopy.model.HolyStripeCopyTeamFmtMo", package.seeall)

local HolyStripeCopyTeamFmtMo = class("HolyStripeCopyTeamFmtMo", ICustomFmtMo)

function HolyStripeCopyTeamFmtMo:initSaveHandler()
	self.setSaveHandler(self, function()
		HolyStripeCopyController.instance:saveForm(true)
	end, self)
end

function HolyStripeCopyTeamFmtMo:initParams(isShowTab, isCanBack)
	self.isShowTab = isShowTab
	self._isCanBack = isCanBack

	self:getCurFormation():SetData(HolyStripeCopyModel.instance:getTeamFormationInfo())

	self._curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	if self._curTeamInfo then
		self._stateCfg = HolyStripeCopyConfig.instance:getStageCfgByGroupId(self._curTeamInfo.groupId)
		self._tabCfg = HolyStripeCopyConfig.instance:getTabCfgByTabId(self._stateCfg.tabId)

		if self._tabCfg and self._stateCfg then
			self._creepsCfgs = HolyStripeCopyConfig.instance:getCreepCfgsByPlanId(self._stateCfg.teamPlanId)
			self._masterList = {}

			for i = 1, 3 do
				local masterList = HolyStripeCopyConfig.instance:getCreepMonsterCfgs(self._creepsCfgs[i].creepsMasterId)

				table.insert(self._masterList, masterList)
			end

			self.topTitleStr = self._creepsCfgs[self.curTabIndex].name
			self.ruleDescStr = self._creepsCfgs[self.curTabIndex].WinDesc
		else
			printError("传参或配置错误")
		end
	end
end

function HolyStripeCopyTeamFmtMo:getExtendViewName()
	return ViewName.HolyStripeCopeAddTipView
end

function HolyStripeCopyTeamFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function HolyStripeCopyTeamFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function HolyStripeCopyTeamFmtMo:onClickCloseBtn(handler)
	if self._isCanBack then
		GameUtil.callBack(handler)
	else
		FloatWordMgr.instance:show("组队模式已进入布阵后无法返回。")
	end
end

function HolyStripeCopyTeamFmtMo:initFightHandler()
	self:setFightHandler(function()
		HolyStripeCopyController.instance:sendReadyTeamFight(self:getCurFormation())
	end)
end

function HolyStripeCopyTeamFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local totalPos = MissionModel.instance:getMaxPetNum()
	local numPos = FormationFacade.instance:curFormationPetNum(self:getCurFormation())
	local petsNum = BagModel.instance:diffRacePetCount()
	local minNeedCount = math.min(petsNum, totalPos)
	local isLimit = false

	if numPos == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	elseif numPos > 0 and numPos < minNeedCount then
		isLimit = true

		local text = langPara("当前未上满%s只精灵，是否进入战斗？", minNeedCount)

		TipsFacade.instance:openPopupWindowWithX(lang("tip"), text, function()
			self:sendFightMsg()
		end, nil, lang("进入战斗"), lang("去布阵"))
	end

	return isLimit
end

function HolyStripeCopyTeamFmtMo:jumpToTabIndex(idx)
	self.topTitleStr = self._creepsCfgs[idx].name
	self.ruleDescStr = self._creepsCfgs[idx].WinDesc

	HolyStripeCopyTeamFmtMo.super.jumpToTabIndex(self, idx)
end

function HolyStripeCopyTeamFmtMo:getMonsterConfigList()
	return self._masterList[self.curTabIndex]
end

function HolyStripeCopyTeamFmtMo:getFmtInfoConfig()
	return self._creepsCfgs[self.curTabIndex]
end

function HolyStripeCopyTeamFmtMo:autoExitFormation()
	HolyStripeCopyTeamFmtMo.super.autoExitFormation(self)
	HolyStripeCopyController.instance:saveForm(true)
end

function HolyStripeCopyTeamFmtMo:checkLimitAutoTeamReady()
	local isLimit = false
	local numPos = FormationFacade.instance:curFormationPetNum(self:getCurFormation())

	if numPos == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	end

	return isLimit
end

return HolyStripeCopyTeamFmtMo
