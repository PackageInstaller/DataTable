-- 星之武练
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802501 = oo.class(SkillBase)
function Skill4802501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4802501:OnDeath(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4802501
	self:AddProgress(SkillEffect[4802501], caster, self.card, data, 500)
	-- 4802502
	self:AddBuff(SkillEffect[4802502], caster, self.card, data, 4006,1)
end
-- 伤害前
function Skill4802501:OnBefourHurt(caster, target, data)
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
	-- 8406
	local count6 = SkillApi:PercentHp(self, caster, target,2)
	-- 4802503
	self:AddTempAttr(SkillEffect[4802503], caster, self.card, data, "damage",math.min((1-count6)*0.5,0.5))
end
