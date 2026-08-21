-- baoruichang
-- 2022/11/25 16:42:30
local UIAwakeClassCtrl = BaseClass("UIAwakeClassCtrl")
local M = UIAwakeClassCtrl

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._onClick))
    self:Init()
end

function M:Init()
    self.tabItem = {self._view.UIAwakeLvCtrl}
end

function M:UpdateData(awakeLv, maxAwakeLv)
    self._view.labLv:SetText(tostring(awakeLv) .. "/" .. maxAwakeLv)
    for i = 1, maxAwakeLv do
        local UIAwakeLvCtrl = self.tabItem[i]
        if not UIAwakeLvCtrl then
            UIAwakeLvCtrl = self._view.UIAwakeLvCtrl:Instantiate()
            self.tabItem[i] = UIAwakeLvCtrl
        end
        UIAwakeLvCtrl:UpdateData(awakeLv >= i)
    end
    for i = maxAwakeLv + 1, #self.tabItem do
        local UIAwakeLvCtrl = self.tabItem[i]
        UIAwakeLvCtrl:SetActive(false)
    end
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
    for _, value in ipairs(self.tabItem) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

return UIAwakeClassCtrl
