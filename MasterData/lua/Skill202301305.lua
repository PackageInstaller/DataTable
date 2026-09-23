-- 袅韵（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202301305 = oo.class(SkillBase)
function Skill202301305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202301305:DoSkill(caster, target, data)
	-- 202301305
	self.order = self.order + 1
	self:Cure(SkillEffect[202301305], caster, target, data, 1,0.50)
	-- 202300306
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[202300306], caster, target, data, 2,2)
	-- 202301315
	self.order = self.order + 1
	local targets = SkillFilter:Exception(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[202301315], caster, target, data, 1,0.25)
	end
end
