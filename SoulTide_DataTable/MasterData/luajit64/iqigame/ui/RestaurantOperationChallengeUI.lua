-- chunkname: @IQIGame\\UI\\RestaurantOperationChallengeUI.lua

local RestaurantOperationChallengeUI = {
	roEventMonsters = {},
	ROChallengeRenderPool = {}
}

RestaurantOperationChallengeUI = Base:Extend("RestaurantOperationChallengeUI", "IQIGame.Onigao.UI.RestaurantOperationChallengeUI", RestaurantOperationChallengeUI)

local RestaurantOperationChallengeRender = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationChallenge.RestaurantOperationChallengeRender")

function RestaurantOperationChallengeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateChallengeEvent()
		self:OnChallengeEvent()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
end

function RestaurantOperationChallengeUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationChallengeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationChallengeUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationChallengeUI:GetBGM(userData)
	return nil
end

function RestaurantOperationChallengeUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantOperationChallengeUI:OnClose(userData)
	return
end

function RestaurantOperationChallengeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.ROUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function RestaurantOperationChallengeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function RestaurantOperationChallengeUI:OnPause()
	return
end

function RestaurantOperationChallengeUI:OnResume()
	return
end

function RestaurantOperationChallengeUI:OnCover()
	return
end

function RestaurantOperationChallengeUI:OnReveal()
	return
end

function RestaurantOperationChallengeUI:OnRefocus(userData)
	return
end

function RestaurantOperationChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationChallengeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.ROChallengeRenderPool) do
		v:Dispose()
	end
end

function RestaurantOperationChallengeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RestaurantOperationChallengeUI:OnChallengeEvent()
	self:UpdateView()
end

function RestaurantOperationChallengeUI:UpdateView()
	self.roEventMonsters = RestaurantOperationModule.ROEventMonster

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.roEventMonsters)
end

function RestaurantOperationChallengeUI:OnRenderCell(cell)
	local roEventMonsterData = self.roEventMonsters[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.ROChallengeRenderPool[instanceID]

	if renderCell == nil then
		renderCell = RestaurantOperationChallengeRender.New(cell.gameObject)
		self.ROChallengeRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(roEventMonsterData)
end

return RestaurantOperationChallengeUI
