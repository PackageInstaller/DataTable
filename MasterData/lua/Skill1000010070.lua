-- 加速词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000010070 = oo.class(SkillBase)
function Skill1000010070:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill1000010070:OnDelBuff(caster, target, data)
	-- 1000010070
	self:AddBuff(SkillEffect[1000010070], caster, self.card, data, 1000010071)
end
