-- 袅韵（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202301304 = oo.class(SkillBase)
function Skill202301304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202301304:DoSkill(caster, target, data)
	-- 202301304
	self.order = self.order + 1
	self:Cure(SkillEffect[202301304], caster, target, data, 1,0.48)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202301314
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202301314], caster, target, data, 1,0.24)
	end
end
