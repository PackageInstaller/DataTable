-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331704 = oo.class(SkillBase)
function Skill331704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331704:OnBefourHurt(caster, target, data)
	-- 331704
	self:tFunc_331704_331754(caster, target, data)
	self:tFunc_331704_331714(caster, target, data)
	self:tFunc_331704_331759(caster, target, data)
	self:tFunc_331704_331764(caster, target, data)
end
function Skill331704:tFunc_331704_331714(caster, target, data)
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
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 331714
	self:AddTempAttr(SkillEffect[331714], caster, caster, data, "attack",math.min((count49*0.04),1200))
end
function Skill331704:tFunc_331704_331764(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 331764
	self:AddTempAttr(SkillEffect[331764], caster, caster, data, "attack",math.min((count49*0.04),2000))
end
function Skill331704:tFunc_331704_331759(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 331759
	self:AddTempAttr(SkillEffect[331759], caster, caster, data, "attack",math.min((count49*0.04),2000))
end
function Skill331704:tFunc_331704_331754(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 331754
	self:AddTempAttr(SkillEffect[331754], caster, caster, data, "attack",math.min((count49*0.04),1500))
end
