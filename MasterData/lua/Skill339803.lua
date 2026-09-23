-- 蓝羚4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339803 = oo.class(SkillBase)
function Skill339803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill339803:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8776
	local count776 = SkillApi:BuffCount(self, caster, target,2,4,303000301)
	-- 339811
	if SkillJudger:Greater(self, caster, target, true,count776,0) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 339803
	self:AddTempAttr(SkillEffect[339803], caster, target, data, "defense",-150)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill339803:OnBefourCritHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8775
	local count775 = SkillApi:BuffCount(self, caster, target,1,4,303000201)
	-- 339716
	if SkillJudger:Greater(self, caster, target, true,count775,0) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8776
	local count776 = SkillApi:BuffCount(self, caster, target,2,4,303000301)
	-- 339811
	if SkillJudger:Greater(self, caster, target, true,count776,0) then
	else
		return
	end
	-- 339808
	self:AddTempAttr(SkillEffect[339808], caster, caster, data, "crit_rate",0.15)
end
