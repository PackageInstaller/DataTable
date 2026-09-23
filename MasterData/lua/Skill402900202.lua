-- 快速充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402900202 = oo.class(SkillBase)
function Skill402900202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402900202:DoSkill(caster, target, data)
	-- 402900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[402900201], caster, self.card, data, 402900201,1)
end
