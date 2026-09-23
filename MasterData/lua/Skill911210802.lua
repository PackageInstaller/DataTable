-- 克拉肯-狂暴多队战斗技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210802 = oo.class(SkillBase)
function Skill911210802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill911210802:OnActionOver2(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 911210211
	self:CallOwnerSkill(SkillEffect[911210211], caster, self.card, data, 911210202)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
-- 入场时
function Skill911210802:OnBorn(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 911210211
	self:CallOwnerSkill(SkillEffect[911210211], caster, self.card, data, 911210202)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
