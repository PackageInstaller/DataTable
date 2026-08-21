local M = BaseClass('FirstRechargeItemCtrl')

function M:__init(view)
    self._view = view
end

function M:SetActive(isShow)
    self._view:SetActive(isShow)
end

function M:SetInfo(id, num, day)
    self.id = id
    self.num = num
    self._view.item:SetInfo(id, ItemNumberType.TOTLE, num)
    local isReward = RechargeDataMgr:GetInstance():IsFirstRechargeDayReward(day)
    self._view.item:SetFinish(not isReward)  
    self._view.item:EnablePopItem(true)
    self._view.effect.gameObject:SetActive(isReward)
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
