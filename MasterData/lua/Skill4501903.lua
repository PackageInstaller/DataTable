-- 先手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501903 = oo.class(SkillBase)
function Skill4501903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4501903:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4501903
	self:AddProgress(SkillEffect[4501903], caster, self.card, data, 300)
end
