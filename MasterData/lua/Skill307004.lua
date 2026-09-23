-- 天赋效果307004
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307004 = oo.class(SkillBase)
function Skill307004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill307004:OnCure(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307004
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[307004], caster, target, data, 2101)
	end
end
