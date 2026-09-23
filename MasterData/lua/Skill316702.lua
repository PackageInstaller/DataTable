-- 强力一击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill316702 = oo.class(SkillBase)
function Skill316702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill316702:OnBefourHurt(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 316702
	self:HitAddBuff(SkillEffect[316702], caster, target, data, 1500,3004)
end
