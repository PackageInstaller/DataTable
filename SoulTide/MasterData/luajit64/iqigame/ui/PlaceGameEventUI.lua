-- chunkname: @IQIGame\\UI\\PlaceGameEventUI.lua

local PlaceGameEventUI = {
	placeGameEventDataList = {},
	placeGameEventCellPool = {}
}

PlaceGameEventUI = Base:Extend("PlaceGameEventUI", "IQIGame.Onigao.UI.PlaceGameEventUI", PlaceGameEventUI)

local PlaceGameEventItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameEvent.PlaceGameEventItemCell")

function PlaceGameEventUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnClose1()
		self:OnBtnClose()
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	self.DiaLogList:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
end

function PlaceGameEventUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameEventUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameEventUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameEventUI:GetBGM(userData)
	return nil
end

function PlaceGameEventUI:OnOpen(userData)
	self:UpdateView()
end

function PlaceGameEventUI:OnClose(userData)
	return
end

function PlaceGameEventUI:OnAddListeners()
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose1)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	EventDispatcher.AddEventListener(EventID.PlaceGameUpdateEvent, self.DelegateUpdateEvent)
end

function PlaceGameEventUI:OnRemoveListeners()
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose1)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameUpdateEvent, self.DelegateUpdateEvent)
end

function PlaceGameEventUI:OnPause()
	return
end

function PlaceGameEventUI:OnResume()
	return
end

function PlaceGameEventUI:OnCover()
	return
end

function PlaceGameEventUI:OnReveal()
	return
end

function PlaceGameEventUI:OnRefocus(userData)
	return
end

function PlaceGameEventUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameEventUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameEventUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameEventUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameEventUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function PlaceGameEventUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGameEventUI:OnUpdateEvent()
	self:UpdateView()
end

function PlaceGameEventUI:UpdateView()
	self.placeGameEventDataList = {}

	for i, v in pairs(PlaceGameModule.placeGameEventList) do
		if v:IsUnlock() then
			table.insert(self.placeGameEventDataList, v)
		end
	end

	table.sort(self.placeGameEventDataList, function(a, b)
		return a:GetCfgData().UnlockTower < b:GetCfgData().UnlockTower
	end)
	self.DiaLogList:GetComponent("ScrollAreaList"):Refresh(#self.placeGameEventDataList)
	self.NoneNode:SetActive(#self.placeGameEventDataList == 0)
end

function PlaceGameEventUI:OnRenderCell(cell)
	local placeGameEventData = self.placeGameEventDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local eventCell = self.placeGameEventCellPool[instanceID]

	if eventCell == nil then
		eventCell = PlaceGameEventItemCell.New(cell.gameObject)
		self.placeGameEventCellPool[instanceID] = eventCell
	end

	eventCell:SetData(placeGameEventData)
end

return PlaceGameEventUI
