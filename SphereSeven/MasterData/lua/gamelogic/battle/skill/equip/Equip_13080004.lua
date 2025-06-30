---
--- 回避率上升${Params[1]}%
---

local Equip_13080004 = BaseClass("Equip_13080004", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.PryAdd, self.Params[1])
end


Equip_13080004.__init = __init
Equip_13080004.OnBattleStart = OnBattleStart

return Equip_13080004