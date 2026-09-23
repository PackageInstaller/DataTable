-- 超级索尼子3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300305 = oo.class(SkillBase)
function Skill750300305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300305:DoSkill(caster, target, data)
	-- 750300310
	self.order = self.order + 1
	self:Cure(SkillEffect[750300310], caster, target, data, 1,0.20)
	-- 750300305
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750300305], caster, target, data, 2,3)
end
