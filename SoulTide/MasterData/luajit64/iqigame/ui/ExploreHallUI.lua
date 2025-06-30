-- chunkname: @IQIGame\\UI\\ExploreHallUI.lua

local ExploreHallUI = {
	CurrencyControllers = {},
	Controllers = {},
	ToggleGOs = {}
}

ExploreHallUI = Base:Extend("ExploreHallUI", "IQIGame.Onigao.UI.ExploreHallUI", ExploreHallUI)

local ExploreHallUIModule = require("IQIGame.UI.ExploreHall.ExploreHallUIModule")
local MazePanelController = require("IQIGame.UI.ExploreHall.MazePanelController")
local ChallengePanelController = require("IQIGame.UI.ExploreHall.ChallengePanelController")

function ExploreHallUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateBtnGuide()
		self.OnBtnGuide()
	end

	function self.DelegateOnUpdateTask(cid)
		self:OnUpdateTask(cid)
	end

	function self.delegateUpdateWoldBossRedPoint()
		self:OnUpdateWoldBossRedPoint()
	end

	function self.DelegateOnClickTestMazeBtn()
		self:OnClickTestMazeBtn()
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom)

	self:AddCurrencyCell(Constant.ItemID.TREASURE)
	self:InitSubPanels()
	UGUIUtil.SetText(self.TitleText, ExploreHallUIApi:GetString("TitleText"))
end

function ExploreHallUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function ExploreHallUI:GetOpenPreloadAssetPaths(userData)
	local pathList = {}
	local cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid = PlayerModule.GetNormalMazeExploreProgressData()

	table.insert(pathList, UIGlobalApi.GetImagePath(cfgChapterData.Bg))

	local activityAssets = ExploreHallUIModule.GetDailyDupViewAssets()

	table.addAll(pathList, activityAssets)

	return pathList
end

function ExploreHallUI:IsManualShowOnOpen(userData)
	return false
end

function ExploreHallUI:GetBGM(userData)
	return 7
end

function ExploreHallUI:OnOpen(userData)
	self:InitSubPanels(true)
	self:AddDynamicListeners()

	local tabIndex, childTabIndex

	if userData ~= nil then
		tabIndex = userData.tabIndex
		childTabIndex = userData.childTabIndex
	end

	if tabIndex ~= nil and childTabIndex ~= nil then
		local controller = self.Controllers[tabIndex]

		if controller ~= nil and controller.JumpPanel ~= nil then
			controller:JumpPanel(childTabIndex)
		end
	end

	self:UpdateView(tabIndex)
end

function ExploreHallUI:OnClose(userData)
	self:RemoveDynamicListeners()

	for i, controller in pairs(self.Controllers) do
		if controller.IsShow then
			controller:Hide()
		end
	end

	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseExploreHallUI")
end

function ExploreHallUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuide)
	self.TestMazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTestMazeBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.AddEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
end

function ExploreHallUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuide)
	self.TestMazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTestMazeBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.RemoveEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
end

function ExploreHallUI:AddDynamicListeners()
	for i, toggle in pairs(self.ToggleGOs) do
		toggle:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnToggleValueChanged" .. i])
	end
end

function ExploreHallUI:RemoveDynamicListeners()
	for i, toggle in pairs(self.ToggleGOs) do
		toggle:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnToggleValueChanged" .. i])
	end
end

function ExploreHallUI:OnPause()
	return
end

function ExploreHallUI:OnResume()
	return
end

function ExploreHallUI:OnCover()
	return
end

function ExploreHallUI:OnReveal()
	for i, v in pairs(self.Controllers) do
		if v.OnReveal then
			v:OnReveal()
		end
	end
end

function ExploreHallUI:OnRefocus(userData)
	return
end

function ExploreHallUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.Controllers) do
		if v.OnUpdate and v.IsShow then
			v:OnUpdate(elapseSeconds, realElapseSeconds)
		end
	end
end

function ExploreHallUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ExploreHallUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ExploreHallUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ExploreHallUI:OnDestroy()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	for i, controller in pairs(self.Controllers) do
		if controller.IsShow then
			controller:Hide()
		end

		controller:Dispose()
	end

	for i, v in pairs(self.ToggleGOs) do
		self.ToggleGOs[i] = nil
	end
end

function ExploreHallUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function ExploreHallUI:InitSubPanels(isOnOpen)
	if not isOnOpen then
		self:AddSubPanel(1, MazePanelController, self.MazeView)
		self:AddSubPanel(2, ChallengePanelController, self.ChallengeView)
	else
		local indexes = {}

		for index, module in pairs(ExploreHallUIModule.ExploreHallViewController) do
			table.insert(indexes, index)
		end

		table.sort(indexes)

		for i = 1, #indexes do
			local index = indexes[i]

			self:AddSubPanel(index, ExploreHallUIModule.ExploreHallViewController[index], nil)
		end
	end
end

function ExploreHallUI:UpdateRedPoint()
	self.ToggleGOs[1].transform:Find("RedPoint").gameObject:SetActive(PlayerModule.HasMazeChapterCanClaimExploreReward())
	self.ToggleGOs[2].transform:Find("RedPoint").gameObject:SetActive(ChallengeWorldBossModule.CheckRedPoint())

	if self.ToggleGOs[12] then
		self.ToggleGOs[12].transform:Find("RedPoint").gameObject:SetActive(PlaceGameModule:PlaceGameIsGerReward())
	end
end

function ExploreHallUI:AddSubPanel(toggleIndex, panelClass, panelView)
	if self.Controllers[toggleIndex] ~= nil then
		return
	end

	if toggleIndex > 2 and panelView == nil then
		local path = ExploreHallUIModule.GetDailyDupViewAsset(toggleIndex)

		if path == nil then
			return
		end

		local panelViewPrefab = self.UIController:GetPreloadedAsset(path)

		if panelViewPrefab == nil then
			return
		end

		panelView = UnityEngine.Object.Instantiate(panelViewPrefab)

		panelView.transform:SetParent(self.ActivityNode.transform, false)
		UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), panelView)
	end

	panelView:SetActive(false)

	self.Controllers[toggleIndex] = panelClass.New(panelView, self)

	local toggle = UnityEngine.Object.Instantiate(self.ToggleBtnPrefab)

	toggle.name = "Toggle_" .. toggleIndex

	toggle.transform:SetParent(self.TabGrid.transform, false)

	self.ToggleGOs[toggleIndex] = toggle
	self["DelegateOnToggleValueChanged" .. toggleIndex] = function(isOn)
		self:OnToggleValueChanged(toggleIndex, isOn)
	end

	local toggleText

	if toggleIndex <= 2 then
		toggleText = ExploreHallUIApi:GetString("ToggleBtnText", toggleIndex)
	else
		toggleText = self:GetDailyDupChapterName(ExploreHallUIApi:GetString("DailyDupCidToggleIndex", toggleIndex))
	end

	if toggleText == nil or toggleText == "" then
		logError("ExploreHallUIApi.ToggleBtnText()根据序号 " .. toggleIndex .. " 获取不到Toggle文本")

		toggleText = ""
	end

	UGUIUtil.SetTextInChildren(toggle, toggleText)
end

function ExploreHallUI:GetDailyDupChapterName(dailyDupCid)
	local cfgDailyDupData = CfgDailyDupTable[dailyDupCid]
	local dailyDupPOD = DailyDupModule.GetDailyDupPOD(dailyDupCid)
	local openCount = 1

	if dailyDupPOD then
		openCount = dailyDupPOD.common.openCount
	end

	local chapterNameLength = #cfgDailyDupData.ChapterName

	if chapterNameLength < openCount then
		logError(string.format("[id:%s]DailyDup.ChapterName的长度[%s]小于活动期数[%s]，已用最后一个名称[%s]替代。", dailyDupCid, chapterNameLength, openCount, cfgDailyDupData.ChapterName[chapterNameLength]))

		openCount = chapterNameLength
	end

	if openCount == 0 then
		openCount = 1
	end

	return cfgDailyDupData.ChapterName[openCount]
end

function ExploreHallUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function ExploreHallUI:OnToggleValueChanged(index, isOn)
	if isOn then
		for i, controller in pairs(self.Controllers) do
			controller:Hide()
		end

		for i, controller in pairs(self.Controllers) do
			if i == index then
				controller:Show()

				if index > 2 then
					EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUI_Toggle_" .. index)
				end

				break
			end
		end
	end
end

function ExploreHallUI:UpdateView(tabIndex)
	local defaultTabIndex = 1

	if tabIndex ~= nil then
		defaultTabIndex = tabIndex
	end

	self.ToggleGOs[defaultTabIndex]:GetComponent("Toggle").isOn = false
	self.ToggleGOs[defaultTabIndex]:GetComponent("Toggle").isOn = true

	self.ToggleGOs[2]:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.CHALLENGE))
	self:UpdateRedPoint()

	local testMazeBtnText, mazeCid, chapterType = self:GetTestMazeInfo()

	self.TestMazeBtn:SetActive(testMazeBtnText ~= nil and testMazeBtnText ~= "")

	if testMazeBtnText ~= nil then
		UGUIUtil.SetTextInChildren(self.TestMazeBtn, testMazeBtnText)
	end
end

function ExploreHallUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 5000)
end

function ExploreHallUI:OnUpdateTask(cid)
	self:UpdateRedPoint()
end

function ExploreHallUI:OnUpdateWoldBossRedPoint()
	self:UpdateRedPoint()
end

function ExploreHallUI:OnClickTestMazeBtn()
	local mazeName, mazeCid, chapterType = self:GetTestMazeInfo()

	if mazeCid ~= nil then
		local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(chapterType)

		if unfinishedMazeCid ~= nil then
			MazeModule.SendRestore(unfinishedMazeCid)
		else
			local formationPOD = FormationModule.GetFormationByIndex(1)

			MazeModule.SendEnterTestMaze(mazeCid, formationPOD.id)
		end
	end
end

function ExploreHallUI:GetTestMazeInfo()
	if SDKLoginModule.IsSDKMode() then
		return
	end

	if tostring(UnityEngine.Application.platform) ~= "WindowsEditor" then
		return
	end

	return self:GetTestMazeBaseInfo()
end

function ExploreHallUI:GetTestMazeBaseInfo()
	return
end

return ExploreHallUI
