-- 袅韵（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202301301 = oo.class(SkillBase)
function Skill202301301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202301301:DoSkill(caster, target, data)
	-- 202301301
	self.order = self.order + 1
	self:Cure(SkillEffect[202301301], caster, target, data, 1,0.42)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202301311
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202301311], caster, target, data, 1,0.21)
	end
end
