local TestLuaComponentContext = BaseClass( "TestLuaComponentContext" , BaseContext )
local M = TestLuaComponentContext

function M:__init()

end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open()
    self:_Show()
end

function M:OnClose()
    M.super.OnClose(self)
end


return TestLuaComponentContext