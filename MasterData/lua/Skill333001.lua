-- 幽兰4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333001 = oo.class(SkillBase)
function Skill333001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill333001:OnBefourHurt(caster, target, data)
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
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 333001
	self:AddTempAttr(SkillEffect[333001], caster, self.card, data, "attack",count620*100*4)
end
