-- chunkname: @IQIGame\\UI\\SingleWeakTowerFloorUI.lua

local SingleWeakTowerFloorUI = {
	singleWeakTowerTypeCells = {}
}

SingleWeakTowerFloorUI = Base:Extend("SingleWeakTowerFloorUI", "IQIGame.Onigao.UI.SingleWeakTowerFloorUI", SingleWeakTowerFloorUI)

require("IQIGame.UIExternalApi.SingleWeakTowerFloorUIApi")

local SingleWeakTowerTypeCell = require("IQIGame.UI.ExploreHall.SingleWeakTower.SingleWeakTowerTypeCell")

function SingleWeakTowerFloorUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateUpdateSingleWeakTowerEvent()
		self:OnUpdateSingleWeakTower()
	end

	self.singleWeakTowerTypeCells = {}

	local types = {
		Constant.SingleWeakTowerType.TowerType_Magic,
		Constant.SingleWeakTowerType.TowerType_Fire,
		Constant.SingleWeakTowerType.TowerType_Physical,
		Constant.SingleWeakTowerType.TowerType_Thunder,
		Constant.SingleWeakTowerType.TowerType_Frost
	}

	for i = 1, #types do
		local type = types[i]
		local cell = SingleWeakTowerTypeCell.New(self["Item" .. i], type)

		self.singleWeakTowerTypeCells[i] = cell
	end
end

function SingleWeakTowerFloorUI:GetPreloadAssetPaths()
	return nil
end

function SingleWeakTowerFloorUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SingleWeakTowerFloorUI:IsManualShowOnOpen(userData)
	return false
end

function SingleWeakTowerFloorUI:GetBGM(userData)
	return nil
end

function SingleWeakTowerFloorUI:OnOpen(userData)
	self.cfgDailyDupData = userData

	self:UpdateView()
end

function SingleWeakTowerFloorUI:OnClose(userData)
	return
end

function SingleWeakTowerFloorUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.UpdateSingleWeakTowerEvent, self.DelegateUpdateSingleWeakTowerEvent)
end

function SingleWeakTowerFloorUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateSingleWeakTowerEvent, self.DelegateUpdateSingleWeakTowerEvent)
end

function SingleWeakTowerFloorUI:OnPause()
	return
end

function SingleWeakTowerFloorUI:OnResume()
	return
end

function SingleWeakTowerFloorUI:OnCover()
	return
end

function SingleWeakTowerFloorUI:OnReveal()
	return
end

function SingleWeakTowerFloorUI:OnRefocus(userData)
	return
end

function SingleWeakTowerFloorUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SingleWeakTowerFloorUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SingleWeakTowerFloorUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SingleWeakTowerFloorUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SingleWeakTowerFloorUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.singleWeakTowerTypeCells) do
		v:Dispose()
	end
end

function SingleWeakTowerFloorUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SingleWeakTowerFloorUI:OnUpdateDailyDupEvent()
	if SingleWeakTowerMould.IsShow() then
		self:UpdateView()
	end
end

function SingleWeakTowerFloorUI:OnUpdateSingleWeakTower()
	if SingleWeakTowerMould.IsShow() then
		self:UpdateView()
	end
end

function SingleWeakTowerFloorUI:UpdateView()
	UGUIUtil.SetText(self.TextTitle, self.cfgDailyDupData.Name)

	for i, v in pairs(self.singleWeakTowerTypeCells) do
		local floor = SingleWeakTowerMould.GetPassMaxFloorByType(v.type)

		v:SetData(floor)
	end
end

return SingleWeakTowerFloorUI
