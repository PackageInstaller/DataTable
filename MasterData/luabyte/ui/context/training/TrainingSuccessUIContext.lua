local TrainingSuccessUIContext = BaseClass( "TrainingSuccessUIContext" , BaseContext )
local M = TrainingSuccessUIContext

function M:__init()

end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(_level)
    self:_Show(_level)
end

function M:OnClose()
    M.super.OnClose(self)
end


return TrainingSuccessUIContext