local DormitoryTheaterPopupCtrl = BaseClass("DormitoryTheaterPopupCtrl", BaseUICtrl)
local M = DormitoryTheaterPopupCtrl
function  M:Init()
    self._view.mask.transform:onClick(Bind(self, self._ClickMask))
end

function M:OnEnter(taskId,closeCallBack)
    self.taskId = taskId
    local taskCfg = ConfigHelper.GetCfgByLua("task", self.taskId)
    if taskCfg then
        self._view.TaskText:SetText(taskCfg.des)
    end
    if closeCallBack then
        self.closeCallBack = closeCallBack
    end
end

function M:_ClickMask(go)
    self:Close()
end

function M:OnClose()
    if self.closeCallBack then
        self.closeCallBack()
    end
    
    self.closeCallBack = nil
end
function M:OnDispose( ... )
    self.taskId = nil
    M.super.OnDispose(self)
end

return DormitoryTheaterPopupCtrl