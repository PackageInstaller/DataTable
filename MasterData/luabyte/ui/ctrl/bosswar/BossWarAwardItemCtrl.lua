local M = BaseClass("BossWarAwardItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_itemPfbs = { self._view.itemPfb }
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
end

function M:UpdateItem(data)
    if not data then return end

    self.m_data = data
    self._view.img_head:SetPic(data.Icon)
    self._view.txt_name:SetText(data.Name)
    self._view.uiState:SetState(data.GetState()) -- 1:Normal 2:Can Award 3:Awarded
    self._view.txt_lNum:SetText(tostring(data.Stage))
    self._view.txt_rNum:SetText(tostring(data.StageNum))

    self:_SetRewardItems()
end

function M:OnClickAward(go)
    if self.m_data.GetState() ~= 2 then return end
    self.m_data:GetReward()
end

function M:OnDispose()
    for _, item in ipairs(self.m_itemPfbs) do
        item:DoDispose()
    end
    self.m_itemPfbs = nil
    self.m_data = nil
    M.super.OnDispose(self)
end

function M:_SetRewardItems()
    for i, value in ipairs(self.m_data.Items) do
        local item = self.m_itemPfbs[i]
        if not item then
            item = self._view.itemPfb:Instantiate()
            table.insert(self.m_itemPfbs, item)
        end
        item:SetActive(true)
        item:EnablePopItem(true)
        item:SetInfo(value.Id, ItemNumberType.TOTLE, value.Num)
    end

    for i = #self.m_data.Items + 1, #self.m_itemPfbs do
        self.m_itemPfbs[i]:SetActive(false)
    end
end

return M
