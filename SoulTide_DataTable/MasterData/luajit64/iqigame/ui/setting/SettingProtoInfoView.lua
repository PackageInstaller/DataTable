-- chunkname: @IQIGame\\UI\\Setting\\SettingProtoInfoView.lua

local SettingProtoInfoView = {}

function SettingProtoInfoView.New(view)
	local obj = Clone(SettingProtoInfoView)

	obj:Init(view)

	return obj
end

function SettingProtoInfoView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnBack = self.goBtnBack:GetComponent("Button")

	function self.onClickBtnBackDelegate()
		self:OnClickBtnBack()
	end

	self:OnAddListener()
end

function SettingProtoInfoView:Open(url, protocolTitle)
	UIModule.canPopTopConfirm = false

	self.View:SetActive(true)
	UGUIUtil.SetText(self.TitleText, protocolTitle)

	if IQIGame.Onigao.Game.Device.isMobile then
		local uniWebViewCom = self.UniWebView:GetComponent("UniWebView")

		uniWebViewCom:SetZoomEnabled(true)
		uniWebViewCom:SetBackButtonEnabled(false)
		uniWebViewCom:Load(url, false)
		uniWebViewCom:Show()
	else
		UGUIUtil.SetText(self.ContentText, "Not supported on Unity Editor Mode.")
	end
end

function SettingProtoInfoView:Close()
	self.View:SetActive(false)

	UIModule.canPopTopConfirm = true
end

function SettingProtoInfoView:Dispose()
	self:OnRemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SettingProtoInfoView:OnAddListener()
	self.btnBack.onClick:AddListener(self.onClickBtnBackDelegate)
end

function SettingProtoInfoView:OnRemoveListener()
	self.btnBack.onClick:RemoveListener(self.onClickBtnBackDelegate)
end

function SettingProtoInfoView:OnClickBtnBack()
	self:Close()
end

return SettingProtoInfoView
