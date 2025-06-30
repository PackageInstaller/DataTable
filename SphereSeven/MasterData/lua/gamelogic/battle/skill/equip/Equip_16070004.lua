---
--- 每有一名友军受击，提升自身速攻值${Params[1]}%。
---

local Equip_16070004 = BaseClass("Equip_16070004", Skill)
local base = Skill

local function __init(self)
end

local function OnAtkEndEvent(self, atkUnit)
    base.OnAtkEndEvent(self, atkUnit)

    local actChange = 0
    for _, targetUnit in pairs(self.__bc.CurActSkill.TargetUnits) do
        if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
            actChange = actChange + self.Params[1]
        end
    end

    if actChange > 0 then
        self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(actChange)
    end
end

Equip_16070004.__init = __init
Equip_16070004.OnAtkEndEvent = OnAtkEndEvent

return Equip_16070004