-- 迅驰轰炮（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301201302 = oo.class(SkillBase)
function Skill301201302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301201302:DoSkill(caster, target, data)
	-- 11041
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11041], caster, target, data, 0.16,2)
	-- 11042
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11042], caster, target, data, 0.17,4)
end
-- 攻击结束
function Skill301201302:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 999999985
	self:Cure(SkillEffect[999999985], caster, self.card, data, 1,0.50)
end
