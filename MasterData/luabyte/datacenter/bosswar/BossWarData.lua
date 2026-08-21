local M = BaseClass("BossWarData")

function M:__init(bossInfo)
    self.m_bossInfo = bossInfo
    self.m_teamData = nil
end

function M:GetTeam()
    if not self.m_teamData then
        local info = self.m_bossInfo or {}
        local mType = self:BossType()
        local heros = info.Heroes or {}
        self.m_teamData = {
            TeamId = mType,
            HeroLength = #heros,
            Name = "",
            Heroes = heros,
            CommanderSkills = info.CommanderSkills or {}
        }
    end
    return self.m_teamData
end

function M:UpdateTeam(data)
    self.m_teamData.Heroes = data.Heroes
    self.m_teamData.HeroLength = #(data.Heroes or {})
    self.m_teamData.CommanderSkills = data.CommanderSkills
end

-- 首通奖励掩码
function M:UpdateFirstMask(mask)
    if not self.m_bossInfo then return end
    self.m_bossInfo.FirstChestMask = mask
end

-- 普通奖励掩码
function M:UpdateChestMask(mask)
    if not self.m_bossInfo then return end
    self.m_bossInfo.ChestMask = mask
end

-- 是否领取首通奖励
function M:IsGetFirstChest(idx)
    if not self.m_bossInfo then return true end
    return ((1 << idx) & self.m_bossInfo.FirstChestMask) ~= 0
end

-- 是否领取周期奖励
function M:IsGetChest(idx)
    if not self.m_bossInfo then return true end
    return ((1 << idx) & self.m_bossInfo.ChestMask) ~= 0
end

-- 已战斗次数
function M:BattleTimes()
    if not self.m_bossInfo then return 0 end
    return self.m_bossInfo.BattleTimes
end

function M:BossWarId()
    if not self.m_bossInfo then return nil end
    return self.m_bossInfo.BossWarId
end

function M:BossName()
    return self:BossWarCfg().name
end

function M:BossIcon()
    return self:BossWarCfg().icon
end

function M:OpenTips()
    return self:BossWarCfg().openlanguage
end

function M:MissionDesc()
    return self:BossWarCfg().desc
end

-- 几号BOSS，用于保存阵容
function M:BossType()
    return self:BossWarCfg().type
end

-- 血量阶段总数
function M:BloodCount()
    return self:BossWarCfg().blood
end

-- 是否开启
function M:IsOpen()
    if not self.m_startHour then self.m_startHour = GameHelper.GetParamter(361) end
    return GameHelper.CheckWeekDay(self:BossWarCfg().opentime, self.m_startHour)
end

-- 对应的难度
function M:BattleLevel()
    return self:BossWarCfg().level
end

function M:BossWarCfg()
    if not self.m_config then
        local id = self:BossWarId()
        self.m_config = ConfigHelper.GetCfgByLua("bossWar", id)
        if not self.m_config then
            Logger.LogError("bossWar is nil, @四叶, id = " .. id)
        end
    end
    return self.m_config
end

function M:MonsterCfg()
    if not self.m_monsterCfg then
        local bossid = self:BossWarCfg().bossid
        self.m_monsterCfg = ConfigHelper.GetCfgByLua("monster", bossid)
        if not self.m_monsterCfg then
            Logger.LogError("monster is nil, @四叶, id = " .. bossid)
        end
    end
    return self.m_monsterCfg
end

function M:MissionCfg()
    if not self.m_missionCfg then
        local missionId = self:BossWarCfg().mission
        self.m_missionCfg = ConfigHelper.GetCfgByLua("mission", missionId)
        if not self.m_missionCfg then
            Logger.LogError("mission is nil, @四叶, id = " .. missionId)
        end
    end
    return self.m_missionCfg
end

-- 剩余战斗次数
function M:RemainBattleTimes()
    if not self.m_limitTimes then
        self.m_limitTimes = GameHelper.GetParamter(359)
    end
    local mission = self:MissionCfg()
    if mission then return self.m_limitTimes - self:BattleTimes() end
    return 0
end

-- boss血量阶段  (当前第几阶段，总阶段数) 0表示第一阶段未打过
function M:BloodStage()
    if not self.m_bossInfo then return 0 end

    local bloods = self:BloodCount()
    return self.m_bossInfo.StepPassed, bloods, self.m_bossInfo.StepHpPercent
end

-- 怪物属性枚举获取属性值
function M:BossMaxBlood()
    local cfg = self:MonsterCfg()
    if cfg then
        local mType = EnumConst.EAttributeType.EAT_MaxHP
        local attribute, attributeValue = cfg.attribute, cfg.attributeValue
        for i = 0, attribute.Length - 1 do
            if attribute[i] == mType then return attributeValue[i] end
        end
    end
    return 0
end

-- 更新词条
function M:UpdateWords(cfg)
    local id = cfg.id
    self:_InitSelectWords()
    if self.m_selectWordDic[id] then
        self.m_selectWordDic[id] = nil
    else
        self.m_selectWordDic[id] = cfg
    end
    local str = ""
    for key, _ in pairs(self.m_selectWordDic) do
        if string.isNullOrEmpty(str) then
            str = tostring(key)
        else
            str = tostring(key) .. '|' .. str
        end
    end
    local keyName = "BossWords" .. tostring(self:BossWarId())
    PlayerPrefTools.SetPlayerPrefs(keyName, str)
end

-- 当前关卡选择的词条
function M:GetWordDic()
    self:_InitSelectWords()
    return self.m_selectWordDic
end

function M:_InitSelectWords()
    if not self.m_selectWordDic then
        self.m_selectWordDic = {}
        local keyName = "BossWords" .. tostring(self:BossWarId())
        local str = PlayerPrefTools.GetPlayerPrefsString(keyName, "")
        for _, value in ipairs(string.split(str, '|') or {}) do
            if not string.isNullOrEmpty(value) then
                local id = tonumber(value) or 0
                local cfg = ConfigHelper.GetCfgByLua("bossMapcondition", id)
                if cfg then
                    self.m_selectWordDic[id] = cfg
                else
                    Logger.LogError("bossMapcondition is nil, @四叶, id = " .. id)
                end
            end
        end
    end
end

-- 携带词条所占位置
function M:TakeWordSize()
    local level = 0
    for _, cfg in pairs(self:GetWordDic()) do
        level = level + cfg.level
    end
    return level
end

-- 是否有这个词条
function M:HasWord(id)
    local dic = self:GetWordDic()
    return (dic ~= nil) and (dic[id] ~= nil)
end

-- 周期奖励
function M:CycleChests()
    if not self.m_cycleChests then
        self.m_cycleChests = {}
        for _, groupId in ipairs(self:BossWarCfg().chest) do
            local cfg = ConfigHelper.GetCfg("itemGroup", groupId)
            if cfg then
                local tbl, cnts = {}, cfg.cnts
                for i, value in ipairs(cfg.items) do
                    table.insert(tbl, { Id = value, Num = cnts[i] })
                end
                table.insert(self.m_cycleChests, tbl)
            else
                Logger.LogError("itemGroup is nil, id = " .. groupId)
            end
        end
    end
    return self.m_cycleChests
end

-- 首通奖励
function M:FirstChests()
    if not self.m_firstChests then
        self.m_firstChests = {}
        for _, groupId in ipairs(self:BossWarCfg().firstChests) do
            local cfg = ConfigHelper.GetCfg("itemGroup", groupId)
            if cfg then
                local tbl, cnts = {}, cfg.cnts
                for i, value in ipairs(cfg.items) do
                    table.insert(tbl, { Id = value, Num = cnts[i] })
                end
                table.insert(self.m_firstChests, tbl)
            else
                Logger.LogError("itemGroup is nil, id = " .. groupId)
            end
        end
    end
    return self.m_firstChests
end

return M
