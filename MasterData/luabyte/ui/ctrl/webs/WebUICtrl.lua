local WebUICtrl = BaseClass("WebUICtrl" , BaseUICtrl )
local M = WebUICtrl

function M:__init()
    self.view.closeBtn:onClick(Bind(self,self.OnCloseWeb))
end

function M:OnEnter(url)
    self.view.webView:Open(url,Bind(self,self.OnCloseWeb))
end

function M:OnCloseWeb()
    self:Close()
end

function M:OnDispose()
    self.view.webView:Dispose()
    M.super.OnDispose(self)
end

return WebUICtrl