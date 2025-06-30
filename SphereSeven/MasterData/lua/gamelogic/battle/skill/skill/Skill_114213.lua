---
--- 凋零撕裂
--- 对单名敌人造成${Params[1]}%物理伤害，${Params[2]}%的概率赋予${Params[3]}个${Params[4]}回合的【中毒】。如果攻击前目标持有${Params[5]}【中毒】，额外对所有敌军赋予${Params[6]}个${Params[7]}回合的【中毒】，随后使所有敌军的【中毒】立即结算一次伤害(${Params[8]} 0,1 开关)
---

local Skill_114213 = BaseClass("Skill_114213", Skill)
local base = Skill

local function __init(self)
    self.Data.HasPoison = false
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    self.Data.HasPoison= targetUnit:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Poison) >= self.Params[5]

    if BattleUtil.IsPctProbHit(self.Params[2]) then
        for i = 1, self.Params[3], 1 do
            table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Poison, self.Params[4]))
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

    if not self.Data.HasPoison then
        return
    end

    if self.Params[8] == 1 then
        local enemies = self:__get_enemy_all()
        for _, targetUnit in pairs(enemies) do
            local subc = targetUnit:GetComponent("SsUnitBattleComponent")
            for i = 1, self.Params[6], 1 do
                subc:AddDebuff(BattleBuffType.Poison, self.SkillId, self.SrcUnit, self.Params[7])
            end

            local buffs = targetUnit:GetComponent("BuffComponent"):GetBuffsById(BattleBuffType.Poison)
            for _, buff in pairs(buffs) do
                buff:Settle()
                buff:DecLeftTurn()
            end
        end
    end

    self.Data.HasPoison = false
end

Skill_114213.__init = __init
Skill_114213.OnUseActiveSkill = OnUseActiveSkill
Skill_114213.OnAtkEnd = OnAtkEnd

return Skill_114213