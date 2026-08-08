--战斗相关的逻辑处理

---@class Player
local Player = require "Player"
local DataLogMgr
local battleMsg
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    battleMsg = require "battleMsg"
end

---获取编队列表信息
function Player:getFormationMap()
    return self.formationMap
end

---通过id获取编队信息
---@param id integer 编队id
function Player:getFormationListInfoById(id)
    if not isnumber(id) or id < 1 or id > Config.FormationCount then
        return nil
    end

    local formationMap = self:getFormationMap()
    if not formationMap[id] then
        formationMap[id] = {id = id, formationList = {}}
    end

    return formationMap[id]
end

--编队相关数据
---@param id integer 编队id
---@param formationData FormationInfo[] 编队数据
---@param userinfo UserInfo 玩家信息差量更新结构
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function Player:changeFormationList(id, formationData, userinfo)
    --编队id合法性检查
    if id == nil or id < 1 or id > Config.GetConfigInfo("FormationCount") then
        return ActionFailReason.FormationFail_InvalidId
    end

    formationData = formationData or {}

    --检查编队角色数量
    local formationCount = tablex.size(formationData)
    if formationCount > Config.GetConfigInfo("FormationHeroCount") then
        return ActionFailReason.FormationFail_InvalidRole
    end

    --检查编队内角色是否存在，且编队内角色id是否重复
    local temp = {}
    for i = 1, formationCount do
        local nowData = formationData[i]
        local roleCid = nowData.roleCid
        local heroInfo = self:getPlayerHero(roleCid)
        if heroInfo == nil then
            return ActionFailReason.FormationFail_NoRole
        end

        if not temp[roleCid] then
            temp[roleCid] = roleCid
        else
            return ActionFailReason.FormationFail_SameRole
        end
    end

    local formationInfo = self:getFormationListInfoById(id)
    formationInfo.formationList = formationData
    if userinfo then
        if not userinfo.formationMap then
            userinfo.formationMap = {}
        end
        userinfo.formationMap[id] = formationInfo
    end

    return ActionFailReason.None
end

---进入关卡
---@param levelId integer
---@return ActionFailReason
function Player:BattleEnterLevel(levelId)
    if not levelId then
        return ActionFailReason.ParameterInvalid
    end
    if levelId == 0 then        ---表示退出战斗 如果没出击的时候需要调用此方法
        self.curBattlLevelId = levelId
        return ActionFailReason.None
    end

    local levelConfig = Config.GetPveLevelInfo(levelId)
    if not levelConfig then
        return ActionFailReason.CfgNotFind
    end

    --验证关卡前置关卡
    for _, v in pairs(levelConfig.unlock) do
        if v[1] == GE.CommonLockJudgeType.Level then
            local preLevelData = self:getLevelDataByid(v[2])
            if not preLevelData or preLevelData.state ~= GE.LevelStateType.Finish then
                return ActionFailReason.LackOfPrecond
            end
        end
    end

    --情报检测
    local reasion = self:CheckEnterIntelligenceBattle(levelId)
    if reasion ~= ActionFailReason.None then
       return reasion
    end

    self.curBattlLevelId = levelId
    return ActionFailReason.None
end


--开始战斗
---@param levelCid integer 关卡cid
---@param heroCidList integer[] 英雄cid列表
---@param enterMeans integer 进入方式
---@param userInfo UserInfo 玩家信息差量更新结构
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
---@return BattleStartInfo? 返回战斗开始信息
function Player:startBattle(levelCid, heroCidList, enterMeans, userInfo)
    --入参检测
    if not levelCid or not heroCidList then
        return ActionFailReason.ParameterInvalid
    end

    local levelConfig = Config.GetPveLevelInfo(levelCid)
    if not levelConfig then
        return ActionFailReason.CfgNotFind
    end

    if GV.IsServer and not self:checkBattleVersion() then
        return ActionFailReason.BattleVersionMismatch
    end

    --功能开启检测 - 困难模式是否开启
    if levelConfig.typemain == GE.LevelTypeMain.Difficulty then
        local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.DifficultyMode)
        if isOpen == GE.FunctionOpenState.Lock then
            return ActionFailReason.FunctionOpenNotOpen
        end
    end

    --功能开启检测 - 常规清剿是否开启
    if levelConfig.typemain == GE.LevelTypeMain.Material then
        local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.RegularClearance)
        if isOpen == GE.FunctionOpenState.Lock then
            return ActionFailReason.FunctionOpenNotOpen
        end

        --验证细分类型是否开启
        local chapterConfig = Config.GetChapterInfo(levelConfig.page)
        if chapterConfig then
            local deepTypeToModule = {
                [GE.ChapterDeepType.Exp] = GE.FunctionOpenModule.ExperienceMaterial,
                [GE.ChapterDeepType.Equip] = GE.FunctionOpenModule.EquipmentMaterial,
                [GE.ChapterDeepType.Skill] = GE.FunctionOpenModule.TalentTreeMaterial,
                [GE.ChapterDeepType.Technology] = GE.FunctionOpenModule.TechTreeMaterial,
            }
            local moduleId = deepTypeToModule[chapterConfig.DeepType]
            if moduleId then
                local isOpen = self:getFunctionOpenStateById(moduleId)
                if isOpen == GE.FunctionOpenState.Lock then
                    return ActionFailReason.FunctionOpenNotOpen
                end
            end
        end
    end

    --功能开启检测 - 模拟演习
    if levelConfig.typemain == GE.LevelTypeMain.Simulated then
        local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.PeriodicEvent)
        if isOpen == GE.FunctionOpenState.Lock then
            return ActionFailReason.FunctionOpenNotOpen
        end
    end

    --功能开启检测 - 危境攻坚
    if levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
        local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.WeeklyBossChallenges)
        if isOpen == GE.FunctionOpenState.Lock then
            return ActionFailReason.FunctionOpenNotOpen
        end
    end

    --体力检测
    local costTicket = levelConfig.enterCost[2] + levelConfig.victoryCost[2]
    if not self:checkNormalTicket(costTicket) then
        return ActionFailReason.TicketNoEnough
    end

    --验证关卡前置关卡
    for _, v in pairs(levelConfig.unlock) do
        if v[1] == GE.CommonLockJudgeType.Level then
            local preLevelData = self:getLevelDataByid(v[2])
            if not preLevelData or preLevelData.state ~= GE.LevelStateType.Finish then
                return ActionFailReason.LackOfPrecond
            end
        end
    end

    --验证编队角色数量
    local formationCount = tablex.size(heroCidList)
    if levelConfig.type == GE.LevelType.Story then
        if formationCount ~= 0 then
            return ActionFailReason.StoryFormation_HaveRole
        end
    else
        -- if next(levelConfig.UserPosition) then
            if formationCount > levelConfig.maxPerson  then
                return ActionFailReason.FormationFail_InvalidRole
            end
            if formationCount <= 0 then
                return ActionFailReason.FormationFail_NoCharacter
            end
        -- end
    end

    --NPC角色信息
    local npcList = {}
    for _, info in ipairs(levelConfig.npcInfo) do
        if info.calltype == 1 then
            if not tablex.find(heroCidList, info.id) then
                return ActionFailReason.FormationFail_NoNPC
            end
            if info.is_hero ~= 1 then
                table.insert(npcList, info.id)
            end
        end
    end

    --验证编队角色是否存在，且编队角色id是否重复
    local temp = {}
    for _, heroCid in ipairs(heroCidList) do
        --检查是否是NPC，如果是NPC则不需要验证
        local isNpc = tablex.find(npcList, heroCid)
        if not isNpc then
            ---@type HeroInfo
            local heroInfo = self:getPlayerHero(heroCid)
            if not heroInfo then
                return ActionFailReason.FormationFail_NoRole
            end

            if not temp[heroCid] then
                temp[heroCid] = heroCid
            else
                return ActionFailReason.FormationFail_SameRole
            end
        end
    end

    local levelInfo = self:getLevelDataByid(levelCid)
    if not levelInfo then
        --初始化
        levelInfo = {
            id = levelCid,
            state = GE.LevelStateType.Going,
            star = 0,
            achieveList = {},
            completeNum = 0,
            battleNum = 0,
            dailyBattleNum = 0,
        }
        local levelDataMap = self:getPveLevelData()
        levelDataMap[levelCid] = levelInfo
    end
    --次数检测
    if levelConfig.cleanNum ~= -1 then
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0

        local addCount = self:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - curCount
        if lastCount <= 0 then
            return ActionFailReason.InsufficientNumberChallenges
        end
    end

    --记录关卡开始剧情到图鉴
    if levelConfig.storyOpen and levelConfig.storyOpen ~= 0 then
        self:saveStoryHandbookData(levelConfig.storyOpen, userInfo)
    end

    --验证编队及武器
    local heroInfoMap = {}
    local weaponCidMap = {}
    --队伍战力-日志用
    local tps = {}
    for _, heroCid in ipairs(heroCidList) do
        --NPC不需要验证
        local isNpc = tablex.find(npcList, heroCid)
        if not isNpc then
            ---@type HeroInfo
            local heroInfo = self:getBattleHeroInfo(heroCid)
            if not heroInfo then
                return ActionFailReason.FormationFail_NoRole
            end
            heroInfoMap[heroCid] = heroInfo
            tps[heroCid] = heroInfo.allDmg or 0

            local carryWeapon = heroInfo.carryWeapon
            for _, weaponId in ipairs(carryWeapon) do
                local weaponInfo = self:getWeaponDataById(weaponId)
                -- if not weaponInfo then
                --     return ActionFailReason.WeaponNoFind
                -- end
                if weaponInfo then
                    weaponCidMap[weaponId] = weaponInfo.cid
                end
            end
        end
    end

    local battleKey = self.uid .. "_" .. math.floor(levelCid) .. "_" .. math.floor(levelInfo.battleNum)

    --扣除一段体力
    self:costNormalTicket(levelConfig.enterCost[2], userInfo, GE.EventItemType.Battle, battleKey)

    --记录战斗次数
    levelInfo.battleNum = (levelInfo.battleNum or 0) + 1

    local _weeklyBossPveLevelId = 0
    if levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
        local cfg = self:getWeeklyBossLevelConfigByLevelId(levelCid)
        if cfg then
            _weeklyBossPveLevelId = cfg.id
        end
    end

    --组装战斗开始数据
    ---@type BattleStartInfo
    local battleStartInfo = {
        -- battleKey提前保存，确保唯一性
        battleKey = battleKey,
        level = levelCid,
        randomseed = os.time(),
        heroInfoMap = heroInfoMap,--英雄信息h
        weaponCidMap = weaponCidMap,--武器信息
        levelInfo = levelInfo,
        formation = heroCidList,--编队信息
        enterMeans = enterMeans, --进入方式
        startTime = os.date('%Y-%m-%d %H:%M:%S'), --战斗开始时间
        battleNum = math.floor(levelInfo.battleNum),
        tps = tps, --队伍战力
        weeklyBossTagList = self:getWeeklyBossTagListByLevelId(levelCid),
        weeklyBossPveLevelId = _weeklyBossPveLevelId,
    }

    --保存战斗开始数据
    -- self.battleStartInfo = battleStartInfo
    local tempData = self:getUserTempData()
    tempData.battleStartInfo = clone(battleStartInfo)

    return ActionFailReason.None, battleStartInfo
end

--战斗结果
---@param orderReport BattleOrderReport 战报数据
---@param userinfo UserInfo 玩家信息差量更新结构
---@param battleLogData BattleLogData 战斗日志数据
---@param simpleVerifyData ReportRoleDoSkillData[] 简易验证数据
---@return BattleResultResp
function Player:battleResult(orderReport, userinfo, battleLogData, simpleVerifyData)

    self.curBattlLevelId = 0        ---清除情报临时数据
    local tempData = self:getUserTempData()
    -- self.battleStartInfo = tempData.battleStartInfo
    -- tempData.battleStartInfo = nil
    if not tempData or not tempData.battleStartInfo then
        --没有本场战斗数据
        return {ret = ActionFailReason.BattleNoFind}
    end

    --入参检测
    if not orderReport then
        return {ret = ActionFailReason.ParameterInvalid}
    end

    --检查关卡
    if not orderReport.initData or not orderReport.initData.level then
        return {ret = ActionFailReason.BattleNoLevelData}
    end

    local levelId = orderReport.initData.level
    if tempData.battleStartInfo.level ~= levelId then
        return {ret = ActionFailReason.BattleLevelMismatch}
    end

    local levelConfig = Config.GetPveLevelInfo(levelId)
    if not levelConfig then
        return {ret = ActionFailReason.CfgNotFind}
    end

    --NPC角色信息
    local npcList = {}
    for _, info in ipairs(levelConfig.npcInfo) do
        if info.calltype == 1 then
            if info.is_hero ~= 1 then
                table.insert(npcList, info.id)
            end
        end
    end

    local roleList = orderReport.initData.heroInfoList
    if levelConfig.type ~= GE.LevelType.Story then
        --检查编队
        if type(roleList) ~= "table" then
            return { ret = ActionFailReason.FormationFail_NoFormation }
        end

        -- if next(levelConfig.UserPosition) then
        if tablex.size(tempData.battleStartInfo.heroInfoMap) + tablex.size(npcList) ~= tablex.size(roleList) then
            return { ret = ActionFailReason.FormationFail_NotMatch }
        end
        for _, roleInfo in ipairs(roleList) do
            if not tablex.find(npcList, roleInfo.cid) and not tempData.battleStartInfo.heroInfoMap[roleInfo.cid] then
                return { ret = ActionFailReason.FormationFail_RoleNotMatch }
            end
        end
        -- end
    end

    local levelData = self:getLevelDataByid(levelId)
    if not levelData then
        LuaLogger.ds("not levelData", levelId)
        return { ret = ActionFailReason.LevelNoOpen }
    end

    local battleResult = orderReport.result == GE.BattleResultType.Win
    local resultData = orderReport.resultData
    local rewardList = {}

    --剧情关卡
    if (levelConfig.type == GE.LevelType.Story) then
        battleResult = true
        resultData = {star = levelConfig.baseStar}
    end

    --记录关卡结束剧情到图鉴（仅在战斗胜利时记录）
    if battleResult and levelConfig.storyEnd and levelConfig.storyEnd ~= 0 then
        self:saveStoryHandbookData(levelConfig.storyEnd, userinfo)
    end

    if battleResult and levelConfig.storyOver and levelConfig.storyOver ~= 0 then
        self:saveStoryHandbookData(levelConfig.storyOver, userinfo)
    end

    --记录日志数据
    local logData = {
        battleKey = tempData.battleStartInfo.battleKey,
        levelCid = levelId,
        levelType = levelConfig.typemain,
        result = orderReport.result,
        formation = tempData.battleStartInfo.formation,
        enterMeans = tempData.battleStartInfo.enterMeans,
        rounds = resultData and resultData.rounds,
        backtraceTimes = resultData and resultData.backtraceTimes or 0,
        autoSwitchCount = battleLogData and battleLogData.autoSwitchCount or -1,
        startTime = tempData.battleStartInfo.startTime,
        endTime = os.date('%Y-%m-%d %H:%M:%S'),
        tps = tempData.battleStartInfo.tps,
        star = resultData and resultData.star or 0,
        achieveList = resultData and resultData.achieveList or {},
    }

    --战斗细节日志
    if DataLogMgr and battleLogData and battleLogData.battleRoleLogData then
        battleLogData.battleKey = tempData.battleStartInfo.battleKey
        battleLogData.levelCid = levelId
        battleLogData.tps = tempData.battleStartInfo.tps
        DataLogMgr.LogBattleUnitStats(battleLogData, self)
    end

    --战斗结果数据初始化
    ---@type BattleResultResp
    local result = {
        ret = ActionFailReason.None,
        levelId = levelId,
        result = battleResult,
    }

    --战斗失败，直接返回
    if not battleResult then
        --记录日志数据
        if DataLogMgr then
            DataLogMgr.LogBattle(logData, self)
        end
        --清除战斗开始数据
        ---@type BattleStartInfo
        tempData.battleStartInfo = nil
        return result
    end

    --是否战斗验证
    local battleVerify = true

    --剧情关卡不验证、战斗验证配置为false，没有我方角色或者没有敌方角色都不验证
    if levelConfig.type == GE.LevelType.Story or (GV.IsServer and not GF.battleVerify()) or
        tablex.next(tempData.battleStartInfo.heroInfoMap) == nil or tablex.next(levelConfig.monsterInfo) == nil then
        battleVerify = false
    else
        if GV.IsServer and GF.isReleaseVersions() then
            --已处理
        else
            -- 非release模式才可以使用GM胜利
            local useGMToWinBattle = battleLogData and battleLogData.useGMToWinBattle or false
            if useGMToWinBattle then
                battleVerify = false
            end
        end
    end

    --需要验证但是没有验证数据
    if battleVerify and (not simpleVerifyData or not tablex.next(simpleVerifyData)) then
        return {ret = ActionFailReason.ParameterInvalid}
    end

    --战斗关卡,战斗验证
    if battleVerify then
        if GV.IsServer then
            local userInfo =
            {
                uid = self.uid,
                levelId = tempData.battleStartInfo.level,
                battleVersion = self.clientVersionBattle,
            }

            --是否需要简易验证
            local needSimpleVerify = true

            -- 机器人不走全量验证
            if not GF.robotTest() then
                local ret, bResult = battleMsg.battleVerify(userInfo, tempData.battleStartInfo, orderReport, nil, simpleVerifyData)
                if ret and ret ~= ActionFailReason.None then
                    return {ret = ret}
                end
                battleResult = bResult
                --走了全量就不再走简易验证
                needSimpleVerify = false
            end

            -- 简易验证 全量验证成功再进行简易验证
            if needSimpleVerify then
                local ret, bResult = battleMsg.battleSimpleVerify(userInfo, tempData.battleStartInfo, simpleVerifyData)
                if ret and ret ~= ActionFailReason.None then
                    return {ret = ret}
                end
                battleResult = bResult
            end
        else
            local battleCore = require "BattleCore"
            local battleMgr = battleCore:getBattleMgr()
            battleResult = battleMgr:verifyBattle(tempData.battleStartInfo, orderReport, nil, simpleVerifyData)

            local simpleVerifyResult = true
            if battleResult then
                for _, data in ipairs(simpleVerifyData) do
                    simpleVerifyResult = battleMgr:simpleVerifyBattle(tempData.battleStartInfo, data)
                    if not simpleVerifyResult then
                        battleResult = false
                        break
                    end
                end
            end
        end

        --未通过验证
        if not battleResult then
            --一测服不返回失败
            battleResult = true
            --疑似作弊
            -- result.ret = ActionFailReason.BattleResultMismatch
            -- result.result = battleResult
            --记录日志数据
            if DataLogMgr then
                logData.cheat = 1 --作弊
                DataLogMgr.LogBattle(logData, self)
            end

            --写入文件
            local path = string.format("./battle_verify_fail")
            os.execute("mkdir " .. path)
            local file = io.open(string.format("%s/battle_report_%d_%s.txt", path, self.uid, os.date("%Y%m%d%H%M%S")), "w")
            if file then
                file:write(luautil.serialize({
                    orderReport = orderReport,
                    simpleVerifyData = simpleVerifyData,
                    battleStartInfo = clone(tempData.battleStartInfo),
                }))
                file:close()
            end

            --一测服不返回失败
            -- --清除战斗开始数据
            -- tempData.battleStartInfo = nil
            -- return result
        else
            -- --写入文件
            -- local path = string.format("./battle_verify_win")
            -- os.execute("mkdir " .. path)
            -- local file = io.open(string.format("%s/battle_report_%d_%s.txt", path, self.uid, os.date("%Y%m%d%H%M%S")), "w")
            -- if file then
            --     file:write(luautil.serialize({
            --         orderReport = orderReport,
            --         simpleVerifyData = simpleVerifyData,
            --         battleStartInfo = clone(tempData.battleStartInfo),
            --     }))
            --     file:close()
            -- end
        end
    end

    --根据关卡大类更新关卡数据
    local star = battleResult and resultData.star or 0
    local levelInfo = {
        id = levelId,
        isWin = battleResult,
        star = star,
        achieveList = resultData.achieveList or {},
    }
    local ret, achieveRewardList, fristClear = 0, {}, false
    if levelConfig.typemain == GE.LevelTypeMain.Simulated then--模拟演习关卡
        ret, fristClear = self:setSimulatedLevelData(levelInfo, userinfo)
    elseif levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then --危境攻坚关卡
        local bossTagList = self:getWeeklyBossTagListByLevelId(levelId)
        ---@type number 周常BOSS本分数加成值
        local weeklyBossScoreAddition = 0
        for _, tagId in ipairs(bossTagList) do
            local config = Config.GetPveBossBattleEffectInfo(tagId)
            local isPass = true
            if config then
                local effectList = config.Effect or {}
                for _, effectData in ipairs(effectList) do
                    local effectDataType = effectData[1]
                    if effectDataType == GE.WeeklyBossEffectType.ShipAttribute then
                        local limitShipType = effectData[2]
                        local limitNum = effectData[4]
                        local passNum = 0
                        for _, role in ipairs(roleList) do
                            local roleConfig = Config.GetCharacterInfo(role.cid)
                            if roleConfig then
                                local roleAttribute = roleConfig.attribute
                                local restranintConfig = Config.GetCharacterRestraintInfo(roleAttribute)
                                if restranintConfig and restranintConfig.restraintType == limitShipType then
                                    passNum = passNum + 1
                                end
                            end
                        end
                        local r = CommonLogic.CompareTwoValue(passNum, limitNum, effectData[3])
                        if r == false then
                            isPass = false
                            break
                        end
                    end
                end

                if isPass == true then
                    weeklyBossScoreAddition = weeklyBossScoreAddition + config.ScoreAddition
                end
            end
        end
        local finalScore = math.floor((resultData.friendCampDamage or 0) * (1 + weeklyBossScoreAddition))
        ret = self:setWeeklyBossLevelData(levelInfo, finalScore, resultData.rounds, userinfo)
    else
        ret, achieveRewardList = self:setLevelData(levelInfo, userinfo)
    end

    --设置战斗关卡数据失败
    if not (ret == ActionFailReason.None) then
        --疑似作弊
        result.ret = ret
        result.result = false

        --清除战斗开始数据
        tempData.battleStartInfo = nil
        return result
    end

    --扣除二段体力
    self:costNormalTicket(levelConfig.victoryCost[2], userinfo, GE.EventItemType.Battle, tempData.battleStartInfo.battleKey)

    --增加关卡奖励
    local dropList = {}
    ---@type HeroData[]
    local rolesDataList = {}
    local oldUserExp = 0
    local fristDrop = {}


    if levelConfig.typemain ~= GE.LevelTypeMain.Simulated then--非模拟演习关卡
        --首通奖励 第一次且配置有第一次配置才会显示首通奖励
        if levelData ~= nil and  levelData.completeNum == 1 and levelConfig.firstDrop ~= nil and #levelConfig.firstDrop > 0 then
            fristClear = true
        end
    end

    if fristClear then--首通
        fristDrop = self:addRewardList(levelConfig.firstDrop, userinfo, GE.EventItemType.Battle, math.floor(levelId))
    else--普通掉落
        for _, randomAwardId in ipairs(levelConfig.nomalDrop) do
            dropList = tablex.combine(dropList, self:getRandomAward(randomAwardId))
        end
        rewardList = self:addRewardList(dropList, userinfo, GE.EventItemType.Battle, math.floor(levelId))
        rewardList = self:mergeRewardList(rewardList)
    end

    --判断额外掉落
    local extraDropList = {}
    local extraRewardList = {}
    if levelData.completeNum > 1 then--第一次通关时不消耗额外奖励
        if self:canGetExtraRewards(levelConfig, userinfo) then
            for _, randomAwardId in ipairs(levelConfig.ExtraReward) do
                extraDropList = tablex.combine(extraDropList, self:getRandomAward(randomAwardId))
            end
            extraRewardList = self:addRewardList(extraDropList, userinfo, GE.EventItemType.Battle, math.floor(levelId))
            extraRewardList = self:mergeRewardList(extraRewardList)
        end
    end

    --增加英雄经验
    for _, info in ipairs(roleList or {}) do
        local roleInfo = self:getPlayerHero(info.cid)
        if roleInfo then
            self:addExpByHero(roleInfo.id, levelConfig.exp, userinfo)
            ---@type HeroData
            local roleData = {
                id = info.id,
                cid = roleInfo.id,
                level = roleInfo.level,
                nowExp = roleInfo.exp
            }
            table.insert(rolesDataList, roleData)
        end
    end

    --增加玩家经验
    oldUserExp = self.exp
    self:addUserExp(levelConfig.userExp, userinfo)

    --整理击杀怪物列表
    local killMonsterCount = 0
    for _, round in pairs(orderReport.simpleReport or {}) do
        for _, report in pairs(round.reportList or {}) do
            for _, monsterId in pairs(report.defeatCidList or {}) do
                self:missionTrigger(GE.MissionFinishType.KillEnemyTypeCount, {enemyId = monsterId}, userinfo, {})
                killMonsterCount = killMonsterCount + 1
            end
        end
    end

    self:FinishCombatIntellgence(levelId, userinfo)

    --记录怪物图鉴
    if levelConfig.monsterShow then
        self:setMonsterHandbookDataByLevelId(levelId, userinfo)
    end

    --事件触发器
    self:ActivateEventTrigger(GE.EventTriggerType.EveryBattle,1, userinfo)
    --任务触发器
    self:missionTrigger(GE.MissionFinishType.ClearLevel, {}, userinfo, {})
    self:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = levelConfig.id, count = 1}, userinfo, {})
    self:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, userinfo, {})
    self:missionTrigger(GE.MissionFinishType.KillEnemyCount, {count = killMonsterCount}, userinfo, {})
    self:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = levelId, count = 1}, userinfo)

    --记录日志数据
    if DataLogMgr then
        DataLogMgr.LogBattle(logData, self)
    end

    --返回值
    result.star = star
    result.heroExp = levelConfig.exp
    result.userExp = oldUserExp
    result.fristDrop = fristDrop
    result.rewardList = rewardList
    result.rolesDataList = rolesDataList
    result.achieveRewardList = achieveRewardList
    result.extraRewardList = extraRewardList

    --清除战斗开始数据
    tempData.battleStartInfo = nil
    return result
end

--自动切换角色和技能测试战斗
---@param levelCid integer 关卡cid
---@return BattleStartInfo?
function Player:AutoChangeRoleAndSkillToBattleData(levelCid)
    local levelConfig = Config.GetPveLevelInfo(levelCid)
	if not levelConfig then
		LuaLogger.es("BattleManager:setLocalStartBattleData levelConfig is nil for levelCid:", levelCid)
		return
	end
	local formationBlockNum = tablex.size(levelConfig.UserPosition)
	local maxPlayerNum = math.min(levelConfig.maxPerson, formationBlockNum)
    local heroCidList = {}
    local beforeRandomHeroList = {}
    local heroList = self:getHeroList()
    for id, _ in pairs(heroList) do
        beforeRandomHeroList[#beforeRandomHeroList + 1] = id
    end

    for i = 1, maxPlayerNum, 1 do
        local randomIndex = math.random(1, #beforeRandomHeroList)
        heroCidList[i] = beforeRandomHeroList[randomIndex]
        table.remove(beforeRandomHeroList, randomIndex)
    end
    -- 获取英雄信息
    local heroInfoMap = {}
    local weaponCidMap = {}

    -- 处理NPC角色信息
    local npcList = {}
    for _, info in ipairs(levelConfig.npcInfo or {}) do
        if info.calltype == 1 and info.is_hero ~= 1 then
			npcList[info.id] = 1
        end
    end
    -- 收集英雄和武器信息
    for _, heroCid in ipairs(heroCidList) do
        -- 检查是否是NPC
        local isNpc = npcList[heroCid]
        if not isNpc then
            -- 获取英雄战斗信息
            local heroInfo = self:getBattleHeroInfo(heroCid)
			local testConfig = Config.GetBattleTestInfo(heroCid)
            if heroInfo then
				if testConfig then
					if testConfig.baseSkill and tablex.next(testConfig.baseSkill) then
						local testActiveSkillList = tablex.clone(testConfig.baseSkill)
						local replaceSkillList = {}
						for i = 1, 3, 1 do
							local skillCount = #testActiveSkillList
							if skillCount == 0 then
								break
							end
							local index = math.random(1, skillCount)
							local newSkillId = testActiveSkillList[index]
							table.insert(replaceSkillList, newSkillId)
							table.remove(testActiveSkillList, index)
						end
						heroInfo.EquippedSkillList = replaceSkillList
					end
					if testConfig.passiveSkill and tablex.next(testConfig.passiveSkill) then
						local testPassiveSkillList = tablex.clone(testConfig.passiveSkill)
						local replaceSkillList = {}
						for i = 1, 5, 1 do
							local skillCount = #testPassiveSkillList
							if skillCount == 0 then
								break
							end
							local index = math.random(1, skillCount)
							local newSkillId = testPassiveSkillList[index]
							table.insert(replaceSkillList, newSkillId)
							table.remove(testPassiveSkillList, index)
						end
						heroInfo.effectiveSkill = replaceSkillList
					end
				end
                heroInfoMap[heroCid] = heroInfo
                -- 收集武器信息
                local carryWeapon = heroInfo.carryWeapon or {}
                for _, weaponId in ipairs(carryWeapon) do
                    local weaponInfo = self:getWeaponDataById(weaponId)
                    if weaponInfo then
                        weaponCidMap[weaponId] = weaponInfo.cid
                    end
                end
            end
        end
    end

    -- 创建战斗开始信息
    ---@type BattleStartInfo
    local battleStartInfo = {
        level = levelCid,
        randomseed = os.time(),
        heroInfoMap = heroInfoMap,            -- 英雄信息
        weaponCidMap = weaponCidMap,          -- 武器信息
        levelInfo = {},                -- 关卡进度信息
        formation = heroCidList,              -- 编队信息
        enterMeans = 0,         -- 进入方式
        startTime = os.date('%Y-%m-%d %H:%M:%S'), -- 战斗开始时间
    }

    return battleStartInfo
end

---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
---@return BattleOrderReport? 战报数据
function Player:AutoChangeRoleAndSkillToBattleTest(levelCid, battleStartInfo)
    if not battleStartInfo then
        return ActionFailReason.ParameterInvalid
    end
    local battleCore = require "BattleCore"
    local battleMgr = battleCore:getBattleMgr()
    local _, orderReport = battleMgr:LocalStartBattle(levelCid, battleStartInfo, false)
    return ActionFailReason.None, orderReport
end

--生成自动战斗战报
---@param levelCid integer 关卡cid
---@param heroCidList integer[] 英雄cid列表
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
---@return BattleOrderReport? 战报数据
---@return ReportRoleDoSkillData[]? 简易验证数据
---@return BattleStartInfo? 战斗开始信息
function Player:generateAutoBattleReport(levelCid, heroCidList)
    --入参检测
    if not levelCid or not heroCidList then
        return ActionFailReason.ParameterInvalid
    end

    local levelConfig = Config.GetPveLevelInfo(levelCid)
    if not levelConfig then
        return ActionFailReason.CfgNotFind
    end

    --NPC角色信息
    local npcList = {}
    for _, info in ipairs(levelConfig.npcInfo) do
        if info.calltype == 1 then
            if not tablex.find(heroCidList, info.id) then
                return ActionFailReason.ParameterInvalid
            end
            if info.is_hero ~= 1 then
                table.insert(npcList, info.id)
            end
        end
    end

    --验证编队及武器
    local heroInfoMap = {}
    local weaponCidMap = {}
    for _, heroCid in ipairs(heroCidList) do
        --NPC不需要验证
        local isNpc = tablex.find(npcList, heroCid)
        if not isNpc then
            ---@type HeroInfo
            local heroInfo = self:getBattleHeroInfo(heroCid)
            if not heroInfo then
                return ActionFailReason.FormationFail_NoRole
            end
            local testConfig = Config.GetBattleTestInfo(heroCid)
            if testConfig then
            	if testConfig.baseSkill and tablex.next(testConfig.baseSkill) then
            		local testActiveSkillList = tablex.clone(testConfig.baseSkill)
            		local replaceSkillList = {}
            		for i = 1, 3, 1 do
            			local skillCount = #testActiveSkillList
            			if skillCount == 0 then
            				break
            			end
            			local index = math.random(1, skillCount)
            			local newSkillId = testActiveSkillList[index]
            			table.insert(replaceSkillList, newSkillId)
            			table.remove(testActiveSkillList, index)
            		end
            		heroInfo.EquippedSkillList = replaceSkillList
                    LuaLogger.ds(string.format("heroCid: %d, replaceSkillList: %s", heroCid, table.concat(replaceSkillList, ",")))
            	end
            	if testConfig.passiveSkill and tablex.next(testConfig.passiveSkill) then
            		local testPassiveSkillList = tablex.clone(testConfig.passiveSkill)
            		local replaceSkillList = {}
            		for i = 1, 5, 1 do
            			local skillCount = #testPassiveSkillList
            			if skillCount == 0 then
            				break
            			end
            			local index = math.random(1, skillCount)
            			local newSkillId = testPassiveSkillList[index]
            			table.insert(replaceSkillList, newSkillId)
            			table.remove(testPassiveSkillList, index)
            		end
            		heroInfo.effectiveSkill = replaceSkillList
                    LuaLogger.ds(string.format("heroCid: %d, replaceSkillList: %s", heroCid, table.concat(replaceSkillList, ",")))
            	end
            end

            heroInfoMap[heroCid] = heroInfo

            local carryWeapon = heroInfo.carryWeapon
            for _, weaponId in ipairs(carryWeapon) do
                local weaponInfo = self:getWeaponDataById(weaponId)
                if weaponInfo then
                    weaponCidMap[weaponId] = weaponInfo.cid
                end
            end
        end
    end

    ---@type BattleStartInfo
    local battleStartInfo = {
        level = levelCid,
        randomseed = os.time(),
        heroInfoMap = heroInfoMap,--英雄信息
        weaponCidMap = weaponCidMap,--武器信息
        levelInfo = {},
        formation = heroCidList,--编队信息
        enterMeans = 0, --进入方式
        startTime = os.date('%Y-%m-%d %H:%M:%S'), --战斗开始时间
    }

    LuaLogger.Enabled = false
    local battleCore = require "BattleCore"
    local battleMgr = battleCore:getBattleMgr()
    local _, orderReport, simpleVerifyData = battleMgr:LocalStartBattle(levelCid, battleStartInfo, false)
    LuaLogger.Enabled = true
    if not orderReport then
        return ActionFailReason.BattleNoFind
    end

    local ret = self:verifyBattleReport(orderReport, simpleVerifyData, battleStartInfo)
    if ret == ActionFailReason.None then
        --写入文件
        if not self.test_battle_num then
            self.test_battle_num = 1
        end
        local path = string.format("./clientRobot/test")
        os.execute("mkdir " .. path)
        local file = io.open(string.format("%s/auto_battle_report_%d.txt", path, self.test_battle_num), "w")
        if file then
            file:write(luautil.serialize({
                orderReport = orderReport,
                simpleVerifyData = simpleVerifyData,
                battleStartInfo = battleStartInfo
            }))
            self.test_battle_num = self.test_battle_num + 1
            file:close()
        end
    else
        LuaLogger.es("verifyBattleReport failed: ", ret)
        --写入文件
        local path = string.format("./clientRobot/verify_fail")
        os.execute("mkdir " .. path)
        local file = io.open(string.format("%s/auto_battle_report_verify_fail_%s.txt", path, os.date("%Y%m%d%H%M%S")), "w")
        if file then
            file:write(luautil.serialize({
                orderReport = orderReport,
                simpleVerifyData = simpleVerifyData,
                battleStartInfo = battleStartInfo
            }))
            file:close()
        end
        return ret
    end


    return ActionFailReason.None, orderReport, simpleVerifyData, battleStartInfo
end

--验证战斗战报
---@param orderReport BattleOrderReport? 战报数据
---@param simpleVerifyData ReportRoleDoSkillData[]? 简易验证数据
---@param battleStartInfo BattleStartInfo? 战斗开始信息
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function Player:verifyBattleReport(orderReport, simpleVerifyData, battleStartInfo)
    --入参检测
    if not battleStartInfo then
        return ActionFailReason.ParameterInvalid
    end

    if GV.IsServer then
        local userInfo = 
        {
            uid = self.uid,
            levelId = battleStartInfo.level,
            battleVersion = self.clientVersionBattle,
        }
        -- 全量验证
        if orderReport then
            LuaLogger.ds("server,orderReport")
            local result = orderReport.result == GE.BattleResultType.Win
            local ret, battleResult = battleMsg.battleVerify(userInfo, battleStartInfo, orderReport, nil, simpleVerifyData)
            if ret and ret ~= ActionFailReason.None then
                return ret
            end
            --未通过验证
            if result ~= battleResult then
                LuaLogger.es("result ~= battleResult", tostring(result), tostring(battleResult))
                return ActionFailReason.BattleResultMismatch
            end
        end

        --简易验证
        if simpleVerifyData then
            LuaLogger.ds("server,simpleVerifyData")
            local ret, verifyBattleResult = battleMsg.battleSimpleVerify(userInfo, battleStartInfo, simpleVerifyData)
            if ret and ret ~= ActionFailReason.None then
                return ret
            end
            if not verifyBattleResult then
                LuaLogger.es("simple verify battle fail")
                return ActionFailReason.BattleResultMismatch
            end
        end
    else
        local battleCore = require "BattleCore"
        local battleMgr = battleCore:getBattleMgr()

        -- 全量验证
        if orderReport then
            LuaLogger.ds("client,orderReport")
            local result = orderReport.result == GE.BattleResultType.Win
            local battleResult = battleMgr:verifyBattle(battleStartInfo, orderReport)
            --未通过验证
            if result ~= battleResult then
                LuaLogger.es("result ~= battleResult", tostring(result), tostring(battleResult))
                return ActionFailReason.BattleResultMismatch
            end
        end

        --简易验证
        for _, data in ipairs(simpleVerifyData or {}) do
            LuaLogger.ds("client,simpleVerifyData")
            local verifyBattleResult = battleMgr:simpleVerifyBattle(battleStartInfo, data)
            if not verifyBattleResult then
                LuaLogger.es("simple verify battle fail")
                return ActionFailReason.BattleResultMismatch
            end
        end
    end

    return ActionFailReason.None
end

return Player