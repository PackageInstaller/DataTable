-- 末端暴发
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327305 = oo.class(SkillBase)
function Skill327305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill327305:OnAttackOver(caster, target, data)
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
	-- 8832
	if SkillJudger:IsProgressLess(self, caster, target, true,10) then
	else
		return
	end
	-- 327305
	self:LimitDamage(SkillEffect[327305], caster, target, data, 1,1.5)
end
