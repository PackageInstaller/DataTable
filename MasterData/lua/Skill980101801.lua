-- 暴虐其他被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101801 = oo.class(SkillBase)
function Skill980101801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101801:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101801
	local targets = SkillFilter:Group(self, caster, target, 4,8)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101801], caster, target, data, 980101801)
	end
end
