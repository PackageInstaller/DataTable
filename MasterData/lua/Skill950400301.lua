-- 黄金双子座技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950400301 = oo.class(SkillBase)
function Skill950400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950400301:DoSkill(caster, target, data)
	-- 950400305
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 950400311
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[950400311], caster, self.card, data, 950400301)
	elseif 2 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 950400312
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[950400312], caster, self.card, data, 950400302)
	elseif 3 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 950400313
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[950400313], caster, self.card, data, 950400303)
	elseif 4 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 950400319
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[950400319], caster, self.card, data, 950400302)
	elseif 5 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 950400320
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[950400320], caster, self.card, data, 950400303)
	end
end
-- 行动结束
function Skill950400301:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 950400304
	self:tFunc_950400304_950400303(caster, self.card, data)
	self:tFunc_950400304_950400309(caster, self.card, data)
	self:tFunc_950400304_950400310(caster, self.card, data)
end
-- 入场时
function Skill950400301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 950400315
	self:CallOwnerSkill(SkillEffect[950400315], caster, self.card, data, 950400301)
end
-- 回合结束时
function Skill950400301:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 906100606
	if SkillJudger:Equal(self, caster, target, true,(playerturn%8),0) then
	else
		return
	end
	-- 950400316
	self:DelBuffQuality(SkillEffect[950400316], caster, self.card, data, 2,5)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 906100606
	if SkillJudger:Equal(self, caster, target, true,(playerturn%8),0) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 950400314
	self:CallOwnerSkill(SkillEffect[950400314], caster, self.card, data, 950400301)
end
function Skill950400301:tFunc_950400304_950400309(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 950400307
	if SkillJudger:HasBuff(self, caster, target, true,2,950400302) then
	else
		return
	end
	-- 950400309
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[950400309], caster, target, data, 950400801)
	end
end
function Skill950400301:tFunc_950400304_950400310(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 950400308
	if SkillJudger:HasBuff(self, caster, target, true,2,950400303) then
	else
		return
	end
	-- 950400310
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[950400310], caster, target, data, 950400801)
	end
end
function Skill950400301:tFunc_950400304_950400303(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 950400306
	if SkillJudger:HasBuff(self, caster, target, true,2,950400301) then
	else
		return
	end
	-- 950400303
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[950400303], caster, target, data, 950400801)
	end
end
