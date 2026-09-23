-- 目标吸引
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101800203 = oo.class(SkillBase)
function Skill101800203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101800203:DoSkill(caster, target, data)
	-- 101800203
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[101800203], caster, target, data, 9000,3007)
	-- 101800206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101800206], caster, self.card, data, 101800206)
end
