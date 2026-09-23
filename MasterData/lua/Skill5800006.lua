-- 世界boss词条buff6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800006 = oo.class(SkillBase)
function Skill5800006:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800006:OnBefourHurt(caster, target, data)
	-- 5800026
	self:tFunc_5800026_5800022(caster, target, data)
	self:tFunc_5800026_5800023(caster, target, data)
	self:tFunc_5800026_5800024(caster, target, data)
	self:tFunc_5800026_5800027(caster, target, data)
	self:tFunc_5800026_5800031(caster, target, data)
	self:tFunc_5800026_5800032(caster, target, data)
	self:tFunc_5800026_5800033(caster, target, data)
	self:tFunc_5800026_5800034(caster, target, data)
end
-- 入场时
function Skill5800006:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333307
	self:AddValue(SkillEffect[333307], caster, self.card, data, "LimitDamage1003",0.60)
	-- 333317
	self:AddValue(SkillEffect[333317], caster, self.card, data, "LimitDamage1001",0.60)
	-- 333327
	self:AddValue(SkillEffect[333327], caster, self.card, data, "LimitDamage1002",0.60)
	-- 333337
	self:AddValue(SkillEffect[333337], caster, self.card, data, "LimitDamage1051",0.60)
	-- 333338
	self:AddValue(SkillEffect[333338], caster, self.card, data, "LimitDamage603000101",0.60)
	-- 333339
	self:AddValue(SkillEffect[333339], caster, self.card, data, "LimitDamage603100101",0.60)
end
function Skill5800006:tFunc_5800026_5800032(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 5800032
	self:AlterBufferByID(SkillEffect[5800032], caster, target, data, 1003,1)
end
function Skill5800006:tFunc_5800026_5800027(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 5800030
	local count60310 = SkillApi:BuffCount(self, caster, target,2,3,603100101)
	-- 5800029
	if SkillJudger:Greater(self, caster, self.card, true,count60310,0) then
	else
		return
	end
	-- 5800027
	self:AddBuffCount(SkillEffect[5800027], caster, target, data, 603100101,1,999)
end
function Skill5800006:tFunc_5800026_5800031(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 5800031
	self:AddBuff(SkillEffect[5800031], caster, target, data, 1001)
end
function Skill5800006:tFunc_5800026_5800024(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 5800024
	self:AlterBufferByID(SkillEffect[5800024], caster, target, data, 1051,1)
end
function Skill5800006:tFunc_5800026_5800033(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 5800033
	self:AlterBufferByID(SkillEffect[5800033], caster, target, data, 1051,1)
end
function Skill5800006:tFunc_5800026_5800034(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 5800030
	local count60310 = SkillApi:BuffCount(self, caster, target,2,3,603100101)
	-- 5800029
	if SkillJudger:Greater(self, caster, self.card, true,count60310,0) then
	else
		return
	end
	-- 5800034
	self:AddBuffCount(SkillEffect[5800034], caster, target, data, 603100101,1,999)
end
function Skill5800006:tFunc_5800026_5800022(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 5800022
	self:AddBuff(SkillEffect[5800022], caster, target, data, 1001)
end
function Skill5800006:tFunc_5800026_5800023(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 5800023
	self:AlterBufferByID(SkillEffect[5800023], caster, target, data, 1003,1)
end
