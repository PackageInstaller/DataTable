-- 奥西里斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780500201 = oo.class(SkillBase)
function Skill780500201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780500201:DoSkill(caster, target, data)
	-- 780500201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[780500201], caster, target, data, 780500201)
end
-- 行动开始
function Skill780500201:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 780500202
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[780500202], caster, target, data, 780500201)
	end
end
-- 行动结束
function Skill780500201:OnActionOver(caster, target, data)
	-- 8784
	local count784 = SkillApi:GetAttr(self, caster, target,2,"sMech")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 780500203
	self:AddBuff(SkillEffect[780500203], caster, self.card, data, 780500201+count784)
end
-- 回合开始时
function Skill780500201:OnRoundBegin(caster, target, data)
	-- 8793
	local count793 = SkillApi:BuffCount(self, caster, target,1,4,780500201)
	-- 780500208
	if SkillJudger:Greater(self, caster, target, true,count793,0) then
	else
		return
	end
	-- 780500219
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[780500219], caster, target, data, 780500298)
	end
	-- 780500224
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[780500224], caster, target, data, 780500217)
	end
	-- 780500229
	self:DelBufferForce(SkillEffect[780500229], caster, self.card, data, 780500298)
	-- 780500244
	if SkillJudger:HasBuff(self, caster, target, true,1,780500298) then
	else
		return
	end
	-- 9768
	local count9768 = SkillApi:GetAttr(self, caster, target,1,"hp")
	-- 9743
	local count818 = SkillApi:GetAttr(self, caster, target,1,"maxhp")
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 780500209
	self:AddHp(SkillEffect[780500209], caster, caster, data, math.max(math.floor((count9768+count20)/(count818+count49)*count818-count9768),1-count9768))
	-- 780500214
	self:AddHp(SkillEffect[780500214], caster, self.card, data, math.max(-math.floor((count9768+count20)/(count818+count49)*count818-count9768),1-count20))
	-- 780500234
	self:DelBufferForce(SkillEffect[780500234], caster, caster, data, 780500201)
	-- 780500244
	if SkillJudger:HasBuff(self, caster, target, true,1,780500298) then
	else
		return
	end
	-- 780500239
	local targets = SkillFilter:HasBuff(self, caster, target, 3,780500298,4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[780500239], caster, target, data, 780500201)
	end
end
