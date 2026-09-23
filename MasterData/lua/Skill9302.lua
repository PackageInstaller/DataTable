-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9302 = oo.class(SkillBase)
function Skill9302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9302
	self:AddPhysicsShieldCount(SkillEffect[9302], caster, self.card, data, 2209,2,10)
end
