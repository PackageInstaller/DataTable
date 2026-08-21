-- Desc: 玩家材额外奖励相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

--额外掉落配置
local extraRewardsCfg = Config.GetConfigInfo("PveExtraReward")

--更新额外奖励数据
---@param proto UserInfo 玩家数据
function Player:refreshExtraRewardsData(proto)
    local userData = self:getUserData()
    local daysCount = 0
    if not userData.LastDailyRefreshTime or userData.LastDailyRefreshTime <= 0 then
        daysCount = 1
    else
        --累计天数
        daysCount = DLuaUtil.GetApartDays(userData.LastDailyRefreshTime, DLuaUtil.GetGreenwichTime())
    end
    self:recoverExtraRewards(daysCount, proto)
    userData.LastDailyRefreshTime = DLuaUtil.GetGreenwichTime()
end

--获取额外奖励数据
---@return table<integer, ExtraRewardsInfo>
function Player:getExtraRewardsData()
    return self.extraRewardsMap
end

--恢复额外奖励次数
---@param days integer 天数
---@param proto UserInfo 玩家数据
function Player:recoverExtraRewards(days, proto)
    local extraRewardsMap = self:getExtraRewardsData()
    for _, config in pairs(extraRewardsCfg) do
        ---@type integer
        local extraRewardType = config[1] --额外奖励类型
        local dailyReset = config[2]  --每日增加次数
        local countLimit = config[3]  --次数上限
        local needAddCount = dailyReset * days
        local addCount = math.min(countLimit, extraRewardsMap[extraRewardType].count + needAddCount)
        extraRewardsMap[extraRewardType].count = addCount
        extraRewardsMap[extraRewardType].extraCount = self:GetCycleCardPrivilegeAddCount(100 + extraRewardType)
    end
    if proto then
        proto.extraRewardsMap = extraRewardsMap
    end
end

function Player:recoverExtraCount(proto)
    local extraRewardsMap = self:getExtraRewardsData()
    for _, config in pairs(extraRewardsCfg) do
        ---@type integer
        local extraRewardType = config[1] --额外奖励类型
        extraRewardsMap[extraRewardType].extraCount = self:GetCycleCardPrivilegeAddCount(100 + extraRewardType)
    end
    proto.extraRewardsMap = extraRewardsMap
end

--根据关卡表数据判断是否可以领取额外奖励
---@param levelConfig PveLevelTable 关卡配置
---@param proto UserInfo 玩家数据
---@return boolean
function Player:canGetExtraRewards(levelConfig, proto)
    if not next(levelConfig.ExtraReward) then
        return false
    end
    local chapterId = levelConfig.page
    local chapterConfig = Config.GetChapterInfo(chapterId)
    if not chapterConfig then
        return false
    end
    for _, weekday in pairs(chapterConfig.ExtraRewardTime or {}) do
        if weekday == DLuaUtil.getWeekDayWithOffset(DLuaUtil.GetGreenwichTime()) then
            return self:useExtraRewardsCount(chapterConfig.DeepType, proto)
        end
    end
    return false
end

--消耗额外奖励次数
---@param extraRewardType integer 额外奖励类型
---@param proto UserInfo 玩家数据
---@return boolean
function Player:useExtraRewardsCount(extraRewardType, proto)
    local extraRewardsMap = self:getExtraRewardsData()
    local extraReward = extraRewardsMap[extraRewardType]
    extraReward.extraCount =  extraReward.extraCount or 0
    local maxCount = extraReward.count + extraReward.extraCount
    if maxCount <= 0 then
        return false
    else
        local delCount = 1
        local d = math.min(delCount, extraReward.extraCount)
        if d > 0 then
            extraReward.extraCount = extraReward.extraCount - d
            delCount = delCount - d
        end

        extraReward.count = extraReward.count - delCount
        if proto then
            if not proto.extraRewardsMap then
                proto.extraRewardsMap = {}
            end
            proto.extraRewardsMap = self:getExtraRewardsData()
        end
        return true
    end
end

---添加额外奖励次数
---@param addType integer 类型
---@param addType integer 增加数量
---@param proto UserInfo
function Player:AddMaterialExtraAddCount(addType, addCount, proto)
    if addCount == nil or addCount == 0 then
       return 
    end
    local extraRewardsMap = self:getExtraRewardsData()
    if extraRewardsMap == nil then
       return 
    end
    local info = extraRewardsMap[addType]
    if info == nil then
       return 
    end
    info.extraCount = (info.extraCount or 0) + addCount
    proto.extraRewardsMap = self:getExtraRewardsData()
end

return Player