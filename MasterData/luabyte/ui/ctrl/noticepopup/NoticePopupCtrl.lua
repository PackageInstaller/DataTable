local M = BaseClass("NoticePopupCtrl",BaseUICtrl)

function M:OnEnter(noticeDataList,clickCloseCallback)
    if IsNull(noticeDataList) then 
        return
    end
    self._clickCloseCallback = clickCloseCallback
    self._view.imageArea:SetList(noticeDataList,Bind(self,self.OnClickClose))
end

function M:OnClickClose(needCallback)
    self:Close()
    if needCallback and self._clickCloseCallback then 
        self._clickCloseCallback()
    end
    self._clickCloseCallback = nil 
    
end

return M