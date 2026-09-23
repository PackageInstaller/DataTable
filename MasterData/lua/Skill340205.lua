-- 纯白男总队长4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340205 = oo.class(SkillBase)
function Skill340205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill340205:OnBefourHurt(caster, target, data)
	-- 340205
	self:tFunc_340205_340210(caster, target, data)
	self:tFunc_340205_340215(caster, target, data)
end
function Skill340205:tFunc_340205_340210(caster, target, data)
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
	-- 8785
	local count785 = SkillApi:GetCount(self, caster, target,3,710130301)
	-- 710130303
	if SkillJudger:Greater(self, caster, target, true,count785,2) then
	else
		return
	end
	-- 340210
	self:AddTempAttr(SkillEffect[340210], caster, self.card, data, "damage",0.5)
end
function Skill340205:tFunc_340205_340215(caster, target, data)
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
	-- 340216
	if SkillJudger:Greater(self, caster, target, true,count790,2) then
	else
		return
	end
	-- 340215
	self:AddTempAttr(SkillEffect[340215], caster, caster, data, "damage",0.5)
end
