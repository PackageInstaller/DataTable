-- 乌斯怀亚4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334201 = oo.class(SkillBase)
function Skill334201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334201
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[334201], caster, target, data, 334201)
	end
end
