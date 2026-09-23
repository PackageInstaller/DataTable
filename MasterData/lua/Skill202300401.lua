-- 袅韵4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300401 = oo.class(SkillBase)
function Skill202300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300401:DoSkill(caster, target, data)
	-- 202300411
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300411], caster, target, data, 4202311)
	-- 202300401
	self.order = self.order + 1
	self:Cure(SkillEffect[202300401], caster, target, data, 1,0.18)
	-- 202300416
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300416], caster, target, data, 2,2)
end
