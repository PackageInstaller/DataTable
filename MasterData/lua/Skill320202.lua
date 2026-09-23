-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320202 = oo.class(SkillBase)
function Skill320202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill320202:OnAttackOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	local count90 = SkillApi:GetCount(self, caster, target,2,402000101)
	if SkillJudger:Greater(self, caster, target, true,count90,4) then
	else
		return
	end
	self:LimitDamage(SkillEffect[320202], caster, target, data, 0.12,1.2)
end
