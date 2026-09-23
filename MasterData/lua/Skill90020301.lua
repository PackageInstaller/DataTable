-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90020301 = oo.class(SkillBase)
function Skill90020301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90020301:OnCrit(caster, target)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	self:HitAddBuff(SkillEffect[1001], caster, target, data, 10000,1001)
end
-- 执行技能
function Skill90020301:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11021], caster, target, data, 0.1,5)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11022], caster, target, data, 0.5,1)
end
