-- 天赋效果307003
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307003 = oo.class(SkillBase)
function Skill307003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill307003:OnCure(caster, target, data)
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
	-- 307003
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[307003], caster, target, data, 2101)
	end
end
