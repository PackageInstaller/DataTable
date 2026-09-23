-- 破甲融炎
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304103 = oo.class(SkillBase)
function Skill304103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill304103:OnAfterHurt(caster, target, data)
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
	-- 304103
	self:HitAddBuff(SkillEffect[304103], caster, target, data, 600,5104,2)
end
