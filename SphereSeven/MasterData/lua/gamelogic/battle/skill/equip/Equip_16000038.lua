---
--- 生命提升${Params[1]}%，魔防提升${Params[2]}%
---

local Equip_16000038 = BaseClass("Equip_16000038", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
    self.__snc:Inc(NumericType.MagicDefPct, self.Params[2])
end

Equip_16000038.__init = __init
Equip_16000038.OnBattleStart = OnBattleStart

return Equip_16000038