---
--- 每次受击后,解除自身一个异常状态。对自身施加的治疗量提高${Params[1]}%-${Params[2]}%。自身生命值越低,额外治疗量越高,在${Params[3]}%生命值时获得最大值。
---

local Equip_21011032 = BaseClass("Equip_21011032", Skill)
local base = Skill

local function __init(self)
    self.Data.HealAddMin = self.Params[1]
    self.Data.HealAddMax = self.Params[2]
    self.Data.HpLine = self.Params[3]

    self.Data.CurHealAdd = 0
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if BattleUtil.IsPctProbHit(self.Params[1]) then
        self.__sbc:RandomRemoveOneBuff(true)
    end
end

local function OnHpChange(self)
    base.OnHpChange(self)

    local rate = math.min((100 - (BattleUtil.GetHpPct(self.SrcUnit) * 100)) / (100 - self.Data.HpLine), 1)
    local healAdd = rate * (self.Data.HealAddMax - self.Data.HealAddMin) + self.Data.HealAddMin
    
    self.__snc:Dec(NumericType.HealEffectAdd, self.Data.CurHealAdd)
    self.__snc:Inc(NumericType.HealEffectAdd, healAdd)
    self.Data.CurHealAdd = healAdd
end

Equip_21011032.__init = __init
Equip_21011032.AfterBeHitAll = AfterBeHitAll
Equip_21011032.OnHpChange = OnHpChange

return Equip_21011032