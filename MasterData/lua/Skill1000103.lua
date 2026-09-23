-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000103 = oo.class(SkillBase)
function Skill1000103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1000103:DoSkill(caster, target, data)
	-- 1000103
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1000103], caster, target, data, 1000103)
end
