local M = BaseClass("PassShopItemCtrl")

function M:__init(view)
    self._view = view
    self.m_passShop = nil
    self.m_isPaid = true -- 是否付费
    self.m_shopItemPfbs = { self._view.shopItem }
    self._view.btn_buyState:onClick(Bind(self, self.OnClickBuy))
end

function M:OnDispose()
    for _, value in ipairs(self.m_shopItemPfbs) do
        value:OnDispose()
    end
    self.m_passShop = nil
    self.m_shopItemPfbs = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:SetShopPackInfo(info)
    self.m_passShop = info
    self:_SetButtonState()
    self:_SetTextAndPic()
    self:_SetItemsPfb()
end

function M:OnClickBuy(go)
    if self.m_isPaid or not self.m_passShop then
        return
    end

    SDKHelper.Pay(self.m_passShop.payId, function(isOk)
        if not isOk then
            GameHelper.TipsById(5789) -- 充值失败
            return
        end
        -- 此版本先本地记录，下个版本服务器记录 /20230110
        -- PlayerPrefTools.SetPlayerPrefs("BuyPassCard", self.m_passShop.id)
    end)
end

function M:_SetTextAndPic()
    local symbol = ConfigHelper.GetLocalString(543)
    local price = math.floor(self.m_passShop.price / 100) -- 熊伟：此版本向下取整
    local discount = math.floor(self.m_passShop.discount / 100)
    local isDsc = discount > 0
    local present = isDsc and discount or price
    self._view.discountTips:SetActive(isDsc)
    self._view.txt_original:SetActive(isDsc)
    self._view.txt_original:SetText(symbol .. price)
    self._view.txt_present:SetText(symbol .. present)
    self._view.img_headIcon:SetPic(self.m_passShop.showHerd)
    local fmtStr = ConfigHelper.GetLocalString(self.m_passShop.showHerdTitle)
    local name = ConfigHelper.GetLocalString(self.m_passShop.showName)
    self._view.txt_showTitle:SetText(string.format(fmtStr, name))
end

function M:_SetItemsPfb()
    self._view.shopItem.uiState:SetState(2)
    self._view.shopItem.txt_desc:SetText(5788)
    local items = self:_GetItems(self.m_passShop.items)
    local numType = ItemNumberType.TOTLE
    for i, value in ipairs(items) do
        local itemView = self:_GetItemPfb(i + 1)
        itemView.uiState:SetState(1)
        itemView.txt_desc:SetItemName(value.id)
        itemView.item:SetInfo(value.id, numType, value.num)
    end
end

function M:_SetButtonState()
    self.m_isPaid = PassDataMgr:GetInstance():IsPaid()
    -- local passShopId = PlayerPrefTools.GetPlayerPrefsInt("BuyPassCard", 0)
    -- local isBuyCur = passShopId == self.m_passShop.id
    -- self._view.btn_buyState:SetState(self.m_isPaid and (isBuyCur and 2 or 3) or 1)
    self._view.btn_buyState:SetState(self.m_passShop.state)
end

function M:_GetItems(groupIds)
    local items = {}
    for _, groupId in ipairs(groupIds or {}) do
        local itemGroup = ConfigHelper.GetCfg("itemGroup", groupId)
        if itemGroup then
            for i, id in ipairs(itemGroup.items) do
                local num = itemGroup.cnts[i]
                local item = { id = id, num = num }
                table.insert(items, item)
            end
        else
            Logger.LogError("itemGroup is nil. id = " .. groupId)
        end
    end
    return items
end

function M:_GetItemPfb(idx)
    local itemView = self.m_shopItemPfbs[idx]
    if not itemView then
        itemView = self.m_shopItemPfbs[1]:Instantiate()
        itemView.item:EnablePopItem(true)
        self.m_shopItemPfbs[idx] = itemView
    end
    return itemView
end

return M
