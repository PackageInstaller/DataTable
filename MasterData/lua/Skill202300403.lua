-- 袅韵4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300403 = oo.class(SkillBase)
function Skill202300403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300403:DoSkill(caster, target, data)
	-- 202300413
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300413], caster, target, data, 4202313)
	-- 202300403
	self.order = self.order + 1
	self:Cure(SkillEffect[202300403], caster, target, data, 1,0.24)
	-- 202300416
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300416], caster, target, data, 2,2)
end
