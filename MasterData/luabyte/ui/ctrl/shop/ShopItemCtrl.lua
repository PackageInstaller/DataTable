local ShopItemCtrl = BaseClass("ShopItemCtrl")
local M = ShopItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
    self.UpdateCurrencyHandler = EventMgr:AddListener(UIMessageNames.SHOP_UPDATECURRENCY, Bind(self, self.UpdateCost))
end

function M:_ClickItem(go)
    if self.data.Num == self.data.shopItemConfig.buyCount or self.data.type == ShopConst.ShopItemType.Owned then
        return
    end
    UIContextMgr:GetInstance():Show("ComPopupItemBuy", self.data, self.isEnough)
end

function M:UpdateItem(data)
    if not data then
        return
    end
    self._view.redpoint:RefreshRedPoint()
    self.data = data
    local itemId = self.data.shopItemConfig.itemId
    self._view.ItemPfb:SetInfo(itemId, ItemNumberType.TOTLE, self.data.shopItemConfig.num)
    self._view.ItemPfb:EnableClick(false)
    self.cfg = ConfigHelper.GetCfg("item", itemId)
    self._view.NameText:SetText(self.cfg.name)
    self._view.BuyValueText:SetText(tostring(self.data.shopItemConfig.buyCount - self.data.Num))

    if self.data.Num == self.data.shopItemConfig.buyCount then
        self._view.SellOut.gameObject:SetActive(true)
        self._view.ItemCanvasGroup:SetAlpha(0.3)
        self._view.Normal.gameObject:SetActive(false)
    else
        self._view.SellOut.gameObject:SetActive(false)
        self._view.ItemCanvasGroup:SetAlpha(1)
        self._view.Normal.gameObject:SetActive(true)
    end

    --判断家具商品是否已拥有
    if self.cfg.type == 10 then
        if OtakuFurniturDataMgr:CheckFurnitureByTemplateId(itemId) then
            self.data.type = ShopConst.ShopItemType.Owned
        end
    end
    self:ChangeState(self.data.type)
    self:SetCost()
    self._view.redpoint:SetParam(0,self.data.shopItemConfig.id)
    self._view.redpoint:Check()
end

function M:ChangeState(type)
    if type == ShopConst.ShopItemType.Normal then
        self._view.Discount.gameObject:SetActive(false)
        self._view.Alreadyowned.gameObject:SetActive(false)
    end

    if type == ShopConst.ShopItemType.Free then
        self._view.Discount.gameObject:SetActive(false)
        self._view.Alreadyowned.gameObject:SetActive(false)
    end

    if type == ShopConst.ShopItemType.Discount then
        self._view.Discount.gameObject:SetActive(true)
        self._view.DiscountText:SetText(tostring(self.data.shopItemConfig.discount))
        self._view.Alreadyowned.gameObject:SetActive(false)
    end

    if type == ShopConst.ShopItemType.Owned then
        self._view.Discount.gameObject:SetActive(false)
        self._view.Alreadyowned.gameObject:SetActive(true)
    end
end

function M:UpdateCost(itemId, Stack)
    if itemId == self.data.shopItemConfig.finalItem then
        self:SetCost(Stack)
    end
end

function M:SetCost(Stack)
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(self.data.shopItemConfig.finalItem)
    self.finalCfg = ConfigHelper.GetCfg("item", self.data.shopItemConfig.finalItem)

    if self.finalCfg ~= nil then
        self._view.CostIcon:SetPic(self.finalCfg.icon)
        if self.data.shopItemConfig.finalNum == 0 then
            self._view.CostText:SetText(5083)
            self.isEnough = true
        else
            self._view.CostText:SetText(tostring(self.data.shopItemConfig.finalNum))
            if itemNum > 0 then
                local num = itemNum
                if Stack then
                    num = Stack
                end
                if num >= self.data.shopItemConfig.finalNum then
                    self.isEnough = true
                else
                    self.isEnough = false
                end
            else
                self.isEnough = false
            end
        end
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.SHOP_UPDATECURRENCY, self.UpdateCurrencyHandler)
    self.UpdateCurrencyHandler = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return ShopItemCtrl
