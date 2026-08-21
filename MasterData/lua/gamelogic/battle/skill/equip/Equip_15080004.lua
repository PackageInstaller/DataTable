---
--- 行动后，提升自身的速攻值${Params[1]}%。
---

local Equip_15080004 = BaseClass("Equip_15080004", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])
end

Equip_15080004.__init = __init
Equip_15080004.OnActEnd = OnActEnd

return Equip_15080004