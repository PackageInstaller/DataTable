local M = BaseClass("UIPassShopItemCtrl")

function M:__init(view)
    self._view = view
    self.m_passShop = nil
    self._view.ItemPfbView:EnablePopItem(true)
    self.m_shopItemPfbs = { self._view.ItemPfbView }
    self._view.btn_buyState:onClick(Bind(self, self.OnClickBuy))
end

function M:OnDispose()
    for _, v in ipairs(self.m_shopItemPfbs) do v:DoDispose() end
    self.m_shopItemPfbs = nil
    self.m_passShop = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:SetShopPackInfo(info)
    self.m_passShop = info
    self:_SetTextAndPic()
    self:_SetItemsPfb()
    self:_SetDescState()
    self._view.btn_buyState:SetState(self.m_passShop.state)
end

function M:OnClickBuy(go)
    if self.m_passShop.state ~= 1 then return end

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
    local price = string.format("%d", self.m_passShop.price / 100) -- 熊伟：此版本向下取整
    local discount = self.m_passShop.discount / 100
    local isDsc = discount > 0
    local present = isDsc and discount or price
    self._view.discountTips:SetActive(isDsc)
    self._view.txt_original:SetActive(isDsc)
    -- discount = string.format("%.2f", self.m_passShop.discount / 10000)
    -- if string.sub(price, -1) == "0" then price = string.sub(price, 1, -2) end
    -- if string.sub(present, -1) == "0" then present = string.sub(present, 1, -2) end
    self._view.txt_original:SetText(string.format("%s%s", symbol, price))
    self._view.txt_present:SetText(string.format("%s%s", symbol, present))
    self._view.txt_title:SetText(self.m_passShop.showHerdTitle)
    self._view.txt_titleEn:SetText(self.m_passShop.showSubtitle)
end

function M:_SetItemsPfb()
    local items = self:_GetItems(self.m_passShop.showGetItems)
    local numType = ItemNumberType.TOTLE
    for i, v in ipairs(items) do -- 奖励汇总
        local itemView = self:_GetItemPfb(i)
        itemView:SetInfo(v.id, numType, v.num)
        itemView:SetFinish(self.m_passShop.state == 2)
    end
    for _, groupId in ipairs(self.m_passShop.items) do -- 显示第一个
        local itemGroup = ConfigHelper.GetCfg("itemGroup", groupId)
        if itemGroup then
            for i, id in ipairs(itemGroup.items) do
                local num = itemGroup.cnts[i]
                self._view.itemSlip:SetItemById(id, num, nil, false)
                self._view.itemPfbSlip:SetItemById(id, num, nil, false)
                return
            end
        else
            Logger.LogError("itemGroup is nil. id = " .. groupId)
        end
    end
end

function M:_GetItems(groupId)
    local items = {}
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
    return items
end

function M:_GetItemPfb(idx)
    local itemView = self.m_shopItemPfbs[idx]
    if not itemView then
        itemView = self.m_shopItemPfbs[1]:Instantiate()
        itemView:EnablePopItem(true)
        self.m_shopItemPfbs[idx] = itemView
    end
    return itemView
end

-- 高级礼包状态
function M:_SetDescState()
    local SPType = PassConst.ShopPackType
    local passType = self.m_passShop.passBagType
    local isPaid = PassDataMgr:GetInstance():IsPaid()
    self._view.uiState:SetState((isPaid or (passType == SPType.UpNormal) or (passType == SPType.UpHigher)) and 2 or 1)
end

return M
