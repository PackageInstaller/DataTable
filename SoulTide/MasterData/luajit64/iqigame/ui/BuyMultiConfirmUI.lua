-- chunkname: @IQIGame\\UI\\BuyMultiConfirmUI.lua

local BuyMultiConfirmUI = Base:Extend("BuyMultiConfirmUI", "IQIGame.Onigao.UI.BuyMultiConfirmUI", {
	CanBeIgnored = false,
	NoticeCID = 0,
	itemCellPool = {}
})

function BuyMultiConfirmUI:OnInit()
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

function BuyMultiConfirmUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function BuyMultiConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyMultiConfirmUI:OnOpen(userData)
	self.CancelCallback = userData.cancel
	self.ConfirmCallback = userData.confirm
	self.Caller = userData.from

	local noticeCid = tonumber(userData.cid)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	self:UpdateView(cfgNoticeData, userData.itemCids, userData.itemNums, userData.args)
end

function BuyMultiConfirmUI:OnClose(userData)
	return
end

function BuyMultiConfirmUI:OnAddListeners()
	return
end

function BuyMultiConfirmUI:OnRemoveListeners()
	return
end

function BuyMultiConfirmUI:OnPause()
	return
end

function BuyMultiConfirmUI:OnResume()
	return
end

function BuyMultiConfirmUI:OnCover()
	return
end

function BuyMultiConfirmUI:OnReveal()
	return
end

function BuyMultiConfirmUI:OnRefocus(userData)
	return
end

function BuyMultiConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyMultiConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyMultiConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyMultiConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyMultiConfirmUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function BuyMultiConfirmUI:UpdateView(cfgNoticeData, itemCids, itemNums, stringArgs)
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
	self:RefreshItemBlock(cfgNoticeData, itemCids, itemNums)
end

function BuyMultiConfirmUI:RefreshItemBlock(cfgNoticeData, itemCids, itemNums)
	local ctGrid = self.goGridParent.transform:Find("Grid_Slot")

	for i, v in ipairs(itemCids) do
		local cell = self.itemCellPool[i]

		if cell == nil then
			local asset = self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())
			local go = UnityEngine.Object.Instantiate(asset)

			go.transform:SetParent(ctGrid, false)

			cell = ItemCell.PackageOrReuseView(self, go, false)
			self.itemCellPool[i] = cell
		end

		if itemNums == nil or #itemNums == 0 then
			cell:SetItemByCID(v, nil)
		else
			cell:SetItemByCID(v, itemNums[i])
		end

		self.itemCellPool[i].ViewGo:SetActive(true)
	end

	for i = #itemCids + 1, #self.itemCellPool do
		self.itemCellPool[i].ViewGo:SetActive(false)
	end
end

function BuyMultiConfirmUI:OnAddListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
end

function BuyMultiConfirmUI:OnRemoveListeners()
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
end

function BuyMultiConfirmUI:OnConfirm()
	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.BuyMultiConfirmUI)

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)
	end
end

function BuyMultiConfirmUI:OnCancel()
	self:Cancel()
end

function BuyMultiConfirmUI:Cancel()
	if self.CancelCallback ~= nil then
		self.CancelCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.BuyMultiConfirmUI)
end

function BuyMultiConfirmUI:OnClickBtnClose()
	self:Cancel()
end

return BuyMultiConfirmUI
