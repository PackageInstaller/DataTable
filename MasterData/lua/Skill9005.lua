-- 免疫-冰冻
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9005 = oo.class(SkillBase)
function Skill9005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9005:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9005
	self:AddBuff(SkillEffect[9005], caster, self.card, data, 9005)
end
