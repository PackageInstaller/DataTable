-- 护盾词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000020080 = oo.class(SkillBase)
function Skill1000020080:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1000020080:OnBorn(caster, target, data)
	-- 1000020080
	self:AddBuff(SkillEffect[1000020080], caster, self.card, data, 1000020081)
end
