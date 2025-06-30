-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreSeparateConfirmUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreSeparateConfirmUIApi")

local DualTeamExploreLevelTeamItem = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelTeamItem")
local DualTeamExploreSeparateConfirmUIController = {
	TeamItems = {}
}

function DualTeamExploreSeparateConfirmUIController.New(uiController)
	local obj = Clone(DualTeamExploreSeparateConfirmUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreSeparateConfirmUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreSeparateConfirmUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreSeparateConfirmUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	for i = 1, 2 do
		local item = DualTeamExploreLevelTeamItem.New(UnityEngine.Object.Instantiate(self.TeamItemPrefab), i, self.DollCellPrefab)

		item.View.transform:SetParent(self.TeamItemGrid.transform, false)

		self.TeamItems[i] = item
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreSeparateConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, DualTeamExploreSeparateConfirmUIApi:GetString("TipText"))
	UGUIUtil.SetText(self.SelectTeamLabel, DualTeamExploreSeparateConfirmUIApi:GetString("SelectTeamLabel"))
end

function DualTeamExploreSeparateConfirmUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreSeparateConfirmUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreSeparateConfirmUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreSeparateConfirmUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreSeparateConfirmUIController:OnOpen(userData)
	self.OnConfirmCallback = userData.onConfirm

	self:UpdateView()
end

function DualTeamExploreSeparateConfirmUIController:OnClose(userData)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreSeparateConfirmUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreSeparateConfirmUIController:OnPause()
	return
end

function DualTeamExploreSeparateConfirmUIController:OnResume()
	return
end

function DualTeamExploreSeparateConfirmUIController:OnCover()
	return
end

function DualTeamExploreSeparateConfirmUIController:OnReveal()
	return
end

function DualTeamExploreSeparateConfirmUIController:OnRefocus(userData)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreSeparateConfirmUIController:OnDestroy()
	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreSeparateConfirmUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DualTeamExploreSeparateConfirmUIController:OnClickConfirmBtn()
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

	self.OnConfirmCallback(selectTeamIndex)
end

function DualTeamExploreSeparateConfirmUIController:UpdateView()
	local activeAliveTeamIndexes = DualTeamExploreModule.GetActiveAliveTeamIndexes()
	local currentTeamIndex = DualTeamExploreModule.GetCurrentTeamIndex()

	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]
		local isActive = table.indexOf(activeAliveTeamIndexes, i) ~= -1

		item:SetData(currentTeamIndex, isActive)
	end
end

return DualTeamExploreSeparateConfirmUIController
