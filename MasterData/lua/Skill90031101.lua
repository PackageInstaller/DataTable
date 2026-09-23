-- 技能11
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031101 = oo.class(SkillBase)
function Skill90031101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031101:DoSkill(caster, target, data)
	-- 30001
	self.order = self.order + 1
	self:Cure(SkillEffect[30001], caster, target, data, 1,0.1)
	-- 4706
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4706], caster, target, data, 4706)
	-- 2001
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2001], caster, target, data, 2001)
end
