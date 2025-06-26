-- chunkname: @IQIGame\\UI\\TopConfirmationUI.lua

local TopConfirmationUI = Base:Extend("TopConfirmationUI", "IQIGame.Onigao.UI.TopConfirmationUI", {})

function TopConfirmationUI:OnInit()
	function self.DelegateOnCancel()
		self:OnCancel()
	end

	function self.DelegateOnConfirm()
		self:OnConfirm()
	end

	self.CenterConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("ConfirmBtnTxt")
	self.RightConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("ConfirmBtnTxt")
	self.CancelBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("CancelBtnTxt")
end

function TopConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function TopConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TopConfirmationUI:IsManualShowOnOpen(userData)
	return false
end

function TopConfirmationUI:GetBGM(userData)
	return nil
end

function TopConfirmationUI:OnOpen(userData)
	self.CancelCallback = userData.cancel
	self.ConfirmCallback = userData.confirm

	local noticeCid = tonumber(userData.cid)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	self:UpdateView(cfgNoticeData)
end

function TopConfirmationUI:OnClose(userData)
	return
end

function TopConfirmationUI:OnAddListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
end

function TopConfirmationUI:OnRemoveListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
end

function TopConfirmationUI:OnPause()
	return
end

function TopConfirmationUI:OnResume()
	return
end

function TopConfirmationUI:OnCover()
	return
end

function TopConfirmationUI:OnReveal()
	return
end

function TopConfirmationUI:OnRefocus(userData)
	return
end

function TopConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TopConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TopConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TopConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TopConfirmationUI:OnDestroy()
	return
end

function TopConfirmationUI:UpdateView(cfgNoticeData)
	self.TitleText:GetComponent("Text").text = ConfirmationUIApi:GetString("TitleText", cfgNoticeData.Title)
	self.ContentText:GetComponent("Text").text = ConfirmationUIApi:GetString("ContentText", cfgNoticeData.Describe)
	self.SubContentText.transform:Find("Text_Other"):GetComponent("Text").text = ConfirmationUIApi:GetString("SubContentText", cfgNoticeData.SubContent)

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
end

function TopConfirmationUI:OnConfirm()
	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback()
	end

	UIModule.CloseSelf(self)
end

function TopConfirmationUI:OnCancel()
	if self.CancelCallback ~= nil then
		self.CancelCallback()
	end

	UIModule.CloseSelf(self)
end

return TopConfirmationUI
