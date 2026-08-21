local OtakuRedPointMgr = {}
local M = OtakuRedPointMgr

-- 是否有饱食度为0
function M.RommHerosEaters()
    local rooms = OtakuRoomDataMgr:GetInstance():RoomDatas()
    if not rooms then
        return 0
    end

    local num = 0
    for _, v in pairs(rooms) do
        local liveSpace = v:GetLiveSpaceUpRoleNum()
        for _, k in ipairs(liveSpace) do
            local rshd = k:RoleStudio()
            if rshd then
                if rshd:GetEater() <= 0 then
                    num = num + 1
                end
            end
        end
    end

    return num
end

-- 制造舱制造道具完成
function M.ProduceItemFinish()
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Produce)
    for _, roomData in ipairs(roomDatas or {}) do
        if roomData:IsFinish() then
            return true
        end
    end
    return false
end

-- 远征任务完成
function M.SurveyFinish()
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Survey)
    for _, v in ipairs(roomData) do
        local ids = v:GetFinishSurveyIds()
        if #ids > 0 then
            return true
        end
    end
    return false
end

-- 可调查远征任务
function M.SurveyIdleTask()
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Survey)
    for _, v in ipairs(roomData) do
        local ids = v:GetIdleTasks()
        for _, id in ipairs(ids) do
            local cfg = v:GetExpMission(id)
            if v:CheckCondition(cfg.limit1, cfg.parameter1) then return true end
        end
    end
    return false
end

-- 餐厅菜品烹饪完成
function M.CanteenFoodFinish()
    Logger.Log(" 餐厅菜品烹饪完成红点 小威")
    return false
end

-- 解锁新技能
function M.SkillUnLock()
    Logger.Log(" 解锁新指挥官技能红点 火哥")
    return false
end

-- 餐厅吃完饭
function M.CanteenEaterFinish()
    Logger.Log(" 餐厅吃饭完成红点 小威")
    return false
end

return OtakuRedPointMgr
