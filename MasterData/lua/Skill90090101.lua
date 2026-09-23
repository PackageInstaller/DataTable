-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90090101 = oo.class(SkillBase)
function Skill90090101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90090101:OnCrit(caster, target)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AddNp(SkillEffect[70002], caster, caster, data, 10)
end
-- 执行技能
function Skill90090101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.33,3)
end
