-- 理之刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320803 = oo.class(SkillBase)
function Skill320803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill320803:OnBefourHurt(caster, target, data)
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
	-- 8403
	local count3 = SkillApi:DeathCount(self, caster, target,1)
	-- 320803
	self:AddTempAttr(SkillEffect[320803], caster, self.card, data, "damage",count3*0.09)
end
-- 伤害后
function Skill320803:OnAfterHurt(caster, target, data)
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
	-- 320811
	self:LimitDamage(SkillEffect[320811], caster, target, data, 0.01,0.5)
end
