-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333304 = oo.class(SkillBase)
function Skill333304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333304
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333304], caster, target, data, "LimitDamage1003",0.25)
	end
	-- 333314
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333314], caster, target, data, "LimitDamage1001",0.25)
	end
	-- 333324
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333324], caster, target, data, "LimitDamage1002",0.25)
	end
	-- 333334
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333334], caster, target, data, "LimitDamage1051",0.25)
	end
end
