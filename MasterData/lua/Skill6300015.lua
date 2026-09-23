-- 虚数天灾普通模式buff5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300015 = oo.class(SkillBase)
function Skill6300015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6300015:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500001
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[5500001], caster, target, data, "LimitDamage",-0.3,-0.3,0)
	end
end
