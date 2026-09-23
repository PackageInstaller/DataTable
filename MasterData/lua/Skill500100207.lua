-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500100207 = oo.class(SkillBase)
function Skill500100207:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500100207:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[6101], caster, target, data, 6101)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[501400207], caster, target, data, 501400207)
end
