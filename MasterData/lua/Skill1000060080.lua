-- 控制词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000060080 = oo.class(SkillBase)
function Skill1000060080:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1000060080:OnAttackOver(caster, target, data)
	-- 8903
	if SkillJudger:HasBuff(self, caster, target, true,2,1,1) then
	else
		return
	end
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
	-- 1000060080
	self:HitAddBuff(SkillEffect[1000060080], caster, target, data, 10000,1001,2)
end
