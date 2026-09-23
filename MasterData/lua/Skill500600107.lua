-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600107 = oo.class(SkillBase)
function Skill500600107:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600107:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[92015], caster, self.card, data, 2,2)
end
