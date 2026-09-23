-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill50010201 = oo.class(SkillBase)
function Skill50010201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill50010201:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	self.order = self.order + 1
	self:AddSp(SkillEffect[80002], caster, caster, data, 15)
end
