-- 净化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600700405 = oo.class(SkillBase)
function Skill600700405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600700405:DoSkill(caster, target, data)
	-- 600700401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[600700401], caster, target, data, 600700401)
end
