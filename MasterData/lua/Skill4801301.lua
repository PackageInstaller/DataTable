-- 决斗之魂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801301 = oo.class(SkillBase)
function Skill4801301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4801301:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4801301
	self:CallSkillEx(SkillEffect[4801301], caster, self.card, data, 801300401)
end
-- 入场时
function Skill4801301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4801301
	self:CallSkillEx(SkillEffect[4801301], caster, self.card, data, 801300401)
end
