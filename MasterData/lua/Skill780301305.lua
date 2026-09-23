-- 绯瞳（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780301305 = oo.class(SkillBase)
function Skill780301305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780301305:DoSkill(caster, target, data)
	-- 12008
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12008], caster, target, data, 0.125,8)
end
