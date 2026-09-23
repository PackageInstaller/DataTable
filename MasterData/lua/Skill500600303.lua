-- 浮游修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600303 = oo.class(SkillBase)
function Skill500600303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600303:DoSkill(caster, target, data)
	-- 33003
	self.order = self.order + 1
	self:Cure(SkillEffect[33003], caster, target, data, 7,4.5)
end
