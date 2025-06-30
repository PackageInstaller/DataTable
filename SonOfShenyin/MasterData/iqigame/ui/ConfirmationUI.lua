-- chunkname: @IQIGame\\UI\\ConfirmationUI.lua

local ConfirmationUI = Base:Extend("ConfirmationUI", "IQIGame.Onigao.UI.ConfirmationUI", {
	CanBeIgnored = false,
	NoticeCID = 0
})
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function ConfirmationUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function ConfirmationUI:InitMembers()
	return
end

function ConfirmationUI:InitComponent()
	self.IgnoreToggle.transform:Find("Text_1"):GetComponent("Text").text = ConfirmationUIApi:GetIgnoreTxt()
	self.CenterConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetBtnConfirmTxt()
	self.RightConfirmBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetBtnConfirmTxt()
	self.CancelBtn.transform:Find("Text"):GetComponent("Text").text = ConfirmationUIApi:GetBtnCancelTxt()
	self.itemPool = UIViewObjectPool.New(self.CommonSlotUI, self.ItemRoot.transform, function(_view)
		return ItemCell.New(_view)
	end)
end

function ConfirmationUI:InitDelegate()
	function self.DelegateOnCancel()
		self:OnCancel()
	end

	function self.DelegateOnConfirm()
		self:OnConfirm()
	end

	function self.onClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateOnClickButtonClose()
		self:OnClickButtonClose()
	end
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

	self.goBtnClose:SetActive(cfgNoticeData.Type == 9)
	LuaUtility.SetGameObjectShow(self.buttonClose, cfgNoticeData.ClickBlackToClose)
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
	AssetUtil.UnloadAsset(self)
end

function ConfirmationUI:UpdateView(cfgNoticeData, args)
	self.NoticeCID = cfgNoticeData.Id
	self.TitleText:GetComponent("Text").text = ConfirmationUIApi:GetViewTitle(cfgNoticeData.Title)
	self.ContentText:GetComponent("Text").text = ConfirmationUIApi:GetMainContentTxt(string.format(cfgNoticeData.Describe, unpack(args)))
	self.SubContentText.transform:Find("Text_Other"):GetComponent("Text").text = ConfirmationUIApi:GetSubContentTxt(cfgNoticeData.SubContent)
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

	if not cfgNoticeData.CostItem or #cfgNoticeData.CostItem == 0 then
		LuaUtility.SetGameObjectShow(self.ItemRoot, false)

		return
	end

	self.itemPool:ForItems(function(item)
		item:Hide()
	end)
	LuaUtility.SetGameObjectShow(self.ItemRoot, true)

	local len = #cfgNoticeData.CostItem

	for i = 1, len do
		local item = self.itemPool:GetFree(function(_item)
			return _item.gameObject.activeSelf
		end)

		if cfgNoticeData.CostItemNum[i] then
			item:SetItemByCid(cfgNoticeData.CostItem[i], cfgNoticeData.CostItemNum[i])
		else
			item:SetItemByCid(cfgNoticeData.CostItem[i], WarehouseModule.GetItemNumByCfgID(cfgNoticeData.CostItem[i]))
		end

		item:Show()
	end
end

function ConfirmationUI:OnAddListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnClose)
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function ConfirmationUI:OnRemoveListeners()
	self.CenterConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.RightConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCancel)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnClose)
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function ConfirmationUI:OnConfirm()
	if self.ConfirmCallback ~= nil then
		self.ConfirmCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.ConfirmationUI)

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)
	end
end

function ConfirmationUI:OnCancel()
	if self.CancelCallback ~= nil then
		self.CancelCallback(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.ConfirmationUI)

	if self.CanBeIgnored and self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddIgnoreID(self.NoticeCID)
	end
end

function ConfirmationUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ConfirmationUI)
end

function ConfirmationUI:OnClickButtonClose()
	UIModule.Close(Constant.UIControllerName.ConfirmationUI)
	EventDispatcher.DispatchSingleEvent(EventID.ConfirmationUICloseEvent)
end

return ConfirmationUI
