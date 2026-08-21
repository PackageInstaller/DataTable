--zhangliang1
--2021/12/15 20:46:00
local GamesMainUIContext = BaseClass("GamesMainUIContext", BaseContext)
local M = GamesMainUIContext

function M:Init()
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:Open()
    self:_Show()
end

return GamesMainUIContext