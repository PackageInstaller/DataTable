-- 角斗场buff3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000019 = oo.class(SkillBase)
function Skill6000019:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6000019:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6000019
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6000019], caster, target, data, "LimitDamage1003",0.50)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6000022
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6000022], caster, target, data, "LimitDamage1002",0.50)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6000023
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6000023], caster, target, data, "LimitDamage1001",0.50)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6000024
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6000024], caster, target, data, "LimitDamage1051",0.5)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6000025
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6000025], caster, target, data, "LimitDamage603000101",0.5)
	end
end
