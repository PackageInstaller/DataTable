-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333305 = oo.class(SkillBase)
function Skill333305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333305
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333305], caster, target, data, "LimitDamage1003",0.30)
	end
	-- 333315
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333315], caster, target, data, "LimitDamage1001",0.30)
	end
	-- 333325
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333325], caster, target, data, "LimitDamage1002",0.30)
	end
	-- 333335
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333335], caster, target, data, "LimitDamage1051",0.30)
	end
end
