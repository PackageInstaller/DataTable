-- 实弹护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901500101 = oo.class(SkillBase)
function Skill901500101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901500101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901500101
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[901500101], caster, target, data, 2209,1,10)
end
