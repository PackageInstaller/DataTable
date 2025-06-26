---
--- 夺魂银丝
--- 对指定整排敌人造成${Params[1]}%物理伤害，${Params[2]}%的概率造成${Params[3]}回合的【拘束】，如果攻击前目标持有${Params[4]}个【中毒】，则改为${Params[5]}回合的【晕眩】，获得${Params[6]}%额外倍率，并使目标的【中毒】立即结算一次伤害(${Params[7]} 0,1 开关)
---

local Skill_114211 = BaseClass("Skill_114211", Skill)
local base = Skill

local function __init(self)
    self.Data.ActivePoisonUnits = {}
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local hasPoison = targetUnit:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Poison) >= self.Params[4]
    if hasPoison then
        damageScale = damageScale + self.Params[6] / 100
    end

    if BattleUtil.IsPctProbHit(self.Params[2]) then
        if not hasPoison then
            table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Restraint, self.Params[3]))
        else
            table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Stunning, self.Params[5]))
            table.insert(self.Data.ActivePoisonUnits, targetUnit)
        end
    end

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    return result
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    if self.Params[7] == 1 then
        for _, targetUnit in pairs(self.Data.ActivePoisonUnits) do
            local buffs = targetUnit:GetComponent("BuffComponent"):GetBuffsById(BattleBuffType.Poison)
            for _, buff in pairs(buffs) do
                buff:Settle()
                buff:DecLeftTurn()
            end
        end
    end

    self.Data.ActivePoisonUnits = {}
end

Skill_114211.__init = __init
Skill_114211.OnUseActiveSkill = OnUseActiveSkill
Skill_114211.OnAtkEnd = OnAtkEnd

return Skill_114211