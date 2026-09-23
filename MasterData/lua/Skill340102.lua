-- 纯白男总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340102 = oo.class(SkillBase)
function Skill340102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340102:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340102
	self:AddSp(SkillEffect[340102], caster, self.card, data, 20)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340102:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340107
	self:AddSp(SkillEffect[340107], caster, caster, data, 20)
end
-- 行动结束
function Skill340102:OnActionOver(caster, target, data)
	-- 340112
	self:tFunc_340112_340117(caster, target, data)
	self:tFunc_340112_340122(caster, target, data)
end
function Skill340102:tFunc_340112_340117(caster, target, data)
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
	-- 340117
	self:AddSp(SkillEffect[340117], caster, self.card, data, 5)
end
function Skill340102:tFunc_340112_340122(caster, target, data)
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
	-- 340122
	self:AddSp(SkillEffect[340122], caster, caster, data, 5)
end
