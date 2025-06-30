-- chunkname: @IQIGame\\UI\\EvilErosionEquipStrengthenUI.lua

require("IQIGame.UIExternalApi.EvilErosionEquipStrengthenUIApi")

local EvilErosionEquipStrengthenInfo = require("IQIGame.UI.EvilErosion.EvilErosionEquipStrengthenInfo")
local EvilErosionEquipStrengthenUI = {
	InfoControllers = {}
}

EvilErosionEquipStrengthenUI = Base:Extend("EvilErosionEquipStrengthenUI", "IQIGame.Onigao.UI.EvilErosionEquipStrengthenUI", EvilErosionEquipStrengthenUI)

function EvilErosionEquipStrengthenUI:OnInit()
	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpgradeStarComplete()
		self:OnUpgradeStarComplete()
	end

	self.InfoPrefab:SetActive(true)

	for i = 1, 2 do
		local infoController = EvilErosionEquipStrengthenInfo.New(UnityEngine.Object.Instantiate(self.InfoPrefab))

		infoController.View.transform:SetParent(self.InfoPrefab.transform.parent, false)

		self.InfoControllers[i] = infoController
	end

	self.InfoPrefab:SetActive(false)
	UGUIUtil.SetText(self.TitleText, EvilErosionEquipStrengthenUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.AttrUpRateLabel, EvilErosionEquipStrengthenUIApi:GetString("AttrUpRateLabel"))
	UGUIUtil.SetText(self.PreviewAttrUpRateLabel, EvilErosionEquipStrengthenUIApi:GetString("PreviewAttrUpRateLabel"))
	UGUIUtil.SetText(self.CostLabel, EvilErosionEquipStrengthenUIApi:GetString("CostLabel"))
	UGUIUtil.SetText(self.CostLabel2, EvilErosionEquipStrengthenUIApi:GetString("CostLabel2"))
	UGUIUtil.SetText(self.TipText, EvilErosionEquipStrengthenUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EvilErosionEquipStrengthenUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, EvilErosionEquipStrengthenUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetTextInChildren(self.NoHigherStarLvView, EvilErosionEquipStrengthenUIApi:GetString("NoHigherStarLvViewText"))
end

function EvilErosionEquipStrengthenUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionEquipStrengthenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionEquipStrengthenUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionEquipStrengthenUI:GetBGM(userData)
	return nil
end

function EvilErosionEquipStrengthenUI:OnOpen(userData)
	self.OnCloseCallback = userData.onClose

	self:UpdateView(userData.itemData)
end

function EvilErosionEquipStrengthenUI:OnClose(userData)
	return
end

function EvilErosionEquipStrengthenUI:OnAddListeners()
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.EvilErosionUpgradeStarComplete, self.DelegateOnUpgradeStarComplete)
end

function EvilErosionEquipStrengthenUI:OnRemoveListeners()
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionUpgradeStarComplete, self.DelegateOnUpgradeStarComplete)
end

function EvilErosionEquipStrengthenUI:OnPause()
	return
end

function EvilErosionEquipStrengthenUI:OnResume()
	return
end

function EvilErosionEquipStrengthenUI:OnCover()
	return
end

function EvilErosionEquipStrengthenUI:OnReveal()
	return
end

function EvilErosionEquipStrengthenUI:OnRefocus(userData)
	return
end

function EvilErosionEquipStrengthenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionEquipStrengthenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionEquipStrengthenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionEquipStrengthenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionEquipStrengthenUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.InfoControllers do
		local controller = self.InfoControllers[i]

		controller:Dispose()
	end
end

function EvilErosionEquipStrengthenUI:OnClickCancelBtn()
	self:Close()
end

function EvilErosionEquipStrengthenUI:OnClickConfirmBtn()
	local costIdNumMap = EvilErosionModule.GetEnhanceCost(self.ItemData)

	for itemCid, needItemNum in pairs(costIdNumMap) do
		local hasNum = WarehouseModule.GetItemNumByCfgID(itemCid)

		if hasNum < needItemNum then
			local cfgItemData = CfgItemTable[itemCid]

			NoticeModule.ShowNoticeNoCallback(21040112, cfgItemData.Name)

			return
		end
	end

	EvilErosionModule.SendUpgradeEquipmentStar(self.ItemData.id)
end

function EvilErosionEquipStrengthenUI:OnClickCloseBtn()
	self:Close()
end

function EvilErosionEquipStrengthenUI:Close()
	UIModule.CloseSelf(self)

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function EvilErosionEquipStrengthenUI:UpdateView(itemData)
	self.ItemData = itemData

	local cfgItemData = itemData:GetCfg()
	local iconPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)

	AssetUtil.LoadImage(self, iconPath, self.EquipImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, iconPath, self.EquipPreviewImage:GetComponent("Image"))
	UGUIUtil.SetText(self.EquipNameText, cfgItemData.Name)
	UGUIUtil.SetText(self.EquipPreviewNameText, cfgItemData.Name)

	local isMaxStar = itemData.equipData.star >= cfgItemData.StarLimit
	local previewAddStar = isMaxStar and 0 or 1

	self.CostItemView:SetActive(not isMaxStar)
	self.NoHigherStarLvView:SetActive(isMaxStar)

	local starComponent = self.Star:GetComponent("SimpleStarComponent")

	starComponent:UpdateView(cfgItemData.StarLimit, itemData.equipData.star)

	starComponent = self.StarPreview:GetComponent("SimpleStarComponent")

	starComponent:UpdateView(cfgItemData.StarLimit, itemData.equipData.star + previewAddStar)

	for i = 1, #self.InfoControllers do
		local controller = self.InfoControllers[i]

		controller:SetData(itemData, i == 1 and 0 or previewAddStar)
	end

	if not isMaxStar then
		local costItem1Num, costItem2Cid, costItem2Num
		local costIdNumMap = EvilErosionModule.GetEnhanceCost(itemData)

		for itemCid, itemNum in pairs(costIdNumMap) do
			if itemCid == itemData.cid then
				costItem1Num = itemNum
			else
				costItem2Cid = itemCid
				costItem2Num = itemNum
			end

			if costItem1Num ~= nil and costItem2Num ~= nil then
				break
			end
		end

		self.CostItemSubView1:SetActive(costItem1Num ~= nil)

		if costItem1Num ~= nil then
			local hasNum = 0
			local equipList = WarehouseModule.GetItemsByType(Constant.ItemType.EvilErosionEquip, false)

			for i = 1, #equipList do
				local lEquipItemData = equipList[i]

				if lEquipItemData.cid == itemData.cid and lEquipItemData.id ~= itemData.id and lEquipItemData.equipData.star == 1 then
					local ownerSoulPrefabPOD = EvilErosionModule.GetEquipOwner(lEquipItemData.id)

					if ownerSoulPrefabPOD == nil then
						hasNum = hasNum + 1
					end
				end
			end

			UGUIUtil.SetText(self.CostItemNumText, EvilErosionEquipStrengthenUIApi:GetString("CostItemNumText", hasNum, costItem1Num))
		end

		self.CostItemSubView2:SetActive(costItem2Num ~= nil)

		if costItem2Num ~= nil then
			local costItem2CfgData = CfgItemTable[costItem2Cid]

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(costItem2CfgData.Icon), self.CostItemIcon2:GetComponent("Image"))

			local hasNum = WarehouseModule.GetItemNumByCfgID(costItem2Cid)

			UGUIUtil.SetText(self.CostItemNumText2, EvilErosionEquipStrengthenUIApi:GetString("CostItemNumText2", hasNum, costItem2Num))
		end
	end

	self.ConfirmBtn:SetActive(not isMaxStar)
end

function EvilErosionEquipStrengthenUI:OnUpgradeStarComplete()
	self:UpdateView(self.ItemData)
end

return EvilErosionEquipStrengthenUI
