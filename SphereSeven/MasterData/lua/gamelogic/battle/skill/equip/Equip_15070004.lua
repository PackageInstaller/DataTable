---
--- 受击时，自身速度比来源速度速度更低时，根据双方速度的差值，提高物防与魔防。差值在${Params[1]}%时获得最大提升${Params[2]}%。
---

local Equip_15070004 = BaseClass("Equip_15070004", Skill)
local base = Skill

local function __init(self)
    self.DefPctAdd = 0
    self.MagicDefPctAdd = 0
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    base.BeforeBeHit(self, activeSkillResult, atkUnit)

    local atkUnitSpeed = atkUnit:GetComponent("NumericComponent"):Get(NumericType.Speed)
    local selfSpeed = self.__snc:Get(NumericType.Speed)
    local diff = (1 - atkUnitSpeed / selfSpeed) * 100
    if diff <= 0 then
        return
    end
    if diff > self.Params[1] then
        diff = self.Params[1]
    end

    local addValue = diff / self.Params[1] * self.Params[2]

    self.DefPctAdd = addValue
    self.MagicDefPctAdd = addValue
    self.__snc:Inc(NumericType.DefPct, self.DefPctAdd)
    self.__snc:Inc(NumericType.MagicDefPct, self.MagicDefPctAdd)
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    self.__snc:Dec(NumericType.DefPct, self.DefPctAdd)
    self.__snc:Dec(NumericType.MagicDefPct, self.MagicDefPctAdd)
    self.DefPctAdd = 0
    self.MagicDefPctAdd = 0
end


Equip_15070004.__init = __init
Equip_15070004.BeforeBeHit = BeforeBeHit
Equip_15070004.AfterHurt = AfterHurt

return Equip_15070004