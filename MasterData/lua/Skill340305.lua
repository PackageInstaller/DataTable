-- 纯白女总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340305 = oo.class(SkillBase)
function Skill340305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340305
	self:AddSp(SkillEffect[340305], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340305:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340310
	self:AddSp(SkillEffect[340310], caster, caster, data, 30)
end
-- 行动结束
function Skill340305:OnActionOver(caster, target, data)
	-- 340315
	self:tFunc_340315_340320(caster, target, data)
	self:tFunc_340315_340325(caster, target, data)
end
function Skill340305:tFunc_340315_340320(caster, target, data)
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
	-- 340320
	self:AddSp(SkillEffect[340320], caster, self.card, data, 15)
end
function Skill340305:tFunc_340315_340325(caster, target, data)
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
	-- 340325
	self:AddSp(SkillEffect[340325], caster, caster, data, 15)
end
