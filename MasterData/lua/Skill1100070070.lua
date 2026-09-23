-- 我方只剩1人时，攻击时候获得100%攻击力，100%damage伤害(蓝色buff)，行动开始时候获得10点np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070070 = oo.class(SkillBase)
function Skill1100070070:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070070:OnBefourHurt(caster, target, data)
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
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 1100070070
	self:AddTempAttrPercent(SkillEffect[1100070070], caster, self.card, data, "damage",1)
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
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 1100070073
	self:AddTempAttrPercent(SkillEffect[1100070073], caster, self.card, data, "attack",1)
end
-- 行动开始
function Skill1100070070:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 1100070076
	self:AddNp(SkillEffect[1100070076], caster, self.card, data, 10)
end
