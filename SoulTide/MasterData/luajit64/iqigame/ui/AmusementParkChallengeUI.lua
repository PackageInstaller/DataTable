-- chunkname: @IQIGame\\UI\\AmusementParkChallengeUI.lua

local AmusementParkChallengeUI = {
	amusementParkEventMonsters = {},
	amusementChallengeRenderPool = {}
}

AmusementParkChallengeUI = Base:Extend("AmusementParkChallengeUI", "IQIGame.Onigao.UI.AmusementParkChallengeUI", AmusementParkChallengeUI)

require("IQIGame.UIExternalApi.AmusementParkChallengeUIApi")

local AmusementParkChallengeRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkChallenge.AmusementParkChallengeRender")

function AmusementParkChallengeUI:OnInit()
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

function AmusementParkChallengeUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkChallengeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkChallengeUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkChallengeUI:GetBGM(userData)
	return nil
end

function AmusementParkChallengeUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkChallengeUI:OnClose(userData)
	return
end

function AmusementParkChallengeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.APUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function AmusementParkChallengeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.APUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function AmusementParkChallengeUI:OnPause()
	return
end

function AmusementParkChallengeUI:OnResume()
	return
end

function AmusementParkChallengeUI:OnCover()
	return
end

function AmusementParkChallengeUI:OnReveal()
	return
end

function AmusementParkChallengeUI:OnRefocus(userData)
	return
end

function AmusementParkChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkChallengeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.amusementChallengeRenderPool) do
		v:Dispose()
	end
end

function AmusementParkChallengeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function AmusementParkChallengeUI:OnChallengeEvent()
	self:UpdateView()
end

function AmusementParkChallengeUI:UpdateView()
	self.amusementParkEventMonsters = AmusementParkModule.AmusementParkEventMonster

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.amusementParkEventMonsters)
end

function AmusementParkChallengeUI:OnRenderCell(cell)
	local amusementParkEventData = self.amusementParkEventMonsters[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.amusementChallengeRenderPool[instanceID]

	if renderCell == nil then
		renderCell = AmusementParkChallengeRender.New(cell.gameObject)
		self.amusementChallengeRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(amusementParkEventData)
end

return AmusementParkChallengeUI
