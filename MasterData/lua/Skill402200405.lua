-- 扩散爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402200405 = oo.class(SkillBase)
function Skill402200405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402200405:DoSkill(caster, target, data)
	-- 4402215
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4402215], caster, target, data, 1036)
end
