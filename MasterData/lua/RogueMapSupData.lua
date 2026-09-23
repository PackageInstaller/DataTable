local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:Init(_data, pos)
    if _data then
        for k, v in pairs(_data) do
            self[k] = v
        end
    end
    if pos then
        self.pos = pos
    end
end

function this:GetType()
    local type = nil
    if self.ty then
        type = tonumber(self.ty)
    end
    return type
end

function this:GetUID()
    return self.uid or 0
end

function this:GetName()
    return self.name or ""
end

function this:GetIcon()
    return self.icon_id or ""
end

function this:GetHP()
    return self.cur_hp or 0, self.max_hp or 0
end

function this:GetSupCount()
    return self.s_cnt or 0
end

function this:GetStartTime()
    return self.s_time or 0
end

function this:GetEndTime()
    return self.f_time or 0
end

function this:GetIndex()
    return self.s_ix or 0
end

function this:GetDungeonId()
    return self.cfg_id
end

function this:GetDungeonCfg()
    return Cfgs.MainLine:GetByID(self:GetDungeonId())
end

function this:GetDungeonGroupData()
    local cfg = self:GetDungeonCfg()
    if cfg and cfg.dungeonGroup then
        return DungeonMgr:GetDungeonGroupData(cfg.dungeonGroup)
    end
end

function this:GetPos()
    return self.pos
end

function this:GetLv()
    -- local lv = 0
    -- local groupData = self:GetDungeonGroupData()
    -- if groupData and groupData:GetDungeonGroups() then
    --     for i, id in ipairs(groupData:GetDungeonGroups()) do
    --         if id == self.cfg_id then
    --             lv = i
    --             break
    --         end
    --     end
    -- end
    -- return lv
    return math.floor(self:GetIndex() / 10000)
end

function this:GetDungeonName()
    local groupData = self:GetDungeonGroupData()
    return groupData and groupData:GetName() or ""
end

function this:GetRewards()
    return self.reward
end

--怪物组配置表数据
function this:GetMonsterGroupCfg()
    return Cfgs.MonsterGroup:GetByID(self.monsterGroup) 
end

--boss配置表数据
function this:GetBossCfg()
    local cfgMonsterGroup = self:GetMonsterGroupCfg()
    local cfg = nil
    if cfgMonsterGroup and cfgMonsterGroup.monster then
        cfg = Cfgs.MonsterData:GetByID(cfgMonsterGroup.monster)
    end
    return cfg
end

function this:GetBossIcon()
    local bossCfg = self:GetBossCfg()
    if bossCfg and bossCfg.model then
        local cfgModel = Cfgs.character:GetByID(bossCfg.model)
        return cfgModel and cfgModel.List_head
    end
end

function this:IsFinish()
    return self:GetHP() <= 0
end

function this:IsTimeEnd()
    return self:GetEndTime() <= TimeUtil:GetTime()
end

function this:GetCancelTime()
    return self:GetStartTime() + RogueMapMgr:GetGlobal("cancelTime")
end

return this
