local M = BaseClass('FirstRechargeDayItemCtrl')

function M:__init(view)
    self._view = view
    self.itemCtls = {}
    for i = 1, 2 do
        local ctrl = require("UI.Ctrl.Shop.FirstRechargeItemCtrl").New(self._view["item"..i])
        table.insert(self.itemCtls, ctrl)
    end
end

function M:SetActive(isShow)
    self._view:SetActive(isShow)
end

function M:SetInfo(datas, day)
    if day == 1 then
        self._view.DayNum:SetText("1 Day")
        self._view.RewardText:SetText(5721)
    end
    if day == 2 then
        self._view.DayNum:SetText("2 Day")
        self._view.RewardText:SetText(6299)
    end
    for key, value in pairs(self.itemCtls) do
        if datas[key] then
            value:SetInfo(datas[key].id, datas[key].num, day)
            value:SetActive(true)
        else
            value:SetActive(false)
        end
    end
end

function M:OnDispose()
    self.m_callback = nil
    if self._view then
        self._view.item:DoDispose()
        self._view:OnDispose()
        self._view = nil
    end
end

return M
