-- chunkname: @IQIGame\\UI\\BuySingleBatchConfirmUI.lua

local BuySingleBatchConfirmUI = Base:Extend("BuySingleBatchConfirmUI", "IQIGame.Onigao.UI.BuySingleBatchConfirmUI", {
	Ignore = false,
	LimitCount = 0,
	CanBeIgnored = false,
	NowCount = 0,
	DynamicCountArgIndex = 0
})

function BuySingleBatchConfirmUI:OnInit()
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

function BuySingleBatchConfirmUI:GetPreloadAssetPaths()
	return nil
end

function BuySingleBatchConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuySingleBatchConfirmUI:OnOpen(userData)
	self.CancelCallback = userData.cancel
	self.ConfirmCallback = userData.confirm
	self.Caller = userData.from
	self.LimitCount = userData.count
	self.NowCount = userData.nowCount
	self.CostList = userData.costList
	self.NoticeArgs = userData.args
	self.ExtraConditionFunc = userData.extraConditionFunc
	self.DynamicCountArgIndex = userData.dynamicCountArgIndex

	if self.DynamicCountArgIndex ~= nil and self.DynamicCountArgIndex > 0 then
		table.insert(self.NoticeArgs, self.DynamicCountArgIndex, 0)
	end

	self.CfgNoticeData = CfgNoticeTable[userData.cid]

	self:UpdateView()
end

function BuySingleBatchConfirmUI:OnClose(userData)
	self.Ignore = false
end

function BuySingleBatchConfirmUI:OnAddListeners()
	return
end

function BuySingleBatchConfirmUI:OnRemoveListeners()
	return
end

function BuySingleBatchConfirmUI:OnPause()
	return
end

function BuySingleBatchConfirmUI:OnResume()
	return
end

function BuySingleBatchConfirmUI:OnCover()
	return
end

function BuySingleBatchConfirmUI:OnReveal()
	return
end

function BuySingleBatchConfirmUI:OnRefocus(userData)
	return
end

function BuySingleBatchConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuySingleBatchConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuySingleBatchConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuySingleBatchConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuySingleBatchConfirmUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.Content, self)

	self.Content = nil
end

function BuySingleBatchConfirmUI:UpdateView()
	self.TitleText:GetComponent("Text").text = ConfirmationUIApi:GetString("TitleText", self.CfgNoticeData.Title)
	self.SubContentText.transform:Find("Text_Other"):GetComponent("Text").text = ConfirmationUIApi:GetString("SubContentText", self.CfgNoticeData.SubContent)
	self.CanBeIgnored = self.CfgNoticeData.CanBeIgnored

	self.IgnoreToggle:SetActive(self.CfgNoticeData.CanBeIgnored)

	if self.CfgNoticeData.CanBeIgnored then
		self.IgnoreToggle:GetComponent("Toggle").isOn = self.Ignore
	end

	self.CancelBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = self.CfgNoticeData.ButtonText1
	self.RightConfirmBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = self.CfgNoticeData.ButtonText2

	self.SubContentText:SetActive(self.CfgNoticeData.SubContent ~= "")
	self.ContentText.transform.parent.gameObject:SetActive(self.CfgNoticeData.Describe ~= "")
	self:RefreshContent()
	self:RefreshItemBlock()
end

function BuySingleBatchConfirmUI:RefreshContent()
	if self.DynamicCountArgIndex ~= nil and self.DynamicCountArgIndex > 0 then
		table.remove(self.NoticeArgs, self.DynamicCountArgIndex)
		table.insert(self.NoticeArgs, self.DynamicCountArgIndex, self:GetCountOfContentArg())
	end

	self.ContentText:GetComponent("Text").text = ConfirmationUIApi:GetString("ContentText", string.format(self.CfgNoticeData.Describe, unpack(self.NoticeArgs)))
end

function BuySingleBatchConfirmUI:GetCountOfContentArg()
	if self.LimitCount > 0 then
		return self.LimitCount - self.NowCount
	else
		return self.NowCount
	end
end

function BuySingleBatchConfirmUI:RefreshItemBlock()
	local params = self.CfgNoticeData.SpecialContent
	local txt1 = params[1]
	local txt2 = params[2]
	local cost = self:GetCost()
	local moneyParent = self.goMoneyParent.transform

	UGUIUtil.SetText(moneyParent:Find("Text_01").gameObject, ConfirmationUIApi:GetString("LeftTxt", txt1))
	UGUIUtil.SetText(moneyParent:Find("Text_02").gameObject, ConfirmationUIApi:GetString("RightTxt", string.format(txt2, cost.num)))

	local path = UIGlobalApi.GetIconPath(CfgItemTable[cost.cid].Icon)

	AssetUtil.LoadImage(self, path, self.goMoneyParent.transform:Find("Image"):GetComponent("Image"))
end

function BuySingleBatchConfirmUI:OnAddListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
end

function BuySingleBatchConfirmUI:OnRemoveListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
end

function BuySingleBatchConfirmUI:GetCost()
	local pointer = self.NowCount + 1

	if pointer > #self.CostList then
		pointer = #self.CostList
	end

	return self.CostList[pointer]
end

function BuySingleBatchConfirmUI:OnConfirm()
	local cost = self:GetCost()

	if WarehouseModule.GetItemNumByCfgID(cost.cid) < cost.num then
		local cfgItemData = CfgItemTable[cost.cid]

		NoticeModule.ShowNoticeNoCallback(21040112, cfgItemData.Name)

		return
	end

	if self.LimitCount > 0 and self.NowCount >= self.LimitCount then
		NoticeModule.ShowNoticeNoCallback(21040020)

		return
	end

	if self.ExtraConditionFunc ~= nil and not self.ExtraConditionFunc(self.Caller, self.NowCount) then
		return
	end

	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback(self.Caller)
	end

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)

		self.Ignore = true
	end

	self.NowCount = self.NowCount + 1

	self:RefreshContent()
	self:RefreshItemBlock()
end

function BuySingleBatchConfirmUI:OnCancel()
	self:Cancel()
end

function BuySingleBatchConfirmUI:Cancel()
	if self.CancelCallback ~= nil then
		self.CancelCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.BuySingleBatchConfirmUI)
end

function BuySingleBatchConfirmUI:OnClickBtnClose()
	self:Cancel()
end

return BuySingleBatchConfirmUI
