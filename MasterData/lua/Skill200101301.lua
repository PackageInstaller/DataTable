-- 乐驰音掣（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200101301 = oo.class(SkillBase)
function Skill200101301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200101301:DoSkill(caster, target, data)
	-- 200101301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200101301], caster, target, data, 200101301,4)
end
