-- 特殊穿透
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315903 = oo.class(SkillBase)
function Skill315903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill315903:OnBefourHurt(caster, target, data)
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
	-- 8167
	if SkillJudger:IsTargetCareer(self, caster, target, true,3) then
	else
		return
	end
	-- 315903
	self:AddTempAttr(SkillEffect[315903], caster, self.card, data, "damage",0.18)
end
