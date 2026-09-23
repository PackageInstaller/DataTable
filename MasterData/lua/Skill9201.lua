-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9201 = oo.class(SkillBase)
function Skill9201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9201
	self:AddLightShieldCount(SkillEffect[9201], caster, self.card, data, 2309,1,10)
end
