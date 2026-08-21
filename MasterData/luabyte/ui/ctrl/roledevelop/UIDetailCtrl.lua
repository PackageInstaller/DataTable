local UIDetailCtrl = BaseClass("UIHeroItemCtrl")
local M = UIDetailCtrl

function M:__init(view)
    self._view = view
end

function M:Update(state,strDesc)
    self._view.labDesc:SetText(strDesc)
    self._view.uiState:SetState(state and 1 or 2)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UIDetailCtrl
