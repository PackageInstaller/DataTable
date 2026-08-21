local M = BaseClass("BossWarWordsItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_closeCallback = nil
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
    self.m_slots = { self._view.slot1, self._view.slot2, self._view.slot3 }
end

function M:UpdateItem(data)
    if not data then return end

    self.m_data = data
    self._view.txt_desc:SetText(data.Desc)
    self._view.uiState:SetState(data.GetState()) -- 1:Normal 2:Select 3:Cannot Select
    for i, item in ipairs(self.m_slots) do
        item:SetActive(i <= data.Level)
    end
end

function M:OnClickMask(go)
    self.m_closeCallback(self.m_data)
end

function M:SetCallback(callback)
    self.m_closeCallback = callback
end

function M:OnDispose()
    self.m_closeCallback = nil
    M.super.OnDispose(self)
end

return M
