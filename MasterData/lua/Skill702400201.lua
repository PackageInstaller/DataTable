-- 霜寒守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702400201 = oo.class(SkillBase)
function Skill702400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702400201:DoSkill(caster, target, data)
	-- 702400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702400201], caster, target, data, 702400201,2)
end
