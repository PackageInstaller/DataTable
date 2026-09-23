-- 实弹护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901500301 = oo.class(SkillBase)
function Skill901500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901500301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901500301
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[901500301], caster, target, data, 2209,3,10)
end
