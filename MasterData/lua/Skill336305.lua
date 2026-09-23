-- 龙弦2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336305 = oo.class(SkillBase)
function Skill336305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill336305:OnBefourHurt(caster, target, data)
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
	-- 336305
	self:AddTempAttr(SkillEffect[336305], caster, self.card, data, "damage",0.30)
end
-- 攻击结束
function Skill336305:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8718
	local count718 = SkillApi:SkillLevel(self, caster, target,3,6021001)
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8099
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 336315
	self:CallSkill(SkillEffect[336315], caster, self.card, data, 602100100+count718)
end
