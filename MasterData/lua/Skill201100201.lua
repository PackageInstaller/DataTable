-- 阵地弦乐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201100201 = oo.class(SkillBase)
function Skill201100201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201100201:DoSkill(caster, target, data)
	-- 201100201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201100201], caster, target, data, 201100201)
end
