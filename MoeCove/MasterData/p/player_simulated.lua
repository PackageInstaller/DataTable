-- Desc: 玩家关卡相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr, GameGlobal
local skynet
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    GameGlobal = require "GameGlobal"
    skynet = require "skynet"
end

--更新周期活动数据
---@param proto UserInfo 玩家数据
function Player:refreshRegularActivityData(proto)
    self:refreshSimulatedData(proto)
    self:refreshBossActivityData(proto)
end

--更新模拟演习数据
---@param proto UserInfo 玩家数据
function Player:refreshSimulatedData(proto)
    local newPeriod = 1
    local newNextTime = DLuaUtil.GetNextWeekTime(DLuaUtil.GetGreenwichTime())

    local simulatedActivity = self:getSimulatedActivityData()
    --判断是否开启新一期模拟演习
    if DLuaUtil.GetGreenwichTime() > simulatedActivity.closingTime then
        --重置模拟演习数据
        if GameGlobal then
            skynet.fork(function()
                --获取当前期号
                local period, nextTime = GameGlobal.ActivityGetCurIdInfoReq({
                    uid = self.uid,
                    activityType = GE.ActivityType.Simulated
                })
                local proto = {}
                self:resetSimulatedData(period, nextTime, proto)
                if not tablex.empty(proto) then
                    self:notifyDirect({"user.UserInfoUpdate", {userinfo = proto}})
                end
            end)
        else
            self:resetSimulatedData(newPeriod, newNextTime, proto)
        end
    end
end

--获取模拟演习数据
---@return SimulatedActivityInfo
function Player:getSimulatedActivityData()
    return self.regularActivityData.simulatedActivity
end

--设置模拟演习关卡数据
---@param levelInfo PveLevelInfo 关卡数据
---@param userinfo UserInfo 玩家数据
---@return ActionFailReason 错误码
---@return boolean? fristClear 是否首通
function Player:setSimulatedLevelData(levelInfo, proto)
    local simulatedActivity = self:getSimulatedActivityData()
    local nowPeriod = simulatedActivity.nowPeriod
    --通过期数及关卡id获取模拟演习id
    local exeLevelConfig = Config.GetPveExerciseLevelInfoByIssueAndLevelId(nowPeriod, levelInfo.id)
    if not exeLevelConfig then
        return ActionFailReason.CfgNotFind
    end
    --时间检测
    local offsetStringMap = DLuaUtil.getNextWeekRemainingTime(DLuaUtil.GetGreenwichTime())
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end
    --配置表检测
    local floorConfig = Config.GetPveExerciseStoreyInfoByStoreyNum(exeLevelConfig.storeyNum)[1]
    if not floorConfig then
        return ActionFailReason.CfgNotFind
    end
    local nowFloorId = floorConfig.id

    local fristClear = false
    local simulatedLevelData = simulatedActivity.simulatedLevelMap[nowFloorId]
    --LuaLogger.ds(">>>>>simulatedLevelData<<<<<", tablex.dump(simulatedLevelData))
    if simulatedLevelData then
        if tablex.find(simulatedLevelData.levelList, exeLevelConfig.id) then--有数据则为重复通关
            fristClear = false
        else--若没有数据则也是首通
            fristClear = true
            tablex.insertproxy(simulatedLevelData.levelList, exeLevelConfig.id)
        end
    else
        --本层首通
        fristClear = true
        simulatedActivity.simulatedLevelMap[nowFloorId] = {
            levelList = {exeLevelConfig.id},
            getReward = false,
        }
    end

    --计算当前层数是否完成，供任务触发使用
    local nowProgress = 0
    local floorData = simulatedActivity.simulatedLevelMap[nowFloorId]
    for _, levelId in pairs(floorData.levelList) do
        local levelConfig = Config.GetPveExerciseLevelInfo(levelId)
        if levelConfig then
            nowProgress = nowProgress + levelConfig.progressReward
        else
            return ActionFailReason.CfgNotFind
        end
    end
    if nowProgress >= floorConfig.progressNeed then
        --触发任务-模拟演习通关层数
        self:missionTrigger(GE.MissionFinishType.TowerReachLevel, {floorId = exeLevelConfig.storeyNum}, proto)
    end
    self:missionTrigger(GE.MissionFinishType.TowerJoinCount, {count = 1}, proto)

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.simulatedActivity then
            proto.regularActivityData.simulatedActivity = {}
        end
        proto.regularActivityData.simulatedActivity = self:getSimulatedActivityData()
    end

    --LuaLogger.ds(">>>>>self.simulatedActivity<<<<<", tablex.dump(self.simulatedActivity))

    return ActionFailReason.None, fristClear
end

--领取模拟演习层奖励
---@param floorId integer 层id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:getSimulatedAward(floorId, proto)
    --参数检测
    if not floorId or floorId <= 0 then
        return ActionFailReason.ParameterInvalid
    end
    --配置表检测
    local floorConfig = Config.GetPveExerciseStoreyInfo(floorId)
    if not floorConfig then
        return ActionFailReason.CfgNotFind
    end

    --时间检测
    local offsetStringMap = DLuaUtil.getNextWeekRemainingTime(DLuaUtil.GetGreenwichTime())
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end

    --判断是否可领取奖励
    local activityData = self:getSimulatedActivityData()
    local floorData = activityData.simulatedLevelMap[floorId]
    if not floorData then
        return ActionFailReason.ActivityNotFinish
    end
    if floorData.getReward then
        return ActionFailReason.AwardAlready
    end
    local nowProgress = 0
    for _, levelId in pairs(floorData.levelList) do
        local levelConfig = Config.GetPveExerciseLevelInfo(levelId)
        if levelConfig then
            nowProgress = nowProgress + levelConfig.progressReward
        else
            return ActionFailReason.CfgNotFind
        end
    end
    if nowProgress < floorConfig.progressNeed then
        return ActionFailReason.ActivityNotFinish
    end


    --发放奖励
    local rewardList = self:addRewardList(floorConfig.Reward, proto, GE.EventItemType.Simulated, floorId)

    --更新数据
    floorData.getReward = true

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.simulatedActivity then
            proto.regularActivityData.simulatedActivity = {}
        end
        proto.regularActivityData.simulatedActivity = self:getSimulatedActivityData()
    end

    return ActionFailReason.None, rewardList
end

--模拟演习扫荡战斗
---@param formationId integer 编队id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:simulatedSweeping(formationId, proto)
    --参数检测
    if not formationId then
        return ActionFailReason.ParameterInvalid
    end

    local pveExerciseStoreyPass = Config.GetConfigInfo("PveExerciseStoreyPass")
    if not pveExerciseStoreyPass then
        return ActionFailReason.CfgNotFind
    end

    --时间检测
    local offsetStringMap = DLuaUtil.getNextWeekRemainingTime(DLuaUtil.GetGreenwichTime())
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end

    --数据检测
    local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
    local activityData = self:getSimulatedActivityData()
    local hisMaxFloor = activityData.maxFloor
    local quickFloor = hisMaxFloor - pveExerciseStoreyPass
    local sweepCost, sweepReward, userExp = {0,0}, {}, 0
    for _, floorConfig in pairs(floorConfigMap) do
        if floorConfig.storeyNum <= quickFloor then
            local floorData = activityData.simulatedLevelMap[floorConfig.id]
            if floorData and tablex.size(floorData.levelList) > 0 and not floorData.getReward then
                return ActionFailReason.SimulatedIsProgress
            end
            if not floorData then
                sweepCost[1] = floorConfig.passCost[1]
                sweepCost[2] = (sweepCost[2] or 0) + floorConfig.passCost[2]
                for _, award in pairs(floorConfig.passReward) do
                    table.insert(sweepReward, award)
                end
                userExp = userExp + floorConfig.userExp
            end
        end
    end

    --没有可扫荡的层数检测
    if tablex.size(sweepReward) == 0 then
        return ActionFailReason.NoSimulatedSweep
    end

    --体力检测
    if not self:checkNormalTicket(sweepCost[2]) then
        return ActionFailReason.TicketNoEnough
    end

    --扣除体力
    self:costNormalTicket(sweepCost[2], proto, GE.EventItemType.SimulatedSweep, quickFloor)

    --发放奖励
    local rewardList = self:addRewardList(sweepReward, proto, GE.EventItemType.SimulatedSweep, quickFloor)

    --玩家经验
    self:addUserExp(userExp, proto)

    --更新数据
    for _, floorConfig in pairs(floorConfigMap) do
        if floorConfig.storeyNum <= quickFloor and not activityData.simulatedLevelMap[floorConfig.id] then
            activityData.simulatedLevelMap[floorConfig.id] = {
                levelList = {},
                getReward = true,
            }
        end
    end

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.simulatedActivity then
            proto.regularActivityData.simulatedActivity = {}
        end
        proto.regularActivityData.simulatedActivity = self:getSimulatedActivityData()
    end

    return ActionFailReason.None, rewardList
end

--重置模拟演习数据
---@param newPeriod integer 新期数
---@param newNextTime integer 新关闭时间
---@param proto UserInfo 玩家数据
function Player:resetSimulatedData(newPeriod, newNextTime, proto )
    local simulatedActivity = self:getSimulatedActivityData()
    local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
    if not floorConfigMap or not next(floorConfigMap) then
        LuaLogger.es("PveExerciseStoreyTable config not find")
    end
    table.sort(floorConfigMap, function(a, b)
        return a.storeyNum > b.storeyNum
    end)
    --更新历史最大通关层数
    for floorId, floorConfig in pairs(floorConfigMap) do
        local floorData = simulatedActivity.simulatedLevelMap[floorId]
        if floorConfig.storeyNum > simulatedActivity.maxFloor and floorData then
            local nowProgress = 0
            for _, levelId in pairs(floorData.levelList) do
                local levelConfig = Config.GetPveExerciseLevelInfo(levelId)
                if levelConfig then
                    nowProgress = nowProgress + levelConfig.progressReward
                else
                    LuaLogger.es("PveExerciseLevelTable config not find")
                end
            end
            if nowProgress >= floorConfig.progressNeed then
                simulatedActivity.maxFloor = floorConfig.storeyNum
            end
        end
    end
    --更新当前期数
    local newLevelCfgList = Config.GetPveExerciseLevelByIssueAndStorey(newPeriod, 1)
    if not newLevelCfgList or not next(newLevelCfgList) then--若无配置表则重置为第一期
        simulatedActivity.nowPeriod = 1
    else
        simulatedActivity.nowPeriod = newPeriod
    end
    --更新下期刷新时间
    simulatedActivity.closingTime = newNextTime
    --重置模拟演习层数据
    simulatedActivity.simulatedLevelMap = {}
    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.simulatedActivity then
            proto.regularActivityData.simulatedActivity = {}
        end
        proto.regularActivityData.simulatedActivity = self:getSimulatedActivityData()
    end
end

return Player