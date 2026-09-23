-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401900401 = oo.class(SkillBase)
function Skill401900401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401900401:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Unite(SkillEffect[50001], caster, target, data, 10000002,{progress=600})
end
