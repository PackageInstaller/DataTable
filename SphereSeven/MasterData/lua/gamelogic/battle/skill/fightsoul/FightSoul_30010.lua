---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/22 16:52
--- 服部半藏
---自身使用技能后自身获得【隐蔽】效果
local FightSoul_30010 = BaseClass("FightSoul_30010",Skill)
local base = Skill

local function __init(self)

end

local function BeforeSkillEffect(self, targetUnit)
    if targetUnit:GetComponent("BuffComponent"):HasBuffId(BattleBuffType.Poison) then
        self.__subc:IncTempNumeric(NumericType.AtkPct, self.Params[1])
    end
end

FightSoul_30010.__init = __init
FightSoul_30010.BeforeSkillEffect = BeforeSkillEffect

return FightSoul_30010