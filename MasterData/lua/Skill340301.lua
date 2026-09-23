-- 纯白女总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340301 = oo.class(SkillBase)
function Skill340301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340301
	self:AddSp(SkillEffect[340301], caster, self.card, data, 10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340301:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340306
	self:AddSp(SkillEffect[340306], caster, caster, data, 10)
end
-- 行动结束
function Skill340301:OnActionOver(caster, target, data)
	-- 340311
	self:tFunc_340311_340316(caster, target, data)
	self:tFunc_340311_340321(caster, target, data)
end
function Skill340301:tFunc_340311_340321(caster, target, data)
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
	-- 340321
	self:AddSp(SkillEffect[340321], caster, caster, data, 5)
end
function Skill340301:tFunc_340311_340316(caster, target, data)
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
	-- 340316
	self:AddSp(SkillEffect[340316], caster, self.card, data, 5)
end
