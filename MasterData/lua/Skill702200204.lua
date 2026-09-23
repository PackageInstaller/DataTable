-- 不熄护焰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702200204 = oo.class(SkillBase)
function Skill702200204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702200204:DoSkill(caster, target, data)
	-- 702200204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702200204], caster, self.card, data, 702200204,3)
	-- 702200206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702200206], caster, self.card, data, 702200206,2)
end
