---
--- 鞭挞
--- 对血量最高的前排敌人造成&{Params[1]}%物理伤害，当攻击前自身强化状态不小于&{Params[2]}个时，延长自身强化状态&{Params[3]}回合，当攻击前自身强化状态不小于&{Params[4]}个时，对全体敌人造成此次攻击伤害&{Params[5]}%的额外伤害，提升自身&{Params[6]}%的行动值。
---

local Skill_113713 = BaseClass("Skill_113713", Skill)
local base = Skill

local function __init(self)
    self.Data.TriggeredExtraEffect = false

    self.Data.DamageMultiplier = self.Params[1]
    self.Data.IncBuffTurnCondition = self.Params[2]
    self.Data.IncBuffTurn = self.Params[3]
    self.Data.ExtraEffectBuffCount = self.Params[4]
    self.Data.ExtraDamageMultiplier = self.Params[5]
    self.Data.ExtraActValueAdd = self.Params[6]
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end
    
    if self.__sbc:BuffTypeCount(false) >= self.Data.IncBuffTurnCondition then
        self.__sbc:IncAllBuffTurn(false, self.Data.IncBuffTurn)
    end
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    if self.__sbc:BuffTypeCount(false) >= self.Data.ExtraEffectBuffCount then
        self.Data.TriggeredExtraEffect = true
    end

    local result = ActiveSkillResult.New()
    local damageScale = self.Data.DamageMultiplier / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    return result
end

local function OnAtkEnd(self)
    base.OnActEnd(self)

    if not self.__bc.CurActSkill == self then
        return
    end

    if self.Data.TriggeredExtraEffect then
        local result = table.first(self.__bc.CurActSkill.UnitResults, function (v) return true end)
        if result ~= nil then
            local enemies = self:__get_enemy_all()
            table.walk(enemies, 
                function(key, unit)
                    if not unit:GetComponent("CharacterComponent").IsDead then
                        local attr = self.__snc:Get(NumericType.Atk)
                        local damageData = DamageData.New(result.TotalDamage * self.Data.ExtraDamageMultiplier / 100, BattleDamageType.Universal)
                        unit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
                        -- unit:GetComponent("SsUnitBattleComponent"):Hurt(self.SrcUnit, BattleDamageType.Physical, damage)
                    end
                end)
        end
    end
end

local function OnActEnd(self)
    base.OnActEnd(self)

    if not self.__bc.CurActSkill == self then
        return
    end

    if self.Data.TriggeredExtraEffect then
        self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Data.ExtraActValueAdd)
    end

    self.Data.TriggeredExtraEffect = false
end

Skill_113713.__init = __init
Skill_113713.OnAtkStart = OnAtkStart
Skill_113713.OnUseActiveSkill = OnUseActiveSkill
Skill_113713.OnAtkEnd = OnAtkEnd
Skill_113713.OnActEnd = OnActEnd

return Skill_113713