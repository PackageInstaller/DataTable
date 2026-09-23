-- 连锁阵线第二期buff2（通用）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000009 = oo.class(SkillBase)
function Skill6000009:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill6000009:OnAfterHurt(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 60000073
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[60000073], caster, target, data, 60000073)
	end
end
