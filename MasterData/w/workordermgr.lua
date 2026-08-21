-- Desc：工单管理

local WorkOrderMgr = {}

local _userPriority = {
    [GE.WorkOrderState.WaitUser] = 6,
    [GE.WorkOrderState.Dealing] = 4,
    [GE.WorkOrderState.NotSolved] = 3,
    [GE.WorkOrderState.NotDealed] = 3,
    [GE.WorkOrderState.Finished] = 1,
}

-- 1.等待自己回复的
-- 2.正在处理的
-- 3.未结束的
-- 4.其他
function WorkOrderMgr.UserWorkOrderSort(a, b)
    local aPriority = _userPriority[a.state]
    local bPriority = _userPriority[b.state]

    if aPriority ~= bPriority then
        return aPriority > bPriority
    end

    return a.stamp > b.stamp
end

local _gmPriority = {
    [GE.WorkOrderState.NotDealed] = 6,
    [GE.WorkOrderState.NotSolved] = 5,
    [GE.WorkOrderState.Dealing] = 4,
    [GE.WorkOrderState.WaitUser] = 3,
    [GE.WorkOrderState.Finished] = 1,
}

-- 1.未受理的
-- 2.未解决的
-- 3.正在处理的
-- 4.等待玩家回复的
-- 5.已结束的
function WorkOrderMgr.GmWorkOrderSort(a, b)
    local aPriority = _gmPriority[a.state]
    local bPriority = _gmPriority[b.state]

    if aPriority ~= bPriority then
        return aPriority > bPriority
    end

    return a.stamp > b.stamp
end

return WorkOrderMgr