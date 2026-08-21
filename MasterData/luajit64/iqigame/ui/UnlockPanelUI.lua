-- chunkname: @IQIGame\\UI\\UnlockPanelUI.lua

local UnlockPanelUI = Base:Extend("UnlockPanelUI", "IQIGame.Onigao.UI.UnlockPanelUI", {})

function UnlockPanelUI:OnInit()
	self.btnClose = self.btn_Close:GetComponent("Button")
	self.txtInfo = self.txt_Info:GetComponent("Text")
	self.txtItemNum = self.txt_ItemNum:GetComponent("Text")
	self.btnConfirm01 = self.btn_Confirm01:GetComponent("Button")
	self.btnCancel02 = self.btn_Cancel02:GetComponent("Button")
	self.btnConfirm02 = self.btn_Confirm02:GetComponent("Button")

	function self.delegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateOnClickConfirmBtn()
		self:OnClickBtnFirm()
	end

	function self.delegateOnClickCancelBtn()
		self:OnClickBtnCancel()
	end
end

function UnlockPanelUI:GetPreloadAssetPaths()
	return nil
end

function UnlockPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UnlockPanelUI:OnOpen(userData)
	self.txtInfo.text = userData.info

	local itemID = userData.itemID
	local cfgItemData = CfgItemTable[itemID]
	local needItemNum = userData.itemNum

	self.txtItemNum.text = needItemNum

	local goItem = self.img_NeedItemIcon.gameObject.transform:GetChild(0).gameObject
	local itemCell = ItemCell.PackageOrReuseView(self, goItem, false)

	itemCell:SetItem(cfgItemData)
	itemCell:SetNum(needItemNum)

	if userData.clickCancelButtonCallBack == nil then
		self.ui_ButtonGroup01.gameObject:SetActive(true)
		self.ui_ButtonGroup02.gameObject:SetActive(false)
	else
		self.ui_ButtonGroup01.gameObject:SetActive(false)
		self.ui_ButtonGroup02.gameObject:SetActive(true)
	end

	self.callbackSure = userData.clickConfirmButtonCallBack
	self.callbackCancel = userData.clickCancelButtonCallBack
	self.Caller = userData.from
end

function UnlockPanelUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.delegateOnClickBtnClose)
	self.btnConfirm01.onClick:AddListener(self.delegateOnClickConfirmBtn)
	self.btnConfirm02.onClick:AddListener(self.delegateOnClickConfirmBtn)

	if self.delegateOnClickCancelBtn ~= nil then
		self.btnCancel02.onClick:AddListener(self.delegateOnClickCancelBtn)
	end
end

function UnlockPanelUI:OnClose(userData)
	return
end

function UnlockPanelUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.delegateOnClickBtnClose)
	self.btnConfirm01.onClick:RemoveListener(self.delegateOnClickConfirmBtn)
	self.btnConfirm02.onClick:RemoveListener(self.delegateOnClickConfirmBtn)

	if self.delegateOnClickCancelBtn ~= nil then
		self.btnCancel02.onClick:RemoveListener(self.delegateOnClickCancelBtn)
	end
end

function UnlockPanelUI:OnPause()
	return
end

function UnlockPanelUI:OnResume()
	return
end

function UnlockPanelUI:OnCover()
	return
end

function UnlockPanelUI:OnReveal()
	return
end

function UnlockPanelUI:OnRefocus(userData)
	return
end

function UnlockPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UnlockPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UnlockPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UnlockPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UnlockPanelUI:OnDestroy()
	return
end

function UnlockPanelUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.UnlockPanelUI)
end

function UnlockPanelUI:OnClickBtnFirm()
	if self.callbackSure ~= nil then
		self.callbackSure(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.UnlockPanelUI)
end

function UnlockPanelUI:OnClickBtnCancel()
	if self.callbackCancel ~= nil then
		self.callbackCancel(self.Caller)
	end

	UIModule.Close(Constant.UIControllerName.UnlockPanelUI)
end

return UnlockPanelUI
