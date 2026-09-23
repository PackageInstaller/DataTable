-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301200106 = oo.class(SkillBase)
function Skill301200106:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301200106:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
