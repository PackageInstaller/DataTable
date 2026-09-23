-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710201307 = oo.class(SkillBase)
function Skill710201307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710201307:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 行动结束
function Skill710201307:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[999999991], caster, self.card, data, 3003,1)
end
-- 死亡时
function Skill710201307:OnDeath(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddNp(SkillEffect[999999993], caster, self.card, data, 10)
end
