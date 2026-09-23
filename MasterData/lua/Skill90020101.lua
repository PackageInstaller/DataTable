-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90020101 = oo.class(SkillBase)
function Skill90020101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90020101:OnCrit(caster, target)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:AddNp(SkillEffect[70001], caster, caster, data, 5)
end
-- 执行技能
function Skill90020101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
