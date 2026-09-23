-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331701 = oo.class(SkillBase)
function Skill331701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331701:OnBefourHurt(caster, target, data)
	-- 331701
	self:tFunc_331701_331751(caster, target, data)
	self:tFunc_331701_331711(caster, target, data)
	self:tFunc_331701_331756(caster, target, data)
	self:tFunc_331701_331761(caster, target, data)
end
function Skill331701:tFunc_331701_331751(caster, target, data)
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
	-- 331751
	self:AddTempAttr(SkillEffect[331751], caster, caster, data, "attack",math.min((count49*0.01),1500))
end
function Skill331701:tFunc_331701_331711(caster, target, data)
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
	-- 331711
	self:AddTempAttr(SkillEffect[331711], caster, caster, data, "attack",math.min((count49*0.01),1000))
end
function Skill331701:tFunc_331701_331761(caster, target, data)
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
	-- 331761
	self:AddTempAttr(SkillEffect[331761], caster, caster, data, "attack",math.min((count49*0.01),2000))
end
function Skill331701:tFunc_331701_331756(caster, target, data)
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
	-- 331756
	self:AddTempAttr(SkillEffect[331756], caster, caster, data, "attack",math.min((count49*0.01),2000))
end
