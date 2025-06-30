---
--- 攻击提升 攻击力提升50%
---
local Buff_10021 = BaseClass("Buff_10021",Buff)
local base = Buff

local function AfterHurt(self, activeSkillResult, atkUnit)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    if battleComponent.CurActUnit == nil then
        return
    end
    local cauUbc = battleComponent.CurActUnit:GetComponent("SsUnitBattleComponent")
    if cauUbc:CurActSkillIsGeneralAtk() then
        if self.__tcc.IsMustCac > 0 then
            return
        end
        self.__tcc:IncSpecialEffect(SpecialEffectType.MustCac)
    end
end

local function AfterAllHurt(self)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    if battleComponent.CurActUnit == nil then
        return
    end
    local cauUbc = battleComponent.CurActUnit:GetComponent("SsUnitBattleComponent")
    if cauUbc:CurActSkillIsGeneralAtk() then
        if self.__tcc.IsMustCac > 0 then
            self.__tcc:DecSpecialEffect(SpecialEffectType.MustCac)
        end
    end
end

Buff_10021.AfterHurt = AfterHurt
Buff_10021.AfterAllHurt = AfterAllHurt

return Buff_10021