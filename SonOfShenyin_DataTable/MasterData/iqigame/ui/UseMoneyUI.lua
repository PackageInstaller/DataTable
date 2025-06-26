-- chunkname: @IQIGame\\UI\\UseMoneyUI.lua

local UseMoneyUI = {}

UseMoneyUI = Base:Extend("UseMoneyUI", "IQIGame.Onigao.UI.UseMoneyUI", UseMoneyUI)

function UseMoneyUI:OnInit()
	function self.DelegateCancelBtn()
		self:OnCancelBtnClick()
	end

	function self.DelegateConfrimBtn()
		self:OnConfrimBtnClick()
	end

	self.CuritemCell = ItemCell.PackageOrReuseView(self, self.CurSlotParent.transform:GetChild(0).gameObject, false)
	self.NextitemCell = ItemCell.PackageOrReuseView(self, self.NextSlotParent.transform:GetChild(0).gameObject, false)
end

function UseMoneyUI:GetPreloadAssetPaths()
	return nil
end

function UseMoneyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UseMoneyUI:IsManualShowOnOpen(userData)
	return false
end

function UseMoneyUI:GetBGM(userData)
	return nil
end

function UseMoneyUI:OnOpen(args)
	self.ItemCid = args[1]
	self.UseItemCount = args[2]
	self.callBack = args[3]

	self:InitItemData()
end

function UseMoneyUI:OnClose(userData)
	return
end

function UseMoneyUI:OnAddListeners()
	self.ButtonCancel:GetComponent("Button").onClick:AddListener(self.DelegateCancelBtn)
	self.ButtonConfirm:GetComponent("Button").onClick:AddListener(self.DelegateConfrimBtn)
end

function UseMoneyUI:OnRemoveListeners()
	self.ButtonCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateCancelBtn)
	self.ButtonConfirm:GetComponent("Button").onClick:RemoveListener(self.DelegateConfrimBtn)
end

function UseMoneyUI:OnPause()
	return
end

function UseMoneyUI:OnResume()
	return
end

function UseMoneyUI:OnCover()
	return
end

function UseMoneyUI:OnReveal()
	return
end

function UseMoneyUI:OnRefocus(userData)
	return
end

function UseMoneyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UseMoneyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UseMoneyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UseMoneyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UseMoneyUI:OnDestroy()
	self.CuritemCell:Dispose()
	self.NextitemCell:Dispose()
	AssetUtil.UnloadAsset(self)
end

function UseMoneyUI:InitItemData()
	self.itemData = ItemData.CreateByCIDAndNumber(self.ItemCid, 0)

	self:RefreshMisc()
end

function UseMoneyUI:RefreshMisc()
	self.CuritemCell:SetItem(self.itemData, 1)
	self.NextitemCell:SetItem(self.itemData, 1)
	UGUIUtil.SetText(self.UseInfoText, self.UseItemCount .. CfgItemTable[self.ItemCid].Name)
	UGUIUtil.SetText(self.CurSlotNumText, WarehouseModule.GetItemNumByCfgID(self.ItemCid))
	UGUIUtil.SetText(self.NextSlotNumText, WarehouseModule.GetItemNumByCfgID(self.ItemCid) - self.UseItemCount <= 0 and 0 or WarehouseModule.GetItemNumByCfgID(self.ItemCid) - self.UseItemCount)
end

function UseMoneyUI:OnCancelBtnClick()
	UIModule.CloseSelf(self)
end

function UseMoneyUI:OnConfrimBtnClick()
	if self.callBack ~= nil then
		self.callBack()
	end

	self:OnCancelBtnClick()
end

return UseMoneyUI
