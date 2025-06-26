---
--- 攻击提升 攻击力提升50%
---
local Buff_10020 = BaseClass("Buff_10020",Buff)
local base = Buff

local function OnUnitSelfTurnStart(self)
    self.occured = true
    local hp = math.modf(self.__tnc:Get(NumericType.MaxHp)*0.15)
    local tbc = self.TargetUnit:GetComponent("SsUnitBattleComponent")
    tbc:HealHp(hp)
end

local function OnUnitSelfTurnEnd(self)
    if not self.occured then
        return
    end
    base.OnUnitSelfTurnEnd(self)
end

Buff_10020.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd
Buff_10020.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Buff_10020