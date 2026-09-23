-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500601308 = oo.class(SkillBase)
function Skill500601308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500601308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33008], caster, target, data, 7,5.6)
end
-- 行动开始
function Skill500601308:OnActionBegin(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[999999995], caster, self.card, data, 3308,1)
end
