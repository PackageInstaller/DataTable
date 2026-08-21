local M = BaseClass("OtakuBridgeDotGroupCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))

function M:Init()
    self.m_maxLevel = 0
    self:ShowPanel()
end

function M:Update(level, maxLevel, isUp)
    if self.m_maxLevel ~= maxLevel then
        self.m_maxLevel = maxLevel
        self._view.slider:SetMax(maxLevel)
        local height = self._view.transform.rect.height
        local newSize = Vector2.New(60 * maxLevel, height)
        self._view.transform.sizeDelta = newSize
    end
    self._view.slider:SetValue(level)
    if isUp then
        self._view.state:SetState(2)
        return
    end

    if level > 0 then
        self._view.state:SetState(1)
    else
        self._view.state:SetState(3)
    end
end

function M:OnDispose()
    self.m_maxLevel = nil
    M.super.OnDispose(self)
end

return M
