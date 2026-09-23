-- 热能干涉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313505 = oo.class(SkillBase)
function Skill313505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill313505:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8127
	if SkillJudger:IsTargetCareer(self, caster, target, true,2) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 313505
	self:AddTempAttrPercent(SkillEffect[313505], caster, target, data, "defense",-0.30)
end
