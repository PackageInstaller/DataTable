-- chunkname: @IQIGame\\UI\\BuySingleConfirmUI.lua

local BuySingleConfirmUI = Base:Extend("BuySingleConfirmUI", "IQIGame.Onigao.UI.BuySingleConfirmUI", {
	CanBeIgnored = false,
	NoticeCID = 0
})

function BuySingleConfirmUI:OnInit()
	LuaCodeInterface.BindOutlet(self.Content, self)

	function self.DelegateOnCancel()
		self:OnCancel()
	end

	function self.DelegateOnConfirm()
		self:OnConfirm()
	end

	function self.onClickBtnClose()
		self:OnClickBtnClose()
	end

	self.IgnoreToggle.transform:Find("Text_1"):GetComponent("Text").text = ConfirmationUIApi:GetString("IgnoreTxt")
	self.RightConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("ConfirmBtnTxt")
	self.CancelBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetString("CancelBtnTxt")
end

function BuySingleConfirmUI:GetPreloadAssetPaths()
	return nil
end

function BuySingleConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuySingleConfirmUI:OnOpen(userData)
	self.CancelCallback = userData.cancel
	self.ConfirmCallback = userData.confirm
	self.Caller = userData.from

	local noticeCid = tonumber(userData.cid)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	self:UpdateView(cfgNoticeData, userData.itemCid, userData.itemNum, userData.args)
end

function BuySingleConfirmUI:OnClose(userData)
	return
end

function BuySingleConfirmUI:OnAddListeners()
	return
end

function BuySingleConfirmUI:OnRemoveListeners()
	return
end

function BuySingleConfirmUI:OnPause()
	return
end

function BuySingleConfirmUI:OnResume()
	return
end

function BuySingleConfirmUI:OnCover()
	return
end

function BuySingleConfirmUI:OnReveal()
	return
end

function BuySingleConfirmUI:OnRefocus(userData)
	return
end

function BuySingleConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuySingleConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuySingleConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuySingleConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuySingleConfirmUI:UpdateView(cfgNoticeData, itemCid, itemNum, stringArgs)
	self.NoticeCID = cfgNoticeData.Id
	self.TitleText:GetComponent("Text").text = ConfirmationUIApi:GetString("TitleText", cfgNoticeData.Title)
	self.ContentText:GetComponent("Text").text = ConfirmationUIApi:GetString("ContentText", string.format(cfgNoticeData.Describe, unpack(stringArgs)))
	self.SubContentText.transform:Find("Text_Other"):GetComponent("Text").text = ConfirmationUIApi:GetString("SubContentText", cfgNoticeData.SubContent)
	self.CanBeIgnored = cfgNoticeData.CanBeIgnored

	self.IgnoreToggle:SetActive(cfgNoticeData.CanBeIgnored)

	if cfgNoticeData.CanBeIgnored then
		self.IgnoreToggle:GetComponent("Toggle").isOn = false
	end

	self.CancelBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = cfgNoticeData.ButtonText1
	self.RightConfirmBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = cfgNoticeData.ButtonText2

	self.SubContentText:SetActive(cfgNoticeData.SubContent ~= "")
	self.ContentText.transform.parent.gameObject:SetActive(cfgNoticeData.Describe ~= "")
	self:RefreshItemBlock(cfgNoticeData, itemCid, itemNum)
end

function BuySingleConfirmUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.Content, self)

	self.Content = nil
end

function BuySingleConfirmUI:RefreshItemBlock(cfgNoticeData, itemCid, itemNum)
	local params = cfgNoticeData.SpecialContent

	self.goMoneyParent:SetActive(cfgNoticeData.Type == 8)

	local txt1 = params[1]
	local txt2 = params[2]
	local moneyParent = self.goMoneyParent.transform

	moneyParent:Find("Text_01"):GetComponent("Text").text = ConfirmationUIApi:GetString("LeftTxt", txt1)
	moneyParent:Find("Text_02"):GetComponent("Text").text = ConfirmationUIApi:GetString("RightTxt", string.format(txt2, itemNum))

	local path = UIGlobalApi.IconPath .. CfgItemTable[itemCid].Icon

	AssetUtil.LoadImage(self, path, self.goMoneyParent.transform:Find("Image"):GetComponent("Image"))
end

function BuySingleConfirmUI:OnAddListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
end

function BuySingleConfirmUI:OnRemoveListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
end

function BuySingleConfirmUI:OnConfirm()
	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.BuySingleConfirmUI)

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)
	end
end

function BuySingleConfirmUI:OnCancel()
	self:Cancel()
end

function BuySingleConfirmUI:Cancel()
	if self.CancelCallback ~= nil then
		self.CancelCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.BuySingleConfirmUI)
end

function BuySingleConfirmUI:OnClickBtnClose()
	self:Cancel()
end

return BuySingleConfirmUI
