-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700100308 = oo.class(SkillBase)
function Skill700100308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700100308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageSpecial(SkillEffect[13003], caster, target, data, 0.333,3)
end
-- 行动结束
function Skill700100308:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[700100301], caster, self.card, data, 700100301,3)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:ChangeSkill(SkillEffect[700100701], caster, self.card, data, 1,700100601)
end
