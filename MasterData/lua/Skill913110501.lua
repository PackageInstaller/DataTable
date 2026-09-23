-- 人马机神高速形态5技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913110501 = oo.class(SkillBase)
function Skill913110501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913110501:DoSkill(caster, target, data)
	-- 13016
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13016], caster, target, data, 0.125,4)
	-- 13017
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13017], caster, target, data, 0.125,4)
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
	-- 913110803
	self.order = self.order + 1
	self:AddProgress(SkillEffect[913110803], caster, target, data, -200)
end
