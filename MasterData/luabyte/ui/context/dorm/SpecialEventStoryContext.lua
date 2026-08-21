local SpecialEventStoryContext = BaseClass("SpecialEventStoryContext", BaseContext)
local M = SpecialEventStoryContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(heroId, type, groupId, closeCallback)
    self.heroId = heroId
    self.type = type
    self.groupId = groupId
    self.closeCallback = closeCallback
    self:_Show(self.heroId, self.type, self.groupId, self.closeCallback)
end

return SpecialEventStoryContext