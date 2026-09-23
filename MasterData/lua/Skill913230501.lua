-- 第四章核心天使被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913230501 = oo.class(SkillBase)
function Skill913230501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill913230501:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8401
	local count1 = SkillApi:LiveCount(self, caster, target,1)
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 913210503
	self:AddTempAttrPercent(SkillEffect[913210503], caster, self.card, data, "attack",(count1-1)*0.03)
end
-- 入场时
function Skill913230501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 913210502
	if SkillJudger:Less(self, caster, target, true,count76,6) then
	else
		return
	end
	-- 913230501
	self:CallSkillEx(SkillEffect[913230501], caster, self.card, data, 913230601)
end
