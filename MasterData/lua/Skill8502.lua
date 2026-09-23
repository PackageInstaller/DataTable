-- 天赋效果2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8502 = oo.class(SkillBase)
function Skill8502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8502:OnBefourHurt(caster, target, data)
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
	-- 8402
	local count2 = SkillApi:LiveCount(self, caster, target,2)
	-- 8502
	self:AddTempAttr(SkillEffect[8502], caster, self.card, data, "damage",count2*0.03)
end
