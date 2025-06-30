---
---守护天使
---自身反击成功时造成的所有伤害＋40%。
---我方前排防御力＋30%、命中＋30。
---自身战斗不能时对全体敌人造成250%光属性伤害
---亲密度100%：自身对【恐惧】、【消沉】效果免疫。
local Skill_10314 = BaseClass("Skill_10314",Skill)
local base = Skill

local function __init(self)

end

local function OnDamageEvent(self, atkUnit, hurtUnit, activeSkillResult)
    if not BattleUtil.IsFriend(hurtUnit, self.SrcUnit) then
        return
    end
    if self.__scc.IsDead then
        return
    end
    
    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return 
    end

    if self.__bc.CurActType ~= ActType.Cac then
        hurtUnit:GetComponent("SsUnitBattleComponent").CacUnit = atkUnit
    end
end

Skill_10314.__init = __init
Skill_10314.OnDamageEvent = OnDamageEvent


return Skill_10314