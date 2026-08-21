---
--- 行动后，恢复生命值最低的友军${Params[1]}%的最大生命值。
---
local Equip_11060004 = BaseClass("Equip_11060004", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local friends = self:__get_friend_all()
    local targetUnit = BattleUtil.GetExtremeTarget(friends, BattleUtil.GetHpPct, false)
    if targetUnit ~= nil then
        local heal = targetUnit:GetComponent("NumericComponent"):Get(NumericType.MaxHp) * self.Params[1] / 100
        targetUnit:GetComponent("SsUnitBattleComponent"):Heal(heal, self.SrcUnit)
    end
end

Equip_11060004.__init = __init
Equip_11060004.OnActEnd = OnActEnd

return Equip_11060004