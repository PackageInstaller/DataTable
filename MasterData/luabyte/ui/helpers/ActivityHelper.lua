local ActivityHelper = {}


ActivityHelper.ESignState = {
    NONE = 0,
    DOING = 1, --进行中
    ALREADY_GAIN = 2, --已领奖
    COMPLETE_NOT_GAIN = 3, --完成未领奖
}

function ActivityHelper.SplitSecond(value)
    local day = math.floor(value / 86400)
    value = value - day * 86400
    local hour = math.floor(value / 3600)
    value = value - hour * 3600
    local minute = math.floor(value / 60)
    local second = value - minute * 60
    return { day = day, hour = hour, minute = minute, second = second }
end

--根据开始、结束时间戳计算自然天数,结束时间为nil或0，则表示现在
function ActivityHelper.CountDayByStartTime(startTick, endTick)
    if endTick == nil then
        endTick = 0
    end
    return TimeUtil.CountDayByStartTime(startTick, endTick)
end

--兑换活动是否有红点
function ActivityHelper.CheckExchangeRedPoint(activityId)
    local cfgs = ConfigHelper.GetCfgs("activityExchange")
    if cfgs == nil then
        return false
    end
    for i, cfg in ipairs(cfgs) do
        if cfg.id == activityId or activityId == 0 then
            local costItem = cfg.costItem
            local costNum = cfg.costNum
            local isEnough = GameHelper.CalItemEnough(costItem, costNum)
            if isEnough then
                return true
            end
        end
    end
    return false
end

--在线奖励红点
function ActivityHelper.CheckOnlineAwardRedPoint()
    --请对应小伙伴实现
    Logger.Log("请相关小伙伴实现在线奖励红点逻辑")
    return false
end

return ActivityHelper
