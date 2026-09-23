-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702300303 = oo.class(SkillBase)
function Skill702300303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702300303:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2123], caster, target, data, 2123)
end
