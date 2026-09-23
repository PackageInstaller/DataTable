-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9304 = oo.class(SkillBase)
function Skill9304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9304
	self:AddPhysicsShieldCount(SkillEffect[9304], caster, self.card, data, 2209,4,10)
end
