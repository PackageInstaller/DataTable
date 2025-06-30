-- chunkname: @IQIGame\\UI\\PassCheckDealUI.lua

local PassCheckDealUI = Base:Extend("PassCheckDealUI", "IQIGame.Onigao.UI.PassCheckDealUI", {})
local BaseCell = require("IQIGame.UI.PassCheckDeal.BaseCell")
local SuperCell = require("IQIGame.UI.PassCheckDeal.SuperCell")

function PassCheckDealUI:OnInit()
	self:Initialize()
end

function PassCheckDealUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckDealUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckDealUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckDealUI:GetBGM(userData)
	return nil
end

function PassCheckDealUI:OnOpen(userData)
	self:Refresh(userData)
end

function PassCheckDealUI:OnClose(userData)
	self:OnHide()
end

function PassCheckDealUI:OnPause()
	return
end

function PassCheckDealUI:OnResume()
	return
end

function PassCheckDealUI:OnCover()
	return
end

function PassCheckDealUI:OnReveal()
	return
end

function PassCheckDealUI:OnRefocus(userData)
	return
end

function PassCheckDealUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckDealUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckDealUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckDealUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckDealUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.baseCell = BaseCell.New(self.goBaseCell)
	self.superCell = SuperCell.New(self.goSuperCell)
	self.goDesc:GetComponent("Text").text = PassCheckDealUIApi:GetString("desc")
end

function PassCheckDealUI:Refresh(userData)
	self.cfgBattlePassData = userData

	self.baseCell:Refresh(self.cfgBattlePassData)
	self.superCell:Refresh(self.cfgBattlePassData)
end

function PassCheckDealUI:OnHide()
	self.baseCell:OnHide()
	self.superCell:OnHide()
end

function PassCheckDealUI:OnDestroy()
	self.baseCell:OnDestroy()
	self.superCell:OnDestroy()
end

function PassCheckDealUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.baseCell:OnAddListener()
	self.superCell:OnAddListener()
end

function PassCheckDealUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.baseCell:OnRemoveListener()
	self.superCell:OnRemoveListener()
end

function PassCheckDealUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return PassCheckDealUI
