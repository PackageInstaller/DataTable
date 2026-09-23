-- 袅韵4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300402 = oo.class(SkillBase)
function Skill202300402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300402:DoSkill(caster, target, data)
	-- 202300412
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300412], caster, target, data, 4202312)
	-- 202300402
	self.order = self.order + 1
	self:Cure(SkillEffect[202300402], caster, target, data, 1,0.21)
	-- 202300416
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300416], caster, target, data, 2,2)
end
