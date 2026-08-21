---
--- 攻击前，${Params[1]}%的概率解除目标一个buff。
---
local Equip_12060104 = BaseClass("Equip_12060104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    if BattleUtil.IsFriend(targetUnit, self.SrcUnit) then
        return
    end

    if BattleUtil.IsPctProbHit(self.Params[1]) then
        targetUnit:GetComponent("BuffComponent"):RandomRemoveOneBuff(false)
    end
end


Equip_12060104.__init = __init
Equip_12060104.BeforeSkillEffect = BeforeSkillEffect

return Equip_12060104