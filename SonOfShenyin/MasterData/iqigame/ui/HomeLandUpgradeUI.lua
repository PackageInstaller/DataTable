-- chunkname: @IQIGame\\UI\\HomeLandUpgradeUI.lua

local HomeLandUpgradeUI = {
	conditionViewTable = {},
	effectViewTable = {}
}

HomeLandUpgradeUI = Base:Extend("HomeLandUpgradeUI", "IQIGame.Onigao.UI.HomeLandUpgradeUI", HomeLandUpgradeUI)

function HomeLandUpgradeUI:OnInit()
	self:__OnInitEventDelegateFunc()

	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self:__InitConditionView()
	self:__InitEffectView()
end

function HomeLandUpgradeUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandUpgradeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandUpgradeUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandUpgradeUI:GetBGM(userData)
	return nil
end

function HomeLandUpgradeUI:OnOpen(userData)
	self:__RefreshShow()
end

function HomeLandUpgradeUI:OnClose(userData)
	return
end

function HomeLandUpgradeUI:__OnInitEventDelegateFunc()
	function self.__OnUpGradeBtnClickEventProxy()
		self:__OnUpGradeBtnClickEvent()
	end

	function self.__delegateOnHomeDataChange()
		self:__RefreshShow()
	end
end

function HomeLandUpgradeUI:OnAddListeners()
	self.upGradeBtn:GetComponent("Button").onClick:AddListener(self.__OnUpGradeBtnClickEventProxy)
	EventDispatcher.AddEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
end

function HomeLandUpgradeUI:OnRemoveListeners()
	self.upGradeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnUpGradeBtnClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
end

function HomeLandUpgradeUI:OnPause()
	return
end

function HomeLandUpgradeUI:OnResume()
	return
end

function HomeLandUpgradeUI:OnCover()
	return
end

function HomeLandUpgradeUI:OnReveal()
	return
end

function HomeLandUpgradeUI:OnRefocus(userData)
	return
end

function HomeLandUpgradeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandUpgradeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandUpgradeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandUpgradeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandUpgradeUI:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function HomeLandUpgradeUI:__RefreshShow()
	local level = HomeModule.GetHomeLevel()

	self.homeLevelText:GetComponent("Text").text = HomeLandApi:GetLevelText(level)

	local nextLevel = level + 1
	local lvConfig = HomeModule.GetHomeLevelConfig(nextLevel)

	if lvConfig == nil then
		self.maxLevelText:GetComponent("Text").text = HomeLandApi:GetLevelText(level)

		self:__ShowMaxLevel(true)

		return
	end

	self:__ShowMaxLevel(false)

	self.nextLevelText:GetComponent("Text").text = HomeLandApi:GetLevelText(nextLevel)

	local curLvConfig = HomeModule.GetHomeLevelConfig(level)

	self:__FillEffectData(curLvConfig, lvConfig)
	self:__FillConditionData(lvConfig)

	local moneyType = lvConfig.UpgradeNeedCost[1]
	local moneyNum = lvConfig.UpgradeNeedCost[2]

	self.costMoney:GetComponent("Text").text = tostring(moneyNum)

	local ownerMoney = WarehouseModule.GetItemNumByCfgID(moneyType)
	local path = CfgItemTable[moneyType].SmallIcon
	local iconImgCom = self.costMoneyImg:GetComponent("Image")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(path), iconImgCom, function()
		iconImgCom:SetNativeSize()
	end)

	local canUpGrade = moneyNum <= ownerMoney

	canUpGrade = canUpGrade and PlayerModule.GetLevel() >= lvConfig.Lv
	self.upGradeBtn:GetComponent("Button").interactable = canUpGrade
end

function HomeLandUpgradeUI:__ShowMaxLevel(isMax)
	self.normalLevelRoot.gameObject:SetActive(not isMax)
	self.maxLevelRoot.gameObject:SetActive(isMax)
	self.effectRoot.gameObject:SetActive(not isMax)
	self.effectMaxRoot.gameObject:SetActive(isMax)
	self.conditionRoot.gameObject:SetActive(not isMax)
	self.conditionMaxRoot.gameObject:SetActive(isMax)
	self.upGradeBtn.gameObject:SetActive(not isMax)
	self.costRoot.gameObject:SetActive(not isMax)
end

function HomeLandUpgradeUI:__OnUpGradeBtnClickEvent()
	HomeModule.UpgradeHome()
end

function HomeLandUpgradeUI:__InitEffectView()
	for i = 0, self.effectRoot.transform.childCount - 1 do
		local childTrans = self.effectRoot.transform:GetChild(i)

		childTrans.gameObject:SetActive(false)
		table.insert(self.effectViewTable, childTrans.gameObject)
	end
end

function HomeLandUpgradeUI:__FillEffectData(curLvCfg, lvCfg)
	local index = 1

	index = self:__SetText(self.effectViewTable, index, HomeLandApi:GetLvUpgradeOpenRoomText(lvCfg.UnlockRoom))

	if curLvCfg.UnlickTaskQuality ~= lvCfg.UnlickTaskQuality then
		index = self:__SetText(self.effectViewTable, index, HomeLandApi:GetLvUpgradeUnlockTaskQualityText(lvCfg.UnlickTaskQuality))
	end

	if curLvCfg.TaskCountLimt ~= lvCfg.TaskCountLimt then
		index = self:__SetText(self.effectViewTable, index, HomeLandApi:GetLvUpgradeTaskCountLimitText(lvCfg.TaskCountLimt))
	end

	for i = index, #self.effectViewTable do
		self.effectViewTable[i].gameObject:SetActive(false)
	end
end

function HomeLandUpgradeUI:__SetText(viewTable, index, text)
	if LuaUtility.StrIsNullOrEmpty(text) then
		return index
	end

	local itemGo = viewTable[index]

	if itemGo == nil then
		return
	end

	itemGo.gameObject:SetActive(true)

	itemGo:GetComponent("Text").text = text

	return index + 1
end

function HomeLandUpgradeUI:__InitConditionView()
	for i = 0, self.conditionRoot.transform.childCount - 1 do
		local childTrans = self.conditionRoot.transform:GetChild(i)

		childTrans.gameObject:SetActive(false)
		table.insert(self.conditionViewTable, childTrans.gameObject)
	end
end

function HomeLandUpgradeUI:__FillConditionData(lvCfg)
	local index = self:__SetText(self.conditionViewTable, 1, HomeLandApi:GetLvUpgradePlayerLevelLimitText(lvCfg.NeedPlayerLv))

	for i = index, #self.conditionViewTable do
		self.conditionViewTable[i].gameObject:SetActive(false)
	end
end

return HomeLandUpgradeUI
