-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90110301 = oo.class(SkillBase)
function Skill90110301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90110301:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill90110301:OnAttackOver(caster, target, data)
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
		if SkillJudger:Greater(self, caster, self.card, true,count18,95) then
		else
			return
		end
		if SkillJudger:CheckCD(self, caster, target, false) then
		else
			return
		end
		self:CallSkill(SkillEffect[8523], caster, self.card, data, 800900301)
	end
end
