-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700309 = oo.class(SkillBase)
function Skill200700309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700309:DoSkill(caster, target, data)
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	self.order = self.order + 1
	self:AddEnergy(SkillEffect[200700102], caster, self.card, data, count49*0.25,1)
end
-- 伤害后
function Skill200700309:OnAfterHurt(caster, target, data)
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	self:AddEnergy(SkillEffect[200700104], caster, self.card, data, count21*0.4,1)
end
-- 治疗时
function Skill200700309:OnCure(caster, target, data)
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	local count66 = SkillApi:GetCureHp(self, caster, target,2)
	self:AddEnergy(SkillEffect[200700105], caster, self.card, data, count66*0.25,1)
end
