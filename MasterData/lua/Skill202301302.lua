-- 袅韵（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202301302 = oo.class(SkillBase)
function Skill202301302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202301302:DoSkill(caster, target, data)
	-- 202301302
	self.order = self.order + 1
	self:Cure(SkillEffect[202301302], caster, target, data, 1,0.44)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202301312
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202301312], caster, target, data, 1,0.22)
	end
end
