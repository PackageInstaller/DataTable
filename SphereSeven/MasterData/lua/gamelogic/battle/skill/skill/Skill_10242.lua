---
--- 龍擊炮·轟
--- 對單名敵人造成${Params[1]}%物理的物理傷害，${Params[2]}%的概率賦予其${Params[3]}回合【物防降低】效果；當攻擊後目標身上的異常狀態在${Params[4]}種以上時，自身獲得追加回合
---

local Skill_10242 = BaseClass("Skill_10242",Skill)
local base = Skill

local function __init(self)
    self.Data.DamageMultiplier = self.Params[1]
    self.Data.BuffProbability = self.Params[2]
    self.Data.BuffTurn = self.Params[3]
    self.Data.ConditionWithDebuffCount = self.Params[4]
end

local function OnUseActiveSkill(self, targetUnit)
    -- local count = targetUnit:GetComponent("BuffComponent"):BuffTypeCount(true)
    -- if count > 5 then
    --     count = 5
    -- end

    local result = ActiveSkillResult.New()
    local damageScale = self.Data.DamageMultiplier / 100
    local atk = self.__snc:Get(NumericType.Atk)
    local damage = damageScale * atk / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damage
    }

    if BattleUtil.IsPctProbHit(self.Data.BuffProbability) then
        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.DefDecrease, self.Data.BuffTurn))
    end

    return result
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    if table.any(self.TargetUnits, 
        function (targetUnit) 
            return targetUnit:GetComponent("BuffComponent"):BuffTypeCount(true) >= self.Data.ConditionWithDebuffCount 
        end) then

        self.__bc.HighReadyQueue:enqueue(self.SrcUnit)
    end
end

Skill_10242.__init = __init
Skill_10242.OnUseActiveSkill = OnUseActiveSkill
Skill_10242.OnAtkEnd = OnAtkEnd

return Skill_10242