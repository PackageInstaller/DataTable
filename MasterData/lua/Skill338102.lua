-- 夏炙2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338102 = oo.class(SkillBase)
function Skill338102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill338102:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 338102
	self:AddTempAttr(SkillEffect[338102], caster, self.card, data, "damage",0.15)
end
-- 攻击结束
function Skill338102:OnAttackOver(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8740
	local count740 = SkillApi:SkillLevel(self, caster, target,3,4023002)
	-- 338112
	if self:Rand(1500) then
		self:CallOwnerSkill(SkillEffect[338112], caster, target, data, 402300200+count740)
	end
end
