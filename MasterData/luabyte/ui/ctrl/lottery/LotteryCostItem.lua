local LotteryCostItem = BaseClass("LotteryCostItem")
local M = LotteryCostItem

function M:__init(view)
    self._view = view 
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LotteryCostItem