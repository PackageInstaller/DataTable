local BeforeFavorStoryContext = BaseClass("DormContext", BaseContext)
local M = BeforeFavorStoryContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(heroId, taskStoryType, taskStory)
    self:_Show(heroId, taskStoryType, taskStory)
end

return BeforeFavorStoryContext
