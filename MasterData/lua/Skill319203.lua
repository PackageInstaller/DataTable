-- 燃魂剑刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319203 = oo.class(SkillBase)
function Skill319203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill319203:OnBefourHurt(caster, target, data)
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
	-- 8126
	if SkillJudger:IsTargetCareer(self, caster, target, true,1) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 319203
	self:AddTempAttr(SkillEffect[319203], caster, self.card, data, "damage",0.30)
end
