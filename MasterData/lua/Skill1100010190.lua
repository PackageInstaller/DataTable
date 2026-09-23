-- 范围技能攻击伤害加深10%，全体范围技能攻击时根据目标数量额外提升攻击，当目标数量为3时，攻击提升10%，当目标数为2时，攻击提升15%，当目标数为1时，攻击提升20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010190 = oo.class(SkillBase)
function Skill1100010190:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010190:OnBefourHurt(caster, target, data)
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
	-- 1100010190
	self:tFunc_1100010190_11000101900(caster, target, data)
	self:tFunc_1100010190_11000101901(caster, target, data)
	self:tFunc_1100010190_11000101902(caster, target, data)
	self:tFunc_1100010190_11000101903(caster, target, data)
end
function Skill1100010190:tFunc_1100010190_11000101903(caster, target, data)
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
	-- 11000101903
	self:AddTempAttrPercent(SkillEffect[11000101903], caster, self.card, data, "attack",0.20)
end
function Skill1100010190:tFunc_1100010190_11000101900(caster, target, data)
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
	-- 11000101900
	self:AddTempAttr(SkillEffect[11000101900], caster, self.card, data, "damage",0.1)
end
function Skill1100010190:tFunc_1100010190_11000101902(caster, target, data)
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
	-- 11000101902
	self:AddTempAttrPercent(SkillEffect[11000101902], caster, self.card, data, "attack",0.15)
end
function Skill1100010190:tFunc_1100010190_11000101901(caster, target, data)
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
	-- 11000101901
	self:AddTempAttrPercent(SkillEffect[11000101901], caster, self.card, data, "attack",0.1)
end
