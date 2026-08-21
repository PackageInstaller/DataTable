-- chunkname: @IQIGame\\UI\\TownAreaUI.lua

local TownAreaUI = Base:Extend("TownAreaUI", "IQIGame.Onigao.UI.TownAreaUI", {})

function TownAreaUI:OnInit()
	self:Initialize()
end

function TownAreaUI:GetPreloadAssetPaths()
	return nil
end

function TownAreaUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TownAreaUI:IsManualShowOnOpen(userData)
	return false
end

function TownAreaUI:GetBGM(userData)
	return nil
end

function TownAreaUI:OnOpen(userData)
	self:Refresh(userData)
end

function TownAreaUI:OnClose(userData)
	self:OnHide()
end

function TownAreaUI:OnPause()
	return
end

function TownAreaUI:OnResume()
	return
end

function TownAreaUI:OnCover()
	return
end

function TownAreaUI:OnReveal()
	return
end

function TownAreaUI:OnRefocus(userData)
	return
end

function TownAreaUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TownAreaUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TownAreaUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TownAreaUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TownAreaUI:Initialize()
	self.tfTitle = self.goTitle:GetComponent("Text")
	self.tfTimes = self.goTimes:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.updateTownAreaEventDelegate()
		self:OnUpdateTownAreaEvent()
	end

	function self.delegateOnClickTip()
		self:OnClickTip()
	end
end

function TownAreaUI:Refresh(userData)
	self.areaData = TownAreaModule.areaData

	self:RefreshMisc()
end

function TownAreaUI:OnHide()
	return
end

function TownAreaUI:OnDestroy()
	return
end

function TownAreaUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.TimesView:GetComponent("Button").onClick:AddListener(self.delegateOnClickTip)
	EventDispatcher.AddEventListener(EventID.UpdateTownAreaEvent, self.updateTownAreaEventDelegate)
end

function TownAreaUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.TimesView:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateTownAreaEvent, self.updateTownAreaEventDelegate)
end

function TownAreaUI:OnClickBtnClose()
	TownAreaModule.ExitArea()
end

function TownAreaUI:OnUpdateTownAreaEvent()
	self:RefreshMisc()
end

function TownAreaUI:RefreshMisc()
	self.tfTitle.text = TownAreaUIApi:GetString("title", self.areaData.cfgInfo.ShortName)

	local totalTimes = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv].RestTime
	local curTimes = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.VACATION_TIME)

	self.tfTimes.text = TownAreaUIApi:GetString("times", curTimes, totalTimes)
end

function TownAreaUI:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		Constant.ItemID.VACATION_TIME,
		self.TimesView.transform
	})
end

return TownAreaUI
