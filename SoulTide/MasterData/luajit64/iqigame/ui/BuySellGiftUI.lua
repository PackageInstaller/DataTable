-- chunkname: @IQIGame\\UI\\BuySellGiftUI.lua

local BuySellGiftUI = {
	count = 1,
	max = 0,
	ample = true,
	rewardDatum = {},
	itemCellPool = {}
}

BuySellGiftUI = Base:Extend("BuySellGiftUI", "IQIGame.Onigao.UI.BuySellGiftUI", BuySellGiftUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function BuySellGiftUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, BuySellGiftUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBtnMin, BuySellGiftUIApi:GetString("TextBtnMin"))
	UGUIUtil.SetText(self.TextBtnMax, BuySellGiftUIApi:GetString("TextBtnMax"))
	UGUIUtil.SetText(self.TextBtnBuy, BuySellGiftUIApi:GetString("TextBtnBuy"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnReduce()
		self:OnBtnReduce()
	end

	function self.delegateBtnAdd()
		self:OnBtnAdd()
	end

	function self.delegateBtnMin()
		self:OnBtnMin()
	end

	function self.delegateBtnMax()
		self:OnBtnMax()
	end

	function self.delegateBtnBuy()
		self:OnBtnBuy()
	end

	self.rewardList = self.RewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end
end

function BuySellGiftUI:GetPreloadAssetPaths()
	return nil
end

function BuySellGiftUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuySellGiftUI:IsManualShowOnOpen(userData)
	return false
end

function BuySellGiftUI:GetBGM(userData)
	return nil
end

function BuySellGiftUI:OnOpen(userData)
	self.cfgGroupBuyPack = userData[1]
	self.groupBuyID = userData[2]
	self.count = 1
	self.max = 0

	if self.cfgGroupBuyPack then
		if self.cfgGroupBuyPack.payPoint > 0 then
			self.max = math.floor(PlayerModule.PlayerInfo.baseInfo.payPoint / self.cfgGroupBuyPack.payPoint)
		elseif #self.cfgGroupBuyPack.Price > 0 then
			local id = self.cfgGroupBuyPack.Price[1]
			local price = self.cfgGroupBuyPack.Price[2]
			local haveNum = WarehouseModule.GetItemNumByCfgID(id)

			self.max = math.floor(haveNum / price)
		end
	end

	local buyCount, totalCount = ActiveGroupBuyModule.GetServerBuyCount(self.cfgGroupBuyPack.Id, self.groupBuyID)
	local remainCount = self.cfgGroupBuyPack.TimesLimit - buyCount

	self.max = math.min(self.max, remainCount)

	self:UpdateView()
end

function BuySellGiftUI:OnClose(userData)
	return
end

function BuySellGiftUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnReduce:GetComponent("Button").onClick:AddListener(self.delegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:AddListener(self.delegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.delegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.delegateBtnMax)
	self.BtnBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBuy)
end

function BuySellGiftUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnReduce:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:RemoveListener(self.delegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMax)
	self.BtnBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBuy)
end

function BuySellGiftUI:OnPause()
	return
end

function BuySellGiftUI:OnResume()
	return
end

function BuySellGiftUI:OnCover()
	return
end

function BuySellGiftUI:OnReveal()
	return
end

function BuySellGiftUI:OnRefocus(userData)
	return
end

function BuySellGiftUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuySellGiftUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuySellGiftUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuySellGiftUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuySellGiftUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function BuySellGiftUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.BuySellGiftUI)
end

function BuySellGiftUI:UpdateView()
	self.rewardDatum = {}

	if self.cfgGroupBuyPack then
		for i = 1, #self.cfgGroupBuyPack.Reward, 2 do
			local itemId = self.cfgGroupBuyPack.Reward[i]
			local itemNum = self.cfgGroupBuyPack.Reward[i + 1]

			table.insert(self.rewardDatum, {
				itemId,
				itemNum
			})
		end

		UGUIUtil.SetText(self.TextDesc, self.cfgGroupBuyPack.Name)
		self.rewardList:Refresh(#self.rewardDatum)
		self:ShowMsg()
	end
end

function BuySellGiftUI:OnRenderRewardCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.rewardDatum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.gameObject.transform:Find("Slot/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(data[1], data[2])
end

function BuySellGiftUI:ShowMsg()
	UGUIUtil.SetText(self.TextNum, self.count)

	if self.cfgGroupBuyPack then
		if self.cfgGroupBuyPack.payPoint > 0 then
			self.SellType = Constant.ItemID.ID_PAYPOINT_SHOW
			self.ample = PlayerModule.PlayerInfo.baseInfo.payPoint >= self.count * self.cfgGroupBuyPack.payPoint

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.ImgIcon:GetComponent("Image"))
			UGUIUtil.SetText(self.TextSpend, BuySellGiftUIApi:GetString("TextSpend", self.count * self.cfgGroupBuyPack.payPoint, self.ample))
		elseif #self.cfgGroupBuyPack.Price > 0 then
			self.SellType = Constant.ItemID.TREASURE

			local spendItem = self.cfgGroupBuyPack.Price[1]
			local price = self.cfgGroupBuyPack.Price[2]
			local have = WarehouseModule.GetItemNumByCfgID(spendItem)

			self.ample = have >= self.count * price

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[spendItem].Icon), self.ImgIcon:GetComponent("Image"))
			UGUIUtil.SetText(self.TextSpend, BuySellGiftUIApi:GetString("TextSpend", self.count * price, self.ample))
		end
	end
end

function BuySellGiftUI:OnBtnReduce()
	if self.count > 1 then
		self.count = self.count - 1

		self:ShowMsg()
	end
end

function BuySellGiftUI:OnBtnAdd()
	if self.count < self.max then
		self.count = self.count + 1

		self:ShowMsg()
	end
end

function BuySellGiftUI:OnBtnMin()
	self.count = 1

	self:ShowMsg()
end

function BuySellGiftUI:OnBtnMax()
	self.count = self.max

	if self.count <= 0 then
		self.count = 1
	end

	self:ShowMsg()
end

function BuySellGiftUI:OnBtnBuy()
	if self.SellType == Constant.ItemID.ID_PAYPOINT_SHOW then
		local need = self.count * self.cfgGroupBuyPack.payPoint

		if need > PlayerModule.PlayerInfo.baseInfo.payPoint then
			NoticeModule.MoneyDeficitTip(2, need - PlayerModule.PlayerInfo.baseInfo.payPoint)

			return
		end
	elseif self.SellType == Constant.ItemID.TREASURE then
		local spendItem = self.cfgGroupBuyPack.Price[1]
		local price = self.cfgGroupBuyPack.Price[2]
		local have = WarehouseModule.GetItemNumByCfgID(spendItem)
		local need = self.count * price

		if have < need then
			NoticeModule.MoneyDeficitTip(1, need - have)

			return
		end
	end

	if self.ample then
		ActiveGroupBuyModule.GroupPurchaseBuy(self.groupBuyID, self.cfgGroupBuyPack.Id, self.count)
	end

	self:OnBtnClose()
end

return BuySellGiftUI
