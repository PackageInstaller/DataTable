---
--- 无相
---下一次受到的攻击必定回避、必定反击，如果对方有心眼效果则互相抵消。
local Buff_2036 = BaseClass("Buff_2036",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.MustPry)
    self.__tcc:IncSpecialEffect(SpecialEffectType.MustCac)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.MustPry)
    self.__tcc:DecSpecialEffect(SpecialEffectType.MustCac)
    base.OnRemoved(self)
end

local function AfterAllHurtByNothing(self) -- 受到攻击，不管有没有闪避
    OnRemoved(self)
end

Buff_2036.OnOccur = OnOccur
Buff_2036.OnRemoved = OnRemoved
Buff_2036.AfterAllHurtByNothing = AfterAllHurtByNothing
return Buff_2036