local LotteryPVUICtrl = BaseClass("LotteryPVUICtrl", BaseUICtrl)
local M = LotteryPVUICtrl

function M:Init()
    self._view.rectClose:onClick(Bind(self, self.Close))
end

function M:OnEnter(path)
    self._view.media:Play(path, true)
end

function M:OnDispose()
    self._view.rectClose:onClick(nil)
    M.super.OnDispose(self)
end

return LotteryPVUICtrl