-- chunkname: @IQIGame\\UI\\Tips\\ItemTipController.lua

local m = {
	forShow = true,
	itemNum = 0,
	showJewelryNode = false,
	jewelryAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ItemInfoCell = require("IQIGame.UI.Tips.ItemInfoCell")
local ItemTipContent = require("IQIGame.UI.Tips.ItemTipContent")
local JewelryAttrCell = require("IQIGame.UI.Jewelry.JewelryAttrCell")

function m.New(view, onUse, lateUseCall)
	local obj = Clone(m)

	obj:Init(view, onUse, lateUseCall)

	return obj
end

function m:Init(view, onUse, lateUseCall)
	self.View = view
	self.OnUseCallback = onUse
	self.OnLateUseCall = lateUseCall

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfDesc = self.goDesc:GetComponent("Text")
	self.contentView = ItemTipContent.New(self.goDetail)
	self.infoCell = ItemInfoCell.New(self.goInfoCell)
	self.btnUse = self.goBtnUse:GetComponent("Button")

	function self.onClickBtnUseDelegate()
		self:OnClickBtnUse()
	end

	function self.delegateJewelryStarBtn()
		self:OnJewelryStarBtn()
	end

	function self.delegateJewelryRebirthBtn()
		self:OnJewelryRebirthBtn()
	end

	function self.DelegateJewelryComeBtn()
		self:OnJewelryComeBtn()
	end

	self.goBtnUse.transform:Find("Text"):GetComponent("Text").text = ItemTipsApi:GetString("goBtnUse")

	self.JewelryAttrMould:SetActive(false)

	self.jewelryAttrCellPool = UIObjectPool.New(4, function()
		return JewelryAttrCell.New(UnityEngine.Object.Instantiate(self.JewelryAttrMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListeners()
	self.btnUse.onClick:AddListener(self.onClickBtnUseDelegate)

	if self.JewelryStarBtn then
		self.JewelryStarBtn:GetComponent("Button").onClick:AddListener(self.delegateJewelryStarBtn)
	end

	if self.JewelryRebirthBtn then
		self.JewelryRebirthBtn:GetComponent("Button").onClick:AddListener(self.delegateJewelryRebirthBtn)
	end

	if self.JewelryComeBtn then
		self.JewelryComeBtn:GetComponent("Button").onClick:AddListener(self.DelegateJewelryComeBtn)
	end
end

function m:RemoveListeners()
	self.btnUse.onClick:RemoveListener(self.onClickBtnUseDelegate)

	if self.JewelryStarBtn then
		self.JewelryStarBtn:GetComponent("Button").onClick:RemoveListener(self.delegateJewelryStarBtn)
	end

	if self.JewelryRebirthBtn then
		self.JewelryRebirthBtn:GetComponent("Button").onClick:RemoveListener(self.delegateJewelryRebirthBtn)
	end

	if self.JewelryComeBtn then
		self.JewelryComeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateJewelryComeBtn)
	end
end

function m:SetData(data, forShow, hideSource)
	self:RefreshDatum(data, forShow)
	self:RefreshMisc()
	self.infoCell:RefreshView(self.itemData, self.itemNum)
	self.contentView:RefreshView(self.itemData, self, hideSource or PlayerModule.InMaze)
	self:RefreshJewelry()
end

function m:RefreshDatum(data, forShow)
	self.itemData = data

	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 0)
	end

	local hasNum

	if PlayerModule.InMaze then
		hasNum = MazeDataModule.GetItemNumByCfgID(self.itemData.cid)
	else
		hasNum = WarehouseModule.GetItemNumByCfgID(self.itemData.cid)
	end

	self.itemNum = hasNum
	self.cfgItemData = CfgItemTable[self.itemData.cid]
	self.forShow = forShow
end

function m:RefreshMisc()
	if self.cfgItemData.Type == Constant.ItemType.JewelryEquip then
		local cfgJewelryQualityData = self.itemData.jewelryData:GetJewelryQualityData()

		if cfgJewelryQualityData then
			AssetUtil.LoadImage(self, ItemTipsApi:GetString("goQualityImage", cfgJewelryQualityData.Quality), self.goQualityBg:GetComponent("Image"))
		end
	else
		AssetUtil.LoadImage(self, ItemTipsApi:GetString("goQualityImage", self.cfgItemData.Quality), self.goQualityBg:GetComponent("Image"))
	end

	self.tfDesc.text = ItemTipsApi:GetString("goDesc", self.cfgItemData.Describe)

	local canUse = not self.forShow and not self.itemData:IsExpired() and (ItemModule.IsInCorrectUseArea(self.cfgItemData) or ItemModule.IsOptionalGift(self.cfgItemData))

	self.goBtnUse:SetActive(canUse)
end

function m:RefreshJewelry()
	local isOldJewelry = self.cfgItemData.Type == Constant.ItemType.Jewelry
	local isNewJewelry = self.cfgItemData.Type == Constant.ItemType.JewelryEquip
	local isWearing = false

	if isNewJewelry then
		isWearing = #self.itemData.jewelryData.newJewelryEquipmentVoPOD.soul > 0
	end

	if self.JewelryComeBtn then
		self.JewelryComeBtn:SetActive(isOldJewelry)
	end

	self.JewelryBtnNode:SetActive((isOldJewelry or isNewJewelry) and self.showJewelryNode)
	self.JewelryNode:SetActive(isOldJewelry or isNewJewelry)
	self.DetailNode:SetActive(not isOldJewelry and not isNewJewelry)
	self.JewelryRebirthBtn:SetActive(false)
	self.JewelryStarBtn:SetActive(false)

	if self.JewelryTitle then
		self.JewelryTitle:SetActive(self.cfgItemData.Id ~= Constant.ItemID.JEWELRY_STAR_MATERIAL)
	end

	local JewelryPabilityID = 0

	if self.cfgItemData.Type == Constant.ItemType.Jewelry then
		self.JewelryRebirthBtn:SetActive(self.cfgItemData.Star > 1 and self.cfgItemData.Id ~= Constant.ItemID.JEWELRY_STAR_MATERIAL)

		JewelryPabilityID = self.cfgItemData.JewelryPabilityID
	elseif self.cfgItemData.Type == Constant.ItemType.JewelryEquip then
		self.JewelryRebirthBtn:SetActive(self.itemData.jewelryData.newJewelryEquipmentVoPOD.star > 1 and self.cfgItemData.Id ~= Constant.ItemID.JEWELRY_STAR_MATERIAL and not isWearing)
		self.JewelryStarBtn:SetActive(self.itemData.jewelryData.newJewelryEquipmentVoPOD.star < JewelryModule.JewelryMaxStarLv and self.cfgItemData.Id ~= Constant.ItemID.JEWELRY_STAR_MATERIAL)

		local cfgJewelryQualityData = self.itemData.jewelryData:GetJewelryQualityData()

		if cfgJewelryQualityData then
			JewelryPabilityID = cfgJewelryQualityData.JewelryPabilityID
		end
	end

	for i, v in pairs(self.jewelryAttrCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.jewelryAttrCellPool:Release(v)
	end

	self.jewelryAttrCells = {}

	if JewelryPabilityID > 0 then
		local cell = self.jewelryAttrCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.JewelryAttrContent.transform, false)
		cell:SetData(JewelryPabilityID)
		table.insert(self.jewelryAttrCells, cell)
	end
end

function m:OnClickBtnUse()
	if self.OnLateUseCall ~= nil then
		self.OnLateUseCall(self.itemData)

		return
	end

	local canUse, errorMsg, ignoreRedPoint

	if ItemModule.IsInCorrectUseArea(self.cfgItemData) then
		canUse, errorMsg, ignoreRedPoint = ItemModule.CheckCanUse(self.itemData, 1)

		if canUse then
			if self.cfgItemData.UseType == 2 and (self.itemData.num > 1 or self.itemData:GetLeftUseCount() > 1) then
				if ItemModule.CheckUseCostNumEnough(self.itemData:GetCfg()) then
					UIModule.Open(Constant.UIControllerName.UseNumberUI, Constant.UILayer.Tooltip, self.itemData)
				else
					NoticeModule.ShowNoticeNoCallback(21045009)

					return
				end
			else
				ItemModule.UseItem(self.itemData, 1)
			end
		end
	elseif ItemModule.IsOptionalGift(self.cfgItemData) then
		canUse, errorMsg = WarehouseModule.CheckCanUse(self.itemData, 1)

		if canUse then
			UIModule.Open(Constant.UIControllerName.GiftChoosePanelUI, Constant.UILayer.UI, {
				itemData = self.itemData
			})
		end
	end

	if canUse then
		if self.OnUseCallback ~= nil then
			self.OnUseCallback()
		end
	elseif errorMsg ~= nil then
		NoticeModule.ShowNoticeNoCallback(21040005, errorMsg)
	end
end

function m:OnJewelryStarBtn()
	UIModule.Open(Constant.UIControllerName.JewelryStrengthenUI, Constant.UILayer.UI, {
		ItemData = self.itemData
	})
end

function m:OnJewelryRebirthBtn()
	UIModule.Open(Constant.UIControllerName.JewelryDecomposeUI, Constant.UILayer.UI, {
		ItemData = self.itemData
	})
end

function m:OnJewelryComeBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.MiningShop)
end

function m:Dispose()
	self.OnUseCallback = nil
	self.OnLateUseCall = nil

	AssetUtil.UnloadAsset(self)
	self.infoCell:OnDestroy()
	self.contentView:OnDestroy()

	for i, v in pairs(self.jewelryAttrCells) do
		self.jewelryAttrCellPool:Release(v)
	end

	self.jewelryAttrCells = {}

	self.jewelryAttrCellPool:Dispose()

	self.jewelryAttrCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.tfDesc = nil
	self.btnUse = nil
end

return m
