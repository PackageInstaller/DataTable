-- 恐惧咆哮
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302604 = oo.class(SkillBase)
function Skill4302604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4302604:OnBorn(caster, target, data)
	-- 4302634
	self:tFunc_4302634_4302604(caster, target, data)
	self:tFunc_4302634_4302621(caster, target, data)
	self:tFunc_4302634_4302622(caster, target, data)
	self:tFunc_4302634_4302623(caster, target, data)
	self:tFunc_4302634_4302624(caster, target, data)
end
-- 回合开始时
function Skill4302604:OnRoundBegin(caster, target, data)
	-- 8728
	local count728 = SkillApi:SkillLevel(self, caster, target,3,3026003)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8729
	local count729 = SkillApi:BuffCount(self, caster, target,1,4,1)
	-- 8941
	if SkillJudger:Greater(self, caster, self.card, true,count729,3) then
	else
		return
	end
	-- 4302642
	self:CallOwnerSkill(SkillEffect[4302642], caster, caster, data, 302600300+count728)
end
-- 伤害前
function Skill4302604:OnBefourHurt(caster, target, data)
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
	-- 8730
	local count730 = SkillApi:BuffCount(self, caster, target,2,4,1)
	-- 4302654
	self:AddTempAttr(SkillEffect[4302654], caster, target, data, "bedamage",count730*0.04)
end
function Skill4302604:tFunc_4302634_4302622(caster, target, data)
	-- 8274
	if SkillJudger:IsCasterSibling(self, caster, target, true,30220) then
	else
		return
	end
	-- 4302622
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4302622], caster, target, data, 4302621)
	end
end
function Skill4302604:tFunc_4302634_4302623(caster, target, data)
	-- 8273
	if SkillJudger:IsCasterSibling(self, caster, target, true,30270) then
	else
		return
	end
	-- 4302623
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4302623], caster, target, data, 4302621)
	end
end
function Skill4302604:tFunc_4302634_4302624(caster, target, data)
	-- 8271
	if SkillJudger:IsCasterSibling(self, caster, target, true,30250) then
	else
		return
	end
	-- 4302624
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4302624], caster, target, data, 4302621)
	end
end
function Skill4302604:tFunc_4302634_4302604(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4302604
	self:CallSkillEx(SkillEffect[4302604], caster, self.card, data, 302600402)
	-- 4302611
	self:AddBuff(SkillEffect[4302611], caster, self.card, data, 4302601)
end
function Skill4302604:tFunc_4302634_4302621(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4302621
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4302621], caster, target, data, 4302621)
	end
end
