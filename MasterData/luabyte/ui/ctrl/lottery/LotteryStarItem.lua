local LotteryStarItem = BaseClass( "LotteryStarItem")
local M = LotteryStarItem

function M:__init(view)
    self._view = view 
end

function M:SetStarEnable(v)
    self._view.trans_On.gameObject:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LotteryStarItem