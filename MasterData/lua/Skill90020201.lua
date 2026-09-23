-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90020201 = oo.class(SkillBase)
function Skill90020201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90020201:OnCrit(caster, target)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:HitAddBuff(SkillEffect[1002], caster, target, data, 10000,1002)
end
-- 执行技能
function Skill90020201:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11011], caster, target, data, 0.1,5)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11012], caster, target, data, 0.5,1)
end
