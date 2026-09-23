-- 巨蟹座普通形态被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110802 = oo.class(SkillBase)
function Skill984110802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill984110802:OnAttackOver(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110851
	self:AddBuffCount(SkillEffect[984110851], caster, self.card, data, 984110802,1,80)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110854
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110854], caster, target, data, "LimitDamage1003",0.025,0,2)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110855
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110855], caster, target, data, "LimitDamage1001",0.025,0,2)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110856
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110856], caster, target, data, "LimitDamage1002",0.025,0,2)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110857
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110857], caster, target, data, "LimitDamage1051",0.025,0,2)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 984110858
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110858], caster, target, data, "LimitDamage603100101",0.025,0,2)
	end
end
-- 伤害前
function Skill984110802:OnBefourHurt(caster, target, data)
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
