-- 纯白女总队长4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340401 = oo.class(SkillBase)
function Skill340401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill340401:OnBefourHurt(caster, target, data)
	-- 340401
	self:tFunc_340401_340406(caster, target, data)
	self:tFunc_340401_340411(caster, target, data)
end
function Skill340401:tFunc_340401_340406(caster, target, data)
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
	-- 8791
	local count791 = SkillApi:GetCount(self, caster, target,3,710230301)
	-- 710230303
	if SkillJudger:Greater(self, caster, target, true,count791,2) then
	else
		return
	end
	-- 340406
	self:AddTempAttr(SkillEffect[340406], caster, self.card, data, "damage",0.1)
end
function Skill340401:tFunc_340401_340411(caster, target, data)
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
	-- 8790
	local count790 = SkillApi:GetCount(self, caster, target,5,801800101)
	-- 340416
	if SkillJudger:Greater(self, caster, target, true,count790,2) then
	else
		return
	end
	-- 340411
	self:AddTempAttr(SkillEffect[340411], caster, caster, data, "damage",0.1)
end
