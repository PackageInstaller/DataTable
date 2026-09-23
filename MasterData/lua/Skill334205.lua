-- 乌斯怀亚4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334205 = oo.class(SkillBase)
function Skill334205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334205:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334205
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[334205], caster, target, data, 334205)
	end
end
