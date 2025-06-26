---
--- 攻击力+${Params[1]}%。自身回合结束时,使所有敌人的【灼烧】立即结算一次。
---

local Equip_26051006 = BaseClass("Equip_26051006", Skill)
local base = Skill

local function __init(self)
    self.Data.AtkAddPct = self.Params[1]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkAddPct)
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    local enemies = self:__get_enemy_all()
    for _, targetUnit in pairs(enemies) do
        local cc = targetUnit:GetComponent("CharacterComponent");
        if not cc.IsDead then
            local buffs = targetUnit:GetComponent("BuffComponent"):GetBuffsById(BattleBuffType.Fire)
            for _, buff in pairs(buffs) do
                buff:Settle()
                buff:DecLeftTurn()
            end
        end
    end
end

Equip_26051006.__init = __init
Equip_26051006.OnBattleStart = OnBattleStart
Equip_26051006.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd


return Equip_26051006