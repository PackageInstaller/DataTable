-- 利爪狂袭
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300500202 = oo.class(SkillBase)
function Skill300500202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300500202:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill300500202:OnAfterHurt(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8525
	if SkillJudger:CasterIsSelf(self, caster, target, true) and SkillJudger:TargetIsEnemy(self, caster, target, true) then
		-- 31005
		self:Cure(SkillEffect[31005], caster, self.card, data, 5,0.8)
	end
end
