-- chunkname: @IQIGame\\UI\\AccountTransferUI.lua

local AccountTransferUI = {}

AccountTransferUI = Base:Extend("AccountTransferUI", "IQIGame.Onigao.UI.AccountTransferUI", AccountTransferUI)

local AccountTransferNeedKnowView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferNeedKnowView")
local AccountTransferExplainView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferExplainView")
local AccountTransferView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferView")
local AccountTransferRegisterView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferRegisterView")

require("IQIGame.UIExternalApi.AccountTransferUIApi")

function AccountTransferUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateOnClickBtnTransfer()
		self:OnClickBtnTransfer()
	end

	function self.DelegateOnClickBtnNeedKnow()
		self:OnClickBtnNeedKnow()
	end

	function self.DelegateOnClickBtnExplain()
		self:OnClickBtnExplain()
	end

	function self.DelegateOnClickBtnTransferMsg()
		self:OnClickBtnTransferMsg()
	end

	function self.DelegateOpenRegister()
		self:OnOpenRegister()
	end

	function self.DelegateTransferSuccess()
		self:OnTransferSuccess()
	end

	self.needKnowView = AccountTransferNeedKnowView.New(self.NeedKnowNode)
	self.explainView = AccountTransferExplainView.New(self.ExplainNode)
	self.transferView = AccountTransferView.New(self.TransferNode)
	self.registerView = AccountTransferRegisterView.New(self.RegisterNode)
end

function AccountTransferUI:GetPreloadAssetPaths()
	return nil
end

function AccountTransferUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AccountTransferUI:IsManualShowOnOpen(userData)
	return false
end

function AccountTransferUI:GetBGM(userData)
	return nil
end

function AccountTransferUI:OnOpen(userData)
	self.needKnowView:Close()
	self.explainView:Close()
	self.transferView:Close()
	self.registerView:Close()
	self:UpDateView()
end

function AccountTransferUI:OnClose(userData)
	return
end

function AccountTransferUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnTransfer:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTransfer)
	self.BtnNeedKnow:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnNeedKnow)
	self.BtnExplain:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnExplain)
	self.BtnTransferMsg:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTransferMsg)
	EventDispatcher.AddEventListener(EventID.AccountTransferOpenRegister, self.DelegateOpenRegister)
	EventDispatcher.AddEventListener(EventID.AccountTransferSuccess, self.DelegateTransferSuccess)
end

function AccountTransferUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnTransfer:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTransfer)
	self.BtnNeedKnow:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnNeedKnow)
	self.BtnExplain:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnExplain)
	self.BtnTransferMsg:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTransferMsg)
	EventDispatcher.RemoveEventListener(EventID.AccountTransferOpenRegister, self.DelegateOpenRegister)
	EventDispatcher.RemoveEventListener(EventID.AccountTransferSuccess, self.DelegateTransferSuccess)
end

function AccountTransferUI:OnPause()
	return
end

function AccountTransferUI:OnResume()
	return
end

function AccountTransferUI:OnCover()
	return
end

function AccountTransferUI:OnReveal()
	return
end

function AccountTransferUI:OnRefocus(userData)
	return
end

function AccountTransferUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.registerView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function AccountTransferUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AccountTransferUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AccountTransferUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AccountTransferUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.needKnowView:Dispose()
	self.explainView:Dispose()
	self.transferView:Dispose()
	self.registerView:Dispose()
end

function AccountTransferUI:UpDateView()
	local isShowBtn = SDKLoginModule.IsHeroChannel() and LoginModule.LoginResponse and (LoginModule.LoginResponse.data.phone == nil or LoginModule.LoginResponse.data.phone == "")

	self.BtnTransfer:SetActive(isShowBtn)
	self.BtnTransferMsg:SetActive(false)
	self.TextTransferPhone:SetActive(false)

	if LoginModule.LoginResponse and LoginModule.LoginResponse.data.phone and LoginModule.LoginResponse.data.phone ~= "" then
		self.TextTransferPhone:SetActive(true)
		UGUIUtil.SetText(self.TextTransferPhone, AccountTransferUIApi:GetString("TextTransferPhone", LoginModule.LoginResponse.data.phone))
	end
end

function AccountTransferUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AccountTransferUI:OnClickBtnTransfer()
	self.transferView:Open()
end

function AccountTransferUI:OnClickBtnNeedKnow()
	self.needKnowView:Open()
end

function AccountTransferUI:OnClickBtnExplain()
	self.explainView:Open()
end

function AccountTransferUI:OnOpenRegister()
	self.transferView:Close()
	self.registerView:Open()
end

function AccountTransferUI:OnTransferSuccess()
	self:UpDateView()
end

function AccountTransferUI:OnClickBtnTransferMsg()
	return
end

return AccountTransferUI
