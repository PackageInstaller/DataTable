-- 扳机三连
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710130205 = oo.class(SkillBase)
function Skill710130205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710130205:DoSkill(caster, target, data)
	-- 710130205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[710130205], caster, target, data, 710130205)
	-- 710130223
	self.order = self.order + 1
	self:AddSkill(SkillEffect[710130223], caster, target, data, 710130505)
end
-- 行动开始
function Skill710130205:OnActionBegin(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710130210
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[710130210], caster, target, data, 710130205)
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710130228
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelSkill(SkillEffect[710130228], caster, target, data, 710130505)
	end
end
-- 行动结束
function Skill710130205:OnActionOver(caster, target, data)
	-- 8784
	local count784 = SkillApi:GetAttr(self, caster, target,2,"sMech")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 710130211
	self:SetAttr(SkillEffect[710130211], caster, self.card, data, "sMech",count784)
	-- 710130212
	self:AddBuff(SkillEffect[710130212], caster, self.card, data, 710130205+count784)
	-- 8991
	local count991 = SkillApi:GetAttr(self, caster, target,2,"nClass")
	-- 710130232
	self:SetAttr(SkillEffect[710130232], caster, self.card, data, "nClass",count991)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 710130230
	self:SetAttr(SkillEffect[710130230], caster, self.card.oSummoner, data, "sMech",count784)
	-- 710130231
	self:AddBuff(SkillEffect[710130231], caster, self.card.oSummoner, data, 710130205+count784)
	-- 8991
	local count991 = SkillApi:GetAttr(self, caster, target,2,"nClass")
	-- 710130233
	self:SetAttr(SkillEffect[710130233], caster, self.card.oSummoner, data, "nClass",count991)
end
-- 攻击结束
function Skill710130205:OnAttackOver(caster, target, data)
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
	-- 8786
	local count786 = SkillApi:BuffCount(self, caster, target,2,4,710130201)
	-- 710130218
	if SkillJudger:Greater(self, caster, target, true,count786,0) then
	else
		return
	end
	-- 710130507
	if SkillJudger:HasBuff(self, caster, target, true,2,710130302) then
	else
		return
	end
	-- 710130217
	if self:Rand(5000) then
		self:BeatBack(SkillEffect[710130217], caster, self.card, data, nil,13)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill710130205:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 710130229
	self:AddBuff(SkillEffect[710130229], caster, caster, data, 710130302)
end
