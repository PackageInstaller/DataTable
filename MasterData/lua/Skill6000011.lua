-- 连锁阵线第二期怪物buff1（针对洛贝拉）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000011 = oo.class(SkillBase)
function Skill6000011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6000011:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 60000046
	local countbedamage = SkillApi:GetAttr(self, caster, target,3,"bedamage")
	-- 60000046
	local countbedamage = SkillApi:GetAttr(self, caster, target,3,"bedamage")
	-- 60000047
	if SkillJudger:Greater(self, caster, self.card, true,countbedamage,1) then
	else
		return
	end
	-- 60000045
	self:AddTempAttr(SkillEffect[60000045], caster, self.card, data, "bedamage",-((countbedamage-1)*0.8))
end
