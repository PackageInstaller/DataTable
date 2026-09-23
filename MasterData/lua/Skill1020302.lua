-- 超越界限
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020302 = oo.class(SkillBase)
function Skill1020302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020302:DoSkill(caster, target, data)
	-- 1020302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1020302], caster, target, data, 1020302)
end
