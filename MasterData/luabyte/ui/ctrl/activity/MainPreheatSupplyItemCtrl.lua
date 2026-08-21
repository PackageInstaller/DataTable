local M = BaseClass("MainPreheatSupplyItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.btn_buy:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_data = data
    local cfg = data.ActivityShop
    local times = cfg.times
    local itemId = cfg.shopItem
    local buyNum = data:BuyNum()
    self._view.txt_name:SetItemName(itemId)
    self._view.img_icon:SetItemIcon(itemId)
    self._view.txt_discount:SetText("10折")
    self._view.rectDiscount:SetActive(false)
    self._view.txt_timesR:SetText(tostring(times))
    self._view.txt_timesL:SetText(tostring(buyNum))
    self._view.rectSellOut:SetActive(buyNum >= times)
    self._view.img_costIcon:SetItemIcon(cfg.costItem)
    self._view.txt_num:SetText(tostring(cfg.itemNum))
    self._view.txt_costNum:SetText(tostring(cfg.costNum))
    self._view.quality:SetState(ItemHelper.ItemQuality(itemId))
end

function M:OnClickItem(go)
    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

function M:OnDispose()
    self.m_callback = nil
    self.m_data = nil
    M.super.OnDispose(self)
end

return M
