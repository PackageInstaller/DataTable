---
--- 物防和魔防提升${Params[1]}
---

local Equip_13090103 = BaseClass("Equip_13090103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.DefAdd, self.Params[1])
    self.__snc:Inc(NumericType.MagicDefAdd, self.Params[1])
end


Equip_13090103.__init = __init
Equip_13090103.OnBattleStart = OnBattleStart

return Equip_13090103