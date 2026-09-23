-- 赤夕技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942000302 = oo.class(SkillBase)
function Skill942000302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942000302:DoSkill(caster, target, data)
	-- 704000302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704000302], caster, target, data, 704000302)
	-- 704000311
	self.order = self.order + 1
	self:Cure(SkillEffect[704000311], caster, target, data, 1,0.1)
end
