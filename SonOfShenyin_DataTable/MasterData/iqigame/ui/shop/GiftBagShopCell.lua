-- chunkname: @IQIGame\\UI\\Shop\\GiftBagShopCell.lua

local GiftBagShopCell = {}

function GiftBagShopCell.New(go, mainView)
	local o = Clone(GiftBagShopCell)

	o:Initialize(go, mainView)

	return o
end

function GiftBagShopCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()

	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:CheckTime()
		end, 1, -1)

		self.Timer:Start()
	end
end

function GiftBagShopCell:InitComponent()
	self.buyButton = self.ImgButton:GetComponent("Button")
	self.imageItem = self.imageIcon:GetComponent("Image")

	if self.textDiscountNum ~= nil then
		local textTrans = self.textDiscountNum.gameObject:GetComponent("RectTransform")

		textTrans.pivot = Vector2.New(textTrans.pivot.x, 0.5)
	end
end

function GiftBagShopCell:AddListener()
	self.buyButton.onClick:AddListener(self.OnGotoBuyClicked)
	self.imageItem:GetComponent("Button").onClick:AddListener(self.imageItemDelegate)
end

function GiftBagShopCell:RemoveListener()
	self.buyButton.onClick:RemoveListener(self.OnGotoBuyClicked)
	self.imageItem:GetComponent("Button").onClick:RemoveListener(self.imageItemDelegate)
end

function GiftBagShopCell:Refresh(data)
	self.Data = data

	if not self.Data.isShow then
		LuaUtility.SetGameObjectShow(self.gameObject, false)

		return
	end

	local cfgItem = CfgUtil.GetItemCfgDataWithID(self.Data.config.ItemId)

	if self.Data.config.Number > 1 then
		LuaUtility.SetText(self.textItemName, string.format("%s×%s", cfgItem.Name, tostring(self.Data.config.Number)))
	else
		LuaUtility.SetText(self.textItemName, cfgItem.Name)
	end

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), self.imageIcon:GetComponent("Image"), function()
		return
	end)
	LuaUtility.LoadImage(self, ShopUIApi:GetBottomFrameImagePath(cfgItem.Quality), self.BottomBG:GetComponent("Image"), function()
		return
	end)
	self:Reset()
	self:CheckTime()
	self:CheckBuyLimit()
	self:CheckDiscount()
	self:SetRedDotState()
	self:CheckBuyCondition()

	self.refreshLayoutTime = Timer.New(function()
		LuaUtility.SetGameObjectShow(self.textDiscountNum, not self.Data.config.Free)

		self.textDiscountNum:GetComponent("Text").enabled = true

		local layoutGroup = self:__GetHorizontalLayoutGroup()

		if layoutGroup ~= nil then
			layoutGroup.childControlWidth = true
			layoutGroup.enabled = true
		end
	end, 0.5, 1)

	self.refreshLayoutTime:Start()
end

function GiftBagShopCell:__GetHorizontalLayoutGroup()
	if self.PriceLayoutRoot ~= nil then
		return self.PriceLayoutRoot.gameObject:GetComponent("HorizontalLayoutGroup")
	else
		return self.textDiscountNum.gameObject.transform.parent:GetComponent("HorizontalLayoutGroup")
	end
end

function GiftBagShopCell:Reset()
	LuaUtility.SetGameObjectShow(self.discountRoot, false)
	LuaUtility.SetGameObjectShow(self.timeRoot, false)
	LuaUtility.SetGameObjectShow(self.residueRoot, false)
	LuaUtility.SetGameObjectShow(self.textDiscountNum, false)
	LuaUtility.SetGameObjectShow(self.SellOutRoot, false)
	LuaUtility.SetGameObjectShow(self.imagePriceDelete, false)

	if self.refreshLayoutTime ~= nil then
		self.refreshLayoutTime:Stop()

		self.refreshLayoutTime = nil
	end

	local layoutGroup = self:__GetHorizontalLayoutGroup()

	if layoutGroup ~= nil then
		layoutGroup.enabled = false
	end

	self.textDiscountNum:GetComponent("Text").enabled = false
end

function GiftBagShopCell:CheckTime()
	if self.Data.refreshType ~= Constant.ShopRefreshType.None then
		LuaUtility.SetGameObjectShow(self.timeRoot, true)
		LuaUtility.SetText(self.textTime, self.Data:GetRefreshTimeText())
	end
end

function GiftBagShopCell:CheckDiscount()
	LuaUtility.SetGameObjectShow(self.textDiscountNum, not self.Data.config.Free)
	LuaUtility.SetGameObjectShow(self.freeText, self.Data.config.Free)

	if self.Data.config.Free then
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, false)
		LuaUtility.SetText(self.textDiscountNum, ShopUIApi:GetFreeText())
		LuaUtility.SetEmptyText(self.textPriceNum)
	else
		AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.Data:GetPriceIconId()), self.imageCurrencyIcon:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, true)
		LuaUtility.SetEmptyText(self.textPriceNum)

		if self.Data.isDiscount and not self.Data.isDiscountWithoutPrice then
			LuaUtility.SetGameObjectShow(self.discountRoot, true)
			LuaUtility.SetText(self.textDiscountNum, self.Data:GetDiscount())
		else
			LuaUtility.SetText(self.textDiscountNum, self.Data:GetPrice())
		end

		LuaUtility.SetGameObjectShow(self.discountRoot, self.Data.isDiscount)

		if self.Data.isDiscount then
			LuaUtility.SetText(self.textDiscount, self.Data:GetDiscountPercentText())
		end
	end
end

function GiftBagShopCell:CheckBuyLimit()
	if self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit then
		LuaUtility.SetGameObjectShow(self.residueRoot, true)

		if self.Data.buyNum < self.Data.buyLimit then
			LuaUtility.SetText(self.textLimitTag, ShopUIApi:PurchaseLimitation(self.Data.buyNum, self.Data.buyLimit))
		else
			LuaUtility.SetGameObjectShow(self.SellOutRoot, true)
			LuaUtility.SetText(self.textLimitTag, ShopUIApi:GetZeroLimitation(math.max(0, self.Data.buyLimit - self.Data.buyNum), self.Data.buyLimit))
		end

		LuaUtility.SetText(self.textLimitText, self.Data:GetLimitText())
	end
end

function GiftBagShopCell:CheckBuyCondition()
	if not self.Data.isBuy and self.Data.buyConditionId ~= nil then
		UGUIUtil.SetText(self.conditionText, CfgConditionTable[self.Data.buyConditionId].Name)
		LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	end
end

function GiftBagShopCell:InitDelegate()
	function self.OnGotoBuyClicked()
		self:OnClickGotoBuy()
	end

	function self.imageItemDelegate()
		self:OnImageItemClick()
	end
end

function GiftBagShopCell:OnClickGotoBuy()
	UIModule.Open(Constant.UIControllerName.BuyResItemUI, Constant.UILayer.UI, {
		data = self.Data
	})
end

function GiftBagShopCell:OnImageItemClick()
	local ItemData = ItemData.CreateByCIDAndNumber(self.Data.config.ItemId, 0)

	ItemModule.OpenTipByData(ItemData, true)
end

function GiftBagShopCell:SetRedDotState()
	LuaUtility.SetGameObjectShow(self.RedDot, self.Data.config.Free and self.Data.buyNum < self.Data.buyLimit and self.Data.isBuy)
end

function GiftBagShopCell:Dispose()
	if self.refreshLayoutTime ~= nil then
		self.refreshLayoutTime:Stop()

		self.refreshLayoutTime = nil
	end

	self:RemoveListener()

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

return GiftBagShopCell
