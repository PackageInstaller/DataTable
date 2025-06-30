---
--- 当前排友军回合开始时，提升自身行动值${Params[1]}%。每${Params[2]}个回合只能触发1次。
---

local Equip_21051029 = BaseClass("Equip_21051029", Skill)
local base = Skill

local function __init(self)
end

local function OnUnitTurnStartEvent(self, unit)
    base.OnUnitTurnStartEvent(self, unit)

    if self.LeftCooldownTurn > 0 then
        return
    end

    if self.SrcUnit == unit or not BattleUtil.IsFriend(self.SrcUnit, unit) then
        return
    end

    if not unit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Front then
        return
    end

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])

    local coolDown = math.modf(self.Params[2])
    self:SetCooldownTurn(coolDown)
end

Equip_21051029.__init = __init
Equip_21051029.OnUnitTurnStartEvent = OnUnitTurnStartEvent

return Equip_21051029