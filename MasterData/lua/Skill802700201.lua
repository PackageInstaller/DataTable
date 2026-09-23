-- 科迪守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802700201 = oo.class(SkillBase)
function Skill802700201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802700201:DoSkill(caster, target, data)
	-- 802700201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[802700201], caster, target, data, 2115,2)
end
