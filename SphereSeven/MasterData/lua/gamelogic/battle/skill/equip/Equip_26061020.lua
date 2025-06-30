---
--- 处于【麻痹】状态的敌人攻击力减少${Params[1]}%, 速度减少${Params[2]}%。
---

local Equip_26061020 = BaseClass("Equip_26061020", Skill)
local base = Skill

local function __init(self)
    self.Data.AtkReducePct = self.Params[1]
    self.Data.SpeedReducePct = self.Params[2]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end


local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local paralysisCount = enemy:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Paralysis)
        local snc = enemy:GetComponent("NumericComponent")
        snc:Dec(NumericType.AtkPct, self.Data.AtkReducePct * paralysisCount)
        snc:Dec(NumericType.SpeedPct, self.Data.SpeedReducePct * paralysisCount)
    end
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local paralysisCount = enemy:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Paralysis)
        local snc = enemy:GetComponent("NumericComponent")
        snc:Inc(NumericType.AtkPct, self.Data.AtkReducePct * paralysisCount)
        snc:Inc(NumericType.SpeedPct, self.Data.SpeedReducePct * paralysisCount)
    end
end

local function OnBuffAddEvent(self, buff)
    base.OnBuffAddEvent(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.BuffId ~= BattleBuffType.Paralysis then
        return
    end

    if BattleUtil.IsFriend(buff.TargetUnit, self.SrcUnit) then
        return
    end

    local snc = buff.TargetUnit:GetComponent("NumericComponent")
    snc:Dec(NumericType.AtkPct, self.Data.AtkReducePct)
    snc:Dec(NumericType.SpeedPct, self.Data.SpeedReducePct)
end

local function OnBuffRemoveEvent(self, buff)
    base.OnBuffRemoveEvent(self, buff)

    if self.IsDisabled then
        return
    end
    
    if buff.BuffId ~= BattleBuffType.Paralysis then
        return
    end

    if BattleUtil.IsFriend(buff.TargetUnit, self.SrcUnit) then
        return
    end

    local snc = buff.TargetUnit:GetComponent("NumericComponent")
    snc:Inc(NumericType.AtkPct, self.Data.AtkReducePct)
    snc:Inc(NumericType.SpeedPct, self.Data.SpeedReducePct)
end

Equip_26061020.__init = __init
Equip_26061020.OnBattleStart = OnBattleStart
Equip_26061020.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Equip_26061020.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Equip_26061020.OnBuffAddEvent = OnBuffAddEvent
Equip_26061020.OnBuffRemoveEvent = OnBuffRemoveEvent

return Equip_26061020