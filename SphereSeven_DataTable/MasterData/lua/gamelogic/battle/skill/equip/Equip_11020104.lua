---
--- 每次行动后，提升自己${Params[1]}%物防和魔防，最多叠加${Params[2]}次。
---
local Equip_11020104 = BaseClass("Equip_11020104", Skill)
local base = Skill

local function __init(self)
    self.stacks = 0
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if self.stacks >= self.Params[2] then
        return
    end

    self.__snc:Inc(NumericType.DefPct, self.Params[1])
    self.__snc:Inc(NumericType.MagicDefPct, self.Params[1])
    self.stacks = self.stacks + 1
end

Equip_11020104.__init = __init
Equip_11020104.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Equip_11020104