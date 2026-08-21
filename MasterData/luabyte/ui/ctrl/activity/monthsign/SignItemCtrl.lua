local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local SignItemCtrl = BaseClass("SignItemCtrl", CircularScrollViewItem)
local M = SignItemCtrl

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self.OnItemClick))
end

function M:UpdateItem(data)
    self.data = data
    self._view.recived:SetActive(data.isSign)
    local itemCfg = ConfigHelper.GetCfg("itemGroup", data.dailyBonus.dailyReward)
    self.m_itemId = itemCfg.items[1]
    self.m_itemNum = itemCfg.cnts[1]
    self._view.valueText:SetText(tostring(itemCfg.cnts[1]))
    self._view.dayText:SetText(tostring(data.dailyBonus.days))
    self._view.icon:SetItemIcon(self.m_itemId)
    self._view.uiState:SetState(data.dailyBonus.effect == 1 and 2 or 1)
end

function M:PlayAnimator(m_callBack)
    self.m_callBack = m_callBack
    self.data.isSign = true
    self._view.recived:SetActive(self.data.isSign)
    self._view.animator:Play("MonthlySignUI_eff", 0, 0)
    local animTime = self._view.animator.runtimeAnimatorController.animationClips[0].length
    self._timer = TimerManager:GetInstance():GetTimer(animTime, Bind(self, self._EndCallBack), self, true)
    self._timer:Start()
end

function M:_EndCallBack()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    if self.m_callBack then
        self.m_callBack()
    end
end

function M:OnItemClick()
    GameHelper.PopItem(self.m_itemId, self.m_itemNum, self._view)
end

function M:GetId()
    if self.data then
        return self.data.dailyBonus.days
    end
end

function M:OnDispose()
    self.m_callBack = nil
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
