-- 抵抗强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9021 = oo.class(SkillBase)
function Skill9021:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9021:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9021
	self:AddBuff(SkillEffect[9021], caster, self.card, data, 9021)
end
