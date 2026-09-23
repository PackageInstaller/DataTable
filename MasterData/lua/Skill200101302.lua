-- 乐驰音掣（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200101302 = oo.class(SkillBase)
function Skill200101302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200101302:DoSkill(caster, target, data)
	-- 200101302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200101302], caster, target, data, 200101302,4)
end
