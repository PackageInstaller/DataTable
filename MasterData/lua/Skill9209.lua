-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9209 = oo.class(SkillBase)
function Skill9209:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9209:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9209
	self:AddLightShieldCount(SkillEffect[9209], caster, self.card, data, 2309,9,10)
end
