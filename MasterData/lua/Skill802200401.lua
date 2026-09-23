-- 净化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802200401 = oo.class(SkillBase)
function Skill802200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802200401:DoSkill(caster, target, data)
	-- 802200401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[802200401], caster, target, data, 802200401)
end
