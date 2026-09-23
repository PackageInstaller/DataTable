-- 天赋效果307005
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307005 = oo.class(SkillBase)
function Skill307005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill307005:OnCure(caster, target, data)
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
	-- 307005
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[307005], caster, target, data, 2101)
	end
end
