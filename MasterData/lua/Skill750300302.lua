-- 超级索尼子3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300302 = oo.class(SkillBase)
function Skill750300302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300302:DoSkill(caster, target, data)
	-- 750300307
	self.order = self.order + 1
	self:Cure(SkillEffect[750300307], caster, target, data, 1,0.18)
	-- 750300302
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750300302], caster, target, data, 2,1)
end
