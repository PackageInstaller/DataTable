local M = BaseClass('AwardPanelCtrl')

function M:Refresh(awards, func)
    self.m_callback = func
    if not self.m_itemPfbList then
        self.m_itemPfbList = { self.view.itemPfb }
    end
    self.view.itemPfb:SetActive(false)
    for i, award in ipairs(awards or {}) do
        local go = self.m_itemPfbList[i]
        if not go then
            go = self.view.itemPfb:Instantiate()
            self.m_itemPfbList[i] = go
        end
        local id, num = award.id, award.num
        go:SetActive(true)
        go:SetState(award.state)
        go:SetInfo(id, ItemNumberType.TOTLE, num)
        go.onClick = Bind(self, self.OnClickItem, id, num)
    end
end

function M:OnClickItem(id, num)
    if self.m_callback then
        self.m_callback(id, num)
    end
end

function M:OnDispose()
    for _, v in pairs(self.m_itemPfbList or {}) do v:DoDispose() end
    self.m_itemPfbList = nil
    self.m_callback = nil
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return M
