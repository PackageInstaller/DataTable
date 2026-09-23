-- 纯白女总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340304 = oo.class(SkillBase)
function Skill340304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340304
	self:AddSp(SkillEffect[340304], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340304:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340309
	self:AddSp(SkillEffect[340309], caster, caster, data, 30)
end
-- 行动结束
function Skill340304:OnActionOver(caster, target, data)
	-- 340314
	self:tFunc_340314_340319(caster, target, data)
	self:tFunc_340314_340324(caster, target, data)
end
function Skill340304:tFunc_340314_340319(caster, target, data)
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
	-- 340319
	self:AddSp(SkillEffect[340319], caster, self.card, data, 10)
end
function Skill340304:tFunc_340314_340324(caster, target, data)
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
	-- 340324
	self:AddSp(SkillEffect[340324], caster, caster, data, 10)
end
