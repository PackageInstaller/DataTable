local M = BaseClass("OtakuChangeTipsCtrl", BaseUICtrl)

function M:Init()
    self.tipItems = {}
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
    end
    self._timer = nil
    for key, value in pairs(self.tipItems) do
        value:OnDispose()
    end
    self.tipItems = nil
    M.super.OnDispose(self)
end

function M:OnEnter(tips)
    self.tips = tips
    self:UpdateTips()
    --开启定时器
    self._timer = TimerManager:GetInstance():GetTimer(2.5, Bind(self, self.TimerCallBack), self)
    self._timer:Start()
end

function M:TimerCallBack()
    self:Close()
end

function M:UpdateTips()
    local ctrlItemCls = require("UI.Ctrl.Otaku.OtakuTipsPanelCtrl")
    for key, value in pairs(self.tips) do
        local tipItem = self._view.OtakuTip:Instantiate()
        tipItem:SetParent(self._view.Content)
        tipItem:SetActive(true)
        local ctrlItem = ctrlItemCls.New(tipItem)
        ctrlItem:UpdataData(value)
        table.insert(self.tipItems, ctrlItem)
    end
end

return M
