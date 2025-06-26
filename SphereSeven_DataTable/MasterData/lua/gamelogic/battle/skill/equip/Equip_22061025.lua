---
--- 自身回合开始,解除所有敌人${Params[1]}个增益状态。自身回合结束时,赋予所有敌人${Params[2]}个随机的${Params[3]}回合异常状态。每${Params[4]}回合可以触发1次。
---

local Equip_22061025 = BaseClass("Equip_22061025", Skill)
local base = Skill

local function __init(self)
    self.Data.DispelBuffCount = math.modf(self.Params[1])
    self.Data.RandomDebuffCount = math.modf(self.Params[2])
    self.Data.DebuffTurn = math.modf(self.Params[3])
    self.Data.CoolDown = math.modf(self.Params[4])
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    if self.LeftCooldownTurn > 0 then
        return
    end

    local targets = table.choose(self:__get_enemy_all(), function(k, unit) return not unit:GetComponent("CharacterComponent").IsDead end)
    for _, targetUnit in pairs(targets) do
        local bc = targetUnit:GetComponent("BuffComponent")
        local buffs = bc:RandomGetBuff(false, self.Data.DispelBuffCount)
        for _, buff in pairs(buffs) do
            bc:RemoveOneBuff(buff)
        end
    end
end

local function OnUnitSelfTurnEnd(self)
    if self.LeftCooldownTurn <= 0 then
        local targets = table.choose(self:__get_enemy_all(), function(k, unit) return not unit:GetComponent("CharacterComponent").IsDead end)
        for _, targetUnit in pairs(targets) do
            local subc = targetUnit:GetComponent("SsUnitBattleComponent")
            for i = 1, self.Data.RandomDebuffCount, 1 do
                local buffId = math.random(BattleBuffType.DebuffStart + 1, BattleBuffType.DebuffEnd - 1)
                subc:AddDebuff(buffId, self.SkillId, self.SrcUnit, self.Data.DebuffTurn)
            end
        end
    
        self:SetCooldownTurn(self.Data.CoolDown)
    end

    base.OnUnitSelfTurnEnd(self)
end


Equip_22061025.__init = __init
Equip_22061025.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Equip_22061025.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Equip_22061025