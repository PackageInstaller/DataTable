-- 排压盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900205 = oo.class(SkillBase)
function Skill600900205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900205:DoSkill(caster, target, data)
	-- 600900205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[600900205], caster, target, data, 2925)
end
