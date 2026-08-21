local NearInteractiveTipsContext = BaseClass("NearInteractiveTipsContext", BaseContext)
local M = NearInteractiveTipsContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(datas)
    self:_Show(datas)
end

return NearInteractiveTipsContext
