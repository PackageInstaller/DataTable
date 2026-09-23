-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331705 = oo.class(SkillBase)
function Skill331705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331705:OnBefourHurt(caster, target, data)
	-- 331705
	self:tFunc_331705_331755(caster, target, data)
	self:tFunc_331705_331715(caster, target, data)
	self:tFunc_331705_331760(caster, target, data)
	self:tFunc_331705_331765(caster, target, data)
end
function Skill331705:tFunc_331705_331760(caster, target, data)
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
	-- 331760
	self:AddTempAttr(SkillEffect[331760], caster, caster, data, "attack",math.min((count49*0.05),2000))
end
function Skill331705:tFunc_331705_331765(caster, target, data)
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
	-- 331765
	self:AddTempAttr(SkillEffect[331765], caster, caster, data, "attack",math.min((count49*0.05),2000))
end
function Skill331705:tFunc_331705_331715(caster, target, data)
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
	-- 331715
	self:AddTempAttr(SkillEffect[331715], caster, caster, data, "attack",math.min((count49*0.05),1500))
end
function Skill331705:tFunc_331705_331755(caster, target, data)
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
	-- 331755
	self:AddTempAttr(SkillEffect[331755], caster, caster, data, "attack",math.min((count49*0.05),1500))
end
