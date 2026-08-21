local UISignItemCtrl = BaseClass("UISignItemCtrl", UIBaseComponent)
local M = UISignItemCtrl

function M:__init(view)
    self._view = view
end

function M:UpdateData(data)
    self.data = data

    self:_SetState(self.data.state)
    self._view.Day:SetText(tostring(self.data.day))

    local items = ConfigHelper.GetCfgByLua("itemGroup", self.data.reward) or {}
    self._view.itemPfb:SetInfo(items.items[1], ItemNumberType.TOTLE, items.cnts[1])
    self._view.itemPfb:EnablePopItem(true)
end

function M:SignFinish(callback)
    self.m_CallBack = callback

    self:_SetState(2)
    self._view.MonthlySignUI_eff:SetActive(true)
    self._view.MonthlySignUI_eff:Play("MonthlySignUI_eff", 0, 0)

    if not IsNull(self.itemEffGo) then
        GameUtil.DestroyGo(self.itemEffGo)
        self.itemEffGo = nil
    end

    local animTime = self._view.MonthlySignUI_eff.runtimeAnimatorController.animationClips[0].length
    self._timer = TimerManager:GetInstance():GetTimer(animTime, Bind(self, self._OnEndAnimCallBack), self, true)
    self._timer:Start()
end

-- 1 可签到 2 已经签到 3 不可领取
function M:_SetState(state)
    self._view.state:SetState(state)
end

function M:_OnEndAnimCallBack()
    self.m_CallBack()
end

function M:SetActive(b)
    self._view:SetActive(b)
end

return UISignItemCtrl
