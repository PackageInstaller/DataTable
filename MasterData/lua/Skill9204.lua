-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9204 = oo.class(SkillBase)
function Skill9204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9204:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9204
	self:AddLightShieldCount(SkillEffect[9204], caster, self.card, data, 2309,4,10)
end
