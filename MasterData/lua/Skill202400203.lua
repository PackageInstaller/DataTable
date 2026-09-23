-- 和音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202400203 = oo.class(SkillBase)
function Skill202400203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202400203:DoSkill(caster, target, data)
	-- 202400203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400203], caster, target, data, 202400202)
	-- 202400212
	self.order = self.order + 1
	self:AddNp(SkillEffect[202400212], caster, target, data, 3)
end
