-- 阵地弦乐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201100203 = oo.class(SkillBase)
function Skill201100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201100203:DoSkill(caster, target, data)
	-- 201100203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201100203], caster, target, data, 201100203)
end
