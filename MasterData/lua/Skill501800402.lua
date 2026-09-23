-- 全体吸收盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501800402 = oo.class(SkillBase)
function Skill501800402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501800402:DoSkill(caster, target, data)
	-- 8378
	self.order = self.order + 1
	self:AddBuff(SkillEffect[8378], caster, target, data, 2103)
end
