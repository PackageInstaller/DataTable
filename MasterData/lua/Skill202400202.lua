-- 和音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202400202 = oo.class(SkillBase)
function Skill202400202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202400202:DoSkill(caster, target, data)
	-- 202400202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400202], caster, target, data, 202400202)
	-- 202400211
	self.order = self.order + 1
	self:AddNp(SkillEffect[202400211], caster, target, data, 2)
end
