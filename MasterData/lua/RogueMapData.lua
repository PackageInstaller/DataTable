local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:Init(_data)
    self.data = _data
    if self.data and self.cfg == nil then
        self.cfg =Cfgs.DungeonGroup:GetByID(self.data.id)
    end
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetName()
    return self.cfg and self.cfg.name
end

function this:GetDungeonGroups()
    return self.cfg and self.cfg.dungeonGroups
end

function this:GetDungeonCfgs()
    local ids = self:GetDungeonGroups()
    local cfgs = {}
    if ids and #ids > 0 then
        for i, v in ipairs(ids) do
            local cfg = Cfgs.MainLine:GetByID(v)
            if cfg then
                table.insert(cfgs,cfg)
            end
        end
    end
    return cfgs
end

function this:GetRewards()
    return self.cfg and self.cfg.fisrtPassReward
end

function this:GetPreLevel()
    return self.cfg and self.cfg.perLevel
end

function this:IsOpen()
    if self:GetPreLevel() then
        return RogueMapMgr:IsDungeonPass(self:GetPreLevel())
    end
    return true
end

function this:IsPass()
    return self.data and self.data.firstPass or false
end

return this