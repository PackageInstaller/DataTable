-- 绝对免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9015 = oo.class(SkillBase)
function Skill9015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9015:OnBorn(caster, target, data)
	-- 9015
	self:AddBuff(SkillEffect[9015], caster, self.card, data, 9015)
end
