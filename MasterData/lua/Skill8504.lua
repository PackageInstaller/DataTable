-- 天赋效果4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8504 = oo.class(SkillBase)
function Skill8504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8504:OnBefourHurt(caster, target, data)
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
	-- 8404
	local count4 = SkillApi:DeathCount(self, caster, target,2)
	-- 8504
	self:AddTempAttr(SkillEffect[8504], caster, self.card, data, "damage",count4*0.08)
end
