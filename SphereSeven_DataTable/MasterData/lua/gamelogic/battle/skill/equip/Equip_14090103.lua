---
--- 生命提升${Params[1]}
---

local Equip_14090103 = BaseClass("Equip_14090103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpAdd, self.Params[1])
end

Equip_14090103.__init = __init
Equip_14090103.OnBattleStart = OnBattleStart

return Equip_14090103