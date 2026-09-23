-- 标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9036 = oo.class(SkillBase)
function Skill9036:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9036:OnAttackOver(caster, target, data)
	-- 9036
	self:AddBuff(SkillEffect[9036], caster, self.card, data, 9036)
end
