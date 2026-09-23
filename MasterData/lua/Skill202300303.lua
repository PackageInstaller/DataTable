--  袅韵3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300303 = oo.class(SkillBase)
function Skill202300303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300303:DoSkill(caster, target, data)
	-- 202300303
	self.order = self.order + 1
	self:Cure(SkillEffect[202300303], caster, target, data, 1,0.26)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202300313
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202300313], caster, target, data, 1,0.13)
	end
end
