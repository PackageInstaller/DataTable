-- 乐驰音掣（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200101304 = oo.class(SkillBase)
function Skill200101304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200101304:DoSkill(caster, target, data)
	-- 200101304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200101304], caster, target, data, 200101304,4)
end
