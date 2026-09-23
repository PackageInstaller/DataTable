-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331703 = oo.class(SkillBase)
function Skill331703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331703:OnBefourHurt(caster, target, data)
	-- 331703
	self:tFunc_331703_331753(caster, target, data)
	self:tFunc_331703_331713(caster, target, data)
	self:tFunc_331703_331758(caster, target, data)
	self:tFunc_331703_331763(caster, target, data)
end
function Skill331703:tFunc_331703_331753(caster, target, data)
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
	-- 331753
	self:AddTempAttr(SkillEffect[331753], caster, caster, data, "attack",math.min((count49*0.03),1500))
end
function Skill331703:tFunc_331703_331713(caster, target, data)
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
	-- 331713
	self:AddTempAttr(SkillEffect[331713], caster, caster, data, "attack",math.min((count49*0.03),1000))
end
function Skill331703:tFunc_331703_331763(caster, target, data)
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
	-- 331763
	self:AddTempAttr(SkillEffect[331763], caster, caster, data, "attack",math.min((count49*0.03),2000))
end
function Skill331703:tFunc_331703_331758(caster, target, data)
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
	-- 331758
	self:AddTempAttr(SkillEffect[331758], caster, caster, data, "attack",math.min((count49*0.03),2000))
end
