-- 扳机三连
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710230201 = oo.class(SkillBase)
function Skill710230201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710230201:DoSkill(caster, target, data)
	-- 710230201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[710230201], caster, target, data, 710230201)
	-- 710230219
	self.order = self.order + 1
	self:AddSkill(SkillEffect[710230219], caster, target, data, 710230501)
end
-- 行动开始
function Skill710230201:OnActionBegin(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710230206
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[710230206], caster, target, data, 710230201)
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710230224
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelSkill(SkillEffect[710230224], caster, target, data, 710230501)
	end
end
-- 行动结束
function Skill710230201:OnActionOver(caster, target, data)
	-- 8784
	local count784 = SkillApi:GetAttr(self, caster, target,2,"sMech")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710230211
	self:SetAttr(SkillEffect[710230211], caster, self.card, data, "sMech",count784)
	-- 710230212
	self:AddBuff(SkillEffect[710230212], caster, self.card, data, 710230205+count784)
	-- 8991
	local count991 = SkillApi:GetAttr(self, caster, target,2,"nClass")
	-- 710230232
	self:SetAttr(SkillEffect[710230232], caster, self.card, data, "nClass",count991)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 710230230
	self:SetAttr(SkillEffect[710230230], caster, self.card.oSummoner, data, "sMech",count784)
	-- 710230231
	self:AddBuff(SkillEffect[710230231], caster, self.card.oSummoner, data, 710230205+count784)
	-- 8991
	local count991 = SkillApi:GetAttr(self, caster, target,2,"nClass")
	-- 710230233
	self:SetAttr(SkillEffect[710230233], caster, self.card.oSummoner, data, "nClass",count991)
end
-- 攻击结束
function Skill710230201:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8792
	local count792 = SkillApi:BuffCount(self, caster, target,2,4,710230201)
	-- 710230218
	if SkillJudger:Greater(self, caster, target, true,count792,0) then
	else
		return
	end
	-- 710230507
	if SkillJudger:HasBuff(self, caster, target, true,2,710230302) then
	else
		return
	end
	-- 710230213
	if self:Rand(3000) then
		self:BeatBack(SkillEffect[710230213], caster, self.card, data, nil,13)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill710230201:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 710230229
	self:AddBuff(SkillEffect[710230229], caster, caster, data, 710230302)
end
