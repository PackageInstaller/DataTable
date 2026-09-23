-- 天赋效果312902
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312902 = oo.class(SkillBase)
function Skill312902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill312902:OnBefourHurt(caster, target, data)
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
	-- 8126
	if SkillJudger:IsTargetCareer(self, caster, target, true,1) then
	else
		return
	end
	-- 312902
	self:AddTempAttrPercent(SkillEffect[312902], caster, target, data, "defense",-0.12)
end
