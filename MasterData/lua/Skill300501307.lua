-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300501307 = oo.class(SkillBase)
function Skill300501307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300501307:DoSkill(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	self.order = self.order + 1
	self:AddHp(SkillEffect[8526], caster, self.card, data, -count20*0.1)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
