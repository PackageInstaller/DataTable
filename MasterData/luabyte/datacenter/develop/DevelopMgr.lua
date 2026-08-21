local DevelopMgr = BaseClass("DevelopMgr", Singleton)
local M = DevelopMgr
local EQuality = EnumConst.EQuality
local GeneOpenId = EnumConst.GeneOpenId
local TaskType = TaskConst.TaskType
local TaskState = TaskConst.TaskState
local tInsert = table.insert
local tIndexof = table.indexof

function M:__init()
    self.newHeroIds = {}
end

function M:AddNewHeroId(heroId)
    tInsert(self.newHeroIds, heroId)
end

-- 判断英雄是否需要在养成界面展示红点（是否在养成界面展示红点）
-- 传0的时候 判断是否有获得的新英雄  id 则为当前英雄是否获得
function M:IsNewHero(heroId)
    if heroId == 0 then
        return #self.newHeroIds > 0
    end

    return tIndexof(self.newHeroIds, heroId)
end

function M:IsNewTypeHero(faction)
    if faction == 0 then
        return self:IsNewHero(0)
    end

    for _, heroId in pairs(self.IsNewHero) do
        local heroFaction = ConfigHelper.GetCfgPropByLua("role", heroId, "faction")
        if faction == heroFaction then
            return true
        end
    end
end

function M:RemoveHeroId(heroId)
    local index = self:IsNewHero(heroId)

    if index then
        table.removebyvalue(self.newHeroIds, heroId)
    end
end

-- 跃迁红点
function M:GetAwakeRedPoint(heroId)
    if heroId and heroId > 0 then
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        return self:_GetHeroAwakeRedPoint(heroData)
    end
    local heroDatas = IHeroDataMgr:GetHeros()
    if not heroDatas then
        return
    end
    for _, heroData in pairs(heroDatas) do
        if self:_GetHeroAwakeRedPoint(heroData) then
            return true
        end
    end
end

function M:_GetHeroAwakeRedPoint(heroData)
    local heroId = heroData:GetHeroId()
    local rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")

    local awakeLevel = heroData:GetAwakeLevel()

    if self:_IsMaxAwake(rare, awakeLevel) then
        return false
    end

    local heroAwakes = ConfigHelper.GetCfgsByLua("heroAwake", {heroId=heroId, level=awakeLevel + 1})

    if #heroAwakes <= 0 then
        return false
    end

    local heroAwake = heroAwakes[1]
    -- 任务
    if heroAwake.type == 1 then
        local taskId = heroAwake.task
        local taskData = TaskDataMgr:GetTaskData(TaskType.Awake, taskId)

        return taskData.state == TaskState.MissionComplete
    else
        -- 消耗材料
        for k, id in pairs(heroAwake.costItems) do
            local num = heroAwake.costNum[k]
            local haveNum = ItemDataMgr:GetInstance():GetItemNumById(id)
            if haveNum < num then
                return false
            end
        end
        return true
    end
end

function M:_IsMaxAwake(heroRare, awakeLevel)
    if heroRare == EQuality.SSR then
        return awakeLevel == 6
    end

    if heroRare == EQuality.SR then
        return awakeLevel == 3
    end
    return true
end

-- 基因链红点
function M:IsUpGeneLevelRedPoint(heroId)
    if heroId > 0 then
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        return self:_GeneLevelRedPoint(heroData)
    else
        local heroDatas = IHeroDataMgr:GetHeros()
        if not heroDatas then
            return
        end
        for i = 0, heroDatas.Count - 1 do
            local heroData = heroDatas[i]
            if self:_GeneLevelRedPoint(heroData) then
                return true
            end
        end
    end
end

function M:_GeneLevelRedPoint(heroData)
    local heroId = heroData:GetHeroId()
    local rare = heroData:GetHeroCfg().rare
    if not self:OpenGene(heroId, rare) then
        return
    end
    local geneLv = heroData:GetGeneStar() -- 基因链等级
    local geneStars = heroData:GetGenesStars()
    if not geneStars then
        return
    end
    local geneStarLength = geneStars.Length
    if geneStarLength < 5 then
        return
    end
    for i = 0, geneStarLength - 1 do
        if geneStars[i] <= geneLv then
            return
        end
    end

    local heroAiEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=heroId, needStar=geneLv + 1})
    if #heroAiEffects <= 0 then
        return
    else
        local conditionId = heroAiEffects[1].openCondition
        local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, heroId)
        return isOpen
    end
end

-- 基因升星红点
function M:IsUpRoleGene(heroData, pos)
    local heroId = heroData:GetHeroId()
    local rare = heroData:GetHeroCfg().rare
    if not self:OpenGene(heroId, rare) then
        return
    end
    if not self:GenePosRedPoint(heroData, pos) then
        return
    end
    local heroAi = ConfigHelper.GetCfgsByLua("heroAi", {heroId=heroId, slot=pos})[1]
    if not heroAi then
        Logger.LogError("英雄 Id = " .. tostring(heroId) .. " heroAi 表里没有基因位置：" .. tostring(pos) .. "的数据")
        return
    end
    local geneStar = heroData:GeneByPosition(pos - 1)
    local heroAiStars = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=heroAi.aiType, star=geneStar})
    if #heroAiStars <= 0 then
        Logger.LogError("配置错误.heroAi.aiType" .. heroAi.aiType .. "  geneStar:" .. geneStar)
        return
    end
    local heroAiStar = heroAiStars[1]

    local items = heroAiStar.costItems
    local nums = heroAiStar.costNum
    local length = #items

    if length == 0 then
        return true
    end

    for i = 1, length do
        local costId = items[i]
        local costNum = nums[i]
        if not GameHelper.CheckItem(costId, costNum) then
            return
        end
    end

    return true
end

-- 基因是否开放
function M:OpenGene(heroId, rare)
    rare = rare or ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", GeneOpenId[rare], "showCondition")
    local isOpen = GameHelper.CheckLockByOpenConditionIds(showCondition, heroId)
    return isOpen
end

-- 当前位置能否显示基因红点
function M:GenePosRedPoint(heroData, genePos)
    local geneLv = heroData:GetGeneStar() -- 基因链等级
    local geneStar = heroData:GeneByPosition(genePos - 1) -- 基因星级
    if geneStar == 6 or geneStar > geneLv or geneStar > self:_GetGeneTipsLevel() then
        return
    end
    return true
end

-- 获取基因升星显示红点的等级
function M:_GetGeneTipsLevel()
    if not self.tipsLv then
        self.tipsLv = ConfigHelper.GetSystemParam(355)
    end
    return self.tipsLv
end

return DevelopMgr
