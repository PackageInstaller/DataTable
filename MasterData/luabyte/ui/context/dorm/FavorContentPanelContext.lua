local FavorContentPanelContext = BaseClass("FavorContentPanelContext", BaseContext)
local M = FavorContentPanelContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(heroId)
    self._heroId = heroId
    self:_Show(self._heroId)
end

return FavorContentPanelContext
