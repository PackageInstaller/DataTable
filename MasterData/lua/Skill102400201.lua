-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400201 = oo.class(SkillBase)
function Skill102400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400201:DoSkill(caster, target, data)
	-- 4102
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4102], caster, target, data, 4102)
	-- 4201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4201], caster, target, data, 4201)
end
