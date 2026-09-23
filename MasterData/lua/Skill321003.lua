-- 破甲光刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321003 = oo.class(SkillBase)
function Skill321003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill321003:OnBefourHurt(caster, target, data)
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
	-- 8218
	if SkillJudger:IsNormal(self, caster, target, false) then
	else
		return
	end
	-- 321003
	self:AddTempAttr(SkillEffect[321003], caster, self.card, data, "damage",0.18)
end
