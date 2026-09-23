-- 纯白男总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340104 = oo.class(SkillBase)
function Skill340104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340104:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340104
	self:AddSp(SkillEffect[340104], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340104:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340109
	self:AddSp(SkillEffect[340109], caster, caster, data, 30)
end
-- 行动结束
function Skill340104:OnActionOver(caster, target, data)
	-- 340114
	self:tFunc_340114_340119(caster, target, data)
	self:tFunc_340114_340124(caster, target, data)
end
function Skill340104:tFunc_340114_340124(caster, target, data)
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
	-- 340124
	self:AddSp(SkillEffect[340124], caster, caster, data, 10)
end
function Skill340104:tFunc_340114_340119(caster, target, data)
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
	-- 340119
	self:AddSp(SkillEffect[340119], caster, self.card, data, 10)
end
