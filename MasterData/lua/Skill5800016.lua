-- dot易伤词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800016 = oo.class(SkillBase)
function Skill5800016:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800016:OnBefourHurt(caster, target, data)
	-- 5800086
	self:tFunc_5800086_5800083(caster, target, data)
	self:tFunc_5800086_5800084(caster, target, data)
	self:tFunc_5800086_5800085(caster, target, data)
	self:tFunc_5800086_5800087(caster, target, data)
	self:tFunc_5800086_5800088(caster, target, data)
	self:tFunc_5800086_5800104(caster, target, data)
end
-- 入场时
function Skill5800016:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333341
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333341], caster, target, data, "LimitDamage1001",1,0,10)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333343
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333343], caster, target, data, "LimitDamage1002",1,0,10)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333344
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333344], caster, target, data, "LimitDamage1003",1,0,10)
	end
end
-- 伤害后
function Skill5800016:OnAfterHurt(caster, target, data)
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
	-- 5800106
	self:AddBuffCount(SkillEffect[5800106], caster, caster, data, 5800106,1,100)
end
function Skill5800016:tFunc_5800086_5800083(caster, target, data)
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
	-- 5800097
	local count5800097 = SkillApi:BuffCount(self, caster, target,3,3,1001)
	-- 5800100
	if SkillJudger:Greater(self, caster, self.card, true,count5800097,0) then
	else
		return
	end
	-- 5800083
	self:AddBuff(SkillEffect[5800083], caster, self.card, data, 1001)
end
function Skill5800016:tFunc_5800086_5800088(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800088
	self:AddSkill(SkillEffect[5800088], caster, caster, data, 5800016)
end
function Skill5800016:tFunc_5800086_5800087(caster, target, data)
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
	-- 5800103
	local count5800103 = SkillApi:BuffCount(self, caster, target,3,3,603100101)
	-- 5800102
	if SkillJudger:Greater(self, caster, self.card, true,count5800103,0) then
	else
		return
	end
	-- 5800087
	self:AddBuffCount(SkillEffect[5800087], caster, self.card, data, 603100101,1,999)
end
function Skill5800016:tFunc_5800086_5800085(caster, target, data)
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
	-- 5800098
	local count5800098 = SkillApi:BuffCount(self, caster, target,3,3,1003)
	-- 5800101
	if SkillJudger:Greater(self, caster, self.card, true,count5800098,0) then
	else
		return
	end
	-- 5800085
	self:AlterBufferByID(SkillEffect[5800085], caster, self.card, data, 1051,1)
end
function Skill5800016:tFunc_5800086_5800084(caster, target, data)
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
	-- 5800098
	local count5800098 = SkillApi:BuffCount(self, caster, target,3,3,1003)
	-- 5800101
	if SkillJudger:Greater(self, caster, self.card, true,count5800098,0) then
	else
		return
	end
	-- 5800084
	self:AlterBufferByID(SkillEffect[5800084], caster, self.card, data, 1003,1)
end
function Skill5800016:tFunc_5800086_5800104(caster, target, data)
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
	-- 5800104
	self:AddBuff(SkillEffect[5800104], caster, self.card, data, 1002)
end
