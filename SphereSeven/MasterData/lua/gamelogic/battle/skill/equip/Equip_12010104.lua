---
--- 行动后，${Params[1]}%的概率解除自身一个异常状态。
---
local Equip_12010104 = BaseClass("Equip_12010104", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    if BattleUtil.IsPctProbHit(self.Params[1]) then
        self.__sbc:RandomRemoveOneBuff(true)
    end
end


Equip_12010104.__init = __init
Equip_12010104.OnActEnd = OnActEnd

return Equip_12010104