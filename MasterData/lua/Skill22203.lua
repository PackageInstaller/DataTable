-- 广域III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22203 = oo.class(SkillBase)
function Skill22203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill22203:OnBefourHurt(caster, target, data)
	-- 22243
	self:tFunc_22243_22203(caster, target, data)
	self:tFunc_22243_22213(caster, target, data)
	self:tFunc_22243_22223(caster, target, data)
	self:tFunc_22243_22233(caster, target, data)
	self:tFunc_22243_22253(caster, target, data)
	self:tFunc_22243_22263(caster, target, data)
end
function Skill22203:tFunc_22243_22213(caster, target, data)
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
	-- 22213
	self:AddTempAttrPercent(SkillEffect[22213], caster, self.card, data, "attack",0.15)
end
function Skill22203:tFunc_22243_22253(caster, target, data)
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
	-- 22253
	self:AddTempAttr(SkillEffect[22253], caster, self.card, data, "damage",0.30)
end
function Skill22203:tFunc_22243_22233(caster, target, data)
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
	-- 22233
	self:AddTempAttrPercent(SkillEffect[22233], caster, self.card, data, "attack",0.60)
end
function Skill22203:tFunc_22243_22223(caster, target, data)
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
	-- 22223
	self:AddTempAttrPercent(SkillEffect[22223], caster, self.card, data, "attack",0.30)
end
function Skill22203:tFunc_22243_22263(caster, target, data)
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
	-- 8813
	if SkillJudger:Equal(self, caster, target, true,count77,1) then
	else
		return
	end
	-- 22263
	self:AddTempAttrPercent(SkillEffect[22263], caster, self.card, data, "attack",0.30)
end
function Skill22203:tFunc_22243_22203(caster, target, data)
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
	-- 22203
	self:AddTempAttr(SkillEffect[22203], caster, self.card, data, "damage",0.30)
end
