---
--- 攻击提升 攻击力提升50%
---
local Buff_20015 = BaseClass("Buff_20015",Buff)
local base = Buff

local function Settle(self)
    local hp = math.modf(self.__tnc:Get(NumericType.MaxHp)*0.05)
    local tbc = self.TargetUnit:GetComponent("SsUnitBattleComponent")
    local hp = tbc:ReduceHp(hp)
    tbc:GenHUDText(hp, HUDTextType.Red, HUDTextType.Dmg)
    self.battle_component:OnBuffCalcEvent(self.TargetUnit, self)
end

local function OnUnitSelfTurnStart(self)
    self.occured = true
    self:Settle()
end

local function OnUnitSelfTurnEnd(self)
    if not self.occured then
        return
    end
    base.OnUnitSelfTurnEnd(self)
end

Buff_20015.Settle = Settle

Buff_20015.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd
Buff_20015.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Buff_20015