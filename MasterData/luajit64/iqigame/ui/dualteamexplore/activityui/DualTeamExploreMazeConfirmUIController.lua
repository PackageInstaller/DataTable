-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreMazeConfirmUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreMazeConfirmUIApi")

local DualTeamExploreLevelTeamItem = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelTeamItem")
local DualTeamExploreMazeConfirmUIController = {
	TeamItems = {}
}

function DualTeamExploreMazeConfirmUIController.New(uiController)
	local obj = Clone(DualTeamExploreMazeConfirmUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreMazeConfirmUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreMazeConfirmUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreMazeConfirmUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	for i = 1, 2 do
		local item = DualTeamExploreLevelTeamItem.New(UnityEngine.Object.Instantiate(self.TeamTogglePrefab), i, self.SoulHeadPrefab)

		item.View.transform:SetParent(self.TeamGrid.transform, false)

		self.TeamItems[i] = item
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreMazeConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.SubTitleText, DualTeamExploreMazeConfirmUIApi:GetString("SubTitleText"))
	UGUIUtil.SetText(self.ExploreLabel, DualTeamExploreMazeConfirmUIApi:GetString("ExploreLabel"))
end

function DualTeamExploreMazeConfirmUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreMazeConfirmUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreMazeConfirmUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreMazeConfirmUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreMazeConfirmUIController:OnOpen(userData)
	self:UpdateView(userData.mazeInstanceCid)
end

function DualTeamExploreMazeConfirmUIController:OnClose(userData)
	return
end

function DualTeamExploreMazeConfirmUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreMazeConfirmUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreMazeConfirmUIController:OnPause()
	return
end

function DualTeamExploreMazeConfirmUIController:OnResume()
	return
end

function DualTeamExploreMazeConfirmUIController:OnCover()
	return
end

function DualTeamExploreMazeConfirmUIController:OnReveal()
	return
end

function DualTeamExploreMazeConfirmUIController:OnRefocus(userData)
	return
end

function DualTeamExploreMazeConfirmUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreMazeConfirmUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreMazeConfirmUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreMazeConfirmUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreMazeConfirmUIController:OnDestroy()
	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreMazeConfirmUIController:UpdateView(mazeInstanceCid)
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[mazeInstanceCid]
	local score = 0

	if mazeInfoPOD ~= nil then
		score = mazeInfoPOD.score
	end

	UGUIUtil.SetText(self.ExploreProgressText, DualTeamExploreMazeConfirmUIApi:GetString("ExploreProgressText", score))

	self.ExploreProgressBar:GetComponent("Image").fillAmount = score / 100

	local activeAliveTeamIndexes = DualTeamExploreModule.GetActiveAliveTeamIndexes()
	local currentTeamIndex = DualTeamExploreModule.GetCurrentTeamIndex()

	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]
		local isActive = table.indexOf(activeAliveTeamIndexes, i) ~= -1

		item:SetData(currentTeamIndex, isActive)
	end
end

function DualTeamExploreMazeConfirmUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	DualTeamExploreModule.SendEnterMaze(0)
end

function DualTeamExploreMazeConfirmUIController:OnClickConfirmBtn()
	UIModule.CloseSelf(self)

	local selectTeamIndex = 0

	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]

		if item:IsSelect() then
			selectTeamIndex = i

			break
		end
	end

	if selectTeamIndex == 0 then
		selectTeamIndex = 1

		logError("没有队伍被选中")
	end

	DualTeamExploreModule.SendEnterMaze(selectTeamIndex)
end

return DualTeamExploreMazeConfirmUIController
