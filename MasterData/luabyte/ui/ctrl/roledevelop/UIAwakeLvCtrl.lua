-- baoruichang
local UIAwakeLvCtrl = BaseClass("UIAwakeLvCtrl", UIBaseComponent)
local M = UIAwakeLvCtrl

function M:UpdateData(state)
    self:SetActive(true)
    self._view.tf:SetActive(state)
end

return UIAwakeLvCtrl
