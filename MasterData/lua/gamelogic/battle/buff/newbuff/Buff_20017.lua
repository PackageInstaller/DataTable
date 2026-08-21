---
--- 攻击提升 攻击力提升50%
---
local Buff_20017 = BaseClass("Buff_20017",Buff)
local base = Buff

local function Settle(self)
    local hp = self.__snc:Get(NumericType.Atk) * 0.6
    local tbc = self.TargetUnit:GetComponent("SsUnitBattleComponent")
    tbc:ReduceHp(hp)
    tbc:GenHUDText(hp, HUDTextType.Red, HUDTextType.Dmg)
    self.battle_component:OnBuffCalcEvent(self.TargetUnit, self)
end

local function OnOccur(self)
    base.OnOccur(self)
end

local function OnRemoved(self)
    base.OnRemoved(self)
end

local function OnUnitSelfTurnEnd(self)
    self:Settle()
    base.OnUnitSelfTurnEnd(self)
end

Buff_20017.Settle = Settle
Buff_20017.OnOccur = OnOccur
Buff_20017.OnRemoved = OnRemoved
Buff_20017.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Buff_20017