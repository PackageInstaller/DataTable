-- 天赋效果302001
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302001 = oo.class(SkillBase)
function Skill302001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill302001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302001
	self:AddSp(SkillEffect[302001], caster, self.card, data, 10)
end
