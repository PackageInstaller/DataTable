-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710100701 = oo.class(SkillBase)
function Skill710100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill710100701:CanSummon()
	return self.card:CanSummon(10000007,1,{4,1},{progress=600})
end
-- 执行技能
function Skill710100701:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Summon(SkillEffect[40006], caster, target, data, 10000007,1,{4,1},{progress=600})
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[700100701], caster, self.card, data, 1,700100601)
end
