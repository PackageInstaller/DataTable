-- chunkname: @IQIGame\\UI\\ConfirmationUI.lua

local ConfirmationUI = Base:Extend("ConfirmationUI", "IQIGame.Onigao.UI.ConfirmationUI", {
	CanBeIgnored = false,
	NoticeCID = 0
})

function ConfirmationUI:OnInit()
	function self.DelegateOnCancel()
		self:OnCancel()
	end

	function self.DelegateOnConfirm()
		self:OnConfirm()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.IgnoreToggle.transform:Find("Text_1"):GetComponent("Text").text = ConfirmationUIApi:GetString("IgnoreTxt")
	self.CenterConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("ConfirmBtnTxt")
	self.RightConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("ConfirmBtnTxt")
	self.CancelBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("CancelBtnTxt")
end

function ConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function ConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ConfirmationUI:OnOpen(userData)
	self.CancelCallback = userData.cancel
	self.ConfirmCallback = userData.confirm
	self.Caller = userData.from

	local noticeCid = tonumber(userData.cid)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	self:UpdateView(cfgNoticeData, userData.args)
end

function ConfirmationUI:OnClose(userData)
	return
end

function ConfirmationUI:OnPause()
	return
end

function ConfirmationUI:OnResume()
	return
end

function ConfirmationUI:OnCover()
	return
end

function ConfirmationUI:OnReveal()
	return
end

function ConfirmationUI:OnRefocus(userData)
	return
end

function ConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ConfirmationUI:OnDestroy()
	return
end

function ConfirmationUI:UpdateView(cfgNoticeData, args)
	self.NoticeCID = cfgNoticeData.Id
	self.TitleText:GetComponent("Text").text = ConfirmationUIApi:GetString("TitleText", cfgNoticeData.Title)
	self.ContentText:GetComponent("Text").text = ConfirmationUIApi:GetString("ContentText", string.format(cfgNoticeData.Describe, unpack(args)))
	self.SubContentText.transform:Find("Text_Other"):GetComponent("Text").text = ConfirmationUIApi:GetString("SubContentText", cfgNoticeData.SubContent)
	self.CanBeIgnored = cfgNoticeData.CanBeIgnored

	self.IgnoreToggle:SetActive(cfgNoticeData.CanBeIgnored)

	if cfgNoticeData.CanBeIgnored then
		self.IgnoreToggle:GetComponent("Toggle").isOn = false
	end

	self.OneBtnCom:SetActive(cfgNoticeData.Type == 4)
	self.TwoBtnCom:SetActive(cfgNoticeData.Type ~= 4)

	if cfgNoticeData.Type == 4 then
		self.CenterConfirmBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = cfgNoticeData.ButtonText1
	else
		self.CancelBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = cfgNoticeData.ButtonText1
		self.RightConfirmBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = cfgNoticeData.ButtonText2
	end

	self.SubContentText:SetActive(cfgNoticeData.SubContent ~= "")
	self.ContentText.transform.parent.gameObject:SetActive(cfgNoticeData.Describe ~= "")
	self.goBtnClose:SetActive(not cfgNoticeData.HideCloseButton)
	self.goBtnClose1:SetActive(not cfgNoticeData.HideCloseButton)
end

function ConfirmationUI:OnAddListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function ConfirmationUI:OnRemoveListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function ConfirmationUI:OnConfirm()
	UIModule.CloseSelf(self)

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)
	end

	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback(self.Caller)
	end
end

function ConfirmationUI:OnCancel()
	UIModule.CloseSelf(self)

	if self.CancelCallback ~= nil then
		self.CancelCallback(self.Caller)
	end
end

function ConfirmationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return ConfirmationUI
