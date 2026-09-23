-- 天赋效果17
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8517 = oo.class(SkillBase)
function Skill8517:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8517:OnBefourHurt(caster, target, data)
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
	-- 8517
	self:AddTempAttr(SkillEffect[8517], caster, self.card, data, "careerAdjust",0.2)
end
