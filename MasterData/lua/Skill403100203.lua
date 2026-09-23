-- 漫游超速
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill403100203 = oo.class(SkillBase)
function Skill403100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill403100203:DoSkill(caster, target, data)
	-- 403100203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[403100203], caster, self.card, data, 403100203)
	-- 403100206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[403100206], caster, self.card, data, 403100206)
end
