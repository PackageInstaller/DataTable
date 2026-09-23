-- 阵地弦乐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201100205 = oo.class(SkillBase)
function Skill201100205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201100205:DoSkill(caster, target, data)
	-- 201100205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201100205], caster, target, data, 201100205)
end
