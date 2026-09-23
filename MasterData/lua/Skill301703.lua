-- 天赋效果301703
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301703 = oo.class(SkillBase)
function Skill301703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill301703:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301703
	self:AddNp(SkillEffect[301703], caster, self.card, data, 10)
end
