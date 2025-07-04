---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/8 21:36
---

local TaskData = {};
local this = TaskData;

local function CheckTaskNum(taskComponent, i, num)

end

function this.AddModeTaskNum(mode, num)
    if num == 0 then return end
    if not num then num = 1 end

    local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
    if mode.type then
        for _, v in ipairs(Z_MissionIDType[mode.type].MiID) do
            CheckTaskNum(taskComponent, v, num)
        end
        for _, v in ipairs(Z_MissionIDType[mode.type].ActivityMiID) do
            CheckTaskNum(taskComponent, v, num)
        end
    elseif mode.Id then
        CheckTaskNum(taskComponent, mode.Id, num)
    end

    

end





----------------任务完成情况-------------------------------------------------------------------

local function AddTaskLackNum(taskComponent, tasks, totalNum)
    table.walk(tasks, function(_, v)
        if v > 0 then
            local temTask = table.first(taskComponent.Tasks, function(t)
                return t.TemplateId == v and t.Num < Z_Mission[v].NumMax and t.Num < totalNum end)
            if temTask then
                CheckTaskNum(taskComponent, v, totalNum - temTask.Num)
            end
        end
    end)
end

local function TaskStatus(mode)
    local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
    local tasks = {}
    if mode.type then
        for _, v in ipairs(Z_MissionIDType[mode.type].MiID) do
            table.insert(tasks, v)
        end
        for _, v in ipairs(Z_MissionIDType[mode.type].ActivityMiID) do
            table.insert(tasks, v)

        end
    elseif mode.Id then
        table.insert(tasks, mode.Id)
    end

end


return TaskData