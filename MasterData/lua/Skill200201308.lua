-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200201308 = oo.class(SkillBase)
function Skill200201308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200201308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201308], caster, target, data, 200201308)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201318], caster, target, data, 200201318)
end
