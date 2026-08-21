local M = BaseClass("ChiefNoteDataMgr", Singleton)
local tIsNullOrEmpty = table.isNullOrEmpty

function M:__init()
    self.m_keyWordsDict = nil
end

function M:Dispose()
    self.m_keyWordsDict = nil
end

function M:Cleanup()
end

function M:_InitData()
    if not self.m_keyWordsDict then
        self.m_keyWordsDict = {}
        local mType = ChiefNoteConst.Type.Story
        for _, value in pairs(ConfigHelper.GetCfgs("keyWords") or {}) do
            if value.type == mType then
                local subject = value.subject
                if not self.m_keyWordsDict[subject] then
                    self.m_keyWordsDict[subject] = {}
                end
                value.select = false
                table.insert(self.m_keyWordsDict[subject], value)
            end
        end
    end
end

function M:_SortData()
    local jMgr = JumpMgr:GetInstance()
    for _, cfgs in pairs(self.m_keyWordsDict or {}) do
        table.sort(cfgs, function(a, b)
            local isUnlockA = jMgr:CheckLockByOpenConditionIds(a.openCondition)
            local isUnlockB = jMgr:CheckLockByOpenConditionIds(b.openCondition)
            if isUnlockA and isUnlockB then
                return a.order < b.order
            elseif not isUnlockA and not isUnlockB then
                return a.order < b.order
            elseif isUnlockA and not isUnlockB then
                return true
            elseif not isUnlockA and not isUnlockB then
                return false
            end
            return false
        end)
    end
end

function M:InitSelectData()
    self:_InitData()
    self:_SortData()
    if not tIsNullOrEmpty(self.m_keyWordsDict) then
        self:_ResetSelectData()
        self.m_keyWordsDict[ChiefNoteConst.Subject.FACTIONS][1].select = true
    end
end

function M:_ResetSelectData()
    for _, cfgs in pairs(self.m_keyWordsDict) do
        for _, cfg in pairs(cfgs) do
            if cfg.select then
                cfg.select = false
                return
            end
        end
    end
end

function M:UpdateSelectDataById(id)
    if not tIsNullOrEmpty(self.m_keyWordsDict) then
        for _, cfgs in pairs(self.m_keyWordsDict) do
            for _, cfg in pairs(cfgs) do
                cfg.select = cfg.id == id
            end
        end
    end
end

function M:UpdateSelectDataBySubject(subject)
    if not tIsNullOrEmpty(self.m_keyWordsDict) then
        self:_ResetSelectData()
        self.m_keyWordsDict[subject][1].select = true
    end
end

function M:GetDataBySubject(subject)
    if not self.m_keyWordsDict then self:_InitData() end
    return self.m_keyWordsDict[subject]
end

-- 使用keyWords表subject类型检查红点（0：所有类型）
function M:CheckRedPointBySubType(subject)
    if subject == 0 then
        for _, value in pairs(ChiefNoteConst.Subject) do
            for _, v in ipairs(self:GetDataBySubject(value) or {}) do
                if self:_CheckRedPoint(v) then return true end
            end
        end
    else
        for _, v in ipairs(self:GetDataBySubject(subject) or {}) do
            if self:_CheckRedPoint(v) then return true end
        end
    end
    return false
end

function M:_CheckRedPoint(cfg)
    local keyName = "keyWord" .. tostring(cfg.id)
    local value = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
    if value > 0 then return false end
    return JumpMgr:GetInstance():CheckLockByOpenConditionIds(cfg.openCondition)
end

-- 使用keyWords表id检查红点
function M:CheckRedPointById(id)
    local cfg = ConfigHelper.GetCfgByLua("keyWords", id)
    if cfg then return self:_CheckRedPoint(cfg) end
    Logger.LogError("keyWords is 空, id = " .. tostring(id))
    return false
end

-- 关闭所有红点
function M:CheckOffRedPoint()
    for _, group in pairs(ChiefNoteConst.Subject) do
        for _, v in ipairs(self:GetDataBySubject(group) or {}) do
            if JumpMgr:GetInstance():CheckLockByOpenConditionIds(v.openCondition) then
                PlayerPrefTools.SetPlayerPrefs("keyWord" .. tostring(v.id), 1)
            end
        end
    end
end

return M
