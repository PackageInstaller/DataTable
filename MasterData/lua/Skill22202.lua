-- 广域II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22202 = oo.class(SkillBase)
function Skill22202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill22202:OnBefourHurt(caster, target, data)
	-- 22242
	self:tFunc_22242_22202(caster, target, data)
	self:tFunc_22242_22212(caster, target, data)
	self:tFunc_22242_22222(caster, target, data)
	self:tFunc_22242_22232(caster, target, data)
	self:tFunc_22242_22252(caster, target, data)
	self:tFunc_22242_22262(caster, target, data)
end
function Skill22202:tFunc_22242_22262(caster, target, data)
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
	-- 8269
	if SkillJudger:IsCtrlType(self, caster, target, true,14) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8915
	if SkillJudger:Equal(self, caster, target, true,count77,2) then
	else
		return
	end
	-- 22262
	self:AddTempAttrPercent(SkillEffect[22262], caster, self.card, data, "attack",0.20)
end
function Skill22202:tFunc_22242_22202(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 22202
	self:AddTempAttr(SkillEffect[22202], caster, self.card, data, "damage",0.20)
end
function Skill22202:tFunc_22242_22232(caster, target, data)
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
	-- 8265
	if SkillJudger:IsALLRange(self, caster, target, true) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8813
	if SkillJudger:Equal(self, caster, target, true,count77,1) then
	else
		return
	end
	-- 22232
	self:AddTempAttrPercent(SkillEffect[22232], caster, self.card, data, "attack",0.40)
end
function Skill22202:tFunc_22242_22252(caster, target, data)
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
	-- 8269
	if SkillJudger:IsCtrlType(self, caster, target, true,14) then
	else
		return
	end
	-- 22252
	self:AddTempAttr(SkillEffect[22252], caster, self.card, data, "damage",0.20)
end
function Skill22202:tFunc_22242_22222(caster, target, data)
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
	-- 8265
	if SkillJudger:IsALLRange(self, caster, target, true) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8915
	if SkillJudger:Equal(self, caster, target, true,count77,2) then
	else
		return
	end
	-- 22222
	self:AddTempAttrPercent(SkillEffect[22222], caster, self.card, data, "attack",0.20)
end
function Skill22202:tFunc_22242_22212(caster, target, data)
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
	-- 8265
	if SkillJudger:IsALLRange(self, caster, target, true) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8916
	if SkillJudger:Equal(self, caster, target, true,count77,3) then
	else
		return
	end
	-- 22212
	self:AddTempAttrPercent(SkillEffect[22212], caster, self.card, data, "attack",0.10)
end
