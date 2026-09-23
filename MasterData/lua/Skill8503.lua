-- 天赋效果3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8503 = oo.class(SkillBase)
function Skill8503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8503:OnBefourHurt(caster, target, data)
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
	-- 8403
	local count3 = SkillApi:DeathCount(self, caster, target,1)
	-- 8503
	self:AddTempAttr(SkillEffect[8503], caster, self.card, data, "damage",count3*0.08)
end
