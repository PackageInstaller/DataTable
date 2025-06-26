---
--- 每次自身回合开始时，使自身攻击力增加${Params[1]}%，最多叠加${Params[2]}层。
---

local Equip_15090404 = BaseClass("Equip_15090404", Skill)
local base = Skill

local function __init(self)
    self.stackCount = 0
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.stackCount = 0
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    local maxStackCount = math.modf(self.Params[2])
    if self.stackCount > maxStackCount then
        return
    end

    self.__snc:Inc(NumericType.AtkPct, self.Params[1])

    self.stackCount = self.stackCount + 1
end

Equip_15090404.__init = __init
Equip_15090404.OnBattleStart = OnBattleStart
Equip_15090404.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Equip_15090404