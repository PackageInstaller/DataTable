---
--- 速度提升${Params[1]}
---

local Equip_15090303 = BaseClass("Equip_15090303", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.SpeedAdd, self.Params[1])
end

Equip_15090303.__init = __init
Equip_15090303.OnBattleStart = OnBattleStart

return Equip_15090303