-- 分解者技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914100301 = oo.class(SkillBase)
function Skill914100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914100301:DoSkill(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914100305
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914100321
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[914100321], caster, self.card, data, 914100301)
	elseif 2 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914100322
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[914100322], caster, self.card, data, 914100302)
	elseif 3 == r then
		-- 8070
		if SkillJudger:TargetIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914100323
		self.order = self.order + 1
		self:OwnerAddBuff(SkillEffect[914100323], caster, self.card, data, 914100303)
	end
end
-- 行动结束
function Skill914100301:OnActionOver(caster, target, data)
	-- 914100304
	self:tFunc_914100304_914100301(caster, target, data)
	self:tFunc_914100304_914100303(caster, target, data)
	self:tFunc_914100304_914100312(caster, target, data)
	self:tFunc_914100304_914100314(caster, target, data)
	self:tFunc_914100304_914100315(caster, target, data)
	self:tFunc_914100304_914100317(caster, target, data)
	self:tFunc_914100304_914100318(caster, target, data)
	self:tFunc_914100304_914100319(caster, target, data)
	self:tFunc_914100304_914100320(caster, target, data)
end
-- 入场时
function Skill914100301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914100504
	self:CallOwnerSkill(SkillEffect[914100504], caster, self.card, data, 914100301)
end
-- 回合结束时
function Skill914100301:OnRoundOver(caster, target, data)
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
	-- 914100503
	self:CallOwnerSkill(SkillEffect[914100503], caster, self.card, data, 914100301)
end
function Skill914100301:tFunc_914100304_914100318(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 914100308
	if SkillJudger:HasBuff(self, caster, target, true,2,914100303) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100318
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100318], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100314(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 914100306
	if SkillJudger:HasBuff(self, caster, target, true,2,914100301) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100314
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100314], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100315(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 914100308
	if SkillJudger:HasBuff(self, caster, target, true,2,914100303) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100315
	self:AddBuffCount(SkillEffect[914100315], caster, self.card, data, 914100304,1,20)
end
function Skill914100301:tFunc_914100304_914100317(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 914100306
	if SkillJudger:HasBuff(self, caster, target, true,2,914100301) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100317
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100317], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100320(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 914100307
	if SkillJudger:HasBuff(self, caster, target, true,2,914100302) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100320
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100320], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100303(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 914100307
	if SkillJudger:HasBuff(self, caster, target, true,2,914100302) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100303
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100303], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100319(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 914100308
	if SkillJudger:HasBuff(self, caster, target, true,2,914100303) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100319
	local targets = SkillFilter:Rand(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914100319], caster, target, data, 914100101)
	end
end
function Skill914100301:tFunc_914100304_914100301(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 914100306
	if SkillJudger:HasBuff(self, caster, target, true,2,914100301) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100301
	self:AddBuffCount(SkillEffect[914100301], caster, self.card, data, 914100304,1,20)
end
function Skill914100301:tFunc_914100304_914100312(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 914100307
	if SkillJudger:HasBuff(self, caster, target, true,2,914100302) then
	else
		return
	end
	-- 914100324
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 914100325
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 914100312
	self:AddBuffCount(SkillEffect[914100312], caster, self.card, data, 914100304,1,20)
end
