-- 乐驰音掣（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200101303 = oo.class(SkillBase)
function Skill200101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200101303:DoSkill(caster, target, data)
	-- 200101303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200101303], caster, target, data, 200101303,4)
end
