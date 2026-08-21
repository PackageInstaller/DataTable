local AwakeTeskPointChecker = BaseClass("AwakeTeskPointChecker" , require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = AwakeTeskPointChecker


function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.TaskData}
end

function M:Check()
    self.checkResult = 0

    local listDatas = TaskDataMgr:GetTasksDataByType(TaskConst.TaskType.Awake)
    table.sort( listDatas, function (v1, v2)
        return v1.id < v2.id
    end )
    self:Checking(listDatas)
end

function M:Checking(listDatas)
    local isShow = true

    for i=1,4 do
        local data = listDatas[i]
        local name = "task" .. i
        local curState = 1

        if data.state <= 0 and isShow then
            isShow = false
        end

        if data.state == 1 and isShow then
            self.checkResult = 1
        end
    end
end


return AwakeTeskPointChecker