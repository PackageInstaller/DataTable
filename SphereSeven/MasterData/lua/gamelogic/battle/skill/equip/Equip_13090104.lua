---
--- 行动后，${Params[1]}%的概率随机减少自身${Params[2]}个技能的冷却时间${Params[3]}回合。如果自身持有增益状态，则概率翻倍。
---

local Equip_13090104 = BaseClass("Equip_13090104", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local probability = self.Params[1]
    if self.__sbc:HasBuff() then
        probability = probability * 2
    end

    if not BattleUtil.IsPctProbHit(probability) then
        return
    end

    local reduceCoolDown = math.modf(self.Params[3])
    local skills = self.SrcUnit:GetComponent("SkillComponent"):RandomActiveSkills(self.Params[2])
    for _, skill in pairs(skills) do
        skill:ReduceCoolDownTurn(reduceCoolDown)
    end
end


Equip_13090104.__init = __init
Equip_13090104.OnActEnd = OnActEnd

return Equip_13090104