-- 曙暮辉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400602 = oo.class(SkillBase)
function Skill4400602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4400602:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8871
	if SkillJudger:Greater(self, caster, target, true,count77,0) then
	else
		return
	end
	-- 4400602
	local targets = SkillFilter:All(self, caster, target, nil)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4400602], caster, target, data, 1043)
	end
	-- 4400607
	self:DelValue(SkillEffect[4400607], caster, self.card, data, "dmg4006")
end
-- 入场时
function Skill4400602:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400606
	self:OwnerAddBuff(SkillEffect[4400606], caster, self.card, data, 1041)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4400602:OnBefourCritHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 4400612
	self:AddTempAttr(SkillEffect[4400612], caster, caster, data, "crit",0.002*math.max(count7-count8,0))
end
-- 特殊入场时(复活，召唤，合体)
function Skill4400602:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400606
	self:OwnerAddBuff(SkillEffect[4400606], caster, self.card, data, 1041)
end
