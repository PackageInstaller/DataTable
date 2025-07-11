---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
---复苏Buff
--- DateTime: 2019/5/5 11:59
---
local Buff_2027 = BaseClass("Buff_2027",Buff)
local base = Buff

local function OnRoundStart(self)
    self.occured = true
    local hp = math.modf(self.__tcc:GetHealHpBase()*0.25)
    local tbc = self.TargetUnit:GetComponent("SsUnitBattleComponent")
    tbc:HealHp(hp)
end

local function OnRoundEnd(self)
    if not self.occured then
        return
    end
    base.OnRoundEnd(self)
end

Buff_2027.OnRoundEnd = OnRoundEnd
Buff_2027.OnRoundStart = OnRoundStart

return Buff_2027