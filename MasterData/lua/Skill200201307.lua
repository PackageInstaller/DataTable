-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200201307 = oo.class(SkillBase)
function Skill200201307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200201307:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201307], caster, target, data, 200201307)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201317], caster, target, data, 200201317)
end
