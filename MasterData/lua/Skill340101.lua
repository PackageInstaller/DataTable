-- 纯白男总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340101 = oo.class(SkillBase)
function Skill340101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340101
	self:AddSp(SkillEffect[340101], caster, self.card, data, 10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340101:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340106
	self:AddSp(SkillEffect[340106], caster, caster, data, 10)
end
-- 行动结束
function Skill340101:OnActionOver(caster, target, data)
	-- 340111
	self:tFunc_340111_340116(caster, target, data)
	self:tFunc_340111_340121(caster, target, data)
end
function Skill340101:tFunc_340111_340121(caster, target, data)
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
	-- 340121
	self:AddSp(SkillEffect[340121], caster, caster, data, 5)
end
function Skill340101:tFunc_340111_340116(caster, target, data)
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
	-- 340116
	self:AddSp(SkillEffect[340116], caster, self.card, data, 5)
end
