-- 紧急修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500800203 = oo.class(SkillBase)
function Skill500800203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500800203:DoSkill(caster, target, data)
	-- 500800203
	self.order = self.order + 1
	self:SpillCure(SkillEffect[500800203], caster, target, data, 1,0.26,1)
end
