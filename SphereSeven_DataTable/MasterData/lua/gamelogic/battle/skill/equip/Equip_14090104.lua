---
--- 效果抗性提高${Params[1]}%
---

local Equip_14090104 = BaseClass("Equip_14090104", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
end

Equip_14090104.__init = __init
Equip_14090104.OnBattleStart = OnBattleStart

return Equip_14090104