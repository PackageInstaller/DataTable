-- 超级烧伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326503 = oo.class(SkillBase)
function Skill326503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill326503:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 326503
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[326503], caster, target, data, "LimitDamage1002",0.3,0.3,0.3)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill326503:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 326503
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[326503], caster, target, data, "LimitDamage1002",0.3,0.3,0.3)
	end
end
