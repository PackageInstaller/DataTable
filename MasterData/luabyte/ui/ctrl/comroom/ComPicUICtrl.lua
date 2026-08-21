local ComPicUICtrl = BaseClass("ComPicUICtrl", BaseUICtrl)
local M = ComPicUICtrl

function M:Init()
    self._view.rectClose:onClick(Bind(self, self.Close))
end

function M:OnEnter(path)
    self._view.rimgBigPic:SetPic(path, false)
end

function M:OnDispose()
    self._view.rectClose:onClick(nil)

    M.super.OnDispose(self)
end

return ComPicUICtrl