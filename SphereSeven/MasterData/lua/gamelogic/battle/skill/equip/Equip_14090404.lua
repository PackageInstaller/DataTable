---
--- 每次行动开始时提升${Params[1]}%的暴击伤害，最多叠加${Params[2]}层。
---

local Equip_14090404 = BaseClass("Equip_14090404", Skill)
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

    self.__snc:Inc(NumericType.CriFinalDamageAdd, self.Params[1])

    self.stackCount = self.stackCount + 1
end

Equip_14090404.__init = __init
Equip_14090404.OnBattleStart = OnBattleStart
Equip_14090404.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Equip_14090404