-- 天赋效果304404
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304404 = oo.class(SkillBase)
function Skill304404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill304404:OnAfterHurt(caster, target, data)
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
	-- 304404
	self:HitAddBuff(SkillEffect[304404], caster, target, data, 2000,1001)
end
