-- 剧情
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9032 = oo.class(SkillBase)
function Skill9032:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9032:OnAttackOver(caster, target, data)
	-- 9032
	self:AddBuff(SkillEffect[9032], caster, self.card, data, 9032)
end
