-- 绯瞳2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914700201 = oo.class(SkillBase)
function Skill914700201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914700201:DoSkill(caster, target, data)
	-- 4203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4203], caster, target, data, 4203)
end
