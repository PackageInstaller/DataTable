-- 震荡击退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315202 = oo.class(SkillBase)
function Skill315202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill315202:OnActionOver(caster, target, data)
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
	-- 315202
	self:AddProgress(SkillEffect[315202], caster, target, data, -150)
end
-- 伤害前
function Skill315202:OnBefourHurt(caster, target, data)
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
	-- 315212
	self:AddTempAttr(SkillEffect[315212], caster, self.card, data, "damage",0.10)
end
