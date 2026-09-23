-- 6.1新天启buff32
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400035 = oo.class(SkillBase)
function Skill6400035:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400035:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6400032
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[6400032], caster, target, data, "LimitDamage",-0.10,-0.35,0)
	end
end
