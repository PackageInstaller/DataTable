-- 每周boss巨蟹座角色buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200004 = oo.class(SkillBase)
function Skill6200004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6200004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333345
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333345], caster, target, data, "LimitDamage1001",1,0,10)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333347
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333347], caster, target, data, "LimitDamage1002",1,0,10)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333348
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333348], caster, target, data, "LimitDamage1003",1,0,10)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333349
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333349], caster, target, data, "LimitDamage1051",1,0,10)
	end
end
-- 伤害后
function Skill6200004:OnAfterHurt(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 6200015
	self:AddBuffCount(SkillEffect[6200015], caster, self.card, data, 6200015,1,100)
end
-- 伤害前
function Skill6200004:OnBefourHurt(caster, target, data)
	-- 6200025
	self:tFunc_6200025_6200022(caster, target, data)
	self:tFunc_6200025_6200023(caster, target, data)
	self:tFunc_6200025_6200024(caster, target, data)
	self:tFunc_6200025_6200026(caster, target, data)
end
function Skill6200004:tFunc_6200025_6200026(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 6200026
	if self:Rand(2500) then
		self:AddBuff(SkillEffect[6200026], caster, target, data, 1002)
	end
end
function Skill6200004:tFunc_6200025_6200023(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 6200023
	if self:Rand(2500) then
		self:AlterBufferByID(SkillEffect[6200023], caster, target, data, 1003,2)
	end
end
function Skill6200004:tFunc_6200025_6200022(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 6200022
	if self:Rand(2500) then
		self:AddBuff(SkillEffect[6200022], caster, target, data, 1001)
	end
end
function Skill6200004:tFunc_6200025_6200024(caster, target, data)
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
	-- 984110853
	if SkillJudger:IsCtrlType(self, caster, target, true,15) then
	else
		return
	end
	-- 6200024
	if self:Rand(2500) then
		self:AlterBufferByID(SkillEffect[6200024], caster, target, data, 1051,2)
	end
end
