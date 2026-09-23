-- 弱者清退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320704 = oo.class(SkillBase)
function Skill320704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill320704:OnBefourHurt(caster, target, data)
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
	-- 320704
	self:AddTempAttr(SkillEffect[320704], caster, self.card, data, "damage",0.08)
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 320714
	self:AddTempAttr(SkillEffect[320714], caster, self.card, data, "damage",0.16)
end
