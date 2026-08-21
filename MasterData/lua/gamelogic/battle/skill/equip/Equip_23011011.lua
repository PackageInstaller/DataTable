---
--- 物防+${Params[1]}%。受击后，${Params[2]}%的概率赋予对方${Params[3]}回合的【无法强化】。
---

local Equip_23011011 = BaseClass("Equip_23011011", Skill)
local base = Skill

local function __init(self)
    self.Data.AktAddPct = self.Params[1]
    self.Data.BuffProb = self.Params[2]
    self.Data.BuffTurn = self.Params[3]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.__snc:Inc(NumericType.AtkPct, self.Data.AktAddPct)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if activeSkillResult.FeixiaoDamage == nil then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    if BattleUtil.IsPctProbHit(self.Data.BuffProb) then
        local subc = atkUnit:GetComponent("SsUnitBattleComponent")
        subc:AddDebuff(BattleBuffType.BuffDisable, self.SkillId, self.SrcUnit, self.Data.BuffTurn)
    end
end

Equip_23011011.__init = __init
Equip_23011011.OnBattleStart = OnBattleStart
Equip_23011011.AfterBeHitAll = AfterBeHitAll

return Equip_23011011