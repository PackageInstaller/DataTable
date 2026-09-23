-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000102 = oo.class(SkillBase)
function Skill1000102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1000102:DoSkill(caster, target, data)
	-- 1000102
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1000102], caster, target, data, 1000102)
end
