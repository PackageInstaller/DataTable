-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100100209 = oo.class(SkillBase)
function Skill100100209:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100100209:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2139], caster, target, data, 2139)
end
