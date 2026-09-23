-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9310 = oo.class(SkillBase)
function Skill9310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9310:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9310
	self:AddPhysicsShieldCount(SkillEffect[9310], caster, self.card, data, 2209,10,10)
end
