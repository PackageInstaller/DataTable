-- 梦幻音律（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201401302 = oo.class(SkillBase)
function Skill201401302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201401302:DoSkill(caster, target, data)
	-- 201401302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201401302], caster, target, data, 201401302)
end
