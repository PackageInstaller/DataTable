-- 天赋效果304203
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304203 = oo.class(SkillBase)
function Skill304203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill304203:OnAfterHurt(caster, target, data)
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
	-- 304203
	self:HitAddBuff(SkillEffect[304203], caster, target, data, 1600,5204,1)
end
