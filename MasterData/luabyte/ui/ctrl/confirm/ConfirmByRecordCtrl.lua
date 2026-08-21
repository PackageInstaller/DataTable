local M = BaseClass("ConfirmByRecordCtrl", BaseUICtrl)

function M:Init()
    self._view.BtnOK:SetOnClick(function(go) self:_OnClicktsBtnOK(go) end)
    self._view.BtnCancel:SetOnClick(function(go) self:_OnClicktsBtnCancel(go)  end)
    self._view.ComToggle:OnToggleClick(function(b) self:ClickToggle(b) end)
end

function M:OnEnter(content,action,recordKey)
    self.clickEnterAction = action
    self._view.TipStr:SetText(content)
    self._view.ComToggle:SetIsOn(false)
    self._view.ComToggle:SetActive(recordKey ~= nil)
    self.bRecord = false
    self._recordKey = recordKey

end

--点击设置退出键
function M:OnDeviceBack()
    self:_OnClicktsBtnCancel(nil)
    return true 
end

function M:_OnClicktsBtnOK(go)
    self:Close()
    if  self.clickEnterAction ~= nil then
        self.clickEnterAction(true)
    end
    self:SaveRecord()
end

function M:_OnClicktsBtnCancel(go)
    if  self.clickEnterAction ~= nil then
        self.clickEnterAction(false)
    end
    self:SaveRecord()
    self:Close()
end

function M:ClickToggle(b)
    self.bRecord = b
end

function M:SaveRecord()
    if self.bRecord and self._recordKey then
        local context = UIContextMgr:GetInstance():GetContext("ConfirmByRecord")
        context:SaveRecord(self._recordKey)
    end
end


function M:OnDispose()
    M.super.OnDispose(self)
    
    
end

return M
