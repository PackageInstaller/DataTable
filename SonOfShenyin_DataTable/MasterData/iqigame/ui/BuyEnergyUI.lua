-- chunkname: @IQIGame\\UI\\BuyEnergyUI.lua

local BuyEnergyUI = {
	EnergyItemCid = 0
}

BuyEnergyUI = Base:Extend("BuyEnergyUI", "IQIGame.Onigao.UI.BuyEnergyUI", BuyEnergyUI)

local exChangeEnergyView = require("IQIGame.UI.ExChangeEnergy.ExChangeEnergyView")

function BuyEnergyUI:OnInit()
	function self.DelegateOnCloseBtnClick()
		UIModule.CloseSelf(self)
	end

	function self.DelegateOnUpdateItem()
		self:RefreshData()
	end

	function self.DelegateRefreshShowEnergyEvent(AddEnergyCount)
		self:RefreshShowEnergyEvent(AddEnergyCount)
	end

	self.ExChangeEnergyView = exChangeEnergyView.New(self.ItemCotent)
	self.EnergyItemCid = Constant.ItemCid.STRENGTH
end

function BuyEnergyUI:GetPreloadAssetPaths()
	return nil
end

function BuyEnergyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyEnergyUI:IsManualShowOnOpen(userData)
	return false
end

function BuyEnergyUI:GetBGM(userData)
	return nil
end

function BuyEnergyUI:OnOpen(userData)
	self.ExChangeEnergyView:Show()
	self.ExChangeEnergyView:SetData()
	self:RefreshData()
	self:RefreshEnergyInfoShow(0)
	self:RefreshTime()
end

function BuyEnergyUI:OnClose(userData)
	self:ResetTimer()
end

function BuyEnergyUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtnClick)
	EventDispatcher.AddEventListener(EventID.UseItemResult, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.RefreshShowEnergyEvent, self.DelegateRefreshShowEnergyEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function BuyEnergyUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnClick)
	EventDispatcher.RemoveEventListener(EventID.UseItemResult, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.RefreshShowEnergyEvent, self.DelegateRefreshShowEnergyEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function BuyEnergyUI:OnPause()
	return
end

function BuyEnergyUI:OnResume()
	return
end

function BuyEnergyUI:OnCover()
	return
end

function BuyEnergyUI:OnReveal()
	return
end

function BuyEnergyUI:OnRefocus(userData)
	return
end

function BuyEnergyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyEnergyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyEnergyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyEnergyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyEnergyUI:OnDestroy()
	self:ResetTimer()
	self.ExChangeEnergyView:Dispose()
end

function BuyEnergyUI:RefreshData()
	self.MaxStrength = PlayerModule.GetPlayerEnergy()
	self.CurStrength = WarehouseModule.GetItemNumByCfgID(self.EnergyItemCid)

	UGUIUtil.SetText(self.RestNum, self.CurStrength)
	UGUIUtil.SetText(self.AllNum, "/" .. self.MaxStrength)
end

function BuyEnergyUI:RefreshShowEnergyEvent(AddEnergyCount)
	self:RefreshEnergyInfoShow(AddEnergyCount)
end

function BuyEnergyUI:RefreshEnergyInfoShow(energyCount)
	UGUIUtil.SetText(self.AddNum, "+" .. energyCount)
	LuaUtility.SetTransGameObjectShow(self.AddNum.transform, energyCount > 0)
end

function BuyEnergyUI:RefreshTime()
	self.recoveryTime = PlayerModule.GetPlayerEnergyItemResourceCfg().RestoreTime

	self:ResetTimer()
	self:CalculationTime()

	self.recoveryTimer = Timer.New(function()
		self:CalculationTime()
	end, 1, -1)

	self.recoveryTimer:Start()
end

function BuyEnergyUI:CalculationTime()
	local difference = self.MaxStrength - WarehouseModule.GetItemNumByCfgID(self.EnergyItemCid)

	LuaUtility.SetGameObjectShow(self.timeTips, difference > 0)
	LuaUtility.SetGameObjectShow(self.timeText, difference > 0)

	if difference <= 0 then
		self:ResetTimer()

		return
	end

	local otherTime = PlayerModule.GetServerTime() - PlayerModule.PlayerInfo.baseInfo.restoreTime
	local allTime = self.recoveryTime * difference - otherTime - 0.25

	UGUIUtil.SetText(self.timeText, DateTimeFormat(allTime, BuyEnergyUIApi:GetTimeFormat(allTime)))
end

function BuyEnergyUI:ResetTimer()
	if self.recoveryTimer then
		self.recoveryTimer:Stop()

		self.recoveryTimer = nil
	end
end

return BuyEnergyUI
