---
--- 每有一个角色回合结束，提升自身${Params[1]}%的攻击力，最多叠加${Params[2]}次
---
local Equip_11010204 = BaseClass("Equip_11010204", Skill)
local base = Skill

local function __init(self)
    self.stackCount = 0
end

local function OnActEndEvent(self, unit)
    local maxStackCount = math.modf(self.Params[2])
    if self.stackCount >= maxStackCount then
        return
    end

    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
    self.stackCount = self.stackCount + 1
end

Equip_11010204.__init = __init
Equip_11010204.OnActEndEvent = OnActEndEvent

return Equip_11010204