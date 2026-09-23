-- 阿努比斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331103 = oo.class(SkillBase)
function Skill331103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331103:OnBefourHurt(caster, target, data)
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
	-- 331103
	self:AddTempAttr(SkillEffect[331103], caster, self.card, data, "damage",0.12)
	-- 8092
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 331113
	self:AddTempAttr(SkillEffect[331113], caster, self.card, data, "damage",0.12)
end
