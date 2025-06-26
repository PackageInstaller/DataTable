-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferProtoInfoView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.onClickBtnBackDelegate()
		self:OnClickBtnBack()
	end

	self:AddListener()
end

function m:AddListener()
	self.goBtnBack:GetComponent("Button").onClick:AddListener(self.onClickBtnBackDelegate)
end

function m:RemoveListener()
	self.goBtnBack:GetComponent("Button").onClick:RemoveListener(self.onClickBtnBackDelegate)
end

function m:OnClickBtnBack()
	self:Close()
end

function m:Open(url, protocolTitle)
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

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
