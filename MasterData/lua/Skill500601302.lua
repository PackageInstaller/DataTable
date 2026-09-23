-- 浮游修复（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500601302 = oo.class(SkillBase)
function Skill500601302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500601302:DoSkill(caster, target, data)
	-- 33007
	self.order = self.order + 1
	self:SpillCure(SkillEffect[33007], caster, target, data, 7,8.5,1)
end
