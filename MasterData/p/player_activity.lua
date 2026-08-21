-- Desc: 活动相关逻辑
---@class Player
local Player = require "Player"


---获取活动数据
---@return table<integer, ActivityInfo>
function Player:getActivityMap()
    return self.activityMap
end


---获取活动信息
---@param activityId integer 活动id
---@return ActivityInfo
function Player:getActivityInfo(activityId)
    local activityMap = self:getActivityMap()
    if activityMap[activityId] == nil then
        self.activityMap[activityId] = {
            state = GE.ActivityState.NotOpen,   --活动状态
        }
    end
    return activityMap[activityId]
end

--活动开启
---@param cfg table 活动配置
---@param proto table 协议数据
function Player:activityOpen(cfg, proto)
    --通行证
    if cfg.Type == GE.ActivityType.Pass then
        self:passportOpen(cfg.id, proto)
    --签到
    elseif cfg.Type == GE.ActivityType.Sign then
        self:signOpen(cfg.activityPara[1], proto)
    end

    --开启活动任务
    local missionType = GE.ActivityMissionType[cfg.Type]
    if missionType then
        self:OpenActiveMission(missionType, cfg.TaskGroup or {}, proto)
    end

    proto.activityMap = self:propToProto("activityMap")
end

--活动关闭
---@param cfg table 活动配置
---@param proto table 协议数据
function Player:activityClose(cfg, proto)
    --通行证
    if cfg.Type == GE.ActivityType.Pass then
        self:passportClose(cfg.id, proto)
    --签到
    elseif cfg.Type == GE.ActivityType.Sign then
        self:signClose(cfg.activityPara[1], proto)
    end

    --关闭活动任务
    local missionType = GE.ActivityMissionType[cfg.Type]
    if missionType then
        self:CloseActiveMission(missionType, cfg.TaskGroup, proto)
    end

    proto.activityMap = self:propToProto("activityMap")
end

--更新活动数据
---@param proto table 协议数据
function Player:updateActivityInfo(proto)
    local allCfg = Config.GetAllConfig("ActivityTable")
    local curTime = DLuaUtil.GetGreenwichTime()

    for _, cfg in pairs(allCfg) do
        local activityInfo = self:getActivityInfo(cfg.id)
        --关闭活动
        if (cfg.StartTime > 0 and curTime < cfg.StartTime) or (cfg.EndTime > 0 and curTime > cfg.EndTime) then
            if activityInfo.state == GE.ActivityState.Open then
                LuaLogger.ds("close activity", cfg.id)
                activityInfo.state = GE.ActivityState.Ended
                self:activityClose(cfg, proto)
            end
        --开启活动
        else
            if activityInfo.state == GE.ActivityState.NotOpen then
                LuaLogger.ds("open activity", cfg.id)
                activityInfo.state = GE.ActivityState.Open
                self:activityOpen(cfg, proto)
            end
        end
    end
end

--第二天时检测活动是否已完成
function Player:checkActivityIsCompleted(proto)
    local change = false
    local activityMap = self:getActivityMap()

    for activityId, activityInfo in pairs(activityMap) do
        local cfg = Config.GetActivityInfo(activityId)
        if not cfg then
            LuaLogger.es("not cfg", activityId)
            goto continue
        end

        --任务全部已领取，则活动完成
        --如果此活动除了任务还有其他条件，则需前端自行判断
        local missionType = GE.ActivityMissionType[cfg.Type]
        if missionType and activityInfo.state == GE.ActivityState.Open then
            local isCompleted = self:checkActiveMissionIsCompleted(missionType, cfg.TaskGroup)
            if isCompleted then
                activityInfo.state = GE.ActivityState.Completed
                change = true
            end
        end

        --签到全部已领取，则活动完成
        --如果此活动有结束时间，则根据结束时间来，不会提前完成
        if cfg.Type == GE.ActivityType.Sign and cfg.EndTime <= 0 then
            local isCompleted = self:checkSignIsCompleted(cfg.activityPara[1])
            if isCompleted then
                activityInfo.state = GE.ActivityState.Completed
                change = true
            end
        end
        ::continue::
    end

    if change and proto then
        proto.activityMap = self:propToProto("activityMap")
    end
end

--根据所属功能类型获取活动信息
---@param type ActivityFunctionType 功能类型
function Player:getActivityInfoByFunctionType(type)
    local info = {}
    for activityId, activityInfo in pairs(self.activityMap) do
        local cfg = Config.GetActivityInfo(activityId)
        if cfg and cfg.FunctionType == type then
            info[activityId] = activityInfo
        end
    end
    return info
end

--获取简易通行证全量信息
---@return table<integer, MiniPassInfo>
function Player:getAllMiniPassInfo()
    return self.miniPassMap
end

--通过通行证id获取简易通行证信息
---@param miniPassId integer 简易通行证id
---@return MiniPassInfo
function Player:getMiniPassInfo(miniPassId)
    return self.miniPassMap[miniPassId]
end

--通过通行证id获取简易通行证额外奖励是否开启
---@param miniPassId integer 简易通行证id
---@return boolean
function Player:isMiniPassExtraRewardOpen(miniPassId)
    local passInfo = self:getMiniPassInfo(miniPassId)
    return passInfo and passInfo.openExtraReward
end

--解锁简易通行证高级模式
---@param miniPassId integer 简易通行证id
---@param proto UserInfo 用户数据
function Player:unlockMiniPass(miniPassId, proto)
    local passInfo = self:getMiniPassInfo(miniPassId)
    if not passInfo then
        local miniPassMap = self:getAllMiniPassInfo()
        miniPassMap[miniPassId] = {
            openExtraReward = false,
        }
        passInfo = miniPassMap[miniPassId]
    end
    if passInfo and not passInfo.openExtraReward then
        passInfo.openExtraReward = true
    end
    if proto then
        proto.miniPassMap = self:propToProto("miniPassMap")
    end
end

return Player