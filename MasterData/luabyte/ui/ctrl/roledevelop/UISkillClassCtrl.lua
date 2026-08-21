-- baoruichang
local UISkillClassCtrl = BaseClass("UISkillClassCtrl")
local M = UISkillClassCtrl

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._onClick))
end

function M:UpdataData(lv)
    self._view.labSkillLv:SetText(tostring(lv))
end

function M:SetState(state, lv)
    self._view.uiState:SetState(state)
    if state == 1 then
        self._view.labLockTips:SetText(tostring(lv))
    end
end

function M:_onClick()
    if self.func then
        self.func()
    end
end

function M:SetOnClick(func)
    self.func = func
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UISkillClassCtrl
