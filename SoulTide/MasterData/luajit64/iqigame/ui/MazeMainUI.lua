-- chunkname: @IQIGame\\UI\\MazeMainUI.lua

local MazeMainUI = {}

MazeMainUI = Base:Extend("MazeMainUI", "IQIGame.Onigao.UI.MazeMainUI", MazeMainUI)

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local MazeTaskPanel = require("IQIGame.UI.Maze.MazeTaskPanel")

function MazeMainUI:OnInit()
	function self.DelegateOnUpdateExploreScore(addValue)
		self:OnUpdateExploreScore(addValue)
	end

	self.CommonModule = MazeMainUICommonModuleController.New(self.CommonModule, self.UIController, self.Top, self.BtnGroup, self.Bottom, function()
		return self:GetCustomData()
	end)

	self.CommonModule:OnInit()

	self.TaskPanelController = MazeTaskPanel.New(self.TaskPanel)

	UGUIUtil.SetTextInChildren(self.BagBtn, MazeMainUIApi:GetString("BagBtnText"))
	UGUIUtil.SetText(self.ExploreLabel, MazeMainUIApi:GetString("ExploreLabel"))
end

function MazeMainUI:GetPreloadAssetPaths()
	local paths = {}
	local commonModulePaths = MazeMainUICommonModuleController.GetPreloadAssetPaths()

	if commonModulePaths ~= nil then
		for i = 1, #commonModulePaths do
			table.insert(paths, commonModulePaths[i])
		end
	end

	return paths
end

function MazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function MazeMainUI:OnOpen(userData)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function MazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
end

function MazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()
	self.TaskPanelController:OnAddListeners()
	self.BagBtn:GetComponent("Button").onClick:AddListener(self.OnClickBagBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function MazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()
	self.TaskPanelController:OnRemoveListeners()
	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.OnClickBagBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function MazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function MazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function MazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function MazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function MazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function MazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
end

function MazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function MazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function MazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function MazeMainUI:OnDestroy()
	self.CommonModule:OnDestroy()
	self.TaskPanelController:Dispose()
end

function MazeMainUI:UpdateView()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	self.MazeNameText:GetComponent("Text").text = MazeMainUIApi:GetString("MazeNameText", cfgChapterData.Order, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name)

	self:UpdateExploreProgress()
	self.TaskPanelController:Refresh()
end

function MazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = MazeMainUIApi:GetString("StartTitleText"),
		startTip = MazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function MazeMainUI:UpdateExploreProgress(addValue)
	UGUIUtil.SetText(self.ExploreProgressText, MazeMainUIApi:GetString("ExploreProgressText", MazeDataModule.PlayerInfo.ExploreScore))
	self.MaxExploreProgressImage:SetActive(MazeDataModule.PlayerInfo.ExploreScore >= 100)

	if addValue ~= nil then
		self.AddExploreValueNotice:SetActive(true)
		UGUIUtil.SetTextInChildren(self.AddExploreValueNotice, MazeMainUIApi:GetString("AddExploreValueNotice", addValue))

		local timer = Timer.New(function()
			self.AddExploreValueNotice:SetActive(false)
		end, 1.5)

		timer:Start()
	end
end

function MazeMainUI:OnUpdateExploreScore(addValue)
	self:UpdateExploreProgress(addValue)
end

function MazeMainUI.OnClickBagBtn()
	UIModule.Open(Constant.UIControllerName.MazeBagUI, Constant.UILayer.UI)
end

return MazeMainUI
