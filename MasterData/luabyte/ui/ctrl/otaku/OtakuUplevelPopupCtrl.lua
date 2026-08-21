local M = BaseClass("OtakuUplevelPopupCtrl", BaseUICtrl)

function M:Init()
    self.m_second = 11
    self._view.btn_mask:onClick(Bind(self, self.Close))
end

function M:OnEnter(roomData, callback)
    self._view.upInfo:ShowUpgradeInfo(roomData)
    self._view.txt_count:SetText(self.m_second .. "S")
    if callback then callback() end
    self:_StartTimer()
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    self.m_second = nil
    self:_CloseTimer()
    M.super.OnDispose(self)
end

function M:OnTimerCallback()
    self.m_second = self.m_second - 1
    self._view.txt_count:SetText(self.m_second .. "S")
    if self.m_second <= 0 then self:Close() end
end

function M:_StartTimer()
    self:_CloseTimer()

    self.m_timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.OnTimerCallback), self)
    self.m_timer:Start()
end

function M:_CloseTimer()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
end

return M
