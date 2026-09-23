-- 纯白男总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340105 = oo.class(SkillBase)
function Skill340105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340105:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340105
	self:AddSp(SkillEffect[340105], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340105:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340110
	self:AddSp(SkillEffect[340110], caster, caster, data, 30)
end
-- 行动结束
function Skill340105:OnActionOver(caster, target, data)
	-- 340115
	self:tFunc_340115_340120(caster, target, data)
	self:tFunc_340115_340125(caster, target, data)
end
function Skill340105:tFunc_340115_340125(caster, target, data)
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
	-- 340125
	self:AddSp(SkillEffect[340125], caster, caster, data, 15)
end
function Skill340105:tFunc_340115_340120(caster, target, data)
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
	-- 340120
	self:AddSp(SkillEffect[340120], caster, self.card, data, 15)
end
