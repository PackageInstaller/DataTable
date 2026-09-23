-- 神威III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23303 = oo.class(SkillBase)
function Skill23303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill23303:OnBefourHurt(caster, target, data)
	-- 23343
	self:tFunc_23343_23303(caster, target, data)
	self:tFunc_23343_23313(caster, target, data)
end
-- 行动结束
function Skill23303:OnActionOver(caster, target, data)
	-- 23336
	self:tFunc_23336_23334(caster, target, data)
	self:tFunc_23336_23335(caster, target, data)
end
function Skill23303:tFunc_23343_23313(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 23313
	self:AddTempAttr(SkillEffect[23313], caster, caster, data, "damage",0.15)
	-- 8749
	local count749 = SkillApi:GetNP(self, caster, target,3)
	-- 8964
	if SkillJudger:Greater(self, caster, self.card, true,count749,40) then
	else
		return
	end
	-- 23333
	self:AddTempAttr(SkillEffect[23333], caster, caster, data, "damage",0.4)
end
function Skill23303:tFunc_23336_23335(caster, target, data)
	-- 8749
	local count749 = SkillApi:GetNP(self, caster, target,3)
	-- 8964
	if SkillJudger:Greater(self, caster, self.card, true,count749,40) then
	else
		return
	end
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 23335
	self:AddNp(SkillEffect[23335], caster, self.card, data, -5)
end
function Skill23303:tFunc_23336_23334(caster, target, data)
	-- 8749
	local count749 = SkillApi:GetNP(self, caster, target,3)
	-- 8964
	if SkillJudger:Greater(self, caster, self.card, true,count749,40) then
	else
		return
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 23334
	self:AddNp(SkillEffect[23334], caster, self.card, data, -5)
end
function Skill23303:tFunc_23343_23303(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 23303
	self:AddTempAttr(SkillEffect[23303], caster, self.card, data, "damage",0.15)
	-- 8749
	local count749 = SkillApi:GetNP(self, caster, target,3)
	-- 8964
	if SkillJudger:Greater(self, caster, self.card, true,count749,40) then
	else
		return
	end
	-- 23323
	self:AddTempAttr(SkillEffect[23323], caster, self.card, data, "damage",0.4)
end
