-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333301 = oo.class(SkillBase)
function Skill333301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333301], caster, target, data, "LimitDamage1003",0.10)
	end
	-- 333311
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333311], caster, target, data, "LimitDamage1001",0.10)
	end
	-- 333321
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333321], caster, target, data, "LimitDamage1002",0.10)
	end
	-- 333331
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333331], caster, target, data, "LimitDamage1051",0.10)
	end
end
