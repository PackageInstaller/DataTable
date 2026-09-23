-- 弱者清退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320705 = oo.class(SkillBase)
function Skill320705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill320705:OnBefourHurt(caster, target, data)
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
	-- 320705
	self:AddTempAttr(SkillEffect[320705], caster, self.card, data, "damage",0.10)
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 320715
	self:AddTempAttr(SkillEffect[320715], caster, self.card, data, "damage",0.20)
end
