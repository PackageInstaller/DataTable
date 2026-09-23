-- 饥呃逆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302600402 = oo.class(SkillBase)
function Skill302600402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302600402:DoSkill(caster, target, data)
	-- 302600402
	self.order = self.order + 1
	self:AddProgress(SkillEffect[302600402], caster, target, data, 150)
end
