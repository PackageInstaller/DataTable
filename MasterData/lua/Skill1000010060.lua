-- 加速词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000010060 = oo.class(SkillBase)
function Skill1000010060:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill1000010060:OnDelBuff(caster, target, data)
	-- 1000010060
	self:AddNp(SkillEffect[1000010060], caster, self.card, data, 10)
end
