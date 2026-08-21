local AwakeTaskCtrl = BaseClass("AwakeTaskCtrl", BaseUICtrl)
local M = AwakeTaskCtrl



function M:OnEnter()
    self:_RefreshTask()
    self:_RefreshAwake()
end


function M:_RefreshTask()
    self.m_CompleteNum = 1

    local listDatas = TaskDataMgr:GetTasksDataByType(TaskConst.TaskType.Awake)
    table.sort( listDatas, function (v1, v2)
        return v1.order < v2.order 
    end )

    local isStart = true
    for i=1,4 do
        local data = listDatas[i]
        local name = "task" .. i
        local curState = 1

        if isStart and data.state > 0 then
            curState = data.state + 1
            self.m_CompleteNum = self.m_CompleteNum + 1
        else
            if isStart then
                curState = 2
                isStart = false
            end
        end

        self._view[name]:Refresh(i, curState, data, Bind(self, self._TaskComplete))
    end

    self.m_CompleteNum = self.m_CompleteNum > 4 and 4 or self.m_CompleteNum 
    self._view.unLockFrame:SetState(self.m_CompleteNum)
end


function M:_RefreshAwake()
    local skillId = ConfigHelper.GetSystemParam(275)
    local skillCfg = ConfigHelper.GetCfg("heroBreak", skillId)
    self._view.skillIcon:SetPic(skillCfg.icon)
    self._view.skillName:SetText(skillCfg.name)
    self._view.skillDesc:SetText(skillCfg.desc)
end


function M:_TaskComplete(id)
    TaskDataMgr:RequestCompleteTask(id, Bind(self, self._OnTaskCompleteCallBack))
end


function M:_OnTaskCompleteCallBack()
    self:_RefreshTask()
end



return AwakeTaskCtrl
