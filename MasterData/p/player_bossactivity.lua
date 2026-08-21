-- Desc: 玩家Boss关卡相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr, GameGlobal
local skynet
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    GameGlobal = require "GameGlobal"
    skynet = require "skynet"
end

--更新危境攻坚数据
---@param proto UserInfo 玩家数据
function Player:refreshBossActivityData(proto)
    local newPeriod = 1
    local newNextTime = DLuaUtil.GetNextWeekTime(DLuaUtil.GetGreenwichTime()) + (Config.GetConfigInfo("PveBossBattleUpdateCycle") - 7) * 24 * 3600

    --判断是否开启新一期危境攻坚
    local bossActivity = self:getBossActivityData()
    if DLuaUtil.GetGreenwichTime() > bossActivity.closingTime then
        if GameGlobal then
            skynet.fork(function()
                --获取当前期号
                local period, nextTime = GameGlobal.ActivityGetCurIdInfoReq({
                    uid = self.uid,
                    activityType = GE.ActivityType.Boss
                })
                local proto = {}
                self:resetBossActivityData(period, nextTime, proto)
                if not tablex.empty(proto) then
                    self:notifyDirect({"user.UserInfoUpdate", {userinfo = proto}})
                end
            end)
        else
            self:resetBossActivityData(newPeriod, newNextTime, proto)
        end
    end
end

--重置危境攻坚数据
---@param newPeriod integer 新期数
---@param newNextTime integer 新结束时间
---@param proto UserInfo 玩家数据
function Player:resetBossActivityData(newPeriod, newNextTime, proto )
    local bossActivity = self:getBossActivityData()
    --更新当前期数
    local newLevelCfgList = Config.GetPveBossBattleInfoByIssue(newPeriod)
    if not newLevelCfgList or not next(newLevelCfgList) then--若无配置表则重置为第一期
        bossActivity.nowPeriod = 1
    else
        bossActivity.nowPeriod = newPeriod
    end
    --更新结束时间
    bossActivity.closingTime = newNextTime
    --重置奖励
    bossActivity.scoreRewardList = {}
    --重置关卡数据
    for _, bossData in pairs(bossActivity.bossLevelMap or {}) do
        bossData.nowScore = 0
        bossData.tagList = {}
    end
    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.bossActivity then
            proto.regularActivityData.bossActivity = {}
        end
        proto.regularActivityData.bossActivity = self:getBossActivityData()
    end
end

--获取危境攻坚数据
---@return BossActivityInfo
function Player:getBossActivityData()
    return self.regularActivityData.bossActivity
end

--根据危境攻坚关卡id获取对应boss配置
---@param levelId integer 关卡id
---@return PveBossBattleLevelTable|nil boss配置
function Player:getWeeklyBossLevelConfigByLevelId(levelId)
    local bossActivity = self:getBossActivityData()

    --通过关卡id查找对应的Boss配置
    local bossConfig = nil
    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(bossActivity.nowPeriod)
    local allBossConfigs = {}
    for _, bossId in pairs(bossBattleCfg and bossBattleCfg.BossBattleId or {}) do
        local cfg = Config.GetPveBossBattleLevelInfo(bossId)
        table.insert(allBossConfigs, cfg)
    end
    for _, config in pairs(allBossConfigs) do
        if config.LevelId then
            for _, id in ipairs(config.LevelId) do
                if id == levelId then
                    bossConfig = config
                    break
                end
            end
        end
        if bossConfig then
            break
        end
    end

    return bossConfig
end

--根据危境攻坚关卡id获取对应boss tag列表
---@param levelId integer 关卡id
---@return integer[] tagId列表
function Player:getWeeklyBossTagListByLevelId(levelId)
    local bossActivity = self:getBossActivityData()

    --通过关卡id查找对应的Boss配置
    local bossConfig = self:getWeeklyBossLevelConfigByLevelId(levelId)
    if not bossConfig then
        return {}
    end

    local bossLevelData = bossActivity.bossLevelMap and bossActivity.bossLevelMap[bossConfig.id] or nil
    if not bossLevelData then
        return {}
    end

    return bossLevelData.tagList or {}
end

--设置Boss关卡数据
---@param levelInfo PveLevelInfo 关卡数据
---@param score integer 本次得分
---@param roundCount integer 本次战斗回合数
---@param proto UserInfo 玩家数据
---@return ActionFailReason 错误码
function Player:setWeeklyBossLevelData(levelInfo, score, roundCount, proto)
    local bossActivity = self:getBossActivityData()

    --时间检测
    local nowTime = DLuaUtil.GetGreenwichTime()
    local offsetStringMap = DLuaUtil.getBossActivityRemainingTime(bossActivity.closingTime, nowTime)
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end

    --通过关卡id查找对应的Boss配置
    local bossConfig = nil
    local levelDifficulty = 0  --当前关卡难度（在LevelId数组中的位置，从1开始）

    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(bossActivity.nowPeriod)
    local allBossConfigs = {}
    for _, bossId in pairs(bossBattleCfg and bossBattleCfg.BossBattleId or {}) do
        local cfg = Config.GetPveBossBattleLevelInfo(bossId)
        table.insert(allBossConfigs, cfg)
    end
    for _, config in pairs(allBossConfigs) do
        if config.LevelId then
            for index, levelId in ipairs(config.LevelId) do
                if levelId == levelInfo.id then
                    bossConfig = config
                    levelDifficulty = index
                    break
                end
            end
        end
        if bossConfig then
            break
        end
    end

    if not bossConfig then
        return ActionFailReason.CfgNotFind
    end

    local bossLevelData = bossActivity.bossLevelMap[bossConfig.id]

    if bossLevelData then
        --已有数据，更新分数和难度
        if bossLevelData.maxDifficulty < levelDifficulty then
            bossLevelData.maxDifficulty = levelDifficulty
        end

        --更新当前分数
        if bossLevelData.nowScore < score then
            bossLevelData.nowScore = score
        end

        --更新历史最高分数
        if bossLevelData.nowScore > (bossLevelData.maxScore or 0) then
            bossLevelData.maxScore = bossLevelData.nowScore
        end
    else
        --首次挑战该Boss
        bossActivity.bossLevelMap[bossConfig.id] = {
            nowScore = score,
            maxScore = score,
            maxDifficulty = levelDifficulty,
            tagList = {},
        }
        bossLevelData = bossActivity.bossLevelMap[bossConfig.id]
    end

    --触发任务：BOSS通关指定难度
    self:missionTrigger(GE.MissionFinishType.BossLevelClearDifficult, {bossId = bossConfig.id, difficulty = levelDifficulty}, proto)

    --触发任务：通过危境攻坚任意指定难度关卡
    self:missionTrigger(GE.MissionFinishType.BossLevelClearAnyDifficult, {difficulty = levelDifficulty}, proto)

    --触发任务：BOSS历史最高积分达到目标
    self:missionTrigger(GE.MissionFinishType.BossLevelReachPoint, {bossId = bossConfig.id, score = bossLevelData.maxScore}, proto)

    --触发任务：BOSS在指定回合内获得积分（如果传入了回合数）
    if roundCount and roundCount > 0 then
        self:missionTrigger(GE.MissionFinishType.BossLevelGetPointInRound, {bossId = bossConfig.id, roundCount = roundCount, score = score}, proto)
    end

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.bossActivity then
            proto.regularActivityData.bossActivity = {}
        end
        proto.regularActivityData.bossActivity = self:getBossActivityData()
    end

    return ActionFailReason.None
end

--领取Boss积分奖励
---@param scoreId integer 积分任务id（传0则领取所有可领取的奖励）
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:getWeeklyBossScoreAward(scoreId, proto)
    local bossActivity = self:getBossActivityData()

    --时间检测
    local nowTime = DLuaUtil.GetGreenwichTime()
    local offsetStringMap = DLuaUtil.getBossActivityRemainingTime(bossActivity.closingTime, nowTime)
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end

    --计算当期所有boss的总积分
    local totalScore = 0
    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(bossActivity.nowPeriod)
    if not bossBattleCfg then
        return ActionFailReason.CfgNotFind
    end

    for _, bossId in pairs(bossBattleCfg.BossBattleId or {}) do
        local bossLevelData = bossActivity.bossLevelMap[bossId]
        if bossLevelData then
            totalScore = totalScore + (bossLevelData.nowScore or 0)
        end
    end

    local rewardList = {}
    local scoreConfigList = {}

    if scoreId ~= 0 then
        --传入id，只判断对应任务
        if not scoreId or scoreId <= 0 then
            return ActionFailReason.ParameterInvalid
        end

        local scoreConfig = Config.GetPveBossBattleScoreInfo(scoreId)
        if not scoreConfig then
            return ActionFailReason.CfgNotFind
        end

        --检查是否已领取
        if tablex.find(bossActivity.scoreRewardList, scoreId) then
            return ActionFailReason.AwardAlready
        end

        --检查积分是否达到要求
        if totalScore < scoreConfig.scoreNum then
            return ActionFailReason.ActivityNotFinish
        end

        table.insert(scoreConfigList, scoreConfig)
    else
        --id为0，判断所有任务
        local allScoreConfigs = Config.GetAllConfig("PveBossBattleScoreTable")
        if not allScoreConfigs then
            return ActionFailReason.CfgNotFind
        end

        --筛选出所有可领取的奖励
        for _, scoreConfig in pairs(allScoreConfigs) do
            --未领取且积分达到要求
            if not tablex.find(bossActivity.scoreRewardList, scoreConfig.id) and totalScore >= scoreConfig.scoreNum then
                table.insert(scoreConfigList, scoreConfig)
            end
        end

        --没有可领取的奖励
        if #scoreConfigList == 0 then
            return ActionFailReason.ActivityNotFinish
        end
    end

    --发放奖励
    for _, scoreConfig in pairs(scoreConfigList) do
        local rewards = self:addRewardList(scoreConfig.Reward, proto, GE.EventItemType.BossScoreReward, scoreConfig.id)
        if rewards then
            for _, reward in pairs(rewards) do
                table.insert(rewardList, reward)
            end
        end

        --记录已领取
        tablex.insertproxy(bossActivity.scoreRewardList, scoreConfig.id)
    end

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.bossActivity then
            proto.regularActivityData.bossActivity = {}
        end
        proto.regularActivityData.bossActivity = self:getBossActivityData()
    end

    return ActionFailReason.None, rewardList
end

--设置Boss战所选Tag列表
---@param bossId integer Boss ID
---@param tagList integer[] Tag ID列表
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:setWeeklyBossTag(bossId, tagList, proto)
    --参数检测
    if not bossId or bossId <= 0 or not tagList then
        return ActionFailReason.ParameterInvalid
    end

    --配置表检测
    local bossConfig = Config.GetPveBossBattleLevelInfo(bossId)
    if not bossConfig then
        return ActionFailReason.CfgNotFind
    end

    --验证所有tag ID是否有效
    local mainEffectMap = {}
    for _, mainEffectId in ipairs(bossConfig.MainEffect or {}) do
        mainEffectMap[mainEffectId] = true
    end
    local selectedMainEffectMap = {}
    for _, tagId in ipairs(tagList) do
        local tagConfig = Config.GetPveBossBattleEffectInfo(tagId)
        if not tagConfig then
            return ActionFailReason.CfgNotFind
        end

        if not mainEffectMap[tagConfig.MainEffectId] then
            return ActionFailReason.ParameterInvalid
        end

        if selectedMainEffectMap[tagConfig.MainEffectId] then
            return ActionFailReason.ParameterInvalid
        end

        selectedMainEffectMap[tagConfig.MainEffectId] = true
    end

    --时间检测
    local bossActivity = self:getBossActivityData()
    local nowTime = DLuaUtil.GetGreenwichTime()
    local offsetStringMap = DLuaUtil.getBossActivityRemainingTime(bossActivity.closingTime, nowTime)
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        return ActionFailReason.SimulatedIsResetting
    end

    --获取或创建boss数据
    local bossLevelData = bossActivity.bossLevelMap[bossId]
    if not bossLevelData then
        --如果该boss数据不存在，创建初始数据
        bossActivity.bossLevelMap[bossId] = {
            nowScore = 0,
            maxScore = 0,
            maxDifficulty = 0,
            tagList = {},
        }
        bossLevelData = bossActivity.bossLevelMap[bossId]
    end

    --更新tagList
    bossLevelData.tagList = {}
    for _, tagId in ipairs(tagList) do
        tablex.insertproxy(bossLevelData.tagList, tagId)
    end

    if proto then
        if not proto.regularActivityData then
            proto.regularActivityData = {}
        end
        if not proto.regularActivityData.bossActivity then
            proto.regularActivityData.bossActivity = {}
        end
        proto.regularActivityData.bossActivity = self:getBossActivityData()
    end

    return ActionFailReason.None
end

--前端使用更新活动数据
---@param data RegularActivityInfo
function Player:updateRegularActivityData(data)
    for key, value in pairs(data) do
        self.regularActivityData[key] = value
    end
end

return Player