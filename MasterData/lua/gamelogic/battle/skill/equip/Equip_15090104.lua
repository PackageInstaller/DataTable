---
--- 行动后，提升攻击力最高的友军${Params[1]}%的速攻值（自身以外）
---

local Equip_15090104 = BaseClass("Equip_15090104", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local friends = self:__get_friend_all()
    local targetUnit = BattleUtil.GetExtremeAttrTarget(friends, NumericType.Atk, true, function(unit) return unit ~= self.SrcUnit end)
    if targetUnit ~= nil then
        targetUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])
    end
end

Equip_15090104.__init = __init
Equip_15090104.OnActEnd = OnActEnd

return Equip_15090104