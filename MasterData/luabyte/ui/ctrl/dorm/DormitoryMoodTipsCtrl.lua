local DormitoryMoodTipsCtrl = BaseClass("DormitoryMoodTipsCtrl", BaseUICtrl)
local M = DormitoryMoodTipsCtrl

function M:Init()
    self._closeCallback = nil
    self._view.rectClose:onClick(Bind(self, self._ClickMask))
end

function M:OnEnter(titleId, contentId, callback)
    self._view.txtTitle:SetText(titleId)
    self._view.txtContent:SetText(contentId)
    self._closeCallback = callback
end

--点击背景关闭
function M:_ClickMask(go)
    if self._closeCallback then
        self._closeCallback()
        self._closeCallback = nil
    end
    self:Close()
end

return DormitoryMoodTipsCtrl
