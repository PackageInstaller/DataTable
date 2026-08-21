local M = BaseClass("JourneyFoodItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))

function M:Init()
    self.m_data = nil
    self:SetClickCallback(Bind(self, self.OnClickItem))
    self._view.addBtn:onClick(Bind(self, self.OnClickItem))
end

function M:OnClickItem(go)
    if self.m_callback then self.m_callback(self.m_itemId) end
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_data = data
    self.m_itemId = data.foodId
    local isSelect = data.isSelect
    self:SetQualityActive(isSelect)
    self:SetItemNameActive(isSelect)
    self._view.addBtn:SetActive(not isSelect)
    self:SetInfo(self.m_itemId, ItemNumberType.NONE)
end

function M:OnDispose()
    self.m_data = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

-- 增加道具
function M:ClickAddCallback(callback)
    self.m_callback = callback
end

return M
