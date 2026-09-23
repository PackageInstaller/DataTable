-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100201310 = oo.class(SkillBase)
function Skill100201310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100201310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11051], caster, target, data, 0.5,4)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11052], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill100201310:OnActionOver(caster, target, data)
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
function Skill100201310:OnDeath(caster, target, data)
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
