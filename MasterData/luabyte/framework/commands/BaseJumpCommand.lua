local M = BaseClass("BaseJumpCommand", BaseCommand)

M.uiName = nil
M.moduleId = nil
M.isJumpBack = true -- 是否加入回退栈
M.closeOtherUI = {}
M.beExecuted = false
function M:Execute(...)
    -- body
end

function M:ChangeModule(_moduleId, ...)
    --{onComplete:nil}
    self.moduleId = _moduleId 
    self._onCompleteHandler = self._onCompleteHandler or Bind(self,self._OnChangeModule)
    ModuleMgr:GetInstance():ChangeModuleWithCallback(_moduleId,self._onCompleteHandler, ...)
end

function M:_OnChangeModule(_moduleId,hasError)
    if _moduleId == self.moduleId and not hasError then 
        if self.onComplete then 
            self.onComplete()
        end
    end
    self.onComplete = nil
end

function M:ShowUI(uiName, ...)
    local handler = UIContextMgr:GetInstance():Show(uiName, ...)
    handler.onShow = self.onComplete
end

function M:CloseUI(uiName)
    UIContextMgr:GetInstance():Close(uiName)
end

return M
