-- 巨蟹座普通形态被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110801 = oo.class(SkillBase)
function Skill984110801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill984110801:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110801
	self:AddBuffCount(SkillEffect[984110801], caster, self.card, data, 984110801,1,10)
end
-- 攻击结束
function Skill984110801:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110803
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110803], caster, target, data, "LimitDamage1003",0.2,0,2)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110813
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110813], caster, target, data, "LimitDamage1001",0.2,0,2)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110823
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110823], caster, target, data, "LimitDamage1002",0.2,0,2)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110833
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110833], caster, target, data, "LimitDamage1051",0.2,0,2)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984110843
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[984110843], caster, target, data, "LimitDamage603100101",0.2,0,2)
	end
end
-- 伤害前
function Skill984110801:OnBefourHurt(caster, target, data)
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
