---
--- 受击后,将最终伤害的${Params[1]}%反伤给所有带有【麻痹】状态的敌人。
---

local Skill_10464 = BaseClass("Skill_10464",Skill)
local base = Skill

local function __init(self)
end

local function onParamsInited(self)
    base.onParamsInited(self)

    self.Data.DamageScale = self.Params[1] / 100
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if self.IsDisabled then
        return
    end

    if activeSkillResult.FeixiaoDamage == nil then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    local value = activeSkillResult.TotalDamage * self.Data.DamageScale
    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local sbc = enemy:GetComponent("BuffComponent")
        local cc = enemy:GetComponent("CharacterComponent")
        if (not cc.IsDead) and sbc:HasBuffId(BattleBuffType.Paralysis) then
            local damageData = DamageData.New(value, BattleDamageType.Universal)
            enemy:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
        end
    end
end


Skill_10464.__init = __init
Skill_10464.onParamsInited = onParamsInited
Skill_10464.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_10464.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_10464.OnBattleStart = OnBattleStart
Skill_10464.AfterBeHitAll = AfterBeHitAll


return Skill_10464