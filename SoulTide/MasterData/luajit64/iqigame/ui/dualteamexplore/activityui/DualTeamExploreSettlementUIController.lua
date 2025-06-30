-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreSettlementUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreSettlementUIApi")

local DualTeamExploreLevelShowTeamItem = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelShowTeamItem")
local DualTeamExploreSettlementUIController = {
	TeamItems = {}
}

function DualTeamExploreSettlementUIController.New(uiController)
	local obj = Clone(DualTeamExploreSettlementUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreSettlementUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreSettlementUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreSettlementUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, 2 do
		local item = DualTeamExploreLevelShowTeamItem.New(UnityEngine.Object.Instantiate(self.TeamItemPrefab), i, self.DollCellPrefab)

		item.View.transform:SetParent(self.TeamNode.transform, false)

		self.TeamItems[i] = item
	end

	UGUIUtil.SetText(self.ExploreLabel, DualTeamExploreSettlementUIApi:GetString("ExploreLabel"))
	UGUIUtil.SetTextInChildren(self.SuccessView, DualTeamExploreSettlementUIApi:GetString("SuccessViewText"))
	UGUIUtil.SetTextInChildren(self.FailView, DualTeamExploreSettlementUIApi:GetString("FailViewText"))
end

function DualTeamExploreSettlementUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreSettlementUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreSettlementUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreSettlementUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreSettlementUIController:OnOpen(userData)
	self:UpdateView(userData.isSuccess)
end

function DualTeamExploreSettlementUIController:OnClose(userData)
	return
end

function DualTeamExploreSettlementUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreSettlementUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreSettlementUIController:OnPause()
	return
end

function DualTeamExploreSettlementUIController:OnResume()
	return
end

function DualTeamExploreSettlementUIController:OnCover()
	return
end

function DualTeamExploreSettlementUIController:OnReveal()
	return
end

function DualTeamExploreSettlementUIController:OnRefocus(userData)
	return
end

function DualTeamExploreSettlementUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreSettlementUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreSettlementUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreSettlementUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreSettlementUIController:OnDestroy()
	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreSettlementUIController:UpdateView(isSuccess)
	self.SuccessView:SetActive(isSuccess)
	self.FailView:SetActive(not isSuccess)

	for i = 1, #self.TeamItems do
		local item = self.TeamItems[i]

		item:Refresh()
	end
end

function DualTeamExploreSettlementUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	DualTeamExploreModule.ExitScene()
end

return DualTeamExploreSettlementUIController
