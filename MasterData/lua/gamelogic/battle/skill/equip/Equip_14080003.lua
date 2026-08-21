---
--- 生命提升${Params[1]}%
---

local Equip_14080003 = BaseClass("Equip_14080003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
end

Equip_14080003.__init = __init
Equip_14080003.OnBattleStart = OnBattleStart

return Equip_14080003