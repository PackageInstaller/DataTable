local LimitShopItemCtrl = BaseClass("LimitShopItemCtrl")
local M = LimitShopItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
    self.UpdateCurrencyHandler = EventMgr:AddListener(UIMessageNames.SHOP_UPDATECURRENCY, Bind(self, self.UpdateCost))
end

function M:_ClickItem(go)
    if not self.data:GetBuyMore(1) then
        return
    end

    --模拟商店数据
    local shopItemConfig = {}
    shopItemConfig.finalItem = self.data:GetCostItemId()
    shopItemConfig.itemId = self.data:GetItemId()
    shopItemConfig.finalNum = self.data:GetCostItemNumber()
    shopItemConfig.num = self.data:GetItemNumber()
    shopItemConfig.buyCount = self.data:GetCfg().times
    self.data.shopItemConfig = shopItemConfig
    self.data.Num = self.data:GetBuyTimes()
    self.data.bLimitShop = true
    UIContextMgr:GetInstance():Show("ComPopupItemBuy", self.data, self.isEnough)
end

function M:UpdateItem(data)
    -- if not data then
    --     return
    -- end
    -- self._view.redpoint:RefreshRedPoint()
    -- self.data = data
    -- local itemId = self.data:GetItemId()
    -- self._view.ItemPfb:SetInfo(itemId, ItemNumberType.TOTLE,self.data:GetItemNumber())
    -- self._view.ItemPfb:EnableClick(false)
    -- self.cfg = ConfigHelper.GetCfg("item", itemId)
    -- self._view.NameText:SetText(self.cfg.name)
    -- self._view.BuyValueText:SetText(tostring(self.data:GetResidualTime()))

    -- if not self.data:GetBuyMore(1) then
    --     self._view.SellOut.gameObject:SetActive(true)
    --     self._view.ItemCanvasGroup:SetAlpha(0.3)
    --     self._view.Normal.gameObject:SetActive(false)
    -- else
    --     self._view.SellOut.gameObject:SetActive(false)
    --     self._view.ItemCanvasGroup:SetAlpha(1)
    --     self._view.Normal.gameObject:SetActive(true)
    -- end

    -- --判断家具商品是否已拥有
    -- if self.cfg.type == 10 then
    --     if OtakuFurniturDataMgr:CheckFurnitureByTemplateId(itemId) then
    --         self.data.type = ShopConst.ShopItemType.Owned
    --     end
    -- end
    -- self:ChangeState(self.data.type)
    -- self:SetCost()
    -- self._view.redpoint:SetParam(0,self.data:GetItemId())
    -- self._view.redpoint:Check()




    self.data = data
    local itemId = data:GetItemId()
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    self._view.stateQuality:SetState(item.quality)
    self._view.imgIcon:SetItemIcon(itemId)
    self._view.labName:SetText(item.name)
    self._view.ComItemSlipCtrl:SetItemById(data:GetCostItemId(), data:GetCostItemNumber())
    self._view.labCanBuyNum:SetText(tostring(data:GetResidualTime()) .. "/" .. data:GetCfg().times)
    self._view.labNum:SetText(tostring(data:GetItemNumber()))
    self._view.tfNull:SetActive(data:GetResidualTime() <= 0)
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
        self._view.DiscountText:SetText(tostring(self.data:GetCostItemNumber()))
        self._view.Alreadyowned.gameObject:SetActive(false)
    end

    if type == ShopConst.ShopItemType.Owned then
        self._view.Discount.gameObject:SetActive(false)
        self._view.Alreadyowned.gameObject:SetActive(true)
    end
end

function M:UpdateCost(itemId, Stack)
    if itemId == self.data:GetCostItemId() then
        self:SetCost(Stack)
    end
end

function M:SetCost(Stack)
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(self.data:GetCostItemId())
    self.finalCfg = ConfigHelper.GetCfg("item", self.data:GetCostItemId())

    if self.finalCfg ~= nil then
        self._view.ComItemSlipCtrl:SetItemById(self.data:GetCostItemId(), self.data:GetCostItemNumber())
        if self.data:GetCostItemNumber() == 0 then
            self._view.ComItemSlipCtrl.txt_value:SetText(5083)
            self.isEnough = true
        else
            if itemNum > 0 then
                local num = itemNum
                if Stack then
                    num = Stack
                end
                if num >= self.data:GetCostItemNumber() then
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

return LimitShopItemCtrl
