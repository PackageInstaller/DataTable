-- 范围技能攻击伤害加深20%，全体范围技能攻击时根据目标数量额外提升攻击，当目标数量为3时，攻击提升20%，当目标数为2时，攻击提升25%，当目标数为1时，攻击提升40%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010191 = oo.class(SkillBase)
function Skill1100010191:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010191:OnBefourHurt(caster, target, data)
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
	-- 1100010191
	self:tFunc_1100010191_11000101911(caster, target, data)
	self:tFunc_1100010191_11000101912(caster, target, data)
	self:tFunc_1100010191_11000101913(caster, target, data)
	self:tFunc_1100010191_11000101914(caster, target, data)
end
function Skill1100010191:tFunc_1100010191_11000101914(caster, target, data)
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
	-- 11000101914
	self:AddTempAttrPercent(SkillEffect[11000101914], caster, self.card, data, "attack",0.40)
end
function Skill1100010191:tFunc_1100010191_11000101912(caster, target, data)
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
	-- 11000101912
	self:AddTempAttrPercent(SkillEffect[11000101912], caster, self.card, data, "attack",0.2)
end
function Skill1100010191:tFunc_1100010191_11000101911(caster, target, data)
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
	-- 11000101911
	self:AddTempAttr(SkillEffect[11000101911], caster, self.card, data, "damage",0.1)
end
function Skill1100010191:tFunc_1100010191_11000101913(caster, target, data)
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
	-- 11000101913
	self:AddTempAttrPercent(SkillEffect[11000101913], caster, self.card, data, "attack",0.25)
end
