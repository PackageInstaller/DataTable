-- chunkname: @IQIGame\\UI\\ConvertUI.lua

local ConvertUI = {
	curAddCount = 0,
	proportion = 0,
	needFreeDiamondCount = 0
}

ConvertUI = Base:Extend("ConvertUI", "IQIGame.Onigao.UI.ConvertUI", ConvertUI)

function ConvertUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		UIModule.Close(Constant.UIControllerName.ConvertUI)
	end

	function self.DelegateOnClickAddBtn()
		self:OnAddOrReduceBtnClick(true)
	end

	function self.DelegateOnClickReduceBtn()
		self:OnAddOrReduceBtnClick(false)
	end

	function self.DelegateOnClickMaxBtn()
		self:OnMaxOrMinBtnClick(true)
	end

	function self.DelegateOnClickMinBtn()
		self:OnMaxOrMinBtnClick(false)
	end

	function self.DelegateInputValueChanged(value)
		self:InputOnValueChanged(value)
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateBuyItemResultEvent()
		self:BuyItemResultEvent()
	end

	self.freeDiamondInputField = self.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.AddBtnComponent = self.AddBtn:GetComponent("Button")
	self.ReduceBtnComponent = self.ReduceBtn:GetComponent("Button")
	self.MAXBtnComponent = self.MAXBtn:GetComponent("Button")
	self.MinBtnComponent = self.MinBtn:GetComponent("Button")
	self.AffirmBtnComponent = self.AffirmBtn:GetComponent("Button")
	self.AffirmGrayComponent = self.AffirmBtn:GetComponent("GrayComponent")

	UGUIUtil.SetText(self.TitleText, ConvertUIApi:GetUITitle())
	UGUIUtil.SetText(self.ConverTitleText, ConvertUIApi:GetConvertTitle())
	UGUIUtil.SetText(self.Title, ConvertUIApi:GetConsumeTitle())
	UGUIUtil.SetTextsInChildren(self.CancelBtn, ConvertUIApi:GetCancelBtnTitle())
	UGUIUtil.SetTextsInChildren(self.AffirmBtn, ConvertUIApi:GetConvertBtnTitle())
	UGUIUtil.SetTextsInChildren(self.MAXBtn, ConvertUIApi:GetMaxBtnTitle())
	UGUIUtil.SetTextsInChildren(self.MinBtn, ConvertUIApi:GetMinBtnTitle())
end

function ConvertUI:GetPreloadAssetPaths()
	return nil
end

function ConvertUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ConvertUI:IsManualShowOnOpen(userData)
	return false
end

function ConvertUI:GetBGM(userData)
	return nil
end

function ConvertUI:OnOpen(needFreeDiamondCount)
	self.needFreeDiamondCount = nil

	if needFreeDiamondCount ~= nil then
		self.needFreeDiamondCount = needFreeDiamondCount
	end

	self:SetData()
	self:InitShowInfo()
end

function ConvertUI:OnClose(userData)
	return
end

function ConvertUI:OnAddListeners()
	self.AddBtnComponent.onClick:AddListener(self.DelegateOnClickAddBtn)
	self.ReduceBtnComponent.onClick:AddListener(self.DelegateOnClickReduceBtn)
	self.MAXBtnComponent.onClick:AddListener(self.DelegateOnClickMaxBtn)
	self.MinBtnComponent.onClick:AddListener(self.DelegateOnClickMinBtn)
	self.AffirmBtnComponent.onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.freeDiamondInputField.onEndEdit:AddListener(self.DelegateInputValueChanged)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function ConvertUI:OnRemoveListeners()
	self.AddBtnComponent.onClick:RemoveListener(self.DelegateOnClickAddBtn)
	self.ReduceBtnComponent.onClick:RemoveListener(self.DelegateOnClickReduceBtn)
	self.MAXBtnComponent.onClick:RemoveListener(self.DelegateOnClickMaxBtn)
	self.MinBtnComponent.onClick:RemoveListener(self.DelegateOnClickMinBtn)
	self.AffirmBtnComponent.onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.freeDiamondInputField.onEndEdit:RemoveListener(self.DelegateInputValueChanged)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function ConvertUI:OnPause()
	return
end

function ConvertUI:OnResume()
	return
end

function ConvertUI:OnCover()
	return
end

function ConvertUI:OnReveal()
	return
end

function ConvertUI:OnRefocus(userData)
	return
end

function ConvertUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ConvertUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ConvertUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ConvertUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ConvertUI:OnDestroy()
	self.ChargeIconCell:Dispose()
	self.FreeIconCell:Dispose()
	self.IconCell_2:Dispose()
end

function ConvertUI:InitShowInfo()
	UGUIUtil.SetText(self.ChargeTitleText, CfgItemTable[self.buyPricesCfg[1]].Name)
	UGUIUtil.SetText(self.FreeTitleText, CfgItemTable[self.shopItemCfg.ItemId].Name)

	self.ChargeIconCell = ItemCell.New(self.ChargeIconImg, false)

	self.ChargeIconCell:SetItem(ItemData.CreateByCIDAndNumber(self.buyPricesCfg[1], 0))

	self.FreeIconCell = ItemCell.New(self.FreeIconImg, false)

	self.FreeIconCell:SetItem(ItemData.CreateByCIDAndNumber(self.shopItemCfg.ItemId, 0))

	self.IconCell_2 = ItemCell.New(self.IconImg, false)

	self.IconCell_2:SetItem(ItemData.CreateByCIDAndNumber(self.buyPricesCfg[1], 0))
end

function ConvertUI:SetData()
	self.shopData = ShopModule.GetShopDataWithShopID(Constant.ShopType.Diamond)

	local commodityCfg = ShopModule.findOneByCommodityByShopId(self.shopData.id)

	self.shopItemData = self.shopData.itemDic[commodityCfg.Id]
	self.shopItemCfg = self.shopItemData.config
	self.buyPricesCfg = self.shopItemCfg.Price[1]
	self.allPayDiamondNum = WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.TOLL_MONEY)
	self.proportion = self.shopItemCfg.Number / self.buyPricesCfg[2]
	self.maxUseCount = math.floor(self.allPayDiamondNum / self.buyPricesCfg[2])

	if self.needFreeDiamondCount ~= nil then
		local need = math.ceil(self.needFreeDiamondCount / self.proportion)

		if need >= self.maxUseCount then
			self.curAddCount = self.maxUseCount
		else
			self.curAddCount = need
		end

		self.needFreeDiamondCount = nil
	else
		self.curAddCount = 1
	end

	self:UpdateSelectNum()
end

function ConvertUI:RefreshExChangeInfo()
	local payDiamondNum = self.buyPricesCfg[2] * self.curAddCount
	local freeDiamondNum = payDiamondNum * self.proportion

	UGUIUtil.SetText(self.ChargeNumText, "×" .. payDiamondNum)
	UGUIUtil.SetText(self.FreeNumText, "×" .. freeDiamondNum)
	UGUIUtil.SetText(self.ExpendNum, payDiamondNum)
	UGUIUtil.SetText(self.AllNum, "/" .. self.allPayDiamondNum)

	local isEnough = self:MoneyIsEnough()

	if isEnough then
		UGUIUtil.SetText(self.ExpendNum, "<color=#FFFFFF>" .. payDiamondNum .. "</color>")
		UGUIUtil.SetText(self.AllNum, "<color=#FFFFFF>/" .. self.allPayDiamondNum .. "</color>")
	else
		UGUIUtil.SetText(self.ExpendNum, "<color=#E04A37>" .. payDiamondNum .. "</color>")
		UGUIUtil.SetText(self.AllNum, "<color=#E04A37>/" .. self.allPayDiamondNum .. "</color>")
	end
end

function ConvertUI:OnAddOrReduceBtnClick(isAdd)
	self.curAddCount = isAdd and self.curAddCount + 1 or self.curAddCount - 1

	if self.curAddCount >= self.maxUseCount then
		self.curAddCount = self.maxUseCount
	end

	if self.curAddCount <= 0 then
		self.curAddCount = 0
	end

	self:UpdateSelectNum()
end

function ConvertUI:OnMaxOrMinBtnClick(isMax)
	self.curAddCount = isMax and self.maxUseCount or 0

	self:UpdateSelectNum()
end

function ConvertUI:RefreshBtnState()
	self.AddBtnComponent.interactable = self.curAddCount < self.maxUseCount
	self.ReduceBtnComponent.interactable = self.curAddCount > 0
	self.MAXBtnComponent.interactable = self.curAddCount < self.maxUseCount
	self.MinBtnComponent.interactable = self.curAddCount > 0
end

function ConvertUI:InputOnValueChanged(value)
	if value == "" or value == nil then
		self.curAddCount = 0
	else
		local count = math.floor(tonumber(value) / self.proportion)

		if count >= self.maxUseCount then
			count = self.maxUseCount
		end

		self.curAddCount = count
	end

	self:UpdateSelectNum()
end

function ConvertUI:UpdateSelectNum()
	self.freeDiamondInputField.text = self.curAddCount * self.proportion

	self:RefreshExChangeInfo()
	self:RefreshBtnState()
end

function ConvertUI:MoneyIsEnough()
	local money = self.curAddCount * self.shopItemCfg.Number / self.proportion

	return money <= self.allPayDiamondNum, money
end

function ConvertUI:OnClickConfirmBtn()
	local isEnough, money = self:MoneyIsEnough()

	if not isEnough or money == 0 then
		NoticeModule.ShowNotice(21044004, function()
			UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
				Constant.ShopType.SoulStone.Type,
				enterType = Constant.ShopEnterType.Normal
			})
			UIModule.Close(Constant.UIControllerName.ConvertUI)
		end)

		return
	end

	if self.curAddCount <= 0 then
		return
	end

	ShopModule.BuyItemRequest(self.shopItemData.cid, self.curAddCount)
end

function ConvertUI:BuyItemResultEvent()
	UIModule.CloseSelf(self)
end

return ConvertUI
