-- chunkname: @IQIGame\\UI\\EquipComposeUI.lua

local EquipComposeUI = Base:Extend("EquipComposeUI", "IQIGame.Onigao.UI.EquipComposeUI", {})
local ComposeInfoView = require("IQIGame.UI.EquipCompose.ComposeInfoView")

function EquipComposeUI:OnInit()
	self:Initialize()
end

function EquipComposeUI:GetPreloadAssetPaths()
	return nil
end

function EquipComposeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipComposeUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipComposeUI:OnClose(userData)
	self:OnHide()
end

function EquipComposeUI:OnPause()
	return
end

function EquipComposeUI:OnResume()
	return
end

function EquipComposeUI:OnCover()
	return
end

function EquipComposeUI:OnReveal()
	return
end

function EquipComposeUI:OnRefocus(userData)
	return
end

function EquipComposeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipComposeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipComposeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipComposeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipComposeUI:Initialize()
	self.equipCell = EquipCell.New(self.goSlot.transform:GetChild(0).gameObject)
	self.equipCell.enableClick = false
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goClipSlot)
	self.infoView = ComposeInfoView.New(self.goInfoView)
	self.tfClipNum = self.goClipNum:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnCompose = self.goBtnCompose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnComposeDelegate()
		self:OnClickBtnCompose()
	end

	function self.onComposeSuccessDelegate()
		self:OnComposeSuccess()
	end

	self.goViewTitle:GetComponent("Text").text = EquipComposeUIApi:GetString("goTitle")
	self.goBtnCompose.transform:Find("Text"):GetComponent("Text").text = EquipComposeUIApi:GetString("goBtnComposeTxt")
end

function EquipComposeUI:Refresh(userData)
	self.itemData = userData

	for i, v in pairsCfg(CfgExchangeTable) do
		if v.GetItems[1][1] == self.itemData.cid then
			self.cfgExchangeData = v

			break
		end
	end

	self.clipCid = self.cfgExchangeData.CostItems[1][1]

	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self:RefreshEquipCell()
	self:RefreshDetails()
	self:RefreshClipBlock()
end

function EquipComposeUI:OnHide()
	self.infoView:OnHide()
end

function EquipComposeUI:OnDestroy()
	self.equipCell:OnDestroy()
	self.infoView:OnDestroy()
	self.itemCell:Dispose()
end

function EquipComposeUI:RefreshEquipCell()
	self.equipCell:Refresh(self.itemData)

	if self.itemData.id == 0 then
		self.equipCell:SetGray(true)
	end
end

function EquipComposeUI:RefreshDetails()
	self.infoView:Refresh(self.itemData)
end

function EquipComposeUI:RefreshClipBlock()
	self.itemCell:SetItemByCID(self.clipCid)

	self.curCount = WarehouseModule.GetItemNumByCfgID(self.clipCid)
	self.needCount = self.cfgExchangeData.CostItems[1][2]
	self.tfClipNum.text = EquipComposeUIApi:GetString("goClipNum", self.curCount, self.needCount)
end

function EquipComposeUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnCompose.onClick:AddListener(self.onClickBtnComposeDelegate)
	EventDispatcher.AddEventListener(EventID.EquipComposeSuccess, self.onComposeSuccessDelegate)
end

function EquipComposeUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnCompose.onClick:RemoveListener(self.onClickBtnComposeDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipComposeSuccess, self.onComposeSuccessDelegate)
end

function EquipComposeUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.EquipComposeUI)
end

function EquipComposeUI:OnClickBtnCompose()
	local count = math.floor(self.curCount / self.needCount)

	EquipModule.ReqCompose(self.cfgExchangeData.Id, count)
end

function EquipComposeUI:OnComposeSuccess()
	local retCount = math.floor(self.curCount / self.needCount)

	UIModule.Open(Constant.UIControllerName.EquipComposeShowUI, Constant.UILayer.UI, {
		self.itemData,
		retCount
	})
	self:OnClickBtnClose()
end

return EquipComposeUI
