---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/12 20:56
--- 格挡
---
local Buff_2026 = BaseClass("Buff_2026",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.Block)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.Block)
    base.OnRemoved(self)
end

Buff_2026.OnOccur = OnOccur
Buff_2026.OnRemoved = OnRemoved

return Buff_2026