-- 阵地扩成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102300305 = oo.class(SkillBase)
function Skill102300305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102300305:DoSkill(caster, target, data)
	-- 102300205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300205], caster, target, data, 2905)
end
