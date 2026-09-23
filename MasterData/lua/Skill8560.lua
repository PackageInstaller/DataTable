-- 天赋效果60
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8560 = oo.class(SkillBase)
function Skill8560:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8560:OnAttackOver(caster, target, data)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8460
	local count60 = SkillApi:GetAttr(self, caster, target,2,"crit_rate")
	-- 8321
	self:AddValue(SkillEffect[8321], caster, self.card, data, "bj1",count60)
	-- 8560
	self:RelevanceBuff(SkillEffect[8560], caster, target, data, 8503,8513)
	-- 8322
	self:DelValue(SkillEffect[8322], caster, self.card, data, "bj1")
end
