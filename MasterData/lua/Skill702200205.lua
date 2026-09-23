-- 不熄护焰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702200205 = oo.class(SkillBase)
function Skill702200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702200205:DoSkill(caster, target, data)
	-- 702200205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702200205], caster, self.card, data, 702200205,3)
	-- 702200206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702200206], caster, self.card, data, 702200206,2)
end
