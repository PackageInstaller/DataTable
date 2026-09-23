-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333303 = oo.class(SkillBase)
function Skill333303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333303:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333303], caster, target, data, "LimitDamage1003",0.20)
	end
	-- 333313
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333313], caster, target, data, "LimitDamage1001",0.20)
	end
	-- 333323
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333323], caster, target, data, "LimitDamage1002",0.20)
	end
	-- 333333
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333333], caster, target, data, "LimitDamage1051",0.20)
	end
end
