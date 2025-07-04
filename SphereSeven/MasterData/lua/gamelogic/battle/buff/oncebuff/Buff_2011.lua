---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/19 17:08
--- 感应
---下一次的攻击必定命中，如果对方有直觉效果则互相抵消
local Buff_2011 = BaseClass("Buff_2011",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.MustHit)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.MustHit)
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
Buff_2011.OnOccur = OnOccur
Buff_2011.OnRemoved = OnRemoved
Buff_2011.BeforeHit = BeforeHit
Buff_2011.OnAtkEnd = OnAtkEnd

return Buff_2011