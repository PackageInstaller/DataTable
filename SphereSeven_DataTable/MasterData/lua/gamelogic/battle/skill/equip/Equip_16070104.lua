---
--- 每场战斗中第一次受到攻击时，提升${Params[1]}%的护甲与魔抗。
---

local Equip_16070104 = BaseClass("Equip_16070104", Skill)
local base = Skill

local function __init(self)
    self.IsFirstBeHit = true
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.IsFirstBeHit = true
end


local function BeforeSkillEffect(self, atkUnit)
    base.BeforeSkillEffect(self, atkUnit)

    if not self.IsFirstBeHit then
        return
    end

    self.__subc:IncTempNumeric(NumericType.DefPct, self.Params[1])
    self.__subc:IncTempNumeric(NumericType.MagicDefPct, self.Params[1])

    self.IsFirstBeHit = false
end

Equip_16070104.__init = __init
Equip_16070104.OnBattleStart = OnBattleStart
Equip_16070104.BeforeSkillEffect = BeforeSkillEffect

return Equip_16070104