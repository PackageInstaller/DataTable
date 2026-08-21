local BaseDataCenter = BaseClass("BaseDataCenter")
local M = BaseDataCenter


function M:__init(...)
    self:Init(...)
end

--不要重写
function M:Dispose()
    self:OnDispose()
end

--重写这个
function M:OnDispose()
    
end




return BaseDataCenter
