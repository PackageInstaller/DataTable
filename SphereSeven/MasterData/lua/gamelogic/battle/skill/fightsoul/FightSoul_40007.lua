---
--- 物防和术防提升${Params[1]}%。受到持有异常状态的目标攻击时,${Params[2]}%的概率减少随机一个主动技能${Params[3]}回合冷却。
---


local FightSoul_40007 = BaseClass("FightSoul_40007",Skill)
local base = Skill

local function __init(self)
    self.Data.DefPct = self.Params[1]
    self.Data.MagicDefPct = self.Params[1]
    self.Data.Probably = self.Params[2]
    self.Data.ReduceCoolDownTurn = self.Params[3]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.DefPct, self.Data.DefPct)
    self.__snc:Inc(NumericType.MagicDefPct, self.Data.MagicDefPct)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if activeSkillResult.FeixiaoDamage == nil or activeSkillResult.FeixiaoDamage.Type ~= BattleDamageType.Magic then
        return
    end

    if BattleUtil.IsFriend(atkUnit, self.SrcUnit) then
        return
    end

    if not atkUnit:GetComponent("BuffComponent"):HasDeBuff() then
        return
    end

    if BattleUtil.IsPctProbHit(self.Data.Probably) then
        local skills = self.SrcUnit:GetComponent("SkillComponent"):RandomActiveSkills(1)
        for _, skill in pairs(skills) do
            skill:ReduceCoolDownTurn(self.Data.ReduceCoolDownTurn)
        end
    end
end

FightSoul_40007.__init = __init
FightSoul_40007.OnBattleStart = OnBattleStart
FightSoul_40007.AfterBeHitAll = AfterBeHitAll

return FightSoul_40007