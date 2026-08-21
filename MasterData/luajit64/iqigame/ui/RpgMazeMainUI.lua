-- chunkname: @IQIGame\\UI\\RpgMazeMainUI.lua

local RpgMazeMainUI = {}

RpgMazeMainUI = Base:Extend("RpgMazeMainUI", "IQIGame.Onigao.UI.RpgMazeMainUI", RpgMazeMainUI)

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local MazeTaskPanel = require("IQIGame.UI.Maze.MazeTaskPanel")

function RpgMazeMainUI:OnInit()
	function self.DelegateOnUpdateExploreScore(addValue)
		self:OnUpdateExploreScore(addValue)
	end

	self.CommonModule = MazeMainUICommonModuleController.New(self.CommonModule, self.UIController, self.Top, self.BtnGroup, self.Bottom, function()
		return self:GetCustomData()
	end)

	self.CommonModule:OnInit()
	self.CommonModule:SetCustomClickSoulHeadHandler(function(dollId)
		self:OnClickDollHead(dollId)
	end)

	self.TaskPanelController = MazeTaskPanel.New(self.TaskPanel)

	UGUIUtil.SetTextInChildren(self.BagBtn, RpgMazeMainUIApi:GetString("BagBtnText"))
	UGUIUtil.SetText(self.ExploreLabel, RpgMazeMainUIApi:GetString("ExploreLabel"))
end

function RpgMazeMainUI:GetPreloadAssetPaths()
	local paths = {}
	local commonModulePaths = MazeMainUICommonModuleController.GetPreloadAssetPaths()

	if commonModulePaths ~= nil then
		for i = 1, #commonModulePaths do
			table.insert(paths, commonModulePaths[i])
		end
	end

	return paths
end

function RpgMazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function RpgMazeMainUI:OnOpen(userData)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function RpgMazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
end

function RpgMazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()
	self.TaskPanelController:OnAddListeners()
	self.BagBtn:GetComponent("Button").onClick:AddListener(self.OnClickBagBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function RpgMazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()
	self.TaskPanelController:OnRemoveListeners()
	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.OnClickBagBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function RpgMazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function RpgMazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function RpgMazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function RpgMazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function RpgMazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function RpgMazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
end

function RpgMazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function RpgMazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function RpgMazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function RpgMazeMainUI:OnDestroy()
	self.CommonModule:OnDestroy()
	self.TaskPanelController:Dispose()
end

function RpgMazeMainUI:UpdateView()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	self.MazeNameText:GetComponent("Text").text = RpgMazeMainUIApi:GetString("MazeNameText", cfgChapterData.Order, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name)

	self:UpdateExploreProgress()
	self.TaskPanelController:Refresh()
end

function RpgMazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = RpgMazeMainUIApi:GetString("StartTitleText"),
		startTip = RpgMazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function RpgMazeMainUI:UpdateExploreProgress(addValue)
	UGUIUtil.SetText(self.ExploreProgressText, RpgMazeMainUIApi:GetString("ExploreProgressText", MazeDataModule.PlayerInfo.ExploreScore))
	self.MaxExploreProgressImage:SetActive(MazeDataModule.PlayerInfo.ExploreScore >= 100)

	if addValue ~= nil then
		self.AddExploreValueNotice:SetActive(true)
		UGUIUtil.SetTextInChildren(self.AddExploreValueNotice, RpgMazeMainUIApi:GetString("AddExploreValueNotice", addValue))

		local timer = Timer.New(function()
			self.AddExploreValueNotice:SetActive(false)
		end, 1.5)

		timer:Start()
	end
end

function RpgMazeMainUI:OnUpdateExploreScore(addValue)
	self:UpdateExploreProgress(addValue)
end

function RpgMazeMainUI.OnClickBagBtn()
	UIModule.Open(Constant.UIControllerName.MazeBagUI, Constant.UILayer.UI)
end

function RpgMazeMainUI:OnClickDollHead(dollId)
	if MazeModule.MazeScene == nil or MazeModule.MazeScene.Hero == nil or MazeModule.MazeScene.Hero:IsMoving() then
		return
	end

	UIModule.Open(Constant.UIControllerName.RpgMazeTeamUI, Constant.UILayer.UI, {
		dollId = dollId
	})
end

return RpgMazeMainUI
