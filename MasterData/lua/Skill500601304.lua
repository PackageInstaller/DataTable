-- 浮游修复（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500601304 = oo.class(SkillBase)
function Skill500601304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500601304:DoSkill(caster, target, data)
	-- 33009
	self.order = self.order + 1
	self:SpillCure(SkillEffect[33009], caster, target, data, 7,9.5,1)
end
