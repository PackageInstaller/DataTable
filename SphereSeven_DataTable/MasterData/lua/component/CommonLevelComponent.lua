---

---七星进度数据

local CommonLevelComponent = BaseClass("CommonLevelComponent",Component);
local base = Component
local currentMonth = TimeUtil.GetServerTimeSplitData().month

local function Awake(self)
    base.Awake(self)
    self.CommonLevels={}
    self.Profession = {}
    self.ServerDay = 1
end

local function CoLoadData(self)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.LevelPackReq, {
                types = {
                    LevelType.LevelTypeTower,
                    LevelType.LevelTypeChallenge,
                    LevelType.LevelTypeMonthlyTower
                }
            })
    self:SetData(info, type)
    return coroutine.yieldbreak(info)
end

local function SetData(self,data)
    local challengeDragonTable = {}
    local challengeGoldTable = {}
    local challengeExpTable = {}
    local towerTable = {}
    local monthlyTowerTable = {}
    self.CommonLevels[LevelType.LevelTypeTower] = {}
    self.CommonLevels[LevelType.LevelTypeChallenge] = {}
    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Dragon] = {}
    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Gold] = {}
    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Exp] = {}

    local challengeDataTable = {}
    local towerDataTable = {}
    local monthlyTowerDataTable = {}
    for _, levelPack in pairs(data.level_packs) do
        if levelPack.level_type == LevelType.LevelTypeChallenge then
            for _, value in ipairs(levelPack.levels) do
                challengeDataTable[value.id] = value
            end
        elseif levelPack.level_type == LevelType.LevelTypeTower then
            for _, value in ipairs(levelPack.levels) do
                towerDataTable[value.id] = value
            end
        elseif levelPack.level_type == LevelType.LevelTypeMonthlyTower then
            for _, value in ipairs(levelPack.levels) do
                monthlyTowerDataTable[value.id] = value
            end
        end
    end

    for _, levelInfo in pairs(Z_Challenge) do
        local currentLevelInfo = challengeDataTable[levelInfo.Id]
        local isLocked = true
        if levelInfo.UnlockCondition == 0 then
            isLocked = false
        else
            if challengeDataTable[levelInfo.UnlockCondition] ~= nil and challengeDataTable[levelInfo.UnlockCondition].pass_times > 0 then
                isLocked = false
            end
        end

        local value = {}
        
        if currentLevelInfo == nil then
            value = 
            {
                id = levelInfo.Id,
                star = 0,
                passTimes = 0,
                reached_goals = {},
                firstDropAvailable = true,
                firstPerfectDropAvailable = true,
                isLocked = isLocked,
                levelInfo = levelInfo,
                LevelType = LevelType.LevelTypeChallenge,
                OpenDate = levelInfo.OpenDate
            }
        else
            value = 
            {
                id = levelInfo.Id,
                star = currentLevelInfo.Star,
                passTimes = currentLevelInfo.pass_times,
                reached_goals = currentLevelInfo.reached_goals,
                firstDropAvailable = currentLevelInfo.first_drop_available,
                firstPerfectDropAvailable = currentLevelInfo.first_perfect_drop_available,
                isLocked = isLocked,
                levelInfo = levelInfo,
                LevelType = LevelType.LevelTypeChallenge,
                OpenDate = levelInfo.OpenDate
            }
        end

        if levelInfo.TypeId == ChallengeType.Dragon then
            table.insert(challengeDragonTable, value)
        elseif levelInfo.TypeId == ChallengeType.Gold then
            table.insert(challengeGoldTable, value)
        elseif levelInfo.TypeId == ChallengeType.Exp then
            table.insert(challengeExpTable, value)
        end
    end

    local currentMonthChapter = Z_MonthlyTower[currentMonth].ChapterId
    for _, levelInfo in pairs(Z_MonthlyTowerLevel) do
        if levelInfo.ChapterId == currentMonthChapter then
            local currentLevelInfo = monthlyTowerDataTable[levelInfo.Id]
            local isLocked = true
            if levelInfo.UnlockCondition == 0 then
                isLocked = false
            else
                if monthlyTowerDataTable[levelInfo.UnlockCondition] ~= nil and monthlyTowerDataTable[levelInfo.UnlockCondition].first_drop_available == false then
                    isLocked = false
                end
            end

            local value = {}

            if currentLevelInfo == nil then
                value = 
                {
                    id = levelInfo.Id,
                    star = 0,
                    passTimes = 0,
                    reached_goals = {},
                    firstDropAvailable = true,
                    firstPerfectDropAvailable = true,
                    isLocked = isLocked,
                    levelInfo = levelInfo,
                    LevelType = LevelType.LevelTypeMonthlyTower
                }
            else
                value = 
                {
                    id = levelInfo.Id,
                    star = currentLevelInfo.Star or 0,
                    passTimes = currentLevelInfo.pass_times or 0,
                    reached_goals = currentLevelInfo.reached_goals or {},
                    firstDropAvailable = currentLevelInfo.first_drop_available,
                    firstPerfectDropAvailable = currentLevelInfo.first_perfect_drop_available,
                    isLocked = isLocked,
                    levelInfo = levelInfo,
                    LevelType = LevelType.LevelTypeMonthlyTower
                }
            end

            table.insert(monthlyTowerTable, value)
        end
    end

    for _, levelInfo in pairs(Z_LordTower) do
        local currentLevelInfo = towerDataTable[levelInfo.Id]
        local isLocked = true
        if levelInfo.UnlockCondition == 0 then
            isLocked = false
        else
            if towerDataTable[levelInfo.UnlockCondition] ~= nil and towerDataTable[levelInfo.UnlockCondition].pass_times > 0 then
                isLocked = false
            end
        end

        local value = {}
        
        if currentLevelInfo == nil then
            value = 
            {
                id = levelInfo.Id,
                star = 0,
                passTimes = 0,
                reached_goals = {},
                firstDropAvailable = true,
                firstPerfectDropAvailable = true,
                isLocked = isLocked,
                levelInfo = levelInfo,
                LevelType = LevelType.LevelTypeTower
            }
        else
            value = 
            {
                id = levelInfo.Id,
                star = currentLevelInfo.Star or 0,
                passTimes = currentLevelInfo.pass_times or 0,
                reached_goals = currentLevelInfo.reached_goals or {},
                firstDropAvailable = currentLevelInfo.first_drop_available,
                firstPerfectDropAvailable = currentLevelInfo.first_perfect_drop_available,
                isLocked = isLocked,
                levelInfo = levelInfo,
                LevelType = LevelType.LevelTypeTower
            }
        end

        table.insert(towerTable, value)
    end

    table.sort(challengeDragonTable, function (a, b) return a.id < b.id end)
    table.sort(challengeGoldTable, function (a, b) return a.id < b.id end)
    table.sort(challengeExpTable, function (a, b) return a.id < b.id end)

    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Dragon] = challengeDragonTable
    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Gold] = challengeGoldTable
    self.CommonLevels[LevelType.LevelTypeChallenge][ChallengeType.Exp] = challengeExpTable
    self.CommonLevels[LevelType.LevelTypeTower] = towerTable
    self.CommonLevels[LevelType.LevelTypeMonthlyTower] = monthlyTowerTable
end

local function Dispose(self)
    base.Dispose(self)
end
CommonLevelComponent.Awake = Awake
CommonLevelComponent.Dispose = Dispose
CommonLevelComponent.SetData= SetData
CommonLevelComponent.CoLoadData = CoLoadData
return CommonLevelComponent