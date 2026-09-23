-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801305 = oo.class(SkillBase)
function Skill4801305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4801305:OnBornSpecial(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[4801305], caster, self.card, data, 4801301)
end
-- 入场时
function Skill4801305:OnBorn(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[4801305], caster, self.card, data, 4801301)
end
