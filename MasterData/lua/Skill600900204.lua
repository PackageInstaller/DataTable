-- 排压盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900204 = oo.class(SkillBase)
function Skill600900204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900204:DoSkill(caster, target, data)
	-- 600900204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[600900204], caster, target, data, 2924)
end
