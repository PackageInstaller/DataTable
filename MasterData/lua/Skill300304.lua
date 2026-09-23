-- 天赋效果300304
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300304 = oo.class(SkillBase)
function Skill300304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300304:OnBefourHurt(caster, target, data)
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
	-- 300304
	self:AddTempAttr(SkillEffect[300304], caster, self.card, data, "damage",count3*0.10)
end
