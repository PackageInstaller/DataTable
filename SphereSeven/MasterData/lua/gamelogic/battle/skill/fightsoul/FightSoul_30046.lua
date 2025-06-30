---
--- 最大生命值提升${Params[1]}%。自身回合结束时,根据处于【麻痹】状态的敌人数量,每个恢复自身${Params[2]}%的最大生命值。

---

local FightSoul_30046 = BaseClass("FightSoul_30046",Skill)
local base = Skill

local function __init(self)
    self.Data.MaxHpAddPct = self.Params[1]
    self.Data.HpHealPct = self.Params[2]

end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Data.MaxHpAddPct)
end


local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    local healTimes = 0
    local targets = self:__get_enemy_all()
    table.walk(targets, function(k, target)
        local cc = target:GetComponent("CharacterComponent")
        local sbc = target:GetComponent("BuffComponent")
        if (not cc.IsDead) and (sbc:HasBuffId(BattleBuffType.Paralysis)) then
            healTimes = healTimes + 1
        end
    end)

    if healTimes > 0 then
        local maxHp = self.__snc:Get(NumericType.MaxHp)
        local heal = maxHp * self.Data.HpHealPct / 100 * healTimes
        self.__subc:HealHp(heal)
    end
end

FightSoul_30046.__init = __init
FightSoul_30046.OnBattleStart = OnBattleStart
FightSoul_30046.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return FightSoul_30046