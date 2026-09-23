TaskProto = {}

----------------------------------任务--------------------------------------
function TaskProto:TaskAdd(proto)
    MissionMgr:TaskAdd(proto)
end

function TaskProto:TaskFlush(proto)
    MissionMgr:TaskFlush(proto)
end

function TaskProto:GetReward(_id, _ids)
    local proto = {"TaskProto:GetReward", {
        id = _id,
        ids = _ids
    }}
    NetMgr.net:Send(proto)
end

function TaskProto:GetRewardRet(proto)
    --
    local datas = (proto.infos and #proto.infos > 0) and proto.infos or {proto.info}
    MissionMgr:GetRewardRet(datas, proto.dailyStar, proto.weeklyStar, proto.gets, proto.anvsStarInfo)

    -- rui数数 日常/周常任务 -- GCalHelp:GetTaskCfg(taskType, taskCfgid) 需要策划修改 todo 
    -- if proto.info and #proto.info>0 then
    --     local id = proto.info.id
    --     local curData = MissionMgr:GetData(id)
    --     if (curData) then
    --         local _datas = {}
    --         _datas.reason = "领取任务奖励"
    --         _datas.task_type =eTaskTypeName[curData:GetType()] --self:GetTaskType(curData:GetType())
    --         _datas.task_names = {}
    --         table.insert(_datas.task_names, {
    --             ["task_name"] = curData:GetName(),
    --             ["task_id"] = id,
    --             ["task_cfgid"] = curData:GetCfgID()
    --         })
    --         _datas.item_gain = proto.gets
    --         _datas.active_dailyStar = proto.dailyStar or 0
    --         _datas.active_weeklyStar = proto.weeklyStar or 0
    --         local eventName = (curData:GetType() == eTaskType.Main or curData:GetType() == eTaskType.Main) and
    --                               "main_work" or "repetition_work"
    --         BuryingPointMgr:TrackEvents(eventName, _datas)
    --     end
    -- end
end

function TaskProto:GetRewardByType(_type, _nGroup)
    local proto = {"TaskProto:GetRewardByType", {
        type = _type,
        nGroup = _nGroup
    }}
    NetMgr.net:Send(proto)
end


function TaskProto:GetRewardByTypeRet(proto)
    --
    MissionMgr:GetRewardRet(proto.infos, proto.dailyStar, proto.weeklyStar, proto.gets,proto.anvsStarInfo)

    -- rui数数 日常/周常任务 -- GCalHelp:GetTaskCfg(taskType, taskCfgid) 需要策划修改 todo 
    -- if (proto.infos and #proto.infos > 0) then
    --     local task_names = {}
    --     local eventName = "main_work"
    --     local sType = 1
    --     for i, v in ipairs(proto.infos) do
    --         local id = v.id
    --         local curData = MissionMgr:GetData(id)
    --         table.insert(task_names, {
    --             ["task_name"] = curData:GetName(),
    --             ["task_id"] = id,
    --             ["task_cfgid"] = curData:GetCfgID()
    --         })
    --         if (i == 1) then
    --             sType = curData:GetType()
    --             eventName = (sType == eTaskType.Main or sType == eTaskType.Main) and "main_work" or "repetition_work"
    --         end
    --     end
    --     local _datas = {}
    --     _datas.reason = "一键领取任务奖励"
    --     _datas.task_type = eTaskTypeName[sType] --self:GetTaskType(sType)
    --     _datas.task_names = task_names
    --     _datas.item_gain = proto.gets
    --     _datas.active_dailyStar = proto.dailyStar or 0
    --     _datas.active_weeklyStar = proto.weeklyStar or 0
    --     BuryingPointMgr:TrackEvents(eventName, _datas)
    -- end
end

function TaskProto:GetResetTaskInfoRet(proto)
    MissionMgr:GetResetTaskInfoRet(proto)
end

-- 任务类型
--[[eTaskType.Main = 1 -- 主线
eTaskType.Sub = 2 -- 支线
eTaskType.Daily = 3 -- 日常
eTaskType.Weekly = 4 -- 每周
eTaskType.Activity = 5 -- 活动
]]
-- function TaskProto:GetTaskType(sType)
--     if (not self.TaskTypes) then
--         self.TaskTypes = {}
--         self.TaskTypes[eTaskType.Main] = "主线任务"
--         self.TaskTypes[eTaskType.Sub] = "支线任务"
--         self.TaskTypes[eTaskType.Daily] = "日常任务"
--         self.TaskTypes[eTaskType.Weekly] = "每周任务"
--         self.TaskTypes[eTaskType.Activity] = "活动任务"
--     end
--     return self.TaskTypes[sType] or "未知类型"
-- end

function TaskProto:GetSevenTasksDayRet(proto)
    MissionMgr:GetSevenTaskDayRet(proto)
end

--任务重置通知
function TaskProto:TaskReSet(proto)
    MissionMgr:Clear()
    MissionMgr:GetResetTaskInfo()
    MissionMgr:GetTasksData()
    EventMgr.Dispatch(EventType.Mission_ReSet) --注意 此时任务还未重置完成（可用来关闭界面）
end

function TaskProto:GetTasksDataRet()
    MissionMgr:GetTasksDataRet()
end

function TaskProto:TaskDelete(proto)
    MissionMgr:TaskDelete(proto)
end

--多类型一键领取
function TaskProto:GetRewardByTypes(datas)
    local proto = {"TaskProto:GetRewardByTypes", {
        taskType = datas
    }}
    NetMgr.net:Send(proto)
end

--培养引导任务进度信息
function TaskProto:GetRoleGuideBaseInfo()
    local proto = {"TaskProto:GetRoleGuideBaseInfo"}
    NetMgr.net:Send(proto)
end

function TaskProto:GetRoleGuideBaseInfoUpdate(proto)
    CharacterRaisingMgr:Update(proto)
end

--培养引导任务领取奖励
function TaskProto:GetRoleGuideReward(id)
    local proto = {"TaskProto:GetRoleGuideReward", {
        id = id
    }}
    NetMgr.net:Send(proto)
end

--培养引导任务领取奖励返回
function TaskProto:GetRoleGuideRewardRet(proto)
    CharacterRaisingMgr:UpdateReward(proto)
    EventMgr.Dispatch(EventType.CharacterRaising_Reward_Update, proto);
end