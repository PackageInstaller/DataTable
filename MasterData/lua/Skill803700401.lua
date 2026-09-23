-- 锋流4技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803700401 = oo.class(SkillBase)
function Skill803700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803700401:DoSkill(caster, target, data)
	-- 4803711
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4803711], caster, target, data, 4803701)
end
