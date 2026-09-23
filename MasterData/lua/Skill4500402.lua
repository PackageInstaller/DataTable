-- 千羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500402 = oo.class(SkillBase)
function Skill4500402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4500402:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500406
	self:AddSp(SkillEffect[4500406], caster, self.card, data, 20)
end
-- 伤害后
function Skill4500402:OnAfterHurt(caster, target, data)
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
	-- 4500402
	if self:Rand(3500) then
		self:AddBuff(SkillEffect[4500402], caster, target, data, 4500401)
	end
end
