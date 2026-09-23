--  袅韵3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300304 = oo.class(SkillBase)
function Skill202300304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300304:DoSkill(caster, target, data)
	-- 202300304
	self.order = self.order + 1
	self:Cure(SkillEffect[202300304], caster, target, data, 1,0.28)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202300314
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202300314], caster, target, data, 1,0.14)
	end
end
