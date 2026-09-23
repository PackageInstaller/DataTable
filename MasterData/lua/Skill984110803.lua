-- 巨蟹座普通形态被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110803 = oo.class(SkillBase)
function Skill984110803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill984110803:OnAddBuff(caster, target, data, buffer)
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
	-- 984110868
	if SkillJudger:IsCtrlBuffType(buffer or self, caster, target, true,1) then
	else
		return
	end
	-- 984110861
	self:AddBuffCount(SkillEffect[984110861], caster, self.card, data, 984110802,1,100)
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
	-- 984110863
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110863], caster, target, data, "LimitDamage1003",0.02,0,2)
	end
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
	-- 984110864
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110864], caster, target, data, "LimitDamage1001",0.02,0,2)
	end
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
	-- 984110865
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110865], caster, target, data, "LimitDamage1002",0.02,0,2)
	end
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
	-- 984110866
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110866], caster, target, data, "LimitDamage1051",0.02,0,2)
	end
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
	-- 984110867
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110867], caster, target, data, "LimitDamage603100101",0.02,0,2)
	end
end
-- 伤害前
function Skill984110803:OnBefourHurt(caster, target, data)
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
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 984110807
	if SkillJudger:Greater(self, caster, target, true,count18,79) then
	else
		return
	end
	-- 984110804
	self:AddTempAttr(SkillEffect[984110804], caster, self.card, data, "bedamage",-0.3)
end
