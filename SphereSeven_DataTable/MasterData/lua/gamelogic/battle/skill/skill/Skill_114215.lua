---
--- 毒囊喷洒
--- 解除全体敌人${Params[1]}个强化状态，对其造成${Params[2]}%的法术伤害，${Params[3]}%的概率赋予${Params[4]}个${Params[5]}回合的【中毒】。如果攻击前目标持有${Params[6]}个【中毒】，获得${Params[7]}%额外倍率，并使目标的【中毒】立即结算一次伤害(${Params[8]} 0,1 开关)。
---

local Skill_114215 = BaseClass("Skill_114215", Skill)
local base = Skill

local function __init(self)
    self.Data.HasPoison = false
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[2] / 100

    local targetUnitBuffComponent = targetUnit:GetComponent("BuffComponent")
    self.Data.HasPoison = targetUnit:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Poison) >= self.Params[6]
    if self.Data.HasPoison then
        damageScale = damageScale + self.Params[7] / 100
    end

    if BattleUtil.IsPctProbHit(self.Params[3]) then
        for i = 1, self.Params[4], 1 do
            table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Poison, self.Params[5]))
        end
    end

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Magic,
        Value = damageNum
    }

    result.FeixiaoDispel = {
        Tpye = BattleDispelType.Buff,
        Value = self.Params[1]
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
            local buffs = targetUnit:GetComponent("BuffComponent"):GetBuffsById(BattleBuffType.Poison)
            for _, buff in pairs(buffs) do
                buff:Settle()
                buff:DecLeftTurn()
            end
        end
    end

    self.Data.HasPoison = false
end

Skill_114215.__init = __init
Skill_114215.OnUseActiveSkill = OnUseActiveSkill
Skill_114215.OnAtkEnd = OnAtkEnd

return Skill_114215