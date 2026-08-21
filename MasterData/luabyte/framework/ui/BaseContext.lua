local BaseEventHandler = require "Framework.UI.BaseEventHandler"
BaseContext = BaseClass("BaseContext", BaseEventHandler)
local M = BaseContext

function M:__init(uiName)
    -- body
    self.uiName = uiName
    self:Init()
end

function M:Init()

end

function M:Open()

end

function M:OnClose()
    self:_Close()
end

function M:OnSceneChange()

end

function M:_Show(...)
    UIManager:GetInstance():Show(self.uiName, ...)
end

function M:_Close()
    UIManager:GetInstance():Close(self.uiName)
end

function M:_Destory()
    self:OnDispose()
    UIManager:GetInstance():_Destory(self.uiName)
end

function M:GetCtrl()
    return UIManager:GetInstance():GetCtrl(self.uiName)
end

return BaseContext