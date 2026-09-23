-- 阿努比斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331104 = oo.class(SkillBase)
function Skill331104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331104:OnBefourHurt(caster, target, data)
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
	-- 331104
	self:AddTempAttr(SkillEffect[331104], caster, self.card, data, "damage",0.16)
	-- 8092
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 331114
	self:AddTempAttr(SkillEffect[331114], caster, self.card, data, "damage",0.16)
end
