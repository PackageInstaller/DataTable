-- 先手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501902 = oo.class(SkillBase)
function Skill4501902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4501902:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4501902
	self:AddProgress(SkillEffect[4501902], caster, self.card, data, 250)
end
