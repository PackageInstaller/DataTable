-- 纯白男总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340103 = oo.class(SkillBase)
function Skill340103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340103:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340103
	self:AddSp(SkillEffect[340103], caster, self.card, data, 20)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340103:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340108
	self:AddSp(SkillEffect[340108], caster, caster, data, 20)
end
-- 行动结束
function Skill340103:OnActionOver(caster, target, data)
	-- 340113
	self:tFunc_340113_340118(caster, target, data)
	self:tFunc_340113_340123(caster, target, data)
end
function Skill340103:tFunc_340113_340123(caster, target, data)
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
	-- 340123
	self:AddSp(SkillEffect[340123], caster, caster, data, 10)
end
function Skill340103:tFunc_340113_340118(caster, target, data)
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
	-- 340118
	self:AddSp(SkillEffect[340118], caster, self.card, data, 10)
end
