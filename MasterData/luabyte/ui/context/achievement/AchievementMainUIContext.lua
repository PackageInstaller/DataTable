local AchievementSelectPopupContext = BaseClass("AchievementSelectPopupContext", BaseContext)
local M = AchievementSelectPopupContext


function M:Init()
end


function M:Open(data, callback)
    self:_Show()
end


function M:_OnCallBack()
    self:_Show()
end


function M:OnClose()
    M.super.OnClose(self)
end


return AchievementSelectPopupContext