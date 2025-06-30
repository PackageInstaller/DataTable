---
---心眼
---下一次的攻击必定命中、必定暴击，如果对方有无相效果则互相抵消。
local Buff_2037 = BaseClass("Buff_2037",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.MustHit)
    self.__tcc:IncSpecialEffect(SpecialEffectType.MustCri)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.MustHit)
    self.__tcc:DecSpecialEffect(SpecialEffectType.MustCri)
    base.OnRemoved(self)
end

-- 攻击敌方，不论是否闪避
local function BeforeHit(self)
    self.occured = true
end

local function OnAtkEnd(self)
    if not self.occured then
        return
    end
    OnRemoved(self)
end

Buff_2037.BeforeHit = BeforeHit
Buff_2037.OnOccur = OnOccur
Buff_2037.OnRemoved = OnRemoved
Buff_2037.OnAtkEnd = OnAtkEnd

return Buff_2037

