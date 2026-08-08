-- Desc: 玩家关卡相关逻辑
---@class Player
local Player = require "Player"


--获取关卡总数据
---@return table<integer, PveLevelInfo> 关卡数据
function Player:getPveLevelData()
    return self.pveLevelMap
end

--通过关卡id查找关卡信息
---@param levelId integer 关卡id
---@return PveLevelInfo? 关卡信息
function Player:getLevelDataByid(levelId)
    local levelDataMap = self:getPveLevelData()
    return levelDataMap[levelId]
end

--获取章节奖励数据
---@return table<integer, ChapterAwardInfo> 章节奖励数据
function Player:getChapterAwardData()
    return self.chapterAwardMap
end

--通过章节奖励id获取章节奖励领取记录
---@param chapterAwardId integer 章节奖励id
---@return ChapterAwardInfo 章节星级奖励信息
function Player:getChapterAwardDataById(chapterAwardId)
    local chapterAwardMap = self:getChapterAwardData()
    return chapterAwardMap[chapterAwardId]
end

--获取主线当前关卡进度
---@return integer 关卡进度id
function Player:getLevelMainMax()
    return self:getUserData().LevelMainMax
end

---获取困难当前关卡进度
function Player:getLevelDifficultMax()
    return self:getUserData().LevelDifficultMax
end

--通过关卡id获取该关卡是否可以开启
---@param levelId integer 关卡id
---@return boolean
function Player:getLevelIsUnLock(levelId)
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if not levelConfig then
        LuaLogger.es("Config Not Find:", levelId)
        return false
    end
    for _, level in pairs(levelConfig.unlock) do
        if level[1] == GE.CommonLockJudgeType.Level then
            local condition = self:getLevelDataByid(level[2])
            if condition == nil or condition.state ~= GE.LevelStateType.Finish then
                return false
            end
        end
    end
    return true
end

--通过chapter的id获取当前是故事场景，还是故事和困难场景同时存在
---@param chapterId integer 章节id
---@return boolean
function Player:getChapterIsHadDifficulty(chapterId)
    local chapterConfig = Config.GetAllConfig("ChapterTable")
    if not chapterConfig then
        LuaLogger.es("Config Not Find:", chapterId)
        return false
    end
    for k , chapter in pairs(chapterConfig) do
        if chapter and chapter.DeepType == chapterId then
            return true
        end
    end
    return false
end

--通过关卡id判断该关卡是否通关过
---@param levelId integer 关卡id
---@return boolean
function Player:getLevelIsPassed(levelId)
    local levelData = self:getLevelDataByid(levelId)
    if levelData and levelData.completeNum > 0 then
        return true
    end
    return false
end

--通过chapter的id获取通关的数量
---@param chapterId integer 章节id
---@return integer 通关数量
function Player:getChapterHadPassedLevelCount(chapterId)
    local hadPassedCount = 0
    local chapterInfo = Config.GetChapterInfo(chapterId)
    if not chapterInfo then
        LuaLogger.es("Config Not Find:", chapterId)
        return 0
    end
    for _, v in pairs(chapterInfo.PveLevel or {}) do
        if chapterInfo.Type == GE.ChapterType.MainDifficult then
            local difficultConfig = Config.GetPveLevelInfo(v[1])
            if v[4] == GE.LevelPointType.Normal and difficultConfig.type ~= GE.LevelType.Story then
                local isPassed = self:getLevelIsPassed(v[1])
                if isPassed and isPassed == true then
                    hadPassedCount = hadPassedCount + 1
                end
            end
        else
            local isPassed = self:getLevelIsPassed(v[1])
            if isPassed and isPassed == true then
                hadPassedCount = hadPassedCount + 1
            end
        end
    end
    return hadPassedCount
end

---@class SetLevelNeedData
---@field id integer 关卡id
---@field isWin boolean 是否获胜
---@field star integer  星级
---@field achieveList integer[] 成就列表

--更新关卡信息
---@param data SetLevelNeedData 部分关卡数据
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? achRewardList 奖励列表
function Player:setLevelData(data, proto)
    local levelId = data.id
    local isWin = data.isWin
    local starNum = data.star
    local achieveList = data.achieveList
    local levelconfig = Config.GetPveLevelInfo(levelId)

    --失败不更新数据
    if not isWin then
        return ActionFailReason.LevelNoPass
    end

    --参数检测
    if starNum < 0 or not achieveList then
        return ActionFailReason.ParameterInvalid
    end

    --配置表检测
    if not levelconfig then
        return ActionFailReason.CfgNotFind
    end

    local levelData = self:getLevelDataByid(levelId)
    if not levelData then
        return ActionFailReason.LevelNoOpen
    end

    --成就检测
    local newAchieveList = {}
    for _, achieveId in pairs(achieveList) do
        --是否存在检测
        local achConfig = Config.GetPveLevelAchieveInfo(achieveId)
        if not achConfig then
            return ActionFailReason.CfgNotFind
        end
        --检测是否为本关成就
        if not tablex.find(levelconfig.achieve, achieveId) then
            return ActionFailReason.ParameterInvalid
        end
        --防重复添加成就
        if not tablex.find(levelData.achieveList, achieveId) then
            if not newAchieveList[achieveId] then
                newAchieveList[achieveId] = achieveId
            end
        end
    end

    --关卡数据检测
    if levelData then--有数据则根据逻辑修改数据
        if levelData.state == GE.LevelStateType.Going then
            levelData.state = GE.LevelStateType.Finish
        end

        levelData.star = math.max(levelData.star, starNum)

        for _, v in pairs(newAchieveList) do
            tablex.insertproxy(levelData.achieveList, v)
        end
        levelData.completeNum = levelData.completeNum + 1
        levelData.dailyBattleNum = (levelData.dailyBattleNum or 0) + 1
    end

    --更新主线关卡最大值
    if self:checkLevelFirstComplete(levelId) and levelconfig.typemain == GE.LevelTypeMain.Main then
        self.userData.LevelMainMax = levelId
        --更新社交数据
        self:socialUpdateCurrLevelId(levelId)
    end

    if self:checkLevelFirstComplete(levelId) and levelconfig.typemain == GE.LevelTypeMain.Difficulty then
        self.userData.LevelDifficultMax = levelId
    end

    --获胜则根据新增关卡成就添加奖励
    local achRewardList = {}
    for _, achieveId in pairs(newAchieveList) do
        local achConfig = Config.GetPveLevelAchieveInfo(achieveId)
        local singleAchReward = self:addRewardList(achConfig.award, proto, GE.EventItemType.LevelAchievement, levelId)
        achRewardList = tablex.combine(achRewardList, singleAchReward)
    end

    -- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
    self:missionLockUpdate(GE.MissionUnLockType.ClearLevel, proto)
    self:FunctionOpenTrigger(GE.CommonLockJudgeType.Level, proto) -- 关卡完成触发功能开放

    if proto then
        if not proto.pveLevelMap then
            proto.pveLevelMap = {}
        end
        proto.pveLevelMap[levelId] = levelData
        proto.userData = self:getUserData()
    end

    return ActionFailReason.None, achRewardList
end

--判断是否是关卡首通
---@param levelId integer 关卡id
---@return boolean
function Player:checkLevelFirstComplete(levelId)
    local levelData = self:getLevelDataByid(levelId)
    if levelData and levelData.completeNum == 1 then
        return true
    end
    return false
end

--更新关卡数据
---@param data PveLevelInfo[] 关卡数据
function Player:updatePveLevelData(data)
    for key, value in pairs(data) do
        local levelDataMap = self:getPveLevelData()
        levelDataMap[key] = value
    end
end

--重复战斗
---@param levelId integer 关卡id
---@param repeatNum integer 重复次数
---@param formationId integer 编队id（目前没有相关逻辑，后续有用）
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? resultRewardList 总奖励列表
---@return RewardInfo[]? singleRewardList 单奖励列表
---@return RewardInfo[]? extraRewardList 额外奖励列表
---@return RewardInfo[]? extraSingleList 额外单奖励列表
function Player:finishBattleRepeat(levelId, repeatNum, formationId, proto)
    --参数检测
    if not levelId or not repeatNum or not formationId then
        return ActionFailReason.ParameterInvalid
    end

    local levelData = self:getLevelDataByid(levelId)
    if not levelData then
        return ActionFailReason.CfgNotFind
    end

    --通关状态检测
    if levelData.state ~= GE.LevelStateType.Finish then
        return ActionFailReason.LevelNoPass
    end

    --次数检测
    if repeatNum < 1 then
        return ActionFailReason.ParameterInvalid
    end

    --配置表检测
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if not levelConfig then
        return ActionFailReason.CfgNotFind
    end

    local addCount = self:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
    --通过次数检测
    if levelConfig.cleanNum ~= -1 and levelData.dailyBattleNum + repeatNum > levelConfig.cleanNum + addCount then
        return ActionFailReason.LevelNoPass
    end

    --体力检测
    local needStrength = repeatNum * (levelConfig.enterCost[2] + levelConfig.victoryCost[2])
    if not self:checkNormalTicket(needStrength) then
        return ActionFailReason.TicketNoEnough
    end

    --扣除体力
    if not self:costNormalTicket(needStrength, proto, GE.EventItemType.Sweep, levelId) then
        return ActionFailReason.TicketNoEnough
    end

    --增加关卡完成次数
    levelData.completeNum = levelData.completeNum + repeatNum
    --增加关卡完成次数
    levelData.dailyBattleNum = (levelData.dailyBattleNum or 0) + repeatNum
    if proto then
        if not proto.pveLevelMap then
            proto.pveLevelMap = {}
        end
        proto.pveLevelMap[levelId] = levelData
    end
    --获得通关奖励
    local allRewardList = {}
    local singleRewardList = {}
    local extraAllList = {}
    local extraSingleList = {}
    for i = 1, repeatNum do
        local rewardList = {}
        for _, randomAwardId in ipairs(levelConfig.nomalDrop) do
            rewardList = tablex.combine(rewardList, self:getRandomAward(randomAwardId))
        end
        singleRewardList[i] = {}
        singleRewardList[i].list = self:mergeRewardList(self:addRewardList(rewardList, proto, GE.EventItemType.Sweep, levelId))
        allRewardList = tablex.combine(allRewardList, singleRewardList[i].list)

        --额外奖励
        local extraDropList = {}
        if self:canGetExtraRewards(levelConfig, proto) then
            for _, randomAwardId in ipairs(levelConfig.ExtraReward) do
                extraDropList = tablex.combine(extraDropList, self:getRandomAward(randomAwardId))
            end
            extraSingleList[i] = {}
            extraSingleList[i].list = self:mergeRewardList(self:addRewardList(extraDropList, proto, GE.EventItemType.Sweep, levelId))
            extraAllList = tablex.combine(extraAllList, extraSingleList[i].list)
        end
    end

    --相同道具叠加
    local resultRewardList = self:mergeRewardList(allRewardList)
    local extraRewardList = self:mergeRewardList(extraAllList)

    --玩家经验
    self:addUserExp(levelConfig.userExp * repeatNum, proto)
    --TODO好感度增加

    self:ActivateEventTrigger(GE.EventTriggerType.EveryBattle, repeatNum, proto)

    self:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = repeatNum}, proto)
    self:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = levelId, count = repeatNum}, proto)
    self:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = levelId, count = repeatNum}, proto, {})

    return ActionFailReason.None, resultRewardList, singleRewardList, extraRewardList, extraSingleList
end

--领取章节星级奖励
---@param chapterAwardId integer  章节奖励id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:getChapterAwardReward(chapterAwardId, proto)
    if chapterAwardId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local chapterAwardMap = self:getChapterAwardData()

    --检测是否已领取
    if chapterAwardMap[chapterAwardId] then
        return ActionFailReason.AwardAlready
    end
    --配置表检测
    local chapterStarConfig = Config.GetChapterStarInfo(chapterAwardId)
    if not chapterStarConfig then
        return ActionFailReason.CfgNotFind
    end
    local chapterId = chapterStarConfig.chapterId
    local chapterConfig = Config.GetChapterInfo(chapterId)
    if not chapterConfig then
        return ActionFailReason.CfgNotFind
    end
    --根据完成条件判断是否完成
    local completeData = chapterStarConfig.complete
    local completeType = completeData[1]
    if completeType == 1 then--章节总星级
        local completeStar = completeData[2]
        local totalStar = 0
        for _, levelId in pairs(chapterConfig.PveLevel) do
            local levelData = self:getLevelDataByid(levelId[1])
            if levelData then
                totalStar = totalStar + levelData.star
            end
        end
        --总星级检测
        if totalStar < completeStar then
            return ActionFailReason.TaskNoFinish
        end
    else
        LuaLogger.es("completeType not support", completeType)
        return ActionFailReason.CfgNotFind
    end

    --奖励发放
    local rewardList = self:addRewardList(chapterStarConfig.starAward, proto, GE.EventItemType.ChapterStar, chapterAwardId)

    --记录完成数据
    chapterAwardMap[chapterAwardId] = {getTime = DLuaUtil.GetGreenwichTime()}

    if proto then
        if not proto.chapterAwardMap then
            proto.chapterAwardMap = {}
        end
        proto.chapterAwardMap[chapterAwardId] = chapterAwardMap[chapterAwardId]
    end

    return ActionFailReason.None, rewardList
end

--更新章节奖励数据
---@param data ChapterAwardInfo[] 章节星级奖励数据
function Player:updateChapterAwardData(data)
    for key, value in pairs(data) do
        local chapterAwardMap = self:getChapterAwardData()
        chapterAwardMap[key] = value
    end
end


---检测每日pve 关卡刷新次数
function Player:CheckDailyPveLevelInfo(proto)
    local pveLevelMap = self:getPveLevelData()

    for k, v in pairs(pveLevelMap) do
        if v.dailyBattleNum ~= 0 then
            v.dailyBattleNum = 0
            if proto then
                if not proto.pveLevelMap then
                    proto.pveLevelMap = {}
                end
                proto.pveLevelMap[k] = v
            end
        end
    end
end

return Player