-- 袅韵4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300405 = oo.class(SkillBase)
function Skill202300405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300405:DoSkill(caster, target, data)
	-- 202300415
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300415], caster, target, data, 4202315)
	-- 202300405
	self.order = self.order + 1
	self:Cure(SkillEffect[202300405], caster, target, data, 1,0.30)
	-- 202300416
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300416], caster, target, data, 2,2)
end
