local DormTaskCtrl = BaseClass("DormTaskCtrl")
local M = DormTaskCtrl

function M:__init(view)
    self._view = view
    self._view.Task.transform:onClick(Bind(self, self._OnClickTask))
end

function M:UpdateData(taskId)
    self.taskId = taskId
    self.data = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.taskId)
    if self.data then
        self._view.ContentText:SetText(self.data.des)
        local value1 = self.data.value0 > self.data.limitValue1 and self.data.limitValue1 or self.data.value0
        self._view.Number:SetText(value1 .. "/" .. self.data.limitValue1)
        self._view.ExpSlider:SetValue(TaskHelper.GetProgress(self.data))
        self:Enable(true)
    else
        self:Enable(false)
    end
end

--点击任务跳转
function M:_OnClickTask(go)
    if self.data.state == TaskConst.TaskState.Doing then
        GameHelper.Jump(self.data.jumpId)
    end
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    self.taskId = 0
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormTaskCtrl
