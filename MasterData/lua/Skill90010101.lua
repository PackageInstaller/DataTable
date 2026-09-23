-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90010101 = oo.class(SkillBase)
function Skill90010101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90010101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4316], caster, self.card, data, 4306)
	self.order = self.order + 1
	self:AddNp(SkillEffect[70001], caster, caster, data, 5)
end
