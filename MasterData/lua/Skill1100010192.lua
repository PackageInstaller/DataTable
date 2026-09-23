-- 范围技能攻击伤害加深30%，全体范围技能攻击时根据目标数量额外提升攻击，当目标数量为3时，攻击提升30%，当目标数为2时，攻击提升4%，当目标数为1时，攻击提升60%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010192 = oo.class(SkillBase)
function Skill1100010192:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010192:OnBefourHurt(caster, target, data)
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
	-- 1100010192
	self:tFunc_1100010192_11000101922(caster, target, data)
	self:tFunc_1100010192_11000101923(caster, target, data)
	self:tFunc_1100010192_11000101924(caster, target, data)
	self:tFunc_1100010192_11000101925(caster, target, data)
end
function Skill1100010192:tFunc_1100010192_11000101923(caster, target, data)
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
	-- 11000101923
	self:AddTempAttrPercent(SkillEffect[11000101923], caster, self.card, data, "attack",0.3)
end
function Skill1100010192:tFunc_1100010192_11000101922(caster, target, data)
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
	-- 11000101922
	self:AddTempAttr(SkillEffect[11000101922], caster, self.card, data, "damage",0.2)
end
function Skill1100010192:tFunc_1100010192_11000101925(caster, target, data)
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
	-- 11000101925
	self:AddTempAttrPercent(SkillEffect[11000101925], caster, self.card, data, "attack",0.60)
end
function Skill1100010192:tFunc_1100010192_11000101924(caster, target, data)
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
	-- 11000101924
	self:AddTempAttrPercent(SkillEffect[11000101924], caster, self.card, data, "attack",0.4)
end
