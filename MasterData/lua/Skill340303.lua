-- 纯白女总队长2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340303 = oo.class(SkillBase)
function Skill340303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340303:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340303
	self:AddSp(SkillEffect[340303], caster, self.card, data, 20)
end
-- 特殊入场时(复活，召唤，合体)
function Skill340303:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 340308
	self:AddSp(SkillEffect[340308], caster, caster, data, 20)
end
-- 行动结束
function Skill340303:OnActionOver(caster, target, data)
	-- 340313
	self:tFunc_340313_340318(caster, target, data)
	self:tFunc_340313_340323(caster, target, data)
end
function Skill340303:tFunc_340313_340323(caster, target, data)
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
	-- 340323
	self:AddSp(SkillEffect[340323], caster, caster, data, 10)
end
function Skill340303:tFunc_340313_340318(caster, target, data)
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
	-- 340318
	self:AddSp(SkillEffect[340318], caster, self.card, data, 10)
end
