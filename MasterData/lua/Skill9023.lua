-- 忽视伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9023 = oo.class(SkillBase)
function Skill9023:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9023:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 96001
	self:SetFixedDamage(SkillEffect[96001], caster, self.card, data, 1)
end
