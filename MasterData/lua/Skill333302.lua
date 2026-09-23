-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333302 = oo.class(SkillBase)
function Skill333302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333302
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333302], caster, target, data, "LimitDamage1003",0.15)
	end
	-- 333312
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333312], caster, target, data, "LimitDamage1001",0.15)
	end
	-- 333322
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333322], caster, target, data, "LimitDamage1002",0.15)
	end
	-- 333332
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333332], caster, target, data, "LimitDamage1051",0.15)
	end
end
