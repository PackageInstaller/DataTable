---
--- 反击时,最终伤害提升${Params[1]}%。
---

local Equip_21011015 = BaseClass("Equip_21011015", Skill)
local base = Skill

local function __init(self)
    self.Data.CacFinalDamageAdd = self.Params[1]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CacFinalDamageAdd, self.Data.CacFinalDamageAdd)
end

Equip_21011015.__init = __init
Equip_21011015.OnBattleStart = OnBattleStart

return Equip_21011015