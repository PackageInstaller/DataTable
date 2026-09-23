-- 克拉伦特
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4602804 = oo.class(SkillBase)
function Skill4602804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4602804:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8095
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 4602804
	self:AddTempAttr(SkillEffect[4602804], caster, self.card, data, "damage",0.4)
end
