-- 弱者清退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320703 = oo.class(SkillBase)
function Skill320703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill320703:OnBefourHurt(caster, target, data)
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
	-- 320703
	self:AddTempAttr(SkillEffect[320703], caster, self.card, data, "damage",0.06)
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 320713
	self:AddTempAttr(SkillEffect[320713], caster, self.card, data, "damage",0.12)
end
