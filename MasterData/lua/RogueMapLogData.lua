local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:Init(_data)
    if _data then
        for k, v in pairs(_data) do
            self[k] = v
        end
    end
end

function this:GetType()
    return self.ty
end

function this:GetUID()
    return self.id
end

function this:GetName()
    return self.name or ""
end

function this:GetTime()
    return self.time or 0
end

function this:GetPercent()
    return self.left_hp_percent or 0
end

function this:IsHelp()
    return self.isHelp
end

function this:GetDungeonId()
    return self.cfg_id or 0
end

function this:GetDungeonCfg()
    return Cfgs.MainLIne:GetByID(self:GetDungeonId())
end

function this:GetMonsterGroup()
    return self.monsterGroup
end

function this:GetBossName()
    local name = ""
    local cfgGroup = Cfgs.MonsterGroup:GetByID(self:GetMonsterGroup())
    if cfgGroup and cfgGroup.monster then
        local cfg = Cfgs.MonsterData:GetByID(cfgGroup.monster)
        if cfg then
            name = cfg.name
        end
    end
    return name
end

function this:GetDesc()
    local isKill = self:GetPercent() <= 0
    local str = ""
    if isKill then
        str = LanguageMgr:GetByID(self:IsHelp() and 76055 or 76033,string.gsub(TimeUtil:GetTimeShortStr2(TimeUtil:GetTime() - self:GetTime()), "%s", ""),self:GetName(),self:GetBossName())
    else
        str = LanguageMgr:GetByID(self:IsHelp() and 76056 or 76034,string.gsub(TimeUtil:GetTimeShortStr2(TimeUtil:GetTime() - self:GetTime()), "%s", ""),self:GetName(),self:GetBossName(),math.floor(self:GetPercent() * 10) / 10 .. "%")
    end
    return str
end

function this:SetIsNew(b)
    self.isNew = b
end

function this:GetIsNew()
    return self.isNew
end

return this