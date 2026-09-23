-- 天赋效果301405
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301405 = oo.class(SkillBase)
function Skill301405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill301405:OnBefourHurt(caster, target, data)
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
	-- 301405
	self:AddTempAttr(SkillEffect[301405], caster, self.card, data, "careerAdjust",0.3)
end
