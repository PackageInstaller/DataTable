local SettingUIContext = BaseClass( "SettingUIContext" , BaseContext )
local M = SettingUIContext

function M:__init()

end


function M:_Destory()
    M.super._Destory(self)
end


function M:Open()
    self:_Show()
end

return SettingUIContext