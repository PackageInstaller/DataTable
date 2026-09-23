-- 溯源探查ex技能10
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070090 = oo.class(SkillBase)
function Skill1100070090:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100070090:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070093
	if self:Rand(5000) then
		self:AddProgress(SkillEffect[1100070093], caster, self.card, data, 200)
	end
end
