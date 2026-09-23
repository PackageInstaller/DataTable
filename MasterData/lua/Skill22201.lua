-- 广域I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22201 = oo.class(SkillBase)
function Skill22201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill22201:OnBefourHurt(caster, target, data)
	-- 22241
	self:tFunc_22241_22201(caster, target, data)
	self:tFunc_22241_22211(caster, target, data)
	self:tFunc_22241_22221(caster, target, data)
	self:tFunc_22241_22231(caster, target, data)
	self:tFunc_22241_22251(caster, target, data)
	self:tFunc_22241_22261(caster, target, data)
end
function Skill22201:tFunc_22241_22251(caster, target, data)
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
	-- 22251
	self:AddTempAttr(SkillEffect[22251], caster, self.card, data, "damage",0.10)
end
function Skill22201:tFunc_22241_22231(caster, target, data)
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
	-- 22231
	self:AddTempAttrPercent(SkillEffect[22231], caster, self.card, data, "attack",0.20)
end
function Skill22201:tFunc_22241_22201(caster, target, data)
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
	-- 22201
	self:AddTempAttr(SkillEffect[22201], caster, self.card, data, "damage",0.10)
end
function Skill22201:tFunc_22241_22211(caster, target, data)
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
	-- 22211
	self:AddTempAttrPercent(SkillEffect[22211], caster, self.card, data, "attack",0.05)
end
function Skill22201:tFunc_22241_22221(caster, target, data)
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
	-- 22221
	self:AddTempAttrPercent(SkillEffect[22221], caster, self.card, data, "attack",0.10)
end
function Skill22201:tFunc_22241_22261(caster, target, data)
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
	-- 8916
	if SkillJudger:Equal(self, caster, target, true,count77,3) then
	else
		return
	end
	-- 22261
	self:AddTempAttrPercent(SkillEffect[22261], caster, self.card, data, "attack",0.10)
end
